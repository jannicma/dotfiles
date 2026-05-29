local M = {}

local uv = vim.uv or vim.loop

local function join(...)
	return table.concat({ ... }, "/")
end

local function has_package_manifest(dir)
	return dir and uv.fs_stat(join(dir, "Package.swift")) ~= nil
end

local function current_dir()
	return vim.fs.normalize(vim.fn.getcwd())
end

local function dirname(path)
	return vim.fs.dirname(path)
end

local function nearest_package_root(fname)
	local current = vim.fs.dirname(vim.fs.normalize(fname))

	while current and current ~= "/" do
		if has_package_manifest(current) then
			return current
		end
		current = dirname(current)
	end
end

function M.root_for_file(fname)
	local cwd = current_dir()

	if has_package_manifest(cwd) then
		return cwd
	end

	return nearest_package_root(fname)
end

function M.root(bufnr, on_dir)
	local fname = vim.api.nvim_buf_get_name(bufnr)
	local root = M.root_for_file(fname)

	if root then
		on_dir(root)
	end
end

function M.workspace_dirs()
	local cwd = current_dir()

	if not has_package_manifest(cwd) then
		return { cwd }
	end

	local dirs = { cwd }
	local seen = { [cwd] = true }
	local parent = dirname(cwd)
	local scan = parent and uv.fs_scandir(parent)

	while scan do
		local name, kind = uv.fs_scandir_next(scan)
		if not name then
			break
		end

		local path = join(parent, name)
		if kind == "directory" and not seen[path] and has_package_manifest(path) then
			table.insert(dirs, path)
			seen[path] = true
		end
	end

	table.sort(dirs, function(a, b)
		if a == cwd then
			return true
		end
		if b == cwd then
			return false
		end
		return a < b
	end)

	return dirs
end

return M
