[[!meta title="LuaDoc - <%=file_doc.name%>"]]

<div id="luadoc" markdown="1">

<%=luadoc.doclet.ikiwiki.include("menu.lp", { doc=doc, file_doc=file_doc })%>

---

<span id="luadoc-content" />

# File `<%=file_doc.name%>`

<%if file_doc.description then%>
<%=file_doc.description%>
<%end%>

<%if file_doc.author then%>
**<%= #file_doc.author>1 and "Authors" or "Author" %>:**

<%for _, author in ipairs(file_doc.author) do%>* <%= author %>
<%end%>
<%end%>

<%if file_doc.copyright then%>
Copyright: <%=file_doc.copyright%>
<%end%>

<%if file_doc.release then%>
**Release:** <%=file_doc.release%>
<%end%>

<%if #file_doc.functions > 0 then%>
## Functions summary

| - | - |
<%for _, func_name in ipairs(file_doc.functions) do local func_data = file_doc.functions[func_name]%>
| <%=func_data.private and "`local` " or ""%>[[`<%=func_name%>`|<%=doc.rootpage%>/files/<%=file_doc.name%>#luadoc-function-<%=func_name%>]] `(`*`<%=table.concat(func_data.param, ", ")%>`*`)` | <%=func_data.summary%> |
<%end%>
<%end%>

<%if #file_doc.tables > 0 then%>
## Tables summary

| - | - |
<%for _, tab_name in ipairs(file_doc.tables) do%>| [[`<%=tab_name%>`|<%=doc.rootpage%>/files/<%=file_doc.name%>#luadoc-table-<%=tab_name%>]] | <%=file_doc.tables[tab_name].summary%> |
<%end%>
<%end%>

<%if #file_doc.functions > 0 then%>
## Functions
<%for _, func_name in ipairs(file_doc.functions) do%>
<%=luadoc.doclet.ikiwiki.include("function.lp", { doc=doc, file_doc=file_doc, func=file_doc.functions[func_name] })%>
<%end%>
<%end%>

<%if #file_doc.tables > 0 then%>
## Tables
<%for _, tab_name in ipairs(file_doc.tables) do%>
<%=luadoc.doclet.ikiwiki.include("table.lp", { doc=doc, file_doc=file_doc, tab=file_doc.tables[tab_name] })%>
<%end%>
<%end%>

</div>
