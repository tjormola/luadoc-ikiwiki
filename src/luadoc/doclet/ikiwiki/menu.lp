[[Jump to content|<%=doc.thispage%>#luadoc-content"]]

# LuaDoc

<%if not module_doc and not file_doc then%>
* **Index**
<%else%>
* [[Index|<%=doc.rootpage%>]]
<%end%>

<%if not options.nomodules and #doc.modules > 0 then%>
# Modules

<%for _, modulename in ipairs(doc.modules) do
if module_doc and module_doc.name == modulename then%>* **<%=modulename%>**
<%else%>* [[<%=modulename%>|<%=luadoc.doclet.ikiwiki.module_link(doc, modulename)%>]]
<%end%><%end%>
<%end%>

<%if not options.nofiles and #doc.files > 0 then%>
# Files

<%for _, filepath in ipairs(doc.files) do
if file_doc and file_doc.name == filepath then%>* **<%=filepath%>**
<%else%>* [[<%=filepath%>|<%=luadoc.doclet.ikiwiki.file_link(doc, filepath)%>]]
<%end%><%end%>
<%end%>
