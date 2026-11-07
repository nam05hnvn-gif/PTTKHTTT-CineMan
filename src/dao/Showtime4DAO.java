package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Movie4;
import model.ScreeningRoom4;
import model.SeatPrice4;
import model.SeatType4;
import model.Showtime4;

public class Showtime4DAO extends DAO4 {

    public Showtime4DAO() {
        super();
    }

    public List<Showtime4> getAvailableShowtimes(int movieId) {
        List<Showtime4> list = new ArrayList<>();
        String sql = "SELECT s.id, s.showDate, s.startTime, s.endTime, "
                + "m.id AS movieId, m.movieTitle, m.duration, m.description, m.director, m.`cast`, m.ageRating, m.releaseDate, m.endDate, m.posterImage, "
                + "r.id AS roomId, r.roomName, r.roomType, r.capacity, r.description AS roomDescription, r.roomStatus "
                + "FROM tblShowtime4 s "
                + "JOIN tblMovie4 m ON m.id = s.tblMovie4id "
                + "JOIN tblScreeningRoom4 r ON r.id = s.tblScreeningRoom4id "
                + "WHERE s.tblMovie4id = ? AND s.showDate >= CURDATE() "
                + "AND s.showDate >= m.releaseDate AND s.showDate <= m.endDate "
                + "AND (s.showDate > CURDATE() OR s.startTime > CURTIME()) "
                + "AND r.roomStatus = 'active' "
                + "ORDER BY s.showDate, s.startTime";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Showtime4 showtime = new Showtime4();
                    showtime.setId(rs.getInt("id"));
                    showtime.setShowDate(rs.getDate("showDate").toLocalDate());
                    showtime.setStartTime(rs.getTime("startTime").toLocalTime());
                    showtime.setEndTime(rs.getTime("endTime").toLocalTime());

                    Movie4 movie = new Movie4();
                    movie.setId(rs.getInt("movieId"));
                    movie.setMovieTitle(rs.getString("movieTitle"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setDescription(rs.getString("description"));
                    movie.setDirector(rs.getString("director"));
                    movie.setCast(rs.getString("cast"));
                    movie.setAgeRating(rs.getString("ageRating"));
                    movie.setReleaseDate(rs.getDate("releaseDate").toLocalDate());
                    movie.setEndDate(rs.getDate("endDate").toLocalDate());
                    movie.setPosterImage(rs.getString("posterImage"));
                    showtime.setMovie(movie);

                    ScreeningRoom4 room = new ScreeningRoom4();
                    room.setId(rs.getInt("roomId"));
                    room.setRoomName(rs.getString("roomName"));
                    room.setRoomType(rs.getString("roomType"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setDescription(rs.getString("roomDescription"));
                    room.setRoomStatus(rs.getString("roomStatus"));
                    showtime.setScreeningRoom(room);

                    List<SeatPrice4> seatPrices = new ArrayList<>();
                    String sqlPrice = "SELECT p.id, p.price, p.tblSeatType4id, t.name AS seatTypeName, t.description AS seatTypeDescription "
                            + "FROM tblSeatPrice4 p JOIN tblSeatType4 t ON t.id = p.tblSeatType4id "
                            + "WHERE p.tblShowtime4id = ?";
                    try (PreparedStatement psPrice = con.prepareStatement(sqlPrice)) {
                        psPrice.setInt(1, showtime.getId());
                        try (ResultSet rsPrice = psPrice.executeQuery()) {
                            while (rsPrice.next()) {
                                SeatType4 seatType = new SeatType4();
                                seatType.setId(rsPrice.getInt("tblSeatType4id"));
                                seatType.setName(rsPrice.getString("seatTypeName"));
                                seatType.setDescription(rsPrice.getString("seatTypeDescription"));

                                SeatPrice4 seatPrice = new SeatPrice4();
                                seatPrice.setId(rsPrice.getInt("id"));
                                seatPrice.setPrice(rsPrice.getBigDecimal("price"));
                                seatPrice.setSeatType(seatType);
                                seatPrices.add(seatPrice);
                            }
                        }
                    }
                    showtime.setSeatPrices(seatPrices);
                    list.add(showtime);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
