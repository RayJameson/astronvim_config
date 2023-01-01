return function()
    require("code_runner").setup {
        -- put here the commands by filetype
        startinsert = false,
        filetype = {
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            python = "time python3 -u",
            lua = "time lua",
            typescript = "time deno run",
            rust = "cd $dir && time rustc $fileName && $dir/$fileNameWithoutExt",
            javascript = "time node",
            shellscript = "time bash",
            go = "time go run",
            scala = "time scala",
            c = "cd $dir && gcc $fileName -o $fileNameWithoutExt -Wall && time ./$fileNameWithoutExt && rm $fileNameWithoutExt",
            markdown = "rich"
        },
        term = {
            --  Position to open the terminal, this option is ignored if mode is tab
            mode = "toggleterm",
            position = "bot",
            -- position = "vert",
            -- window size, this option is ignored if tab is true
            size = 20,
        },
    }
end
