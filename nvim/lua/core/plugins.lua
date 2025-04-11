local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- My plugins here
  use 'nvim-treesitter/nvim-treesitter'
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- themes
  use {
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup {
      style = 'warmer'  -- Or try 'cool', 'warmer', etc.  See the theme's docs.
    }
    vim.cmd[[colorscheme onedark]]
  end
}


if packer_bootstrap then
require('packer').sync()
end
end)
