package model;

import java.math.BigDecimal;

public class MovieTicket4 {
    private Integer id;
    private BigDecimal price;
    private Showtime4 showtime;
    private Seat4 seat;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Showtime4 getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime4 showtime) {
        this.showtime = showtime;
    }

    public Seat4 getSeat() {
        return seat;
    }

    public void setSeat(Seat4 seat) {
        this.seat = seat;
    }
}
