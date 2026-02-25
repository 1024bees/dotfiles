-- Neovim 0.11+ native LSP configuration
-- Uses vim.lsp.config() and vim.lsp.enable() instead of nvim-lspconfig

-- Mason for installing LSP servers
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "clangd",
    "cmake",
    "basedpyright",
    "bashls",
    "vtsls",
  },
  -- Disable automatic setup - we use native vim.lsp.config
  handlers = {},
})

require("mason-null-ls").setup({
  ensure_installed = { "stylua", "jq" },
})

-- LSP status integration
local lsp_status = require("lsp-status")
lsp_status.register_progress()
lsp_status.config({
  kind_labels = {},
  current_function = false,
  indicator_separator = " ",
  indicator_errors = "",
  indicator_warnings = "",
  indicator_info = "",
  indicator_hint = "!",
  indicator_ok = "",
  select_symbol = nil,
  status_symbol = "",
  spinner_frames = { "-", "\\", "|", "/" },
})

-- Build capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("keep", capabilities, lsp_status.capabilities)
capabilities.textDocument.codeLens = { dynamicRegistration = false }
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Diagnostic configuration (replaces vim.lsp.handlers["textDocument/publishDiagnostics"])
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
})

vim.lsp.set_log_level("info")

-- LspAttach autocommand (replaces on_attach function)
local augroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Set omnifunc
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Keymaps using modern vim.keymap.set
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)

    -- Formatting keymap (conditional on server capability)
    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting_" .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    -- Disable document highlight (hover word highlighting)
    if client.server_capabilities.documentHighlightProvider then
      client.server_capabilities.documentHighlightProvider = false
    end

    -- lsp-status integration
    lsp_status.on_attach(client)
  end,
})

-- Native LSP server configurations using vim.lsp.config
vim.lsp.config.clangd = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
  capabilities = capabilities,
}

vim.lsp.config.basedpyright = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  capabilities = capabilities,
  settings = {
    basedpyright = {
      typeCheckingMode = "basic",
    },
  },
}

vim.lsp.config.rnix = {
  cmd = { "rnix-lsp" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", "default.nix", ".git" },
  capabilities = capabilities,
}

vim.lsp.config.buck2 = {
  cmd = { "buck2", "lsp" },
  filetypes = { "bzl" },
  root_markers = { ".buckconfig", "BUCK", "TARGETS" },
  capabilities = capabilities,
}

vim.lsp.config.svls = {
  cmd = { "svls" },
  filetypes = { "verilog", "systemverilog" },
  root_markers = { ".git" },
  capabilities = capabilities,
}

vim.lsp.config.taplo = {
  cmd = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  root_markers = { ".git" },
  capabilities = capabilities,
}

vim.lsp.config.tailwindcss = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", ".git" },
  capabilities = capabilities,
}

vim.lsp.config.vtsls = {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  capabilities = capabilities,
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}

-- vtsls-specific: disable formatting and add custom keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "vtsls" then
      -- Disable formatting (let null-ls/prettier handle it)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- TypeScript-specific keymaps
      local opts = { buffer = args.buf, silent = true }
      vim.keymap.set("n", "gs", function()
        require("vtsls").commands.organize_imports(0)
      end, opts)
      vim.keymap.set("n", "go", function()
        require("vtsls").commands.add_missing_imports(0)
      end, opts)
      vim.keymap.set("n", "gR", function()
        require("vtsls").commands.file_references(0)
      end, opts)
    end
  end,
})

-- Disable unwanted LSPs that Neovim 0.11+ auto-enables
-- Setting cmd to false prevents them from starting
--vim.lsp.config("eslint", {
--  cmd = false,
--})

vim.lsp.config("ts_ls", {
  cmd = false,
})

vim.lsp.config("rust_analyzer", {
  cmd = false,
})

-- Enable all configured servers
vim.lsp.enable({
  "clangd",
  "basedpyright",
  "rnix",
  "buck2",
  "svls",
  "taplo",
  "tailwindcss",
  "vtsls",
})

-- Rustaceanvim configuration (handles rust-analyzer separately)
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    default_settings = {
      ["rust-analyzer"] = {
        assist = {
          importMergeBehaviour = "full",
          importPrefix = "plain",
        },
        callInfo = {
          full = true,
        },
        imports = {
          granularity = {
            enforce = true,
            group = "crate",
          },
        },
        files = {
          excludeDirs = {
            "_build",
            ".dart_tool",
            ".flatpak-builder",
            ".git",
            ".gitlab",
            ".gitlab-ci",
            ".gradle",
            ".idea",
            ".next",
            ".project",
            ".scannerwork",
            ".settings",
            ".venv",
            "archetype-resources",
            "bin",
            "hooks",
            "node_modules",
            "po",
            "screenshots",
            "target",
            "website",
          },
        },
        cargo = {
          unsetTest = { "core", "esp-hal-common", "esp-hal-procmacros", "esp32-hal", "esp32c3-hal" },
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },



        procMacro = {
          enable = true,
          attributes = {
            enable = true,
          },
        },
        diagnostics = {
          enable = true,
          disabled = { "unresolved-proc-macro" },
          enableExperimental = true,
          warningsAsHint = {},
        },
      },
    },
  },
}

-- null-ls configuration
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  },
})

-- flutter-tools configuration
require("flutter-tools").setup({ lsp = { capabilities = capabilities } })
