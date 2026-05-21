local M = {}

local uv = vim.uv or vim.loop

local function join(...)
	return table.concat({ ... }, "/")
end

local function has_package_manifest(dir)
	return dir and uv.fs_stat(join(dir, "Package.swift")) ~= nil
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

function M.root(fname)
	local cwd = uv.cwd()

	if has_package_manifest(cwd) then
		return cwd
	end

	return nearest_package_root(fname)
end

function M.workspace_dirs()
	local cwd = uv.cwd()

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
