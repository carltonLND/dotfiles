_G.M = {}

---Helper function for Normal Mode keymaps
---@param lhs string
---@param rhs string|function
---@param buf? integer
---@return nil
function _G.M.n(lhs, rhs, buf)
  return vim.keymap.set(
    "n",
    lhs,
    rhs,
    { noremap = true, silent = true, buffer = buf or nil }
  )
end

---Helper function for Insert Mode keymaps
---@param lhs string
---@param rhs string|function
---@param buf? integer
---@return nil
function _G.M.i(lhs, rhs, buf)
  return vim.keymap.set(
    "i",
    lhs,
    rhs,
    { noremap = true, silent = true, buffer = buf or nil }
  )
end

---Helper function for Visual Mode keymaps
---@param lhs string
---@param rhs string|function
---@param buf? integer
---@return nil
function _G.M.v(lhs, rhs, buf)
  return vim.keymap.set(
    "v",
    lhs,
    rhs,
    { noremap = true, silent = true, buffer = buf or nil }
  )
end

---Helper function for Terminal Mode keymaps
---@param lhs string
---@param rhs string|function
---@param buf? integer
---@return nil
function _G.M.t(lhs, rhs, buf)
  return vim.keymap.set(
    "t",
    lhs,
    rhs,
    { noremap = true, silent = true, buffer = buf or nil }
  )
end

function _G.M.x(lhs, rhs, buf)
  return vim.keymap.set(
    "x",
    lhs,
    rhs,
    { noremap = true, silent = true, buffer = buf or nil }
  )
end
