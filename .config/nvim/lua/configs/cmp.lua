local cmp = require("cmp")
local default_cmp_config = require("nvchad.configs.cmp")
local cmp_next = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
        fallback()
    end
end
local cmp_prev = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
        fallback()
    end
end

-- Merge your custom adjustments with NVChad's default configuration
local custom_config = {
    window = {
        completion = {
            scrollbar = true,
        },
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<S-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<tab>"] = cmp_next,
        ["<down>"] = cmp_next,
        ["<C-p>"] = cmp_prev,
        ["<up>"] = cmp_prev,
    },
    sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "path" },
    },
}

-- Apply the merged configuration
cmp.setup(vim.tbl_deep_extend("force", default_cmp_config, custom_config))

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymor
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})
