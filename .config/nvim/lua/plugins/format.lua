return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
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
					-- "c",
					-- "lua",
					-- "markdown",
					-- "markdown_inline",
					-- "query",
					-- "vim",
					-- "vimdoc",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
			})
		end,
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
