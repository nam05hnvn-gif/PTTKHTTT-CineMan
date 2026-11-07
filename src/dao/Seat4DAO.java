package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Seat4;
import model.SeatType4;

public class Seat4DAO extends DAO4 {

    public Seat4DAO() {
        super();
    }

    public List<Seat4> getSeatMap(int showtimeId) {
        List<Seat4> list = new ArrayList<>();
        String sql = "SELECT se.id, se.seatRow, se.seatNumber, se.seatStatus, "
                + "t.id AS seatTypeId, t.name AS seatTypeName, t.description AS seatTypeDescription "
                + "FROM tblSeat4 se "
                + "JOIN tblShowtime4 s ON s.tblScreeningRoom4id = se.tblScreeningRoom4id "
                + "LEFT JOIN tblSeatType4 t ON t.id = se.tblSeatType4id "
                + "WHERE s.id = ? AND se.seatStatus = 'available' "
                + "ORDER BY se.seatRow, se.seatNumber";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SeatType4 seatType = new SeatType4();
                    seatType.setId(rs.getInt("seatTypeId"));
                    seatType.setName(rs.getString("seatTypeName"));
                    seatType.setDescription(rs.getString("seatTypeDescription"));

                    Seat4 seat = new Seat4();
                    seat.setId(rs.getInt("id"));
                    seat.setSeatRow(rs.getString("seatRow"));
                    seat.setSeatNumber(rs.getInt("seatNumber"));
                    seat.setSeatStatus(rs.getString("seatStatus"));
                    seat.setSeatType(seatType);
                    list.add(seat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Seat4> getSoldSeats(int showtimeId) {
        List<Seat4> list = new ArrayList<>();
        String sql = "SELECT se.id, se.seatRow, se.seatNumber, se.seatStatus, "
                + "t.id AS seatTypeId, t.name AS seatTypeName, t.description AS seatTypeDescription "
                + "FROM tblMovieTicket4 tk "
                + "JOIN tblSeat4 se ON se.id = tk.tblSeat4id "
                + "LEFT JOIN tblSeatType4 t ON t.id = se.tblSeatType4id "
                + "WHERE tk.tblShowtime4id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SeatType4 seatType = new SeatType4();
                    seatType.setId(rs.getInt("seatTypeId"));
                    seatType.setName(rs.getString("seatTypeName"));
                    seatType.setDescription(rs.getString("seatTypeDescription"));

                    Seat4 seat = new Seat4();
                    seat.setId(rs.getInt("id"));
                    seat.setSeatRow(rs.getString("seatRow"));
                    seat.setSeatNumber(rs.getInt("seatNumber"));
                    seat.setSeatStatus(rs.getString("seatStatus"));
                    seat.setSeatType(seatType);
                    list.add(seat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean checkSeatAvailability(int seatId, int showtimeId) {
        String sql = "SELECT (SELECT COUNT(*) FROM tblMovieTicket4 WHERE tblSeat4id = ? AND tblShowtime4id = ?) = 0 "
                + "AND EXISTS (SELECT 1 FROM tblSeat4 se "
                + "JOIN tblShowtime4 s ON s.tblScreeningRoom4id = se.tblScreeningRoom4id "
                + "WHERE se.id = ? AND s.id = ? AND se.seatStatus = 'available')";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, seatId);
            ps.setInt(2, showtimeId);
            ps.setInt(3, seatId);
            ps.setInt(4, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getBoolean(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
