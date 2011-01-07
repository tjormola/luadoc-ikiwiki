[[!meta title="LuaDoc"]]

<div id="luadoc" markdown="1">

<%=luadoc.doclet.ikiwiki.include("menu.lp", { doc=doc })%>

---

<span id="luadoc-content" />

<%if not options.nomodules and #doc.modules > 0 then%>
## Modules

| - | - |
<%for _, modulename in ipairs(doc.modules) do%>| [[<%=modulename%>|<%=luadoc.doclet.ikiwiki.module_link(doc, modulename)%>]] | <%=doc.modules[modulename].summary%> |
<%end%>
<%end%>

<%if not options.nofiles and #doc.files > 0 then%>
## Files

| - |
<%for _, filepath in ipairs(doc.files) do%>| [[<%=filepath%>|<%=luadoc.doclet.ikiwiki.file_link(doc, filepath)%>]] |
<%end%>
<%end%>

</div>
