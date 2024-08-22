local options = {
    debug = true,
    font = nil,
    theme = "Monokai Extended",
    line_offset = 1,
    -- here a function is used to return the actual source code line number
    -- line_offset = function(args)
    --     return args.line1
    -- end,
    -- language = nil, -- try filetype and then extension
    language = function()
        return vim.bo.filetype
    end,
    -- language = function()
    -- 	return vim.fn.fnamemodify(
    -- 		vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
    -- 		":e"
    -- 	)
    -- end
    -- window_title = nil,
    window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
    end,
    -- output = nil
    output = function()
        return "./" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
    end,
}

require("nvim-silicon").setup(options)
