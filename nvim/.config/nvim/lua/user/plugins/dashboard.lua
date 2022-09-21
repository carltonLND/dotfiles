if not packer_plugins["dashboard-nvim"] then
  return
end

local db = require "dashboard"

db.custom_header = {
  "",
  "",
  "",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "",
  "",
  "",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Search Files                      ",
    shortcut = "SPACE sf",
    action = "Telescope find_files",
  },
  {
    icon = "  ",
    desc = "Search Browser                    ",
    shortcut = "SPACE sb",
    action = "Telescope file_browser",
  },
  {
    icon = "  ",
    desc = "Terminal Window                   ",
    shortcut = "SPACE tt",
    action = "FloatermToggle",
  },
  -- {
  --   icon = "  ",
  --   desc = "Neovim Config                  ",
  --   shortcut = "SPACE $",
  --   action = "e $MYVIMRC",
  -- },
}
