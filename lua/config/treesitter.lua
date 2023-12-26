require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "typescript", "go", "svelte", "tsx", "html", "css", "scss", "json", "c", "lua", "rust", "c_sharp", "dockerfile", "proto", "make",
        "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
