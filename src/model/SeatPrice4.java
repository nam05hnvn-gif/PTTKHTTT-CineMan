package model;

import java.math.BigDecimal;

public class SeatPrice4 {
    private Integer id;
    private BigDecimal price;
    private SeatType4 seatType;

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

    public SeatType4 getSeatType() {
        return seatType;
    }

    public void setSeatType(SeatType4 seatType) {
        this.seatType = seatType;
    }
}
