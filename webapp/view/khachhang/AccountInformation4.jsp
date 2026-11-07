<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*,java.time.format.*"%>
<%
    Customer4 customer = (Customer4) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Thông tin tài khoản</title>
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
    a[id^="btn"] { display: inline-block; padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; text-decoration: none; }
    a[id^="btn"]:hover { background: #1e4f88; }
    #btnBackToHome { background: #edf2f7; border-color: #dce4ee; color: #334155; }
    #btnBackToHome:hover { background: #e2e8f0; }
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
<h2>Thông tin tài khoản</h2>
<table style="border: 1px solid black;border-collapse: collapse;">
    <tr>
        <td style="border: 1px solid black;">Họ và tên:</td>
        <td style="border: 1px solid black;"><span id="lblFullName"><%= customer.getFullName() %></span></td>
    </tr>
    <tr>
        <td style="border: 1px solid black;">Ngày sinh:</td>
        <td style="border: 1px solid black;"><span id="lblDateOfBirth"><%= customer.getDateOfBirth().format(fmt) %></span></td>
    </tr>
    <tr>
        <td style="border: 1px solid black;">Số điện thoại:</td>
        <td style="border: 1px solid black;"><span id="lblPhoneNumber"><%= customer.getPhoneNumber() %></span></td>
    </tr>
    <tr>
        <td style="border: 1px solid black;">Email:</td>
        <td style="border: 1px solid black;"><span id="lblEmail"><%= customer.getEmail() %></span></td>
    </tr>
    <tr>
        <td style="border: 1px solid black;">Giới tính:</td>
        <td style="border: 1px solid black;"><span id="lblGender"><%= customer.getGender() %></span></td>
    </tr>
<%
    if (customer.getMemberCard() != null) {
%>
    <tr>
        <td style="border: 1px solid black;">Mã thẻ thành viên:</td>
        <td style="border: 1px solid black;"><span id="lblMembershipCode"><%= customer.getMemberCard().getMembershipCode() %></span></td>
    </tr>
    <tr>
        <td style="border: 1px solid black;">Ngày đăng ký thành viên:</td>
        <td style="border: 1px solid black;"><span id="lblMembershipRegistrationDate"><%= customer.getMemberCard().getMembershipRegistrationDate().format(fmt) %></span></td>
    </tr>
<%
    } else {
%>
    <tr>
        <td colspan="2" style="border: 1px solid black;">Bạn chưa đăng ký thẻ thành viên.</td>
    </tr>
<%
    }
%>
</table>
<br>
<a id="btnBackToHome" href="CustomerHome4.jsp">Về trang chủ</a>
</center>
</body>
</html>
