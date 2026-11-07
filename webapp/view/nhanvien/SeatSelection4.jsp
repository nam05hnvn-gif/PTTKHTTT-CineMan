<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.math.*,java.text.*,dao.*,model.*,java.time.format.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Chọn ghế</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 960px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    h3 { margin: 24px 0 12px; color: #1e3a5f; font-size: 18px; }
    p { margin: 12px 0 20px; }
    table { margin: 12px auto; border-color: #dce4ee !important; }
    td { border-color: #dce4ee !important; }
    #tblSeatMap td { padding: 7px !important; min-width: 52px; }
    #tblSeatMap td:first-child { color: #64748b; }
    #tblSeatMap a { display: block; padding: 9px 14px; border: 1px solid #cbdced; border-radius: 7px; background: #f0f6ff; color: #2563a6; text-decoration: none; }
    #tblSeatMap a:hover { background: #dbeafe; border-color: #2563a6; }
    #tblSeatMap b > a { background: #2563a6; border-color: #2563a6; color: #fff; }
    #tblSeatMap b > a:hover { background: #1e4f88; }
    #tblSelectedTickets { width: 100%; }
    #tblSelectedTickets td { padding: 10px 14px !important; }
    #tblSelectedTickets thead td { background: #edf3fa; color: #1e3a5f; font-weight: 600; }
    #tblSelectedTickets tbody tr:nth-child(even) { background: #f8fafc; }
    input { font: inherit; }
    input[type="submit"] { padding: 9px 17px; margin: 4px 3px; border: 1px solid #2563a6; border-radius: 7px; background: #2563a6; color: #fff; cursor: pointer; }
    input[type="submit"]:hover { background: #1e4f88; }
    #btnBack { background: #edf2f7; border-color: #dce4ee; color: #334155; }
    #btnBack:hover { background: #e2e8f0; }
    input:focus-visible, a:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
}
@media screen and (max-width: 640px) {
    body { padding: 16px 10px; }
    body > center { padding: 18px 12px; }
    h2 { font-size: 21px; }
    #tblSeatMap td { padding: 4px !important; min-width: 36px; }
    #tblSeatMap a { padding: 8px; }
    #tblSelectedTickets td { padding: 8px !important; }
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
    //lay danh sach ve dang chon trong session
    List<MovieTicket4> selectedTickets = (List<MovieTicket4>) session.getAttribute("selectedTickets4");
    if (selectedTickets == null) {
        selectedTickets = new ArrayList<MovieTicket4>();
    }

    Showtime4 showtime = null;
    String showtimeIdParam = request.getParameter("showtimeId");
    if (showtimeIdParam != null) {
        //chon suat chieu tu trang truoc: bo cac ve da chon neu la suat chieu khac
        int showtimeId;
        try {
            showtimeId = Integer.parseInt(showtimeIdParam);
        } catch (Exception e) {
            out.println("<script type='text/javascript'>alert('Suất chiếu không hợp lệ!'); history.back();</script>");
            return;
        }
        Showtime4 found = null;
        List<Showtime4> showtimes = (List<Showtime4>) session.getAttribute("showtimes4");
        if (showtimes != null) {
            for (Showtime4 st : showtimes) {
                if (st.getId() == showtimeId) {
                    found = st;
                    break;
                }
            }
        }
        if (found == null) {
            out.println("<script type='text/javascript'>alert('Không tìm thấy suất chiếu!'); window.location='MovieSearch4.jsp';</script>");
            return;
        }
        showtime = found;
        if (!selectedTickets.isEmpty()
                && !selectedTickets.get(0).getShowtime().getId().equals(showtime.getId())) {
            selectedTickets.clear();
            session.removeAttribute("selectedTickets4");
        }
    } else {
        //quay lai tu trang thanh toan: lay lai suat chieu tu cac ve da chon
        if (!selectedTickets.isEmpty()) {
            showtime = selectedTickets.get(0).getShowtime();
        }
    }
    if (showtime == null) {
        response.sendRedirect("MovieSearch4.jsp");
        return;
    }

    //lay so do ghe va danh sach ghe da ban cua suat chieu
    Seat4DAO seat4DAO = new Seat4DAO();
    List<Seat4> listSeats = seat4DAO.getSeatMap(showtime.getId());
    List<Seat4> soldSeats = seat4DAO.getSoldSeats(showtime.getId());
    seat4DAO.close();
    Set<Integer> soldIds = new HashSet<Integer>();
    for (Seat4 s : soldSeats) {
        soldIds.add(s.getId());
    }

    //bam chon ghe: ghe trong thi them ve, ghe dang chon thi bo ve
    String pickSeatId = request.getParameter("pickSeatId");
    if (pickSeatId != null) {
        int pid = -1;
        try {
            pid = Integer.parseInt(pickSeatId);
        } catch (Exception e) {
            pid = -1;
        }
        Seat4 picked = null;
        for (Seat4 s : listSeats) {
            if (s.getId() == pid) {
                picked = s;
                break;
            }
        }
        if (picked == null) {
            out.println("<script type='text/javascript'>alert('Không tìm thấy ghế!'); history.back();</script>");
            return;
        }
        if (soldIds.contains(picked.getId())) {
            out.println("<script type='text/javascript'>alert('Ghế " + picked.getSeatRow() + picked.getSeatNumber() + " đã được bán!'); history.back();</script>");
            return;
        }
        MovieTicket4 existing = null;
        for (MovieTicket4 t : selectedTickets) {
            if (t.getSeat().getId() == pid) {
                existing = t;
                break;
            }
        }
        if (existing != null) {
            selectedTickets.remove(existing);
        } else {
            BigDecimal seatPrice = showtime.getPrice(picked.getSeatType());
            MovieTicket4 ticket = new MovieTicket4();
            ticket.setPrice(seatPrice);
            ticket.setShowtime(showtime);
            ticket.setSeat(picked);
            selectedTickets.add(ticket);
        }
        session.setAttribute("selectedTickets4", selectedTickets);
    }

    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    DateTimeFormatter fmtDate = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter fmtTime = DateTimeFormatter.ofPattern("HH:mm");
    String movieTitle = showtime.getMovie() != null ? showtime.getMovie().getMovieTitle() : "";
    Integer movieId = showtime.getMovie() != null ? showtime.getMovie().getId() : null;
%>
<body>
<center>
<h2>Chọn ghế</h2>
<p>Phim: <span id="lblMovieTitle"><b><%= movieTitle %></b></span> — Ngày: <span id="lblShowDate"><b><%= showtime.getShowDate().format(fmtDate) %></b></span> <span id="lblShowTime"><%= showtime.getStartTime().format(fmtTime) %></span>
— Phòng: <span id="lblRoomName"><b><%= showtime.getScreeningRoom().getRoomName() %></b></span></p>
<table id="tblSeatMap" style="border: 1px solid black;border-collapse: collapse;">
<%
    String currentRow = null;
    for (Seat4 seat : listSeats) {
        if (!seat.getSeatRow().equals(currentRow)) {
            if (currentRow != null) {
                out.println("</tr>");
            }
            currentRow = seat.getSeatRow();
            out.println("<tr><td style=\"border: 1px solid black; padding:0 15px 0 15px;\"><b>" + currentRow + "</b></td>");
        }
        String label = seat.getSeatRow() + seat.getSeatNumber();
        if (soldIds.contains(seat.getId())) {
            out.println("<td style=\"border: 1px solid black; padding:0 15px 0 15px; text-align:center; background-color:#cccccc; color:#666666;\">" + label + "</td>");
        } else {
            boolean isPicked = false;
            for (MovieTicket4 t : selectedTickets) {
                if (t.getSeat().getId() == seat.getId()) {
                    isPicked = true;
                    break;
                }
            }
            if (isPicked) {
                out.println("<td style=\"border: 1px solid black; padding:0 15px 0 15px; text-align:center;\"><b><a href=\"SeatSelection4.jsp?showtimeId=" + showtime.getId() + "&amp;pickSeatId=" + seat.getId() + "\">[" + label + "]</a></b></td>");
            } else {
                out.println("<td style=\"border: 1px solid black; padding:0 15px 0 15px; text-align:center;\"><a href=\"SeatSelection4.jsp?showtimeId=" + showtime.getId() + "&amp;pickSeatId=" + seat.getId() + "\">" + label + "</a></td>");
            }
        }
    }
    if (currentRow != null) {
        out.println("</tr>");
    }
%>
</table>
<p>Ghi chú: ô xám = đã bán; ô có [...] = đang chọn (bấm để bỏ chọn).</p>
<h3>Vé đã chọn</h3>
<table id="tblSelectedTickets" style="border: 1px solid black;border-collapse: collapse;">
<thead>
<td style="border: 1px solid black; padding:0 15px 0 15px;">STT</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Ghế</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Loại ghế</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Giá vé</td>
</thead>
<%
    for (int i = 0; i < selectedTickets.size(); i++) {
        MovieTicket4 ticket = selectedTickets.get(i);
        Seat4 seat = ticket.getSeat();
%>
<tr>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= i + 1 %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= seat.getSeatRow() + seat.getSeatNumber() %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px;"><%= seat.getSeatType() != null ? seat.getSeatType().getName() : "" %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:right;"><%= nf.format(ticket.getPrice()) %> đ</td>
</tr>
<%
    }
    if (selectedTickets.isEmpty()) {
%>
<tr>
<td colspan="4" style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;">Chưa chọn ghế nào.</td>
</tr>
<%
    }
%>
</table>
<br/>
<form action="Payment4.jsp" method="post">
<input type="submit" id="btnContinue" name="btnContinue" value="Tiếp tục">
<input type="submit" id="btnBack" name="btnBack" value="Quay lại" formaction="ShowtimeSelection4.jsp<%= movieId != null ? "?movieId=" + movieId : "" %>">
</form>
</center>
</body>
</html>
