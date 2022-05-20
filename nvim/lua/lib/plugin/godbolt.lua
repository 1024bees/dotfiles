require("godbolt").setup({
    languages = {
        c = { compiler = "rv64-gcc1020", options = {userArguments = "-mcmodel=medany -static -std=gnu99 -O2 -nostdlib  -fno-tree-loop-distribute-patterns -DPREALLOCATE=1 -march=rv64imafdc -mabi=lp64d"} },
        cpp = { compiler = "rv64-gcc1020", options = {userArguments = " -mcmodel=medany -static --std=c++20 -O2 -nostdlib  -fno-tree-loop-distribute-patterns -march=rv64imafdc -mabi=lp64d"} },
        -- any_additional_filetype = { compiler = ..., options = ... },
    },
    quickfix = {
        enable = true, -- whether to populate the quickfix list in case of errors
        auto_open = true-- whether to open the quickfix list if the compiler outputs errors
    },
    url = "https://godbolt.org" -- can be changed to a different godbolt instance
})
print("goodbolt")
