local status_ok, pqf = pcall(require, "nvim-pqf")
if not status_ok then
  return
end

pqf.setup {}
