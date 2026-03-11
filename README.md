# Dotfiles

My personal terminal-focused configuration files.

## Install

>[!WARNING]
> You may not want most of the configuration presented here.
> Please read the files before installing them.

```bash
git clone https://github.com/rodrigo-pariente/dotfiles
mv dotfiles .dotfiles # optional, for a cleaner home directory
cd .dotfiles
./install             # -h to see available options
```

You can also install only specific configurations by passing their names:

`./install nvim ghostty`

Or using interactive mode to choose which ones to install:

`./install -i`
