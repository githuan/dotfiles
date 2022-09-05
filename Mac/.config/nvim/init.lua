require('nguyent.base')
require('nguyent.highlights')
require('nguyent.maps')
require('nguyent.plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('nguyent.macos')
end
if is_win then
  require('nguyent.windows')
end

-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  overrides = {},
})
vim.cmd("colorscheme gruvbox")
