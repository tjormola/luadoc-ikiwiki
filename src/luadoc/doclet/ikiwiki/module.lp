[[!meta title="LuaDoc - <%=module_doc.name%>"]]

<div id="luadoc" markdown="1">

<%=luadoc.doclet.ikiwiki.include("menu.lp", { doc=doc, module_doc=module_doc })%>

---

<span id="luadoc-content" />

# Module `<%=module_doc.name%>`

<%if module_doc.description then%>
<%=module_doc.description%>
<%end%>

<%if module_doc.author then%>
**<%= #module_doc.author>1 and "Authors" or "Author" %>:**

<%for _, author in ipairs(module_doc.author) do%>* <%= author %>
<%end%>
<%end%>

<%if module_doc.copyright then%>
Copyright: <%=module_doc.copyright%>
<%end%>

<%if module_doc.release then%>
**Release:** <%=module_doc.release%>
<%end%>

<%if #module_doc.functions > 0 then%>
## Functions summary

| - | - |
<%for _, func_name in ipairs(module_doc.functions) do%>| <%=module_doc.functions[func_name].private and "`local` " or ""%>[[`<%=func_name%>`|<%=doc.rootpage%>/modules/<%=module_doc.name%>#luadoc-function-<%=func_name%>]] `(`*`<%=table.concat(module_doc.functions[func_name].param, ", ")%>`*`)` | <%=module_doc.functions[func_name].summary%> |
<%end%>
<%end%>

<%if #module_doc.tables > 0 then%>
## Tables summary

| - | - |
<%for _, tab_name in ipairs(module_doc.tables) do%>| [[`<%=tab_name%>`|<%=doc.rootpage%>/modules/<%=module_doc.name%>#luadoc-table-<%=tab_name%>]] | <%=module_doc.tables[tab_name].summary%> |
<%end%>
<%end%>

<%if #module_doc.functions > 0 then%>
## Functions
<%for _, func_name in ipairs(module_doc.functions) do%>
<%=luadoc.doclet.ikiwiki.include("function.lp", { doc=doc, module_doc=module_doc, func=module_doc.functions[func_name] })%>
<%end%>
<%end%>

<%if #module_doc.tables > 0 then%>
## Tables
<%for _, tab_name in ipairs(module_doc.tables) do%>
<%=luadoc.doclet.ikiwiki.include("table.lp", { doc=doc, module_doc=module_doc, tab=module_doc.tables[tab_name] })%>
<%end%>
<%end%>

</div>
