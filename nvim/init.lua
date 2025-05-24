vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "romainl/vim-cool",
    },
    {
        "stevearc/oil.nvim",
        opts = {
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["q"] = {
                    callback = function()
                        require("oil").close()
                        vim.cmd("close")
                    end,
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "html", "css", "typescript", "astro" },
                sync_install = true,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    { 
        "nvim-lua/plenary.nvim", 
        event = "VeryLazy",
    },
    {
        "nvim-pack/nvim-spectre",
        requires = { {'nvim-lua/plenary.nvim'} },
        event = "VeryLazy",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>r", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} },
        event = "VeryLazy",
    }
})

vim.opt.background = "light"
vim.cmd('colorscheme shine')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>;', builtin.commands, {})

vim.keymap.set("i", "jj", "<ESC>", { silent = true })

vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪"
vim.opt.scrolloff = 5
vim.opt.termguicolors = true
vim.opt.statusline = " %F %m %< %= %r %q"
vim.opt.cursorline = true
vim.opt.laststatus = 0
vim.opt.winbar = "%=%F"
vim.opt.shell = "pwsh.exe"

vim.opt.hidden = true
vim.opt.history = 100
vim.opt.lazyredraw = true
vim.opt.updatetime = 100
vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<Right>", "<C-w><")
vim.keymap.set("n", "<Down>", "<C-w>-")
vim.keymap.set("n", "<Up>", "<C-w>+")
vim.keymap.set("n", "<Left>", "<C-w>>")

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

vim.keymap.set("n", "gf", ":cd %:h<enter>:edit <cfile><enter>")

vim.keymap.set("n", "<leader><space>", "<C-^>")

vim.keymap.set("n", "<leader>k", "<C-w>s:e %:h<enter>", { silent = true })

vim.keymap.set("n", "<leader>h", "<C-w>v:e %:h<enter>", { silent = true })

vim.api.nvim_command [[command! -nargs=0 CopyFullFilePath let @+ = expand('%:p')]]
vim.api.nvim_command [[command! -nargs=0 EditNeovimConfig edit C:\Users\master\AppData\Local\nvim\init.lua]]
vim.api.nvim_command [[command! -nargs=0 EditPowerShellConfig edit C:\Users\master\Documents\PowerShell\Microsoft.PowerShell_profile.ps1]]
vim.api.nvim_command [[command! -nargs=0 EditWindowsTerminalConfig edit C:\Users\master\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json]]
vim.api.nvim_command [[command! -nargs=0 EditDataSync edit C:\Users\master\repos\cutbypham\dotfiles\sync-data.ps1]]
vim.api.nvim_command [[command! -nargs=0 EditAutoHotkey edit C:\Users\master\repos\cutbypham\dotfiles\auto-hot-key.ahk]]
vim.api.nvim_command [[command! -nargs=0 EditAutoHotkeySnippets edit C:\Users\master\repos\cutbypham\dotfiles\lib\snippets.ahk]]
vim.api.nvim_command [[command! -nargs=0 EditFirefoxProfile edit C:\Users\master\AppData\Roaming\Mozilla\Firefox\Profiles\3wr0grx7.default-release\user.js]]
vim.api.nvim_command [[command! -nargs=0 EditRSS edit C:\Users\master\repos\cutbypham\rss-to-email-once-a-day\src\feeds.ts]]

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
