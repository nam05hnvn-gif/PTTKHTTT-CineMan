<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    Customer4 customer = (Customer4) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Trang chủ khách hàng</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 720px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    p { margin: 12px 0 20px; }
    a { color: #2563a6; text-decoration: none; }
    a:hover { text-decoration: underline; }
    a[id^="btn"] { display: inline-block; padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; text-decoration: none; }
    a[id^="btn"]:hover { background: #1e4f88; }
    a:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
}
@media screen and (max-width: 640px) {
    body { padding: 16px 10px; }
    body > center { padding: 18px 12px; }
    h2 { font-size: 21px; }
}
</style>
</head>
<body>
<center>
<h2>Trang chủ khách hàng</h2>
<p>Xin chào, <span id="lblCustomerFullName"><b><%= customer.getFullName() %></b></span>!</p>
<%
    if (customer.getMemberCard() == null) {
%>
<a id="btnRegisterMemberAccount" href="MemberRegistration4.jsp">Đăng ký thẻ thành viên</a>
<%
    } else {
%>
<p>Bạn đã có thẻ thành viên.</p>
<%
    }
%>
<br><br>
<a href="../nguoidung/doLogout4.jsp">Đăng xuất</a>
</center>
</body>
</html>
