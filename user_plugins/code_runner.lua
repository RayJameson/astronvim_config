return function()
    require("code_runner").setup {
        -- put here the commands by filetype
        startinsert = false,
        filetype = {
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            python = "python3 -u",
            lua = "lua",
            typescript = "deno run",
            rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
            javascript = "node",
            shellscript = "bash",
            go = "go run",
            scala = "scala",
        },
    }
end
