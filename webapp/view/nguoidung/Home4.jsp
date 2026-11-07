<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    User4 user = (User4) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login4.jsp?err=timeout");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Trang chủ</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 720px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    a { color: #2563a6; text-decoration: none; }
    a:hover { text-decoration: underline; }
    table { width: 100%; margin: 12px auto; border-color: #dce4ee !important; text-align: left; }
    td { padding: 10px 14px !important; border-color: #dce4ee !important; }
    td:first-child:not([colspan]) { color: #64748b; background: #f8fafc; }
    a:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
}
@media screen and (max-width: 640px) {
    body { padding: 16px 10px; }
    body > center { padding: 18px 12px; }
    h2 { font-size: 21px; }
    td { padding: 8px !important; }
}
</style>
</head>
<body>
<center>
<h2>CineMan</h2>
<table id="tblUserInfo" style="border: 1px solid black;border-collapse: collapse;">
    <tr>
        <td style="border: 1px solid black;">Xin chào:</td>
        <td style="border: 1px solid black;"><%= user.getFullName() %></td>
    </tr>
    <tr>
        <td style="border: 1px solid black;">Vai trò:</td>
        <td style="border: 1px solid black;"><%= user.getRole() %></td>
    </tr>
    <tr>
        <td colspan="2" style="border: 1px solid black;">Chức năng dành cho vai trò này đang phát triển.</td>
    </tr>
</table>
<br>
<a href="doLogout4.jsp">Đăng xuất</a>
</center>
</body>
</html>
