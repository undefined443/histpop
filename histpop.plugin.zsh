function histpop() {
	# Delete the last zsh history record
	local head_cmd=head
	command -v ghead >/dev/null && head_cmd=ghead

	# Verify the negative line-count behavior used below; BSD head rejects it.
	local head_probe
	head_probe=$(printf 'one\ntwo\nthree\n' | "$head_cmd" -n -1 2>/dev/null) || {
		echo "histpop: head with negative line-count support is required." >&2
		return 1
	}
	[[ "$head_probe" == $'one\ntwo' ]] || {
		echo "histpop: head with negative line-count support is required." >&2
		return 1
	}

	# Keep an untouched copy of the history for the diff and as the source;
	# create the new file beside HISTFILE so the final mv is an atomic rename
	local old_history new_history
	old_history=$(mktemp)
	new_history=$(mktemp "$HISTFILE.XXXXXX")
	cp "$HISTFILE" "$old_history"

	# Remove the last entry, plus the histpop invocation itself if present
	local remove_lines=1
	[[ "$(tail -n 1 "$old_history")" =~ 'histpop' ]] && remove_lines=2

	# Handle multi-line commands that end with two backslash
	while [[ "$("$head_cmd" -n -"$remove_lines" "$old_history" | tail -n 1)" =~ .*\\\\$ ]]; do
		((remove_lines++))
	done

	"$head_cmd" -n -"$remove_lines" "$old_history" > "$new_history"

	# Finally, move the new history in place
	mv "$new_history" "$HISTFILE"

	# Show what was removed, colorized when colordiff is available
	local diff_cmd=diff
	command -v colordiff >/dev/null && diff_cmd=colordiff
	"$diff_cmd" -u "$old_history" "$HISTFILE" | grep -aEv '^.*(---|\+\+\+|@@)'

	# Clean up
	rm "$old_history"
}
