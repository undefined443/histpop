function histpop() {
	# Delete the last zsh history record
	local old_history new_history
	old_history=$(mktemp)
	new_history=$(mktemp)

	# Copy current history to temporary files
	cp ~/.zsh_history "$old_history"
	cp ~/.zsh_history "$new_history"

	# Read the last command
	local last_command
	last_command=$(tail -n 1 "$new_history")

	# Decide how many lines to remove
	local remove_lines=1
	[[ "$last_command" =~ 'histpop' ]] && remove_lines=2

	ghead -n -"$remove_lines" "$new_history" | sponge "$new_history"

	# Handle multi-line commands that end with two backslash
	while [[ "$(tail -n 1 "$new_history")" =~ .*\\\\$ ]]; do
		ghead -n -1 "$new_history" | sponge "$new_history"
	done

	# Finally, move the new history in place
	mv "$new_history" ~/.zsh_history
	chmod 600 ~/.zsh_history

	# Optionally, show differences (requires colordiff, might be omitted or ensured it's installed)
	if command -v colordiff >/dev/null; then
		colordiff -u "$old_history" ~/.zsh_history | grep -Ev '^.*(---|\+\+\+|@@)'
	else
		echo "colordiff is not installed, skipping diff display."
	fi

	# Clean up
	rm "$old_history"
}
