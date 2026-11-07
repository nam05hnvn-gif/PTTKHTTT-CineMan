<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    Customer4 customer = (Customer4) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }

    String txtFullName = request.getParameter("txtFullName");
    String txtDateOfBirth = request.getParameter("txtDateOfBirth");
    String txtPhoneNumber = request.getParameter("txtPhoneNumber");
    String txtEmail = request.getParameter("txtEmail");
    String cbGender = request.getParameter("cbGender");

    if (txtFullName == null || txtFullName.trim().isEmpty()
            || txtDateOfBirth == null || txtDateOfBirth.trim().isEmpty()
            || txtPhoneNumber == null || txtPhoneNumber.trim().isEmpty()
            || txtEmail == null || txtEmail.trim().isEmpty()
            || cbGender == null) {
        out.println("<script type='text/javascript'>alert('Vui lòng nhập đầy đủ thông tin!'); history.back();</script>");
        return;
    }

    if (customer.getMemberCard() != null) {
        out.println("<script type='text/javascript'>alert('Bạn đã có thẻ thành viên!'); history.back();</script>");
        return;
    }

    java.time.LocalDate dateOfBirth;
    try {
        dateOfBirth = java.time.LocalDate.parse(txtDateOfBirth);
    } catch (Exception e) {
        out.println("<script type='text/javascript'>alert('Ngày sinh không hợp lệ!'); history.back();</script>");
        return;
    }

    MemberCard4 memberCard = new MemberCard4();

    //tao khach hang moi tu du lieu form, giu nguyen thong tin dinh danh cua tai khoan dang nhap
    Customer4 newCustomer = new Customer4();
    newCustomer.setId(customer.getId());
    newCustomer.setUsername(customer.getUsername());
    newCustomer.setPassword(customer.getPassword());
    newCustomer.setRole(customer.getRole());
    newCustomer.setAccountStatus(customer.getAccountStatus());
    newCustomer.setFullName(txtFullName);
    newCustomer.setDateOfBirth(dateOfBirth);
    newCustomer.setPhoneNumber(txtPhoneNumber);
    newCustomer.setEmail(txtEmail);
    newCustomer.setGender(cbGender);
    newCustomer.setMemberCard(memberCard);

    Customer4DAO customer4DAO = new Customer4DAO();
    if (customer4DAO.checkDuplicateCustomer(newCustomer)) {
        customer4DAO.close();
        out.println("<script type='text/javascript'>alert('Số điện thoại hoặc email đã được sử dụng bởi tài khoản khác!'); history.back();</script>");
        return;
    }
    if (!customer4DAO.saveCustomer(newCustomer)) {
        customer4DAO.close();
        out.println("<script type='text/javascript'>alert('Đăng ký thất bại, vui lòng thử lại!'); history.back();</script>");
        return;
    }
    customer4DAO.close();

    session.setAttribute("customer", newCustomer);

    out.println("<script type='text/javascript'>alert('Đăng ký thẻ thành viên thành công!'); window.location='AccountInformation4.jsp';</script>");
%>
