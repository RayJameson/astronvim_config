<!--toc:start-->
- [AstroNvim user configuration](#astronvim-user-configuration)
    - [Red line numbers above cursor, cyan current line, green below current line](#red-line-numbers-above-cursor-cyan-current-line-green-below-current-line)
    - [Highlight function arguments used in function body](#highlight-function-arguments-used-in-function-body)
    - [Fully transparent background via transparent.nvim](#fully-transparent-background-via-transparentnvim)
    - [Code runner via code_runner.nvim](#code-runner-via-code_runnernvim)
    - [No neo-tree.nvim, I use mini.files and oil.nvim insted](#no-neo-treenvim-i-use-minifiles-and-oilnvim-insted)
    - [No bufferline and tabline](#no-bufferline-and-tabline)
    - [AI completion via codeium.vim](#ai-completion-via-codeiumvim)
    - [Yank history using yanky.nvim](#yank-history-using-yankynvim)
    - ~~[Random alpha header](#random-alpha-header)~~
<!--toc:end-->


# AstroNvim user configuration

I doubt anyone wish to use this config as is, so here is some cool features if anyone wants to yoink them:  
<img width="1728" alt="image" src="https://github.com/RayJameson/astronvim_config/assets/67468725/5912b1d1-2346-4424-a847-a607a152c99d">
<img width="1728" alt="image" src="https://github.com/RayJameson/astronvim_config/assets/67468725/fc4572e1-d775-4ffb-8e14-b1b03cf2d0c0">

### Red line numbers above cursor, cyan current line, green below current line

[How to set it up](astrotheme-config)  

### Highlight function arguments used in function body

[hlargs repo](hlargs-repo)  
[config file](hlargs-config)  
<img width="1066" alt="image" src="https://github.com/RayJameson/astronvim_config/assets/67468725/1cc3a467-c93f-4f4b-bbbc-3d164d56d1f9">

### Fully transparent background via transparent.nvim

[transparent.nvim](transparent-nvim-repo)  
I'm using pinned version of [astrotheme](astrotheme-repo)
with [those](highlight-colors) colors and additional
[highlight groups](transparent-groups)  
_toggle transparency using `<leader>uT` or `:TransparentToggle`_

### Code runner via code_runner.nvim

[code_runner.nvim](core-runner-repo)  
[config file](code-runner-config)  
Very simple to add additional filetypes to run  
_code runner options are in submenu using `<leader>r`_

### No neo-tree.nvim, I use mini.files and oil.nvim insted

[oil config file](oil-config)  
I don't thik you need that permanent filetree sidebar as in your IDE or code editor.  
If you need to see some project structure - use `tree` command in terminal.  
If you need to naviagate files inside Neovim - use Telescope.  
If you need to move/copy/delete a file or two - use terminal commands `mv`, `cp` and `rm`.  
If you need to make some bulk file operation - then you may need filetree, in this case use `mini.files` (`<leader>e`)
or `oil.nvim` (`-`) and edit your files just like text buffer

Why both `mini.files` and `oil.nvim`? `mini.files` doesn't support `nvim .` command and can't be used for ssh.
Oil does (for ssh use `nvim oil-ssh://user@host/path/to/file`)

### No bufferline and tabline

Same reason as above, for navigating I use Telescope and [grapple.nvim](grapple-repo) plugin.
I used [harpoon.nvim](harpoon-repo) before, but [grapple.nvim](grapple-repo) 
has a little bit more functionality, although they both are very similar.

Check this video of ThePrimeagen explaining `harpoon.nvim`  
[![harpoon-video](https://img.youtube.com/vi/Qnos8aApa9g/0.jpg)](https://youtu.be/Qnos8aApa9g)

### AI completion via codeium.vim

[codeium.vim](codeium-repo)  
[config file](codeium-config)  
Very useful for boilerplate stuff, such as copy-paste with a bit of change in some text/variable etc
Also it's free for personal use.  
<img width="1031" alt="image" src="https://github.com/RayJameson/astronvim_config/assets/67468725/9f99070f-1747-4544-98d8-cf250e42bd8a">
_By default there is some telemetry which can be opted-out in your profile_

### Yank history using yanky.nvim

[yanky.nvim](yanky-repo)  
[config file](yanky-config)  
As I said in this issue gbprod/yanky.nvim#122
I believe yank history should be treated as a stack, and plugin's author agrees with me,
so until new commands will be implemented, I will use changed behavior of commands

### ~~Random alpha header~~

I removed alpha plugin because it's doesn't bring any functionality, but takes some of loading time
If you want to yoink that random alpha header - [config file](header-config), and [here is how to add it](how-to-add-random-alpha-header)


[astrotheme-config]: https://github.com/RayJameson/astronvim_config/blob/main/highlights/astrotheme.lua#L3-L5
[hlargs-repo]: https://github.com/m-demare/hlargs.nvim
[hlargs-config]: https://github.com/RayJameson/astronvim_config/blob/main/plugins/user.lua#L14-L21
[transparent-nvim-repo]: https://github.com/xiyaowong/transparent.nvim
[astrotheme-repo]: https://github.com/AstroNvim/astrotheme/tree/7a52efdd9a5bd302445d284a424467f92e4b1d44
[highlight-colors]: https://github.com/RayJameson/astronvim_config/blob/main/highlights/astrotheme.lua
[transparent-groups]: https://github.com/RayJameson/astronvim_config/blob/main/plugins/community.lua#L44-L103
[core-runner-repo]: https://github.com/CRAG666/code_runner.nvim
[code-runner-config]: https://github.com/RayJameson/astronvim_config/blob/main/plugins/code_runner.lua
[neo-tree-repo]: https://github.com/nvim-neo-tree/neo-tree.nvim
[oil-config]: https://github.com/RayJameson/astronvim_config/blob/main/plugins/oil.lua
[grapple-repo]: https://github.com/cbochs/grapple.nvim
[harpoon-repo]: https://github.com/ThePrimeagen/harpoon
[codeium-repo]: https://github.com/Exafunction/codeium.vim
[codeium-config]: https://github.com/RayJameson/astronvim_config/blob/main/plugins/user.lua#L22-L32
[yanky-repo]: https://github.com/gbprod/yanky.nvim
[yanky-config]: https://github.com/RayJameson/astronvim_config/blob/main/plugins/yanky.lua
[header-config]: https://github.com/RayJameson/astronvim_config/blob/9112999beff3f8455e0cc77beb07318c017d110a/header.lua
[how-to-add-random-alpha-header]: https://github.com/RayJameson/astronvim_config/blob/9112999beff3f8455e0cc77beb07318c017d110a/plugins/core.lua#L12-L19
