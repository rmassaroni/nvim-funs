local M = {}

--local popup_content = "Hello world"

function M.popup()
    local popup_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(popup_buf, 0, 1, false, {"Hello world"})

    --local popup_win = vim.api.nvim_open_win(0, true, {
    local popup_win = vim.api.nvim_open_win(popup_buf, true, {
        relative = "cursor",
        width = 120,
        height = 20,
        row = 1,
        col = 1,
        style = "minimal",
        border = "single",
    })

    --vim.api.nvim_buf_set_lines(popup_win, 0, 1, false, {"Hello world"})
    --vim.api.nvim_buf_set_lines(vim.api.nvim_win_get_buf(popup_win), 0, 1, false, {"Hello world"})

    local function on_keypress(key)
        if key == "q" or key == "<Esc>" then
            vim.api.nvim_win_close(popup_win, true)
            --vim.api.nvim_buf_detach(popup_buf)
        end
    end

    vim.api.nvim_win_set_option(popup_win, "wrap", false)  -- Disable line wrapping
    vim.api.nvim_win_set_option(popup_win, "cursorline", false)  -- Disable cursorline
    --vim.api.nvim_win_set_option(popup_win, "cursorcolumn", false)  -- Disable cursorcolumn

    --vim.api.nvim_buf_set_keymap(popup_win, "n", "<Esc>", "<Cmd>q<CR>", { noremap = true })
    --vim.api.nvim_buf_set_keymap(popup_win, "n", "q", "<Cmd>q<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(vim.api.nvim_win_get_buf(popup_win), "n", "<Esc>", "<Cmd>q<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(vim.api.nvim_win_get_buf(popup_win), "n", "q", "<Cmd>q<CR>", { noremap = true })

    --local popup_buf = vim.api.nvim_win_get_buf(popup_win)
    pcall(function()
        vim.api.nvim_buf_attach(popup_buf, false, {
            --on_detach = function()
            --    vim.api.nvim_buf_detach(popup_buf)
            --end,
            --on_input = function(_, input)
            --on_input = function(input)
            on_input = function(input)
                --local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
                --local input = lines[1] or ""
                on_keypress(input)
            end,
        })
    end)
end

return M
