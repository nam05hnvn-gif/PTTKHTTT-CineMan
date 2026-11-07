package model;

public class Seat4 {
    private Integer id;
    private String seatRow;
    private Integer seatNumber;
    private String seatStatus;
    private SeatType4 seatType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSeatRow() {
        return seatRow;
    }

    public void setSeatRow(String seatRow) {
        this.seatRow = seatRow;
    }

    public Integer getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(Integer seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getSeatStatus() {
        return seatStatus;
    }

    public void setSeatStatus(String seatStatus) {
        this.seatStatus = seatStatus;
    }

    public SeatType4 getSeatType() {
        return seatType;
    }

    public void setSeatType(SeatType4 seatType) {
        this.seatType = seatType;
    }
}
