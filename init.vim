set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set inccommand=split

" https://github.com/abhinav/home/blob/master/.config/nvim/init.lua
lua << EOF

vim.g.mapleader = ' ' -- space is leader

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.gopls.setup{
	cmd = {'gopls', '-remote=auto'},
		capabilities = lsp_capabilities,
       flags = {
            -- Don't spam LSP with changes. Wait a second between each.
            debounce_text_changes = 1000,
       },
		init_options = {
			staticcheck = true,
			gofumpt = true,
		},
		analyses = {
			nilness = true,
			shadow = true,
			unusedparams = true,
			unusedwrite = true,
		},
		codelenses = {
			gc_details = true,
			generate = true,
		},
}

local function lsp_on_attach(client, bufnr)
	local function lsp_nmap(key, fn, desc)
		vim.keymap.set('n', key, fn, {
			noremap = true,
			silent = true,
			desc = desc,
			buffer = bufnr,
		})
	end

	vim.bo.omnifunc =  'v:lua.vim.lsp.omnifunc'

	-- Keybindings
	--  K            Documentation (default)
	--  gd           Go to definition
	--  Alt-Enter    Code action
	lsp_nmap('gd', vim.lsp.buf.definition, "Go to definition")

	local telescopes = require('telescope.builtin')
	-- lgr  Language go-to references
	-- lgi  Language go-to implementation
	-- lfr  Language find references
	-- lfi  Language find implementations
	-- lfd  Language find symbols (document)
	-- lfw  Language find symbols (workspace)
	-- lti  Language: Toggle inlay hints (if supported)
	lsp_nmap('<leader>lgr', vim.lsp.buf.references, "Go to references")
	lsp_nmap('<leader>lgi', vim.lsp.buf.implementation, "Go to implementation")
	lsp_nmap('<leader>lfr', telescopes.lsp_references, "Find references")
	lsp_nmap('<leader>lfi', telescopes.lsp_implementations, "Find implementations")
	lsp_nmap('<leader>lfd', telescopes.lsp_document_symbols, "Find symbols (document)")
	lsp_nmap('<leader>lfw', telescopes.lsp_workspace_symbols, "Find symbols (workspace)")

	if client.server_capabilities.inlayHintProvider then
		if vim.lsp.inlay_hint ~= nil then
			lsp_nmap('<leader>lti', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, "Toggle inlay hints")
		end
	end

	-- Mneomonics:
	-- cr   Code rename
	-- cf   Code format
	-- ca   Code action
	lsp_nmap('<leader>ca', vim.lsp.buf.code_action, "Code action")
	lsp_nmap('<leader>cf', vim.lsp.buf.format, "Reformat file")
	lsp_nmap('<leader>cr', vim.lsp.buf.rename, "Rename")
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buffer = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		lsp_on_attach(client, buffer)
	end,
})

require("trouble").setup {}

local cmp = require 'cmp'
local has_copilot, copilot_suggestion = pcall(require, 'copilot.suggestion')

local handleTab = function(fallback)
	-- Completion suggestions take precedence over Copilot suggestions.
	-- Copilot suggestions are still accessible with <C-e>.
	if cmp.visible() then
		if cmp.get_selected_entry() ~= nil then
			cmp.confirm()
		else
			cmp.select_next_item()
		end
	elseif has_copilot and copilot_suggestion.is_visible() then
		copilot_suggestion.accept()
	elseif vim.snippet.active({direction = 1}) then
		vim.snippet.jump(1)
	else
		fallback()
	end
end

local handleCancel = function(cancelFn)
	return function(fallback)
		local used = false
		if cmp.visible() then
			cancelFn()
			used = true
		end
		if  has_copilot and copilot_suggestion.is_visible() then
			copilot_suggestion.dismiss()
			used = true
		end
		if not used then
			fallback()
		end
	end
end

cmp.setup {
	completion = {
		keyword_length = 3,
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	preselect = cmp.PreselectMode.None,
	mapping = {
		['<Down>'] = {i = cmp.mapping.select_next_item()},
		['<C-n>']  = {i = cmp.mapping.select_next_item()},
		['<Up>']   = {i = cmp.mapping.select_prev_item()},
		['<C-p>']  = {i = cmp.mapping.select_prev_item()},

		-- Ctrl-u/d: scroll docs of completion item if available.
		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

		-- tab: If completion menu is visible and nothing has been selected,
		-- select first item. If something is selected, start completion with that.
		-- If in the middle of the completion, jump to next snippet position.

		-- Tab/Shift-Tab:
		-- If completion menu is not visible,
		--  1. if we're in the middle of a snippet, move forwards/backwards
		--  2. Otherwise use regular key behavior
		--
		-- If completion menu is visible and,
		--  1. no item is selected, select the first/last one
		--  2. an item is selected, start completion with it
		['<Tab>'] = cmp.mapping({
			i = handleTab,
			s = handleTab,
		}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.snippet.active({direction = -1}) then
				vim.snippet.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),

		-- Ctrl-Space: force completion
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

		-- Ctrl-c: cancel completion
		['<C-c>'] = cmp.mapping({
			i = handleCancel(cmp.mapping.abort()),
			c = handleCancel(cmp.mapping.close()),
		}),

		-- Enter: confirm completion
		['<CR>'] = cmp.mapping.confirm({select = false}),
	},
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'nvim_lsp_signature_help'},
		{name = 'snippets'},
	}, {
		{name = 'path'},
		{name = 'buffer'},
		{name = 'tmux'},
	}),
}
EOF
 
lua << EOF
function goFormatAndImports(wait_ms)
 
    -- Prefer `format` if available because `formatting_sync` has been deprecated as of nvim v0.8.0.
    if vim.lsp.buf.format == nil then
        vim.lsp.buf.formatting_sync(nil, wait_ms)
    else
        vim.lsp.buf.format({
            timeout_ms = wait_ms,
        })
    end
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end
 
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function(args)
        goFormatAndImports(3000)
    end,
})
EOF
