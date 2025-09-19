{
  pkgs,
  ...
}:
{
  home.file.".config/typos.toml".text = ''
    # typos.toml

    [files]
    extend-exclude = [
      "lazy-lock.json",   # LazyVim lockfile
      "doc/tags",         # Vim help tags
      ".neoconf.json"
    ]

    [default]
    # Ignore common non-words to cut noise in code/configs.
    extend-ignore-re = [
      "#[0-9A-Fa-f]{3,8}\\b",                               # hex colors
      "\\b[0-9a-f]{7,40}\\b",                               # git SHAs
      "\\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\b", # UUID
      "\\b(?:https?|ssh)://\\S+",                           # URLs
      "(?:\\.?\\./)*[\\w.-]+(?:/[\\w.-]+)+",                # file paths
      "(?s)```.*?```"                                       # fenced code blocks in markdown
    ]

    # Project terms (tweak as you go). Value==key => always valid.
    [default.extend-words]
    nvim = "nvim"
    neovim = "neovim"
    treesitter = "treesitter"
    luasnip = "luasnip"
    telescope = "telescope"
    whichkey = "whichkey"
    ["null-ls"] = "null-ls"
    ["neo-tree"] = "neo-tree"
    bufnr = "bufnr"
    keymap = "keymap"
    lspconfig = "lspconfig"
  '';
}
