package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Movie4;

public class Movie4DAO extends DAO4 {

    public Movie4DAO() {
        super();
    }

    public List<Movie4> searchMovies(String keyword) {
        List<Movie4> list = new ArrayList<>();
        String sql = "SELECT id, movieTitle, duration, description, director, `cast`, ageRating, releaseDate, endDate, posterImage "
                + "FROM tblMovie4 ";
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        if (hasKeyword) {
            sql += "WHERE movieTitle LIKE ? ";
        }
        sql += "ORDER BY movieTitle";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasKeyword) {
                ps.setString(1, "%" + keyword.trim() + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Movie4 movie = new Movie4();
                    movie.setId(rs.getInt("id"));
                    movie.setMovieTitle(rs.getString("movieTitle"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setDescription(rs.getString("description"));
                    movie.setDirector(rs.getString("director"));
                    movie.setCast(rs.getString("cast"));
                    movie.setAgeRating(rs.getString("ageRating"));
                    movie.setReleaseDate(rs.getDate("releaseDate").toLocalDate());
                    movie.setEndDate(rs.getDate("endDate").toLocalDate());
                    movie.setPosterImage(rs.getString("posterImage"));
                    list.add(movie);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
