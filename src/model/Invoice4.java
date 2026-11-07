package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Invoice4 {
    private Integer id;
    private LocalDateTime createdAt;
    private String paymentMethod;
    private Customer4 customer;
    private SalesStaff4 salesStaff;
    private List<MovieTicket4> movieTickets;

    public BigDecimal calculateTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        if (movieTickets != null) {
            for (MovieTicket4 ticket : movieTickets) {
                if (ticket.getPrice() != null) {
                    total = total.add(ticket.getPrice());
                }
            }
        }
        return total;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Customer4 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer4 customer) {
        this.customer = customer;
    }

    public SalesStaff4 getSalesStaff() {
        return salesStaff;
    }

    public void setSalesStaff(SalesStaff4 salesStaff) {
        this.salesStaff = salesStaff;
    }

    public List<MovieTicket4> getMovieTickets() {
        return movieTickets;
    }

    public void setMovieTickets(List<MovieTicket4> movieTickets) {
        this.movieTickets = movieTickets;
    }
}
