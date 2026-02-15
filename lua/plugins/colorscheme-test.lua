local theme_file = vim.fn.stdpath("config") .. "/lua/config/theme.lua"

local function load_theme()
  local ok, value = pcall(dofile, theme_file)
  if ok and type(value) == "string" and value ~= "" then
    return value
  end
  return "tokyonight-night"
end

local function save_theme(theme)
  local lines = { string.format('return %q', theme) }
  local ok, err = pcall(vim.fn.writefile, lines, theme_file)
  if not ok then
    vim.notify("테마 저장 실패: " .. tostring(err), vim.log.levels.ERROR)
    return
  end
  vim.notify("테마 저장됨: " .. theme, vim.log.levels.INFO)
end

local default_theme = load_theme()

return {
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rebelot/kanagawa.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "ellisonleao/gruvbox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = default_theme,
    },
    init = function()
      vim.api.nvim_create_user_command("ThemePick", function()
        local themes = {
          "tokyonight-night",
          "tokyonight-day",
          "catppuccin-mocha",
          "catppuccin-latte",
          "kanagawa-wave",
          "kanagawa-lotus",
          "nightfox",
          "dayfox",
          "gruvbox",
        }
        vim.ui.select(themes, { prompt = "Choose colorscheme" }, function(choice)
          if choice then
            vim.cmd.colorscheme(choice)
            save_theme(choice)
          end
        end)
      end, {})
    end,
  },
}
