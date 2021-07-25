vim.cmd('packadd packer.nvim')

return require('packer').startup(
  function()
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'windwp/nvim-autopairs'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'Mofiqul/dracula.nvim'
    use {'nvim-telescope/telescope.nvim', 
      requires = {
	{'nvim-lua/popup.nvim'}, 
	{'nvim-lua/plenary.nvim'}}
      }
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
  end
)
