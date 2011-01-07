# Generate README.txt file and API documentation

MDWN_FILES		= README.mdwn
LUA_MAIN_MODULE	= $(LUA_SRC_DIR)/luadoc/doclet/ikiwiki.lua
SUBMODULES		= $(PWD)/submodules
MDWN2TEXT_MK	= $(SUBMODULES)/mdwn2text/mdwn2text.mk
LUADOC_MK		= luadoc.mk

all: update-readme update-luadoc

include $(MDWN2TEXT_MK)
include $(LUADOC_MK)

update-readme: README.txt
	git add README.txt
	git commit -m'Updated README.txt from README.txt.mdwn' README.txt || true

update-luadoc: $(LUA_APIDOC_DIR)/html/index.html $(LUA_APIDOC_DIR)/ikiwiki/index.mdwn
	git add $(LUA_APIDOC_DIR)
	git commit -m'Updated API documentation' $(LUA_APIDOC_DIR) || true

$(LUA_APIDOC_DIR)/html/index.html: $(LUA_MAIN_MODULE)
	$(MAKE) luadoc-clean-html
	$(MAKE) luadoc-html

$(LUA_APIDOC_DIR)/ikiwiki/index.mdwn: $(LUA_MAIN_MODULE)
	$(MAKE) luadoc-clean-ikiwiki
	$(MAKE) luadoc-ikiwiki

clean:
	rm -f README.txt
	$(MAKE) luadoc-clean

.PHONY: all update-readme update-luadoc clean