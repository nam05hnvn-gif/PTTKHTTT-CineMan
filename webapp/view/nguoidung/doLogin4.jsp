<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    String txtUsername = request.getParameter("txtUsername");
    String txtPassword = request.getParameter("txtPassword");

    if (txtUsername == null || txtPassword == null) {
        response.sendRedirect("Login4.jsp");
        return;
    }

    User4 user = (new User4DAO()).getUserByUsernamePassword(txtUsername, txtPassword);

    if (user == null) {
        response.sendRedirect("Login4.jsp?err=invalid");
        return;
    }

    if ("customer".equals(user.getRole())) {
        Customer4 customer = (new Customer4DAO()).getCustomerByUsernamePassword(txtUsername, txtPassword);
        if (customer == null) {
            response.sendRedirect("Login4.jsp?err=invalid");
            return;
        }
        session.setAttribute("customer", customer);
        response.sendRedirect("../khachhang/CustomerHome4.jsp");
    } else if ("sales_staff".equals(user.getRole())) {
        SalesStaff4 salesStaff = (new SalesStaff4DAO()).getSalesStaffByUsernamePassword(txtUsername, txtPassword);
        if (salesStaff == null) {
            response.sendRedirect("Login4.jsp?err=invalid");
            return;
        }
        session.setAttribute("salesStaff", salesStaff);
        response.sendRedirect("../nhanvien/SalesStaffHome4.jsp");
    } else {
        session.setAttribute("user", user);
        response.sendRedirect("Home4.jsp");
    }
%>
