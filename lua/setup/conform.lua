-- Conform for Formatting

require("conform").setup({
    -- log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        c = {
            "clang-format"
            -- "ast-grep",
        },
        python = {"isort", "black"},
        lua = {"stylua"}
    },
	-- format_on_save = function(bufnr)
    --    print("Formatting")
    --    return {timeout_ms = 500, lsp_format = "fallback"}
    -- end

})

require("conform").formatters.clang_format = {
    ---[[]] prepend_args = {[[--style="{IndentWidth: 4}"]]}

    ---[[
    prepend_args = function() return {[[--style="{IndentWidth: 4}"]]} end
    -- ]]
    ---[[]] prepend_args = function() return {"--style=\"{IndentWidth:4}\""} end
}

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1,
                                                    args.line2, true)[1]
        range = {
            start = {args.line1, 0},
            ["end"] = {args.line2, end_line:len()}
        }
    end
    require("conform").format({
        async = true,
        lsp_format = "fallback",
        range = range
    })
end, {range = true})

