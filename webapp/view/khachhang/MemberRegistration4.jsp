<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    Customer4 customer = (Customer4) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }
    if (customer.getMemberCard() != null) {
        out.println("<script type='text/javascript'>alert('Bạn đã có thẻ thành viên!'); window.location='CustomerHome4.jsp';</script>");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Đăng ký thẻ thành viên</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 760px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    p { margin: 12px 0 20px; }
    table { width: 100%; margin: 12px auto; border-color: #dce4ee !important; }
    td { padding: 10px 14px !important; border-color: #dce4ee !important; }
    td:first-child:not([colspan]), td:nth-child(2) { text-align: left; }
    input, select { font: inherit; }
    input[type="text"], input[type="date"], select { width: 240px; max-width: 100%; padding: 9px 11px; border: 1px solid #cbd5e1; border-radius: 7px; color: #263449; background: #fff; }
    input[type="submit"] { display: inline-block; padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; text-decoration: none; }
    input[type="submit"]:hover { background: #1e4f88; }
    #btnCancel { background: #edf2f7; border-color: #dce4ee; color: #334155; }
    #btnCancel:hover { background: #e2e8f0; }
    input:focus-visible, select:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
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
<h2>Đăng ký thẻ thành viên</h2>
<p>Vui lòng kiểm tra và cập nhật thông tin cá nhân trước khi đăng ký thẻ.</p>
<form action="doMemberRegistration4.jsp" method="post">
    <table style="border: 1px solid black;border-collapse: collapse;">
        <tr>
            <td style="border: 1px solid black;">Họ và tên:</td>
            <td style="border: 1px solid black;"><input type="text" id="txtFullName" name="txtFullName" value="<%= customer.getFullName() %>"></td>
        </tr>
        <tr>
            <td style="border: 1px solid black;">Ngày sinh:</td>
            <td style="border: 1px solid black;"><input type="date" id="txtDateOfBirth" name="txtDateOfBirth" value="<%= customer.getDateOfBirth() %>"></td>
        </tr>
        <tr>
            <td style="border: 1px solid black;">Số điện thoại:</td>
            <td style="border: 1px solid black;"><input type="text" id="txtPhoneNumber" name="txtPhoneNumber" value="<%= customer.getPhoneNumber() %>"></td>
        </tr>
        <tr>
            <td style="border: 1px solid black;">Email:</td>
            <td style="border: 1px solid black;"><input type="text" id="txtEmail" name="txtEmail" value="<%= customer.getEmail() %>"></td>
        </tr>
        <tr>
            <td style="border: 1px solid black;">Giới tính:</td>
            <td style="border: 1px solid black;">
                <select id="cbGender" name="cbGender">
                    <option value="Nam" <%= "Nam".equals(customer.getGender()) ? "selected" : "" %>>Nam</option>
                    <option value="Nữ" <%= "Nữ".equals(customer.getGender()) ? "selected" : "" %>>Nữ</option>
                    <option value="Khác" <%= "Khác".equals(customer.getGender()) ? "selected" : "" %>>Khác</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center" style="border: 1px solid black;">
                <input type="submit" id="btnRegister" name="btnRegister" value="Đăng ký">
                <input type="submit" id="btnCancel" name="btnCancel" value="Hủy" formaction="CustomerHome4.jsp">
            </td>
        </tr>
    </table>
</form>
</center>
</body>
</html>
