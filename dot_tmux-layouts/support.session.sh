if initialize_session "support"; then
	export WINDOW_ROOT="$HOME/StubPythonProject"
	load_window "python-project"

	select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
