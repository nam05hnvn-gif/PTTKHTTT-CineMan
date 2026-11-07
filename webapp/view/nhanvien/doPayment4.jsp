<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    //kiem tra nhan vien da dang nhap chua
    SalesStaff4 salesStaff = (SalesStaff4) session.getAttribute("salesStaff");
    if (salesStaff == null) {
        response.sendRedirect("../nguoidung/Login4.jsp?err=timeout");
        return;
    }
    //lay hoa don da lap va gan day du thong tin o trang thanh toan
    Invoice4 invoice = (Invoice4) session.getAttribute("invoice4");
    if (invoice == null || invoice.getMovieTickets() == null || invoice.getMovieTickets().isEmpty()) {
        response.sendRedirect("MovieSearch4.jsp");
        return;
    }
    if (invoice.getPaymentMethod() == null) {
        response.sendRedirect("Payment4.jsp");
        return;
    }

    //kiem tra lai tung ghe truoc khi luu (ghe co the vua bi nguoi khac mua)
    Seat4DAO seat4DAO = new Seat4DAO();
    for (MovieTicket4 ticket : invoice.getMovieTickets()) {
        if (!seat4DAO.checkSeatAvailability(ticket.getSeat().getId(), ticket.getShowtime().getId())) {
            seat4DAO.close();
            String label = ticket.getSeat().getSeatRow() + ticket.getSeat().getSeatNumber();
            out.println("<script type='text/javascript'>alert('Ghế " + label + " vừa được bán, vui lòng chọn lại!'); history.back();</script>");
            return;
        }
    }
    seat4DAO.close();

    //luu hoa don va cac ve vao CSDL
    Invoice4DAO invoice4DAO = new Invoice4DAO();
    boolean ok = invoice4DAO.saveInvoice(invoice);
    invoice4DAO.close();
    //luu that bai: kiem tra lai xem co ghe vua bi nguoi khac mua khong de bao chinh xac
    if (!ok) {
        String soldSeat = null;
        Seat4DAO recheckDAO = new Seat4DAO();
        for (MovieTicket4 ticket : invoice.getMovieTickets()) {
            if (!recheckDAO.checkSeatAvailability(ticket.getSeat().getId(), ticket.getShowtime().getId())) {
                soldSeat = ticket.getSeat().getSeatRow() + ticket.getSeat().getSeatNumber();
                break;
            }
        }
        recheckDAO.close();
        if (soldSeat != null) {
            out.println("<script type='text/javascript'>alert('Ghế " + soldSeat + " vừa được bán, vui lòng chọn lại!'); history.back();</script>");
        } else {
            out.println("<script type='text/javascript'>alert('Thanh toán thất bại, vui lòng thử lại!'); history.back();</script>");
        }
        return;
    }

    session.removeAttribute("movies4");
    session.removeAttribute("showtimes4");
    session.removeAttribute("selectedTickets4");

    out.println("<script type='text/javascript'>alert('Thanh toán thành công!'); window.location='TicketInvoicePreview4.jsp';</script>");
%>
