package model;

import java.util.List;

public class ScreeningRoom4 {
    private Integer id;
    private String roomName;
    private String roomType;
    private Integer capacity;
    private String description;
    private String roomStatus;
    private List<Seat4> seats;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(String roomStatus) {
        this.roomStatus = roomStatus;
    }

    public List<Seat4> getSeats() {
        return seats;
    }

    public void setSeats(List<Seat4> seats) {
        this.seats = seats;
    }
}
