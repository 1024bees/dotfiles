-- nvim_lsp object
local nvim_lsp = require'lspconfig'
local lsp_status = require'lsp-status'
---local lsp_extension = require'lsp_extensions'


lsp_status.register_progress()
lsp_status.config({
    kind_labels = {},
    current_function = false,
    indicator_separator = ' ',
    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '',
    indicator_hint = '!',
    indicator_ok = '',
    select_symbol = nil,
    status_symbol = '',
    spinner_frames = { '-', '\\', '|', '/' },
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("keep", capabilities, lsp_status.capabilities)
capabilities.textDocument.codeLens = { dynamicRegistration = false }
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)




-- Enable rust_analyzer

require('vim.diagnostic')

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  -- Enable type inlay hints
 

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  -- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --
  --augroup lsp_document_highlight
  --  autocmd! * <buffer>
  --  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --  autocmd CursorHold <buffer> lua vim.diagnostic.show_line_diagnostics()      
  --                                                                                   
  --augroup END

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    ]], false)
  end
  lsp_status.on_attach(client)
end
--
nvim_lsp.rust_analyzer.setup{
  on_attach=on_attach,
  capabilities = capabilities,
  settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehaviour = "full",
                importPrefix = "plain",
            },

            callInfo = {
                full = true,
            };

            cargo = {
                loadOutDirsFromCheck = true
            },

            checkOnSave = {
                --allFeatures = true,
            },

            procMacro = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                disabled = { "unresolved-proc-macro" },
                enableExperimental = true,
                warningsAsHint = {},
            },
        },
    }, 
}
nvim_lsp.clangd.setup({on_attach=on_attach, cmd= {"clangd-12"}, capabilities = capabilities})
-- Enable diagnostics

--nvim_lsp.pyls.setup({on_attach=on_attach, capabilities = capabilities})
nvim_lsp.pylsp.setup({on_attach=on_attach, capabilities= capabilities})




vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

nvim_lsp.tsserver.setup({
    on_attach = function(client, bufnr)

        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap=true, silent=true }

        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        buf_set_keymap("n", "gs", ":TSLspOrganize<CR>",opts)
        buf_set_keymap("n", "gi", ":TSLspRenameFile<CR>",opts)
        buf_set_keymap("n", "go", ":TSLspImportAll<CR>",opts)
        on_attach(client, bufnr)
    end,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})

require("flutter-tools").setup{lsp={on_attach=on_attach}} -- use defaults

--nvim_lsp.eslint.setup({on_attach=on_attach})


--vim.cmd([[ autocmd ColorScheme * :lua require('vim.diagnostic')._define_default_signs_and_highlights() ]]) 

