local deps = {
  "vim-floaterm",
  "nvim-dap",
}

for _, dep in ipairs(deps) do
  if not packer_plugins[dep] then
    return
  end
end

-- Floaterm
vim.g.floaterm_title = " Neovim Terminal: $1/$2 "
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

M.n("<leader>tn", "<cmd>FloatermNew<cr>")
M.n("<leader>tt", "<cmd>FloatermToggle<cr>")
M.n("<leader>G", "<cmd>FloatermNew lazygit<cr>")

M.t("<Esc><Esc>", "<cmd>FloatermToggle!<cr>")
M.t("<Esc>n", "<cmd>FloatermNew<cr>")
M.t("<Esc>q", "<cmd>FloatermKill<cr>")
M.t("<Esc>Q", "<cmd>FloatermKill!<cr>")
M.t("<Esc>h", "<cmd>FloatermPrev<cr>")
M.t("<Esc>l", "<cmd>FloatermNext<cr>")
M.t("<Esc>k", "<Up>")
M.t("<Esc>j", "<Down>")

-- Filetype Extras
vim.api.nvim_create_autocmd("BufEnter", {
  group = UserGroup,
  callback = function(args)
    local ft = vim.bo.filetype
    if ft == "python" then
      M.n(
        "<leader>r",
        "<cmd>FloatermNew --autoclose=0 --title=Run py %<cr>",
        args.buf
      )
    elseif ft == "javascript" then
      M.n(
        "<leader>r",
        "<cmd>FloatermNew --autoclose=0 --title=Run npm run start<cr>",
        args.buf
      )
    elseif ft == "lua" then
      M.n(
        "<leader>r",
        "<cmd>FloatermNew --autoclose=0 --title=Run lua %<cr>",
        args.buf
      )
    elseif ft == "rust" then
      M.n(
        "<leader>r",
        "<cmd>FloatermNew --autoclose=0 --title=Run cargo run<cr>",
        args.buf
      )
    end
  end,
})
