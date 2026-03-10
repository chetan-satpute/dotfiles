vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
    end

    -- Hover documentation
    if client:supports_method('textDocument/hover') then
      map('K', vim.lsp.buf.hover, 'Hover')
    end

    -- Go to definition
    if client:supports_method('textDocument/definition') then
      map('gd', vim.lsp.buf.definition, 'Go to definition')
    end

    -- Go to implementation
    if client:supports_method('textDocument/implementation') then
      map('gi', vim.lsp.buf.implementation, 'Go to implementation')
    end

    -- Find references
    if client:supports_method('textDocument/references') then
      map('gr', vim.lsp.buf.references, 'Find references')
    end

    -- Rename symbol
    if client:supports_method('textDocument/rename') then
      map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    end

    -- Code actions
    if client:supports_method('textDocument/codeAction') then
      map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
    end
  end,
})
