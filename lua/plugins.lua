vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'windwp/nvim-autopairs'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- use 'Mofiqul/dracula.nvim'
    use 'folke/tokyonight.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- use {'glepnir/lspsaga.nvim', requires = {'neovim/nvim-lspconfig'}}
    use 'sbdchd/neoformat'
    use 'editorconfig/editorconfig-vim'
    use 'onsails/lspkind-nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'numToStr/Navigator.nvim'
    use 'kabouzeid/nvim-lspinstall'
    use 'tpope/vim-commentary'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }
    use 'JoosepAlviste/nvim-ts-context-commentstring'
end)
