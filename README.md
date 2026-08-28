# histpop

A zsh function that removes the last record from `~/.zsh_history`.

Useful right after running a command you don't want kept in your shell history (e.g. one containing a typo'd password or a temporary secret). Running `histpop` itself is also removed from history, so it leaves no trace.

## Features

- Removes the last history entry, including its own invocation
- Correctly handles multi-line commands (continuation lines ending in `\`)
- Preserves `~/.zsh_history` file permissions (`600`)
- Shows a diff of what was removed, if `colordiff` is installed

## Dependencies

`histpop` needs a GNU `head` (for negative line counts) and `sponge` from moreutils:

- GNU `head` — the default `head` on Linux; on macOS, install via `coreutils` (exposed as `ghead`, which `histpop` detects automatically, falling back to `head` otherwise)
- `sponge` — from `moreutils`
- `colordiff` (optional, for the diff preview) — from `colordiff`

On macOS:

```zsh
brew install coreutils moreutils colordiff
```

On Linux:

```zsh
sudo apt install moreutils colordiff  # GNU head is already the system default
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
