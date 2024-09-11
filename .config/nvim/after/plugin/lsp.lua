local lsp = require('lsp-zero')

local lsp_attach = function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	if client.name == "eslint" then
		vim.cmd.LspStop('eslint')
		return
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

lsp.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
		'bashls',
		'gradle_ls',
		'jdtls',
		'kotlin_language_server',
		'jsonls',
		'marksman',
		'vuels',
		'eslint',
		'rust_analyzer',
	},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

vim.diagnostic.config({
	virtual_text = true,
})

