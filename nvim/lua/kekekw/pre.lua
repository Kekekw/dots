local download_packer = function()
	local choice = vim.fn.inputlist({ "Install packer or not ? 1. Yes, 2. No" })

	if choice ~= 1 then
		return
	end

	local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))
	
	vim.fn.mkdir(diirectory, "p")
	
	local out = vim.fn.system(string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim"))

	print("Downloading packer.nvim...")
	print(out)
	print("You need to restart and run :PackerInstall")
end

return function()
	if not pcall(require, "packer") then
		download_packer()
		return true
	end
	return false
end
