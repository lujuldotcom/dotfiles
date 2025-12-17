return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = 1
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local function custom_location()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local col = vim.fn.col(".")
				return string.format("%d/%d:%d", current_line, total_lines, col)
			end
			require("lualine").setup({
				options = {
					theme = "gruvbox-material",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { custom_location },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = { custom_location },
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("bufferline").setup({})
		end,
	},
	{ "lewis6991/gitsigns.nvim" },
	{ "hiphish/rainbow-delimiters.nvim" },
	{ "numToStr/Comment.nvim" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.icons",
		},
		opts = {
			-- your configuration comes here
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "<C-g>", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end
			require("nvim-tree").setup({
				on_attach = my_on_attach,
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
					root_folder_label = function(path)
						local parts = vim.split(path, "/", { trimempty = true })
						local depth = 3

						if #parts <= depth then
							return "/" .. table.concat(parts, "/")
						end

						return "…/" .. table.concat(vim.list_slice(parts, #parts - depth + 1), "/")
					end,
				},
				filters = {
					dotfiles = false,
				},
				update_focused_file = {
					enable = true,
					update_cwd = false,
				},
				actions = {
					open_file = {
						quit_on_open = false,
					},
				},
			})
		end,
	},
}
