package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class Showtime4 {
    private Integer id;
    private LocalDate showDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private Movie4 movie;
    private ScreeningRoom4 screeningRoom;
    private List<SeatPrice4> seatPrices;

    public BigDecimal getPrice(SeatType4 seatType4) {
        if (seatPrices != null && seatType4 != null) {
            for (SeatPrice4 sp : seatPrices) {
                if (sp.getSeatType() != null && sp.getSeatType().getId().equals(seatType4.getId())) {
                    return sp.getPrice();
                }
            }
        }
        return BigDecimal.ZERO;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDate getShowDate() {
        return showDate;
    }

    public void setShowDate(LocalDate showDate) {
        this.showDate = showDate;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public Movie4 getMovie() {
        return movie;
    }

    public void setMovie(Movie4 movie) {
        this.movie = movie;
    }

    public ScreeningRoom4 getScreeningRoom() {
        return screeningRoom;
    }

    public void setScreeningRoom(ScreeningRoom4 screeningRoom) {
        this.screeningRoom = screeningRoom;
    }

    public List<SeatPrice4> getSeatPrices() {
        return seatPrices;
    }

    public void setSeatPrices(List<SeatPrice4> seatPrices) {
        this.seatPrices = seatPrices;
    }
}
