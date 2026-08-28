# histpop

A zsh function that removes the last record from `~/.zsh_history`.

Useful right after running a command you don't want kept in your shell
history (e.g. one containing a typo'd password or a temporary secret).
Running `histpop` itself is also removed from history, so it leaves no trace.

## Features

- Removes the last history entry, including its own invocation
- Correctly handles multi-line commands (continuation lines ending in `\`)
- Preserves `~/.zsh_history` file permissions (`600`)
- Shows a diff of what was removed, if `colordiff` is installed

## Dependencies

`histpop` relies on GNU coreutils and moreutils:

- `ghead` (GNU `head`, for negative line counts) — from `coreutils`
- `sponge` — from `moreutils`
- `colordiff` (optional, for the diff preview) — from `colordiff`

On macOS:

```zsh
brew install coreutils moreutils colordiff
```

On Linux, GNU `head` is usually the default `head`; adjust the `ghead` calls
in `histpop.plugin.zsh` to `head` if you don't have GNU coreutils prefixed.

## Installation

### Manual

```zsh
git clone https://github.com/<your-username>/histpop.git ~/.zsh/plugins/histpop
echo "source ~/.zsh/plugins/histpop/histpop.plugin.zsh" >> ~/.zshrc
```

### oh-my-zsh

```zsh
git clone https://github.com/<your-username>/histpop.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/histpop
```

Add `histpop` to the `plugins=(...)` array in `~/.zshrc`.

### zinit

```zsh
zinit light <your-username>/histpop
```

### antidote

```zsh
antidote bundle <your-username>/histpop
```

## Usage

```zsh
$ some-command-with-a-typo'd-secret
$ histpop
```

## License

MIT
