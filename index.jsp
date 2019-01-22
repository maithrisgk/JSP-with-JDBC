<%@ page language="java" import="java.sql.*"%>
        <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    PreparedStatement pst = null;
                    int no = Integer.parseInt(request.getParameter("NO"));
                    String name = request.getParameter("NAME");
                    String address = request.getParameter("ADDRESS");
                    String btn = request.getParameter("btn");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    con = DriverManager.getConnection("jdbc:odbc:student");
                    st = con.createStatement();
                    rs = st.executeQuery("select  * from student");
                    if (btn != null) {
                        if (btn.equals("Insert")) {
                            int k = 0;
                            while (rs.next()) {
                                if (rs.getInt(1) == no) {
                                    k = 1;
                                }
                            }
											   
                            if (k == 0) {
                                pst = con.prepareStatement("insert into student values (?,?,?)");
                                pst.setInt(1, no);
                                pst.setString(2, name);
                                pst.setString(3, address);
                                int i = pst.executeUpdate();
        %>
        <%
                                        if (i > 0) {
                                            out.println("record inserted succesfully");
                                        } else {
                                            out.println("record not inserted");
                                        }%>
        <%
                            } else {
                                out.println("record alredy exist");
                            }
                        }
                        
                        else
                            {
                            out.println("not valid action");
                        }
                     }
											   
                    else
                        {
                        out.println("Specify the action");
                        }
        %>
        <table border="0" bgcolor="lightgreen"  cellspacing="5" cellpadding="2">
            <tr><th>No</th><th>Name</th><th>Address</th></tr>
            <%
                        st = con.createStatement();
                        rs = st.executeQuery("select  * from student");
                        while (rs.next()) {
            %>
            <tr>
                <td><%=rs.getInt(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
            </tr>
            <% }
            %>
        </table>
