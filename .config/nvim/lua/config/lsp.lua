-- local lspconfig = require("lspconfig")
local servers = {
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
	"ember",
}

-- Function called when the LSP client starts
local on_attach = function(client, bufnr)
	if vim.tbl_contains(servers, client.name) then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "Go to definition",
	})
	vim.keymap.set("n", "gr", vim.lsp.buf.references, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "List references",
	})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "Show hover",
	})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "Rename symbol",
	})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "Code actions",
	})
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "Show errors",
	})
end

-- Connect nvim-cmp to LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Default handler for all LSP servers installed via Mason
for _, server in ipairs(servers) do
	vim.lsp.config[server] = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	vim.lsp.enable(server)
end
