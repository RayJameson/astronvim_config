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
        },
    }
end
