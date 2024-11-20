return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "kyazdani42/nvim-web-devicons", opt = true },
  },
  config = function()
    local lualine = require("lualine")

    local cmake = require("cmake-tools")

    -- Credited to [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local icons = LazyVim.config.icons

    local config = {
      options = {
        icons_enabled = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "Outline" },
        always_divide_middle = true,
        theme = "tokyonight",
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "branch" },

        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return LazyVim.ui.fg("Statement") end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return LazyVim.ui.fg("Constant") end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return LazyVim.ui.fg("Debug") end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return LazyVim.ui.fg("Special") end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            separator = { right = "" },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = { "location" },
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      -- filesize component
      "filesize",
      cond = conditions.buffer_not_empty,
    })

    ins_left({ "location" })

    ins_left({
      function()
        local c_preset = cmake.get_configure_preset()
        return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
      end,
      icon = "",
      cond = function()
        return cmake.is_cmake_project() and cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeSelectConfigurePreset")
          end
        end
      end,
    })

    ins_left({
      function()
        local type = cmake.get_build_type()
        return "CMake: [" .. (type and type or "") .. "]"
      end,
      icon = "",
      cond = function()
        return cmake.is_cmake_project() and not cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeSelectBuildType")
          end
        end
      end,
    })

    ins_left({
      function()
        local kit = cmake.get_kit()
        return "[" .. (kit and kit or "X") .. "]"
      end,
      icon = " ",
      cond = function()
        return cmake.is_cmake_project() and not cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeSelectKit")
          end
        end
      end,
    })

    ins_left({
      function()
        return "Build"
      end,
      icon = "",
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeBuild")
          end
        end
      end,
    })

    ins_left({
      function()
        local b_preset = cmake.get_build_preset()
        return "[" .. (b_preset and b_preset or "X") .. "]"
      end,
      icon = "",
      cond = function()
        return cmake.is_cmake_project() and cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeSelectBuildPreset")
          end
        end
      end,
    })

    ins_left({
      function()
        local b_target = cmake.get_build_target()
        return "[" .. (b_target and b_target or "X") .. "]"
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeSelectBuildTarget")
          end
        end
      end,
    })

    ins_left({
      function()
        return ""
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeDebug")
          end
        end
      end,
    })

    ins_left({
      function()
        return ""
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeRun")
          end
        end
      end,
    })

    ins_left({
      function()
        local l_target = cmake.get_launch_target()
        return "[" .. (l_target and l_target or "X") .. "]"
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if n == 1 then
          if mouse == "l" then
            vim.cmd("CMakeSelectLaunchTarget")
          end
        end
      end,
    })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    -- Add components to right sections
    ins_right({
      "o:encoding", -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
    })

    ins_right({
      function()
        return vim.api.nvim_buf_get_option(0, "shiftwidth")
      end,
      icons_enabled = false,
    })

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
