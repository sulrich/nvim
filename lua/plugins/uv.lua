return {
  -- see: https://github.com/benomahony/uv.nvim 
	"benomahony/uv.nvim",
	opts = {
		keymaps = {
			prefix = "<leader>p",
      -- disable invoking the picker for the command list. this is better shown
      -- using the which-key display and less intrusive.
      commands = false,
		},
		picker_integration = true,
	},
}
