<% 
session.invalidate(); //destroy session
response.sendRedirect("index.jsp"); //logout successfully and redirect to "index.jsp" page
%>


