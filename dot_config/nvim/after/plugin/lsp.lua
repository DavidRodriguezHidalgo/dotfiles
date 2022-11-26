local u = require("denzil.utils")
local lsp_g = vim.lsp
require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

require("mason").setup()
require("mason-lspconfig").setup()
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
  lsp_g.buf.format({ bufnr = bufnr })
end
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    u.buf_command(bufnr, "LspFormatting", function()
      lsp_formatting(bufnr)
    end)

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      command = "LspFormatting",
    })
  end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require "lsp_signature".on_attach()
  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- install npm i -g vscode-langservers-extracted@lates
local servers = { "solargraph", "tsserver", "sorbet", "eslint", "sumneko_lua" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}
end

local ts_utils = require("nvim-lsp-ts-utils")
nvim_lsp.tsserver.setup({
  root_dir = nvim_lsp.util.root_pattern("package.json"),
    init_options = ts_utils.init_options,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      ts_utils.setup({
        -- debug = true,
        auto_inlay_hints = false,
        import_all_scan_buffers = 100,
        update_imports_on_move = true,
        -- filter out dumb module warning
        filter_out_diagnostics_by_code = { 80001 },
      })
      ts_utils.setup_client(client)
    end,
})

nvim_lsp.sumneko_lua.setup({
  settings = {
      Lua = {
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
        diagnostics = {
          globals = {
            "global",
            "vim",
            "use",
            "describe",
            "it",
            "assert",
            "before_each",
            "after_each",
          },
        },
      },
  },
})

local with_root_file = function(...)
  local files = { ... }
  return function(utils)
    return utils.root_has_file(files)
  end
end

local null_ls = require("null-ls")
local b = null_ls.builtins
local sources = {
  b.diagnostics.rubocop.with({
    condition = with_root_file(".rubocop.yml"),
    command = "bundle",
    args = { "exec", "rubocop", "-f", "json", "--stdin", "$FILENAME" },
  }),
  b.diagnostics.semgrep.with({
    condition = with_root_file(".semgrep.yml"),
  }),

  b.formatting.trim_whitespace.with({
    filetypes = { "tmux", "zsh" },
  }),
  b.formatting.rubocop.with({
    condition = with_root_file(".rubocop.yml"),
    command = "bundle",
    args = { "exec", "rubocop", "--auto-correct", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
  }),
}

nvim_lsp.null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = on_attach,
})


local prettier = require("prettier")

prettier.setup({
  bin = 'prettier',
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "yaml",
  },
})
vim.o.completeopt = "menuone,noselect"
