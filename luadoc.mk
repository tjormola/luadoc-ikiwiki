#
# This makefile can be used to execute luadoc to generate API documentation
# in HTML and IkiWiki formats from Lua source code. See the site
# http://luadoc.luaforge.net for more information about LuaDoc.
#
# Usage:
#
# 1. Have this file available under your project tree,
#    e.g. submodules/luadoc/luadoc.mk
#
# 2. Include this file in your main Makefile, e.g.
#
#    include submodules/luadoc/luadoc.mk
#
# 3. Define LUA_SRC_DIR and LUA_APIDOC_DIR variables in your main Makefile (or
#    use defaults if these are ok, see below)
#
# 4. Include following kind of targets in your main Makefile to generate API
#    documentation for your Lua projects on demand:
#
# LUA_MAIN_MODULE = $(LUA_SRC_DIR)/metar.lua
# SUBMODULES      = $(PWD)/submodules
# LUADOC_DIR      = $(SUBMODULES)/luadoc-ikiwiki
# LUA_PATH        = ;;$(LUADOC_DIR)/src/?.lua
#
# export LUA_PATH
#
# update-luadoc: $(LUA_API_DIR)/html/index.html $(LUA_API_DIR)/ikiwiki/index.mdwn
#
# $(LUA_API_DIR)/html/index.html: $(LUA_MAIN_MODULE)
#	$(MAKE) luadoc-clean-html
#	$(MAKE) luadoc-html

# $(LUA_API_DIR)/ikiwiki/index.mdwn: $(LUA_MAIN_MODULE)
#	$(MAKE) luadoc-clean-ikiwiki
#	$(MAKE) luadoc-ikiwiki
#
# See below for the variable definitions.
#
# Copyright: © 2010 Tuomas Jormola <tj@solitudo.net> http://solitudo.net
#
# Licensed under the terms of the GNU General Public License Version 2.0.
# License terms are included in the file `COPYING`.
#

# The luadoc command
LUADOC				?= luadoc

# Directory where luadoc writes API documentation files. Under this directory
# directories 'html' and 'ikiwiki' are created which contains API documentation
# in these formats.
LUA_APIDOC_DIR		?= $(PWD)/api

# Directory under which to search for the Lua source files
LUA_SRC_DIR			?= src

LUA_SRC_FILES		?= $(shell cd $(LUA_SRC_DIR) && find . -name '*.lua' | cut -d/ -f2-)

luadoc: luadoc-html luadoc-ikiwiki

luadoc-clean: luadoc-clean-html luadoc-clean-ikiwiki

luadoc-clean-%:
	rm -rf $(LUA_APIDOC_DIR)/$(subst luadoc-clean-,,$@)

luadoc-%:
	cd $(LUA_SRC_DIR) && $(LUADOC) -d $(LUA_APIDOC_DIR)/$(subst luadoc-,,$@) --doclet luadoc.doclet.$(subst luadoc-,,$@) $(LUA_SRC_FILES)

.PHONY: luadoc luadoc-clean
