-- Seed tai khoan khach hang de test (chay sau seed.sql)
-- Chay lai nhieu lan khong tao ban ghi trung (INSERT IGNORE).
-- Mat khau trung username.

-- 1. Khach chua co the thanh vien: test trang dang ky thanh vien
INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('testmember', 'testmember', N'Lê Văn Test', '2004-02-15', 'Nam', '0912000111', 'testmember@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'testmember');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, NULL);

INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('phamthimai', 'phamthimai', N'Phạm Thị Mai', '2003-08-21', N'Nữ', '0912000112', 'phamthimai@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'phamthimai');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, NULL);

INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('hoangvannam', 'hoangvannam', N'Hoàng Văn Nam', '2002-03-10', 'Nam', '0912000113', 'hoangvannam@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'hoangvannam');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, NULL);

INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('lethithu', 'lethithu', N'Lê Thị Thu', '2004-11-02', N'Nữ', '0912000114', 'lethithu@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'lethithu');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, NULL);

-- 2. Khach da co the thanh vien: test ap dung ma the o trang thanh toan
INSERT IGNORE INTO tblMemberCard4(membershipCode, membershipRegistrationDate, rewardPoints)
VALUES ('MC10000001', '2026-10-15', 120);
INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('nguyenthanh', 'nguyenthanh', N'Nguyễn Thanh Thành', '1999-07-15', 'Nam', '0912000115', 'nguyenthanh@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'nguyenthanh');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, 'MC10000001');

INSERT IGNORE INTO tblMemberCard4(membershipCode, membershipRegistrationDate, rewardPoints)
VALUES ('MC10000002', '2026-10-15', 0);
INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('tranvankhoa', 'tranvankhoa', N'Trần Văn Khoa', '2001-01-30', 'Nam', '0912000116', 'tranvankhoa@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'tranvankhoa');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, 'MC10000002');

INSERT IGNORE INTO tblMemberCard4(membershipCode, membershipRegistrationDate, rewardPoints)
VALUES ('MC10000003', '2026-10-15', 45);
INSERT IGNORE INTO tblUser4(username, password, fullName, dateOfBirth, gender, phoneNumber, email, role, accountStatus)
VALUES ('doducanh', 'doducanh', N'Đỗ Đức Anh', '2003-05-09', 'Nam', '0912000117', 'doducanh@gmail.com', 'customer', 'active');
SET @uid = (SELECT id FROM tblUser4 WHERE username = 'doducanh');
INSERT IGNORE INTO tblCustomer4(tblUser4id, tblMemberCard4membershipCode) VALUES (@uid, 'MC10000003');