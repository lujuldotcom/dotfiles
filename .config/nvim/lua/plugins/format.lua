return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.setup()

			treesitter.install({
				"bash",
				"javascript",
				"typescript",
				"json",
				"html",
				"css",
				"scss",
				"yaml",
				"toml",
				"go",
				"python",
				"glimmer",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
				callback = function(args)
					local ft = vim.bo[args.buf].filetype

					if ft == "handlebars" then
						return
					end

					pcall(vim.treesitter.start, args.buf)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserHandlebarsSyntax", { clear = true }),
				pattern = "handlebars",
				callback = function()
					vim.cmd("syntax enable")
					vim.cmd("setlocal syntax=html")
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
		ft = {
			"html",
			"xml",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"svelte",
			"handlebars",
			"glimmer",
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"eslint",
					"ts_ls",
					"jsonls",
					"html",
					"cssls",
					"marksman",
					"yamlls",
					"taplo",
					"lua_ls",
					"gopls",
					"pyright",
				},
				automatic_installation = true,
				automatic_enable = false,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"shfmt",
					"prettier",
					"stylua",
					"goimports",
					"black",
					"xmlformatter",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
				toml = { "prettier" },
				hbs = { "prettier" },
				handlebars = { "prettier" },
				lua = { "stylua" },
				go = { "goimports" },
				python = { "black" },
				xml = { "xmlformatter" },
			},
			format_on_save = false,
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	timeout_ms = 500,
			-- },
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
		dependencies = {
			"neovim/nvim-lspconfig",
			{
				"Bilal2453/luvit-meta",
				lazy = true,
			},
		},
	},
}
