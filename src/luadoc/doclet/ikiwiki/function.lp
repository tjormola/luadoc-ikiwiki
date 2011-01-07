---

<span id="luadoc-function-<%=func.name%>" />

### <%=func.private and "local " or ""%><%=func.name%> (<%=table.concat(func.param, ", ")%>)

<%if func.description then%>
<%=func.description%>
<%end%>

<%if type(func.param) == "table" and #func.param > 0 then%>
**Parameters**

<%for p = 1, #func.param do%>* `<%=func.param[p]%>`: <%=func.param[func.param[p]] or ""%>
<%end%>
<%end%>

<%if type(func.usage) == "string" then%>
**Usage:**

<%=func.usage%>
<%elseif type(func.usage) == "table" then%>
**Usage**

<%for _, usage in ipairs(func.usage) do%>* `<%= usage %>`
<%end%>
<%end%>

<%if type(func.ret) == "string" then%>
**Return value:**

<%=func.ret%>
<%elseif type(func.ret) == "table" then%>
**Return values:**

<%for _, ret in ipairs(func.ret) do%>1. <%= ret %>
<%end%>
<%end%>

<%if type(func.see) == "string" then %>
**See also:**

[[<%=func.see%>]]
<%elseif type(func.see) == "table" and #func.see > 0 then %>
**See also:**

<%for i = 1, #func.see do local l=luadoc.doclet.ikiwiki.symbol_link(func.see[i], doc, module_doc, file_doc)%>* <%if #l>0 then%>[[`<%=func.see[i]%>`|<%=l%>]]<% else %>`<%=func.see[i]%>`<%end%>
<%end%>
<%end%>
