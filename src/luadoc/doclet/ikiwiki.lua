-------------------------------------------------------------------------------
-- Doclet that generates MarkDown output that can be included in a IkiWiki site.
-- This doclet generates a set of mdwn files based on a group of templates.
-- The main templates are: 
-- <ul>
-- <li>index.lp: index of modules and files;</li>
-- <li>file.lp: documentation for a lua file;</li>
-- <li>module.lp: documentation for a lua module;</li>
-- <li>function.lp: documentation for a lua function. This is a 
-- sub-template used by the others.</li>
-- </ul>
-- @author Tuomas Jormola
-- @copyright © 2011 Tuomas Jormola <a href="mailto:tj@solitudo.net">tj@solitudo.net</a> <a href="http://solitudo.net">http://solitudo.net</a>
--  Licensed under the terms of
-- the <a href="http://www.gnu.org/licenses/gpl-2.0.html">GNU General Public License Version 2.0</a>.
--
-------------------------------------------------------------------------------

local assert, getfenv, ipairs, loadstring, pairs, setfenv, tostring, tonumber, type = assert, getfenv, ipairs, loadstring, pairs, setfenv, tostring, tonumber, type
local io = require"io"
local lfs = require "lfs"
local lp = require "luadoc.lp"
local luadoc = require"luadoc"
local package = package
local string = require"string"
local table = require"table"
local print=print

module "luadoc.doclet.ikiwiki"

-------------------------------------------------------------------------------
-- Looks for a file `name` in given path. Removed from compat-5.1
-- @param path String with the path
-- @param name String with the name to look for
-- @return String with the complete path of the file found
--	or nil in case the file is not found.

local function search (path, name)
  for c in path:gfind("[^;]+") do
    c = c:gsub("%?", name)
    local f = io.open(c)
    if f then   -- file exist?
      f:close()
      return c
    end
  end
  return nil    -- file not found
end

-------------------------------------------------------------------------------
-- Include the result of a lp template into the current stream
-- @param template Template name
-- @param env Environment for the template
-- @return String resulted from the template expansion

function include (template, env)
	-- template_dir is relative to package.path
	local templatepath = options.template_dir .. template

	-- search using package.path (modified to search .lp instead of .lua
	local search_path = package.path:gsub("%.lua", "")
	local templatepath = search(search_path, templatepath)
	assert(templatepath, string.format("template `%s' not found", template))

	env = env or {}
	env.table = table
	env.io = io
	env.lp = lp
	env.ipairs = ipairs
	env.tonumber = tonumber
	env.tostring = tostring
	env.type = type
	env.luadoc = luadoc
	env.options = options

	return lp.include(templatepath, env)
end

-------------------------------------------------------------------------------
-- Returns the wikilink of a module
-- @param doc Documentation table
-- @param modulename Name of the module to be processed
-- @return Wikilink string for the module

function module_link (doc, modulename)
	assert(modulename)
	assert(doc)

	if doc.modules[modulename] == nil then
		return
	end

	return doc.rootpage .. "/modules/" .. modulename
end

-------------------------------------------------------------------------------
-- Returns the wikilink of a lua(doc) file
-- @param doc Documentation table
-- @param to Name of the file to be processed, may be a .lua file or
-- a .luadoc file
-- beginning of path
-- @return Wikilink string for the file

function file_link (doc, to)
	assert(to)

	return doc.rootpage .. "/files/" .. to
end

-------------------------------------------------------------------------------
-- Returns a wikilink to a function or to a table
-- @param fname Name of the function or table to link to
-- @param doc Documentation table
-- @param module_doc Modules table
-- @param file_doc Files table
-- @param kind String specifying the kind of element to link ("functions" or "tables"). Default is "functions".
-- @return Wikilink string for the function or table

function link_to (fname, doc, module_doc, file_doc, kind)
	assert(fname)
	assert(doc)
	kind = kind or "functions"

	if file_doc then
		for _, func_name in pairs(file_doc[kind]) do
			if func_name == fname then
				return file_link(doc, file_doc.name) .. "#luadoc-function-" .. fname
			end
		end
	end

	local _, _, modulename, fname = string.find(fname, "^(.-)[%.%:]?([^%.%:]*)$")
	assert(fname)

	-- if fname does not specify a module, use the module_doc
	if #modulename == 0 and module_doc then
		modulename = module_doc.name
	end

	local module_doc = doc.modules[modulename]
	if not module_doc then
		return
	end

	for _, func_name in pairs(module_doc[kind]) do
		if func_name == fname then
			return module_link(doc, modulename) .. "#luadoc-function-" .. fname
		end
	end
end

-------------------------------------------------------------------------------
-- Make a wikilink to a module, function, or table
-- @param symbol Name of the module, function or table
-- @param doc Documentation table
-- @param module_doc Modules table
-- @param file_doc Files table
-- @return Wikilink string for the module, function, or table

	function symbol_link (symbol, doc, module_doc, file_doc)
	assert(symbol)
	assert(doc)

	local link = 
		module_link(doc, symbol) or 
		link_to(symbol, doc, module_doc, file_doc, "functions") or
		link_to(symbol, doc, module_doc, file_doc, "tables")

	if not link then
		logger:error(string.format("unresolved reference to symbol `%s'", symbol))
	end

	return link or ""
end

-------------------------------------------------------------------------------
-- Assembly the output mdwn filename for an input file
-- @param filename input file
-- @return mdwn file name matching the input file
function out_file (filename)
	local h = filename
	h = "files/" .. h .. ".mdwn"
	h = options.output_dir .. h
	return h
end

-------------------------------------------------------------------------------
-- Assembly the output mdwn filename for a module
-- @param modulename module for which to get the filename
-- @return mdwn file name matching the module
function out_module (modulename)
	local h = modulename .. ".mdwn"
	h = "modules/" .. h
	h = options.output_dir .. h
	return h
end

-----------------------------------------------------------------
-- Generate the output
-- @param doc Table with the structured documentation.

function start (doc)
	options.template_dir = options.template_dir:gsub('html/$', 'ikiwiki/')
	doc.rootpage = options.output_dir:match("^.*/([^/]+)/$")

	-- Generate index file
	if (#doc.files > 0 or #doc.modules > 0) and (not options.noindexpage) then
		doc.thispage = doc.rootpage
		local filename = options.output_dir.."index.mdwn"
		logger:info(string.format("generating file `%s'", filename))
		local f = lfs.open(filename, "w")
		assert(f, string.format("could not open `%s' for writing", filename))
		io.output(f)
		include("index.lp", { doc = doc })
		f:close()
	end

	-- Process modules
	if not options.nomodules then
		for _, modulename in ipairs(doc.modules) do
			local module_doc = doc.modules[modulename]
			doc.thispage = module_link(doc, modulename)
			-- assembly the filename
			local filename = out_module(modulename)
			logger:info(string.format("generating file `%s'", filename))
			
			local f = lfs.open(filename, "w")
			assert(f, string.format("could not open `%s' for writing", filename))
			io.output(f)
			include("module.lp", { doc = doc, module_doc = module_doc })
			f:close()
		end
	end

	-- Process files
	if not options.nofiles then
		for _, filepath in ipairs(doc.files) do
			local file_doc = doc.files[filepath]
			doc.thispage = file_link(doc, filepath)
			-- assembly the filename
			local filename = out_file(file_doc.name)
			logger:info(string.format("generating file `%s'", filename))
			
			local f = lfs.open(filename, "w")
			assert(f, string.format("could not open `%s' for writing", filename))
			io.output(f)
			include("file.lp", { doc = doc, file_doc = file_doc} )
			f:close()
		end
	end
end
