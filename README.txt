                           IkiWiki doclet for LuaDoc

   This is a doclet for [1]LuaDoc that writes wiki pages for [2]IkiWiki
   wiki compiler software from Lua source files documented with [3]LuaDoc
   markup. Wiki pages are written as [4]Markdown files.

                                  Downloading

   IkiWiki doclet for LuaDoc home page is at
   [5]http://solitudo.net/software/lua/luadoc-ikiwiki/ and it can be
   downloaded by cloning the public Git repository at
   git://scm.solitudo.net/luadoc-ikiwiki.git. Gitweb interface is
   available at
   [6]http://scm.solitudo.net/gitweb/public/luadoc-ikiwiki.git.

                                  Installation

   Install the src/luadoc under some of the directories included in the
   default LUA_PATH for your Lua distribution, or install under desired
   location and set LUA_PATH accordingly. More info about LUA_PATH at
   [7]http://www.lua.org/pil/8.1.html.

                                     Usage

    1. Use --doclet luadoc.doclet.ikiwiki command line argument when
       running luadoc(1).
    2. Copy the resulting directory tree with .mdwn files under your
       IkiWiki srcdir so that the API documentation can be published as
       part of your wiki.

                                   Automation

   If you want to automate creation of the API documentation using [8]GNU
   Make on demand, see the makefile luadoc.mk for more information how to
   do that.

                               API Documentation

   API documentation for luadoc-ikiwiki is available under the api/
   directory of the distribution.

                            Copyright and licensing

   Copyright: © 2011 Tuomas Jormola [9]tj@solitudo.net
   [10]http://solitudo.net

   Licensed under the terms of the [11]GNU General Public License Version
   2.0. License terms are included in the file COPYING.

   This doclet is based on the [12]HTML doclet included in the [13]LuaDoc
   distribution.

   LuaDoc codebase was designed and developed by Tomás Guisasola. Version
   3.0 was refactored by Danilo Tuler and Tomás Guisasola as part of the
   [14]Kepler Project, which holds its copyright.

   LuaDoc credits snippet above was copied from
   [15]http://luadoc.luaforge.net/index.html#credits and included here in
   order for this software to be compatible with the [16]LuaDoc license.

References

   1. http://luadoc.luaforge.net/
   2. http://ikiwiki.info/
   3. http://luadoc.luaforge.net/manual.html#howto
   4. http://daringfireball.net/projects/markdown/
   5. http://solitudo.net/software/lua/luadoc-ikiwiki/
   6. http://scm.solitudo.net/gitweb/public/luadoc-ikiwiki.git
   7. http://www.lua.org/pil/8.1.html
   8. http://www.gnu.org/software/automake/
   9. mailto:tj@solitudo.net
  10. http://solitudo.net/
  11. http://www.gnu.org/licenses/gpl-2.0.html
  12. http://luadoc.luaforge.net/api/modules/luadoc.doclet.html.html
  13. http://luaforge.net/projects/luadoc/files
  14. http://www.keplerproject.org/
  15. http://luadoc.luaforge.net/index.html#credits
  16. http://luadoc.luaforge.net/license.html
