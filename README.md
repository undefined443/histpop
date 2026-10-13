# histpop

A zsh function that removes the last record from the file `$HISTFILE` points to (`~/.zsh_history` by default).

Useful right after running a command you don't want kept in your shell history (e.g. one containing a typo'd password or a temporary secret). Running `histpop` itself is also removed from history, so it leaves no trace.

## Features

- Removes the last history entry, including its own invocation
- Correctly handles multi-line commands (continuation lines ending in `\`)
- Shows a diff of what was removed (colorized if `colordiff` is installed)

## Dependencies

- GNU `head` — the default on Linux; on macOS, install `coreutils` (`ghead` is detected automatically)
- `colordiff` (optional) — colorizes the diff preview

On macOS:

```zsh
brew install coreutils colordiff
```

On Linux:

```zsh
sudo apt install colordiff  # GNU head is already the system default
```

## Installation

### Manual

```zsh
git clone https://github.com/undefined443/histpop.git ~/.zsh/plugins/histpop
echo "source ~/.zsh/plugins/histpop/histpop.plugin.zsh" >> ~/.zshrc
```

### oh-my-zsh

```zsh
git clone https://github.com/undefined443/histpop.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/histpop
```

Add `histpop` to the `plugins=(...)` array in `~/.zshrc`.

### zinit

```zsh
zinit light undefined443/histpop
```

### antidote

```zsh
antidote bundle undefined443/histpop
```

## Usage

```zsh
$ some-command-with-a-typo'd-secret
$ histpop
```

## License

MIT
