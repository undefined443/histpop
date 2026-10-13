function histpop() {
	# Delete the last zsh history record
	local head_cmd=head
	command -v ghead >/dev/null && head_cmd=ghead

	# Abort early: BSD head fails on negative counts and would empty the history
	"$head_cmd" --version 2>/dev/null | grep -q GNU || {
		echo "histpop: GNU head is required (brew install coreutils)." >&2
		return 1
	}

	# Keep an untouched copy of the history for the diff and as the source
	local old_history new_history
	old_history=$(mktemp)
	new_history=$(mktemp)
	cp ~/.zsh_history "$old_history"

	# Remove the last entry, plus the histpop invocation itself if present
	local remove_lines=1
	[[ "$(tail -n 1 "$old_history")" =~ 'histpop' ]] && remove_lines=2

	# Handle multi-line commands that end with two backslash
	while [[ "$("$head_cmd" -n -"$remove_lines" "$old_history" | tail -n 1)" =~ .*\\\\$ ]]; do
		((remove_lines++))
	done

	"$head_cmd" -n -"$remove_lines" "$old_history" > "$new_history"

	# Finally, move the new history in place
	mv "$new_history" ~/.zsh_history
	chmod 600 ~/.zsh_history

	# Show what was removed when colordiff is available
	if command -v colordiff >/dev/null; then
		colordiff -u "$old_history" ~/.zsh_history | grep -aEv '^.*(---|\+\+\+|@@)'
	else
		echo "colordiff is not installed, skipping diff display."
	fi

	# Clean up
	rm "$old_history"
}
