return {
  "neovim/nvim-lspconfig",

  -- Workaround for gopls and semanticTokensProvider
  -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  opts = {
    setup = {
      gopls = function(_, opts)
        Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument
              and client.config.capabilities.textDocument.semanticTokens
            if semantic then
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end
        end)
      end,
    },
  },
}
