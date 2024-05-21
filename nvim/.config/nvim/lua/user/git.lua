local neogit = require('neogit')

neogit.setup {
  kind = "vsplit",
	integrations = {
		telescope = true,
		diffview = true,
	},
}
