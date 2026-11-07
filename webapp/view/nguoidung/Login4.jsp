<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    String err = request.getParameter("err");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Đăng nhập</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 560px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    table { width: 100%; margin: 12px auto; border-color: #dce4ee !important; }
    td { padding: 10px 14px !important; border-color: #dce4ee !important; }
    td:first-child:not([colspan]), td:nth-child(2) { text-align: left; }
    input { font: inherit; }
    input[type="text"], input[type="password"] { width: 240px; max-width: 100%; padding: 9px 11px; border: 1px solid #cbd5e1; border-radius: 7px; color: #263449; background: #fff; }
    input[type="submit"] { display: inline-block; padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; text-decoration: none; }
    input[type="submit"]:hover { background: #1e4f88; }
    input:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
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
<%
    if ("timeout".equals(err)) {
        out.println("<script type='text/javascript'>alert('Phiên làm việc đã hết, vui lòng đăng nhập lại!');</script>");
    }
    if ("invalid".equals(err)) {
        out.println("<script type='text/javascript'>alert('Sai tên đăng nhập hoặc mật khẩu!');</script>");
    }
%>
<h2>Đăng nhập hệ thống CineMan</h2>
<form action="doLogin4.jsp" method="post">
    <table style="border: 1px solid black;border-collapse: collapse;">
        <tr>
            <td style="border: 1px solid black;">Tên đăng nhập:</td>
            <td style="border: 1px solid black;"><input type="text" id="txtUsername" name="txtUsername"></td>
        </tr>
        <tr>
            <td style="border: 1px solid black;">Mật khẩu:</td>
            <td style="border: 1px solid black;"><input type="password" id="txtPassword" name="txtPassword"></td>
        </tr>
        <tr>
            <td colspan="2" align="center" style="border: 1px solid black;">
                <input type="submit" id="btnLogin" name="btnLogin" value="Đăng nhập">
            </td>
        </tr>
    </table>
</form>
</center>
</body>
</html>
