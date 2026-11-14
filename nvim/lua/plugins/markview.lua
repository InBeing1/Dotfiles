return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    -- dependencies = { "saghen/blink.cmp" },
    config = function()
        require("markview").setup({
            preview = {
                enable = false,
            },
            vim.keymap.set("n", "<leader>pm", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
        })
    end
}
