<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*,java.time.format.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CineMan - Chọn suất chiếu</title>
<style type="text/css">
@media screen {
    * { box-sizing: border-box; }
    body { margin: 0; padding: 40px 20px; background: #f3f6fa; color: #263449; font: 15px/1.55 "Segoe UI", Arial, sans-serif; }
    body > center { max-width: 960px; margin: 0 auto; padding: 28px; background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 6px 24px rgba(30, 55, 85, .06); overflow-x: auto; }
    h2 { margin: 0 0 22px; color: #1e3a5f; font-size: 24px; }
    p { margin: 12px 0 20px; }
    #lblMovieTitle { color: #2563a6; }
    #tblShowtimes { width: 100%; margin: 12px auto; border-color: #dce4ee !important; }
    #tblShowtimes td { padding: 10px 14px !important; border-color: #dce4ee !important; }
    #tblShowtimes thead td { background: #edf3fa; color: #1e3a5f; font-weight: 600; white-space: nowrap; }
    #tblShowtimes tbody tr:nth-child(even) { background: #f8fafc; }
    #tblShowtimes tbody tr:hover { background: #f0f6ff; }
    a { color: #2563a6; text-decoration: none; }
    a:hover { text-decoration: underline; }
    input { font: inherit; }
    #btnBack { padding: 9px 17px; margin: 4px 3px; border: 1px solid #dce4ee; border-radius: 7px; background: #edf2f7; color: #334155; cursor: pointer; }
    #btnBack:hover { background: #e2e8f0; }
    input:focus-visible, a:focus-visible { outline: 3px solid #93c5fd; outline-offset: 2px; }
}
@media screen and (max-width: 640px) {
    body { padding: 16px 10px; }
    body > center { padding: 18px 12px; }
    h2 { font-size: 21px; }
    #tblShowtimes td { padding: 8px !important; }
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
    //lay id phim duoc chon tu trang tim kiem
    String movieIdParam = request.getParameter("movieId");
    if (movieIdParam == null) {
        response.sendRedirect("MovieSearch4.jsp");
        return;
    }
    int movieId;
    try {
        movieId = Integer.parseInt(movieIdParam);
    } catch (Exception e) {
        response.sendRedirect("MovieSearch4.jsp");
        return;
    }
    //lay thong tin phim tu danh sach da tim kiem
    Movie4 movie = null;
    List<Movie4> movies = (List<Movie4>) session.getAttribute("movies4");
    if (movies != null) {
        for (Movie4 m : movies) {
            if (m.getId() == movieId) {
                movie = m;
                break;
            }
        }
    }
    if (movie == null) {
        response.sendRedirect("MovieSearch4.jsp");
        return;
    }
    //lay danh sach suat chieu con hieu luc cua phim (DAO da gan san thong tin phim)
    List<Showtime4> listShowtimes = (new Showtime4DAO()).getAvailableShowtimes(movieId);
    session.setAttribute("showtimes4", listShowtimes);
    DateTimeFormatter fmtDate = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter fmtTime = DateTimeFormatter.ofPattern("HH:mm");
%>
<body>
<center>
<h2>Chọn suất chiếu</h2>
<p>Phim: <span id="lblMovieTitle"><b><%= movie.getMovieTitle() %></b></span></p>
<table id="tblShowtimes" style="border: 1px solid black;border-collapse: collapse;">
<thead>
<td style="border: 1px solid black; padding:0 15px 0 15px;">STT</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Ngày chiếu</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Giờ bắt đầu</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Giờ kết thúc</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Phòng chiếu</td>
<td style="border: 1px solid black; padding:0 15px 0 15px;">Chọn</td>
</thead>
<%
    if (listShowtimes.isEmpty()) {
%>
<tr>
<td colspan="6" style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;">Phim này chưa có suất chiếu sắp tới.</td>
</tr>
<%
    }
    for (int i = 0; i < listShowtimes.size(); i++) {
        Showtime4 showtime = listShowtimes.get(i);
%>
<tr>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= i + 1 %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= showtime.getShowDate().format(fmtDate) %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= showtime.getStartTime().format(fmtTime) %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= showtime.getEndTime().format(fmtTime) %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><%= showtime.getScreeningRoom().getRoomName() %></td>
<td style="border: 1px solid black; padding:0 15px 0 15px; text-align:center;"><a id="chosenShowtime" href="SeatSelection4.jsp?showtimeId=<%= showtime.getId() %>">Chọn</a></td>
</tr>
<%
    }
%>
</table>
<br/>
<form action="MovieSearch4.jsp" method="get">
<input type="submit" id="btnBack" name="btnBack" value="Quay lại">
</form>
</center>
</body>
</html>
