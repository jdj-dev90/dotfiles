local status_ok, tmux_nav = pcall(require, "nvim-tmux-navigation")
if not status_ok then
	return
end


tmux_nav.setup {
	keybindings = {
		left = "<C-h>",
		down = "<C-j>",
		up = "<C-k>",
		right = "<C-l>",
		last_active = "<C-\\>",
		next = "<C-Space>",
	}
}
