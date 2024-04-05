local M = {}

--local popup_content = "Hello world"

function M.popup()
    local popup_win = vim.api.nvim_open_win(0, true, {
        relative = "cursor",
        width = 1,
        height = 1,
        row = 1,
        col = 1,
        style = "minimal",
        border = "single",
    })

    vim.api.nvim_buf_set_lines(popup_win, 0, 1, false, {"Hello world"})

    local function on_keypress(key)
        if key == "q" or key == "<Esc>" then
            vim.api.nvim_win_close(popup_win, true)
            vim.api.nvim_buf_detach(popup_buf)
        end
    end

    local popup_buf = vim.api.nvim_win_get_buf(popup_win)
    vim.api.nvim_buf_attach(popup_buf, false, {
        on_detach = function()
            vim.api.nvim_buf_detach(popup_buf)
        end,
        on_input = function(_, input)
            on_keypress(input)
        end,
    })
end

return M
