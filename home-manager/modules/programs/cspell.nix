{
  pkgs,
  ...
}:
{
  home.file.".config/cspell.yml".text = ''
    version: "0.2"
    extends:
      - "cspell:recommended"

    language: en-US

    # Reusable patterns + references to keep noise low in codebases
    patterns:
      - name: hexColors
        pattern: "#[0-9A-Fa-f]{3,8}\\b"
      - name: shaLike
        pattern: "\\b[0-9a-f]{7,40}\\b"
      - name: uuid
        pattern: "\\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\b"
      - name: filePaths
        pattern: "(?:\\.?\\./)*[\\w.-]+(?:/[\\w.-]+)+"
      - name: urls
        pattern: "\\b(?:https?|ssh)://\\S+"

    ignoreRegExpList:
      - "#hexColors"
      - "#shaLike"
      - "#uuid"
      - "#filePaths"
      - "#urls"

    # Let common camelCase identifiers pass more easily
    allowCompoundWords: true

    # Project dictionary: grow this instead of polluting the main config
    dictionaryDefinitions:
      - name: project-words
        path: "./.cspell/project-words.txt"
        addWords: true

    dictionaries:
      - project-words
      - softwareTerms

    # Target the languages you actually edit in LazyVim
    enabledLanguageIds:
      - markdown
      - plaintext
      - lua
      - vim
      - json
      - yaml
      - toml
      - nix
      - terraform
      - javascript
      - typescript
      - python
      - go

    # File-type tweaks to reduce false positives where needed
    overrides:
      - filename: "**/*.lua"
        words:
          - nvim
          - neovim
          - lsp
          - lspconfig
          - autocmd
          - bufnr
          - keymap
          - treesitter
      - filename: "**/*.vim"
        words:
          - autoload
          - ftplugin
          - vimscript
      - filename: "**/*.nix"
        allowCompoundWords: true
      - filename: "**/*.{tf,tfvars}"
        allowCompoundWords: true
  '';
}
