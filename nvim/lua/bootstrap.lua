local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) and vim.fn.executable('git') then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- Reverse/Apply local patches when updating/installing plugins.
local patches_path = vim.fn.stdpath('config') .. '/patch/'
local plugins_path = vim.fn.stdpath 'data' .. '/lazy/'
local agLazyPatches = vim.api.nvim_create_augroup('LazyPatches', {})
vim.api.nvim_create_autocmd('User', {
    pattern = { 'LazyInstallPre', 'LazyUpdatePre' },
	group = agLazyPatches,
	callback = function()
		for patch in vim.fs.dir(patches_path) do
			local patch_path = patches_path .. patch
			local plugin_path = plugins_path .. patch:gsub('%.patch$', '')
			if vim.loop.fs_stat(plugin_path) then
				vim.notify('Lazy: reverting patch ' .. patch)
				local sh_out = vim.fn.system {
					'git', '-C', plugin_path,
					'apply', '--reverse', '--ignore-space-change',
					patch_path,
				}
				if vim.v.shell_error ~= 0 then
					vim.notify('Failed to reverse ' .. patch .. ':\n' .. sh_out, vim.log.levels.WARN)
				end
			end
		end
	end,
	desc = 'Reverse local patches when installing plugins.',
})
vim.api.nvim_create_autocmd('User', {
    pattern = { 'LazyInstall', 'LazyUpdate' },
	group = agLazyPatches,
	callback = function()
		for patch in vim.fs.dir(patches_path) do
			local patch_path = patches_path .. patch
			local plugin_path = plugins_path .. patch:gsub('%.patch$', '')
			if vim.loop.fs_stat(plugin_path) then
				vim.notify('Lazy: applying patch ' .. patch)
				local sh_out = vim.fn.system {
					'git', '-C', plugin_path,
					'apply', '--ignore-space-change',
					patch_path,
				}
				if vim.v.shell_error ~= 0 then
					vim.notify('Failed to apply ' .. patch .. ':\n' .. sh_out, vim.log.levels.WARN)
				end
			end
		end
	end,
	desc = 'Apply local patches when installing plugins.',
})
