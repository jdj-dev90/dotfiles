local status_ok, spectre = pcall(require, "nvim-spectre")
if not status_ok then
  return
end

spectre.setup {}
