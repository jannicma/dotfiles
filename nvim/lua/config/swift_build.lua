local M = {}

local function split_lines(text)
	local lines = {}
	for line in (text or ""):gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end
	return lines
end

local function parse_diagnostics(output)
	local items = {}

	for _, line in ipairs(split_lines(output)) do
		local filename, lnum, col, kind, message = line:match("^(.+%.swift):(%d+):(%d+):%s+(%w+):%s+(.+)$")
		if filename then
			local item_type = ({ error = "E", warning = "W", note = "N" })[kind] or "I"
			table.insert(items, {
				filename = filename,
				lnum = tonumber(lnum),
				col = tonumber(col),
				type = item_type,
				text = message,
			})
		end
	end

	return items
end

local function project_root()
	local current_file = vim.api.nvim_buf_get_name(0)
	return require("config.swiftpm").root_for_file(current_file) or vim.fn.getcwd()
end

local function open_quickfix()
	local ok, telescope = pcall(require, "telescope.builtin")
	if ok then
		telescope.quickfix()
	else
		vim.cmd.copen()
	end
end

function M.run()
	local root = project_root()
	vim.notify("Running swift build...", vim.log.levels.INFO)

	vim.system({ "swift", "build" }, { cwd = root, text = true }, function(result)
		vim.schedule(function()
			local output = table.concat({ result.stdout or "", result.stderr or "" }, "\n")
			local items = parse_diagnostics(output)

			vim.fn.setqflist({}, "r", {
				title = "swift build",
				items = items,
			})

			if #items == 0 then
				if result.code == 0 then
					vim.notify("swift build succeeded", vim.log.levels.INFO)
				else
					vim.notify("swift build failed, but no Swift diagnostics were parsed", vim.log.levels.WARN)
				end
				return
			end

			open_quickfix()
		end)
	end)
end

return M
