<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.math.*,java.text.*,dao.*,model.*,java.time.format.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Thanh toán</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 1080px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    table { margin: 12px auto; border-color: #dce4ee !important; }
    td { padding: 10px 14px !important; border-color: #dce4ee !important; }
    #tblMovieTickets { width: 100%; }
    #tblMovieTickets thead td { background: #edf3fa; color: #1e3a5f; font-weight: 600; white-space: nowrap; }
    #tblMovieTickets tbody tr:nth-child(even) { background: #f8fafc; }
    #tblMovieTickets tbody tr:last-child { background: #edf3fa; }
    #lblTotalAmount { color: #1e4f88; font-size: 18px; }
    #lblCustomerName { color: #2563a6; }
    form > table { text-align: left; }
    input, select { font: inherit; }
    input[type="text"], select { width: 240px; max-width: 100%; padding: 9px 11px; border: 1px solid #cbd5e1; border-radius: 7px; color: #263449; background: #fff; }
    input[type="submit"] { padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; }
    input[type="submit"]:hover { background: #1e4f88; }
    #btnBack { background: #edf2f7; border-color: #dce4ee; color: #334155; }
    #btnBack:hover { background: #e2e8f0; }
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
<%
    //kiem tra nhan vien da dang nhap chua
    SalesStaff4 salesStaff = (SalesStaff4) session.getAttribute("salesStaff");
    if (salesStaff == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    //lay danh sach ve da chon tu trang chon ghe
    List<MovieTicket4> selectedTickets = (List<MovieTicket4>) session.getAttribute("selectedTickets4");
    if (selectedTickets == null || selectedTickets.isEmpty()) {
        out.println("<script type='text/javascript'>alert('Bạn chưa chọn ghế nào!'); window.location='SeatSelection4.jsp';</script>");
        return;
    }
    //ma the thanh vien trong o nhap: moi request tra cuu lai tu ma nay
    String membershipCode = request.getParameter("txtMembershipCode");
    if (membershipCode == null) {
        membershipCode = "";
    }
    Customer4 customer = null;
    Customer4DAO customer4DAO = new Customer4DAO();
    if (!membershipCode.trim().isEmpty()) {
        customer = customer4DAO.getCustomerInfo(membershipCode.trim());
    }
    customer4DAO.close();

    //bam ap dung: chi kiem tra ma the va thong bao ket qua
    if (request.getParameter("btnApplyMembership") != null) {
        if (membershipCode.trim().isEmpty()) {
            out.println("<script type='text/javascript'>alert('Vui lòng nhập mã thẻ thành viên!');</script>");
        } else if (customer == null) {
            out.println("<script type='text/javascript'>alert('Không tìm thấy thẻ thành viên!');</script>");
        } else {
            out.println("<script type='text/javascript'>alert('Áp dụng thẻ thành viên thành công!');</script>");
        }
    }

    //lap hoa don cho phien ban ve: gan ve, nhan vien, thoi gian tao
    Invoice4 invoice = new Invoice4();
    invoice.setCreatedAt(java.time.LocalDateTime.now());
    invoice.setSalesStaff(salesStaff);
    invoice.setMovieTickets(selectedTickets);
    session.setAttribute("invoice4", invoice);

    //bam xac nhan thanh toan: gan khach hang + phuong thuc roi chuyen sang trang luu
    if (request.getParameter("btnConfirmPayment") != null) {
        String cbPaymentMethod = request.getParameter("cbPaymentMethod");
        if (cbPaymentMethod == null || cbPaymentMethod.trim().isEmpty()) {
            out.println("<script type='text/javascript'>alert('Vui lòng chọn phương thức thanh toán!');</script>");
        } else if (!membershipCode.trim().isEmpty() && customer == null) {
            out.println("<script type='text/javascript'>alert('Không tìm thấy thẻ thành viên!');</script>");
        } else {
            if (customer != null) {
                invoice.setCustomer(customer);
            }
            invoice.setPaymentMethod(cbPaymentMethod);
            response.sendRedirect("doPayment4.jsp");
            return;
        }
    }

    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    DateTimeFormatter fmtDate = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter fmtTime = DateTimeFormatter.ofPattern("HH:mm");
%>
<body>
<center>
<h2>Thanh toán</h2>
<table id="tblMovieTickets" style="border: 1px solid black;border-collapse: collapse;">
<thead>
<td style="border: 1px solid black; padding:0 15px 0 15px;">STT</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Phim</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Ngày chiếu</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Giờ</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Phòng</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Ghế</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Giá vé</td>
</thead>
<%
    for (int i = 0; i < selectedTickets.size(); i++) {
        MovieTicket4 ticket = selectedTickets.get(i);
        Showtime4 st = ticket.getShowtime();
        Seat4 seat = ticket.getSeat();
%>
<tr>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= i + 1 %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px;"><%= st.getMovie() != null ? st.getMovie().getMovieTitle() : "" %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= st.getShowDate().format(fmtDate) %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= st.getStartTime().format(fmtTime) %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= st.getScreeningRoom().getRoomName() %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= seat.getSeatRow() + seat.getSeatNumber() %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><%= nf.format(ticket.getPrice()) %> đ</td>
</tr>
<%
    }
%>
<tr>
<td colspan="6" style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><b>Tổng tiền:</b></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><span id="lblTotalAmount"><b><%= nf.format(invoice.calculateTotalAmount()) %> đ</b></span></td>
</tr>
</table>
<br/>
<form action="Payment4.jsp" method="post">
<table border="0">
<tr>
<td>Khách hàng:</td>
<td>
<%
            if (customer != null) {
                String cardCode = customer.getMemberCard() != null
                        ? customer.getMemberCard().getMembershipCode() : "";
%>
<b id="lblCustomerName"><%= customer.getFullName() %></b> (<span id="lblCardCode"><%= cardCode %></span>)
<%
            } else {
%>
Vãng lai
<%
            }
%>
</td>
</tr>
<tr>
<td>Mã thẻ thành viên:</td>
<td><input type="text" id="txtMembershipCode" name="txtMembershipCode" value="<%= membershipCode %>"></td>
<td><input type="submit" id="btnApplyMembership" name="btnApplyMembership" value="Áp dụng" formaction="Payment4.jsp"></td>
</tr>
<tr>
<td>Phương thức thanh toán:</td>
<td>
<select id="cbPaymentMethod" name="cbPaymentMethod" size="1">
<option value="Tiền mặt" selected>Tiền mặt</option>
<option value="Chuyển khoản">Chuyển khoản</option>
<option value="Thẻ tín dụng">Thẻ tín dụng</option>
</select>
</td>
</tr>
<tr>
<td></td>
<td>
<input type="submit" id="btnConfirmPayment" name="btnConfirmPayment" value="Xác nhận thanh toán" formaction="Payment4.jsp">
<input type="submit" id="btnBack" name="btnBack" value="Quay lại" formaction="SeatSelection4.jsp">
</td>
</tr>
</table>
</form>
</center>
</body>
</html>
