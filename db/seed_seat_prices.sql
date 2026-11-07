-- Seed gia ve cho tat ca suat chieu: Thuong 60.000d, VIP 90.000d (CineMan)
-- Chay 1 lan: mysql -uroot -p cineman < db/seed_seat_prices.sql
-- Bo qua cap (suat chieu, loai ghe) da co gia -> chay lai nhieu lan khong bi trung.

INSERT INTO tblSeatPrice4(price, tblShowtime4id, tblSeatType4id)
SELECT x.price, x.showtimeId, x.seatTypeId
FROM (
    SELECT s.id AS showtimeId, t.id AS seatTypeId,
           CASE WHEN t.name = 'VIP' THEN 90000.00 ELSE 60000.00 END AS price
    FROM tblShowtime4 s
    CROSS JOIN tblSeatType4 t
) x
WHERE NOT EXISTS (
    SELECT 1 FROM tblSeatPrice4 p
    WHERE p.tblShowtime4id = x.showtimeId
      AND p.tblSeatType4id = x.seatTypeId
);
