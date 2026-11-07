<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.math.*,java.text.*,dao.*,model.*,java.time.format.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Vé và hóa đơn</title>
<style type="text/css">
.ve {
    display: inline-block;
    vertical-align: top;
    width: 300px;
    margin: 8px;
    padding: 12px 18px;
    border: 1px dashed #333333;
    text-align: left;
}
.ve .tieude {
    text-align: center;
    font-weight: bold;
    letter-spacing: 1px;
}
.ve .loaive {
    text-align: center;
    font-size: 12px;
    color: #666666;
    border-bottom: 1px dashed #999999;
    padding-bottom: 5px;
    margin-bottom: 6px;
}
.ve table {
    font-size: 13px;
}
.ve td {
    padding: 2px 8px 2px 0;
}
.hoadon {
    display: inline-block;
    text-align: left;
    padding: 12px 18px;
    border: 1px solid black;
    background-color: #fafafa;
}
@media print {
    .no-print {
        display: none;
    }
    body.print-ticket #invoiceSection {
        display: none;
    }
    body.print-invoice #ticketSection {
        display: none;
    }
    .ve {
        display: block;
        margin: 0 auto 12px auto;
        page-break-after: always;
    }
    .ve:last-child {
        page-break-after: auto;
    }
}
</style>
<script type="text/javascript">
//in tung ve (moi ve 1 trang)
function printTicket() {
    document.body.className = "print-ticket";
    window.print();
    document.body.className = "";
    alert("In vé thành công!");
}
//in rieng hoa don
function printInvoice() {
    document.body.className = "print-invoice";
    window.print();
    document.body.className = "";
    alert("In hóa đơn thành công!");
}
</script>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 1080px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    h3 { margin: 24px 0 12px; color: #1e3a5f; font-size: 18px; }
    .ve { width: 320px; max-width: 100%; padding: 18px; border-color: #b7c8dc; border-radius: 10px; background: #fafcff; }
    .ve .tieude { color: #1e4f88; font-size: 19px; letter-spacing: 2px; }
    .ve .loaive { color: #64748b; border-color: #dce4ee; }
    .ve td { overflow-wrap: anywhere; }
    .hoadon { max-width: 100%; padding: 20px; border-color: #dce4ee; border-radius: 10px; background: #fff; overflow-x: auto; }
    .hoadon table { width: 100%; border-color: #dce4ee !important; }
    .hoadon td { padding: 10px 14px !important; border-color: #dce4ee !important; }
    .hoadon thead td { background: #edf3fa; color: #1e3a5f; font-weight: 600; }
    #tblInvoiceDetails tbody tr:nth-child(even) { background: #f8fafc; }
    #tblInvoiceDetails tbody tr:last-child { background: #edf3fa; }
    #lblTotalAmount { color: #1e4f88; font-size: 18px; }
    input { font: inherit; }
    input[type="submit"] { padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; }
    input[type="submit"]:hover { background: #1e4f88; }
    #btnFinish { background: #edf2f7; border-color: #dce4ee; color: #334155; }
    #btnFinish:hover { background: #e2e8f0; }
    input:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
}
@media screen and (max-width: 640px) {
    body { padding: 16px 10px; }
    body > center { padding: 18px 12px; }
    h2 { font-size: 21px; }
    .ve { margin: 8px 0; }
    .hoadon { padding: 10px; }
    .hoadon td { padding: 8px !important; }
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
    //lay hoa don vua thanh toan
    Invoice4 invoice = (Invoice4) session.getAttribute("invoice4");
    if (invoice == null || invoice.getId() == null) {
        response.sendRedirect("SalesStaffHome4.jsp");
        return;
    }
    //bam hoan thanh: ket thuc phien ban ve, quay ve trang tim phim
    if (request.getParameter("btnFinish") != null) {
        session.removeAttribute("invoice4");
        session.removeAttribute("movies4");
        session.removeAttribute("showtimes4");
        session.removeAttribute("selectedTickets4");
        response.sendRedirect("MovieSearch4.jsp");
        return;
    }
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    DateTimeFormatter fmtDate = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter fmtTime = DateTimeFormatter.ofPattern("HH:mm");
    List<MovieTicket4> tickets = invoice.getMovieTickets();
%>
<body>
<center>
<h2 class="no-print">Xem trước vé và hóa đơn</h2>

<div id="ticketSection">
<h3 class="no-print">Vé xem phim</h3>
<%
    for (int i = 0; i < tickets.size(); i++) {
        MovieTicket4 ticket = tickets.get(i);
        Showtime4 st = ticket.getShowtime();
        Seat4 seat = ticket.getSeat();
%>
<div class="ve">
    <div class="tieude">CINEMAN</div>
    <div class="loaive">VÉ XEM PHIM</div>
    <table id="tblTicketInfo<%= i + 1 %>" border="0">
    <tr><td>Phim:</td><td><b><%= st.getMovie() != null ? st.getMovie().getMovieTitle() : "" %></b></td></tr>
    <tr><td>Ngày chiếu:</td><td><%= st.getShowDate().format(fmtDate) %></td></tr>
    <tr><td>Giờ chiếu:</td><td><%= st.getStartTime().format(fmtTime) %></td></tr>
    <tr><td>Phòng chiếu:</td><td><%= st.getScreeningRoom().getRoomName() %></td></tr>
    <tr><td>Ghế:</td><td><b style="font-size: 15px;"><%= seat.getSeatRow() + seat.getSeatNumber() %></b></td></tr>
    <tr><td>Giá vé:</td><td><%= nf.format(ticket.getPrice()) %> đ</td></tr>
    </table>
    <div class="loaive" style="border-bottom: none; border-top: 1px dashed #999999; padding-top: 5px; margin-top: 6px;">Vui lòng giữ vé để soát khi vào phòng chiếu</div>
</div>
<%
    }
%>
</div>

<div id="invoiceSection">
<h3 class="no-print">Hóa đơn</h3>
<div class="hoadon">
    <table id="tblInvoiceInfo" style="border: 1px solid black;border-collapse: collapse;">
    <thead>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Thông tin</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Giá trị</td>
    </thead>
    <tr>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Mã hóa đơn</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;"><%= invoice.getId() %></td>
    </tr>
    <tr>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Nhân viên bán vé</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;"><%= invoice.getSalesStaff() != null ? invoice.getSalesStaff().getFullName() : "" %></td>
    </tr>
    <tr>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Khách hàng</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">
<%
            if (invoice.getCustomer() != null) {
                String cardCode = invoice.getCustomer().getMemberCard() != null
                        ? invoice.getCustomer().getMemberCard().getMembershipCode() : "";
%>
    <%= invoice.getCustomer().getFullName() %> (<%= cardCode %>)
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
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Phương thức thanh toán</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;"><%= invoice.getPaymentMethod() %></td>
    </tr>
    </table>
    <br/>
    <table id="tblInvoiceDetails" style="border: 1px solid black;border-collapse: collapse;">
    <thead>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">STT</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Phim</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Suất chiếu</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Ghế</td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;">Giá vé</td>
    </thead>
<%
    for (int i = 0; i < tickets.size(); i++) {
        MovieTicket4 ticket = tickets.get(i);
        Showtime4 st = ticket.getShowtime();
        Seat4 seat = ticket.getSeat();
%>
    <tr>
    <td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= i + 1 %></td>
    <td style="border: 1px solid black; padding:0 15px 0 15px;"><%= st.getMovie() != null ? st.getMovie().getMovieTitle() : "" %></td>
    <td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= st.getStartTime().format(fmtTime) %> - <%= st.getShowDate().format(fmtDate) %></td>
    <td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= seat.getSeatRow() + seat.getSeatNumber() %></td>
    <td style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><%= nf.format(ticket.getPrice()) %> đ</td>
    </tr>
<%
    }
%>
    <tr>
    <td colspan="4" style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><b>Tổng tiền:</b></td>
    <td style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><b><span id="lblTotalAmount"><%= nf.format(invoice.calculateTotalAmount()) %></span> đ</b></td>
    </tr>
    </table>
</div>
</div>

<br/>
<form action="TicketInvoicePreview4.jsp" method="get" class="no-print">
<input type="submit" id="btnPrintTicket" name="btnPrintTicket" value="In vé" onclick="printTicket(); return false;">
<input type="submit" id="btnPrintInvoice" name="btnPrintInvoice" value="In hóa đơn" onclick="printInvoice(); return false;">
<input type="submit" id="btnFinish" name="btnFinish" value="Hoàn thành">
</form>
</center>
</body>
</html>
