-- Load plugin modules in order.

require 'kickstart.plugins.which-key'
require 'kickstart.plugins.lspconfig'
require 'kickstart.plugins.conform'
require 'kickstart.plugins.blink-cmp'
require 'kickstart.plugins.todo-comments'
require 'kickstart.plugins.mini'
require 'kickstart.plugins.neo-tree'
require 'kickstart.plugins.treesitter'
require 'kickstart.plugins.lint'
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.gitsigns'

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--
--  Here are some example plugins that I've included in the Kickstart repository.
--  Uncomment any of the lines below to enable them (you will need to restart nvim).
--
-- require 'kickstart.plugins.debug',
-- require 'kickstart.plugins.indent_line',

-- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
require 'custom.plugins'

-- vim: ts=2 sts=2 sw=2 et
