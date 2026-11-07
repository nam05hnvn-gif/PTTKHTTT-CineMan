-- Seed du lieu demo cho module ban ve tai quay (CineMan)
-- Chay 1 lan: mysql -uroot -p cineman < db/seed.sql

-- 1. Tai khoan nhan vien ban ve: staff / staff
INSERT INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('staff', 'staff', N'Nguyễn Văn Bán Vé', '2000-05-20', 'Nam', '0909000001', 'staff@cineman.vn', 'sales_staff', 'active');
SET @staff_id = LAST_INSERT_ID();
INSERT INTO tblSalesStaff4(position, workShift, tblUser4id)
VALUES (N'Nhân viên bán vé', N'Ca sáng', @staff_id);

-- 2. Loai ghe
INSERT INTO tblSeatType4(name, description) VALUES (N'Thường', N'Ghế hàng thường');
SET @type_thuong = LAST_INSERT_ID();
INSERT INTO tblSeatType4(name, description) VALUES (N'VIP', N'Ghế hàng VIP');
SET @type_vip = LAST_INSERT_ID();

-- 3. Phong chieu + ghe (P01: hang A-D x 1-4, hang C,D la VIP; P02: hang A-B x 1-4, hang B la VIP)
INSERT INTO tblScreeningRoom4(roomName, roomType, capacity, description, roomStatus)
VALUES ('P01', N'2D', 16, N'Phòng chiếu tiêu chuẩn', 'active');
SET @room_p01 = LAST_INSERT_ID();
INSERT INTO tblSeat4(seatRow, seatNumber, seatStatus, tblScreeningRoom4id, tblSeatType4id)
SELECT r.row_letter, n.seat_num, 'available', @room_p01,
       IF(r.row_letter IN ('C','D'), @type_vip, @type_thuong)
FROM (SELECT 'A' AS row_letter UNION SELECT 'B' UNION SELECT 'C' UNION SELECT 'D') r
CROSS JOIN (SELECT 1 AS seat_num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) n;

INSERT INTO tblScreeningRoom4(roomName, roomType, capacity, description, roomStatus)
VALUES ('P02', N'2D', 8, N'Phòng chiếu nhỏ', 'active');
SET @room_p02 = LAST_INSERT_ID();
INSERT INTO tblSeat4(seatRow, seatNumber, seatStatus, tblScreeningRoom4id, tblSeatType4id)
SELECT r.row_letter, n.seat_num, 'available', @room_p02,
       IF(r.row_letter = 'B', @type_vip, @type_thuong)
FROM (SELECT 'A' AS row_letter UNION SELECT 'B') r
CROSS JOIN (SELECT 1 AS seat_num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) n;

-- 4. Phim (dang chieu, endDate sau 2026-10-26)
INSERT INTO tblMovie4(movieTitle, duration, description, director, `cast`, ageRating, releaseDate, endDate, posterImage)
VALUES (N'Làm Giàu Với Ma', 120, N'Hài - gia đình', N'Phan Gia Nhật Linh', N'Tuấn Trần, Lê Giang', 'C13', '2026-10-01', '2026-11-30', 'lam-giau-voi-ma.jpg');
SET @movie1 = LAST_INSERT_ID();
INSERT INTO tblMovie4(movieTitle, duration, description, director, `cast`, ageRating, releaseDate, endDate, posterImage)
VALUES (N'Địa Đạo: Mặt TrờI Trong Bóng Tối', 126, N'Lịch sử - chiến tranh', N'Bùi Thạc Chuyên', N'Quang Tuấn, Khả Ngân', 'C16', '2026-09-12', '2026-11-15', 'dia-dao.jpg');
SET @movie2 = LAST_INSERT_ID();
INSERT INTO tblMovie4(movieTitle, duration, description, director, `cast`, ageRating, releaseDate, endDate, posterImage)
VALUES (N'Em Là Bà Nội CủA Anh', 128, N'Hài - tình cảm', N'Phan Gia Nhật Linh', N'Miu Lê, Ngô Kiến Huy', 'C13', '2026-10-10', '2026-12-10', 'em-la-ba-noi.jpg');
SET @movie3 = LAST_INSERT_ID();

-- 5. Suat chieu hom nay + ngay mai (ket thuc = bat dau + duration phut)
INSERT INTO tblShowtime4(showDate, startTime, endTime, tblMovie4id, tblScreeningRoom4id)
VALUES (CURDATE(), '18:00:00', ADDTIME('18:00:00', SEC_TO_TIME(120*60)), @movie1, @room_p01);
SET @st1 = LAST_INSERT_ID();
INSERT INTO tblShowtime4(showDate, startTime, endTime, tblMovie4id, tblScreeningRoom4id)
VALUES (CURDATE(), '20:30:00', ADDTIME('20:30:00', SEC_TO_TIME(126*60)), @movie2, @room_p02);
SET @st2 = LAST_INSERT_ID();
INSERT INTO tblShowtime4(showDate, startTime, endTime, tblMovie4id, tblScreeningRoom4id)
VALUES (CURDATE() + INTERVAL 1 DAY, '19:00:00', ADDTIME('19:00:00', SEC_TO_TIME(128*60)), @movie3, @room_p01);
SET @st3 = LAST_INSERT_ID();

-- 6. Gia ve theo (suat chieu, loai ghe): Thuong 60000, VIP 90000
INSERT INTO tblSeatPrice4(price, tblShowtime4id, tblSeatType4id)
SELECT 60000, s.id, t.id FROM tblShowtime4 s CROSS JOIN tblSeatType4 t WHERE t.name = N'Thường';
INSERT INTO tblSeatPrice4(price, tblShowtime4id, tblSeatType4id)
SELECT 90000, s.id, t.id FROM tblShowtime4 s CROSS JOIN tblSeatType4 t WHERE t.name = N'VIP';
