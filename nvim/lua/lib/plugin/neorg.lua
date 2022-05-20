require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          }

        },
        --["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            }
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true
            }
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        },
        --["core.gtd.base"] = {
        --    config = {
        --        workspace = "gtd"
        --    }
        --}

    }
}
