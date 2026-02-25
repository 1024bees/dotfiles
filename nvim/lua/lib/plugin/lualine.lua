local colors = {
  bg = "#282c34",
  fg = "#abb2bf",
  yellow = "#e0af68",
  cyan = "#56b6c2",
  darkblue = "#081633",
  green = "#98c379",
  orange = "#d19a66",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#61afef",
  red = "#e86671",
}

local custom_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.green, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.red, gui = "bold" },
  },
  visual = {
    a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.violet, gui = "bold" },
  },
  command = {
    a = { fg = colors.bg, bg = colors.green, gui = "bold" },
  },
  inactive = {
    a = { fg = colors.fg, bg = colors.bg },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  },
}

require("lualine").setup({
  options = {
    theme = custom_theme,
    component_separators = "",
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "packer", "NvimTree", "fugitive", "fugitiveblame" },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "filename",
        path = 1,
        color = { fg = colors.blue, gui = "bold" },
        symbols = {
          modified = "",
          readonly = "  ",
        },
      },
      {
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      },
      {
        "diff",
        colored = true,
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
      },
    },
    lualine_c = {},
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.blue },
          hint = { fg = colors.cyan },
        },
      },
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end
          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end
          return "慎" .. table.concat(names, ", ")
        end,
        color = { fg = colors.yellow },
      },
    },
    lualine_y = {
      {
        "fileformat",
        symbols = { unix = " UNIX", dos = " DOS", mac = " MAC" },
        color = { fg = colors.violet, gui = "bold" },
      },
      {
        "location",
        color = { fg = colors.cyan },
      },
    },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "filename",
        path = 1,
        color = { fg = colors.blue, gui = "bold" },
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
