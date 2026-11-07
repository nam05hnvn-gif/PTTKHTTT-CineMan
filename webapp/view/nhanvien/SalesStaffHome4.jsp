<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Trang chủ nhân viên bán vé</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 720px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    p { margin: 12px 0 20px; }
    a { color: #2563a6; text-decoration: none; }
    a:hover { text-decoration: underline; }
    #btnSellTicketsAtCounter { display: inline-block; padding: 12px 24px; margin: 8px 0; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; text-decoration: none; }
    #btnSellTicketsAtCounter:hover { background: #1e4f88; }
    a:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
}
@media screen and (max-width: 640px) {
    body { padding: 16px 10px; }
    body > center { padding: 18px 12px; }
    h2 { font-size: 21px; }
}
</style>
</head>
<%
    //kiem tra nhan vien da dang nhap chua
    SalesStaff4 salesStaff = (SalesStaff4) session.getAttribute("salesStaff");
    if (salesStaff == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }
    //xoa du lieu cua phien ban ve truoc
    session.removeAttribute("movies4");
    session.removeAttribute("showtimes4");
    session.removeAttribute("selectedTickets4");
    session.removeAttribute("invoice4");
%>
<body>
<center>
<h2>Trang chủ nhân viên bán vé</h2>
<p>Xin chào, <span id="lblStaffFullName"><b><%= salesStaff.getFullName() %></b></span>!</p>
<p><a id="btnSellTicketsAtCounter" href="MovieSearch4.jsp">Bán vé tại quầy</a></p>
<br/>
<a href="../nguoidung/doLogout4.jsp">Đăng xuất</a>
</center>
</body>
</html>
