window_root "$WINDOW_ROOT"

new_window "${WINDOW_ROOT##*/}"

split_v 20

run_cmd "evenv" 1 # runs in active pane
run_cmd "nvim" 1  # runs in active pane
run_cmd "evenv"   # runs in pane 1

select_pane 1
