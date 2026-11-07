-- Seed suat chieu cho ~60 ngay toi de test module ban ve (CineMan)
-- Chay 1 lan: mysql -uroot -p cineman < db/seed_showtimes.sql
-- Moi phong 4 suat/ngay; chi tao trong thoi gian phim dang chieu (releaseDate..endDate);
-- bo qua suat da ton tai (chay lai nhieu lan khong bi trung).

INSERT INTO tblShowtime4(showDate, startTime, endTime, tblMovie4id, tblScreeningRoom4id)
SELECT x.showDate, x.startTime,
       ADDTIME(x.startTime, SEC_TO_TIME(x.duration * 60)),
       x.movieId, x.roomId
FROM (
    WITH RECURSIVE days(n) AS (
        SELECT 0
        UNION ALL
        SELECT n + 1 FROM days WHERE n < 59
    ),
    movies AS (
        SELECT id, duration, releaseDate, endDate,
               ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM tblMovie4
    ),
    slots AS (
        SELECT 1 AS roomId, CAST('09:00:00' AS TIME) AS startTime, 1 AS movieNo
        UNION ALL SELECT 1, CAST('13:00:00' AS TIME), 2
        UNION ALL SELECT 1, CAST('17:00:00' AS TIME), 3
        UNION ALL SELECT 1, CAST('21:00:00' AS TIME), 1
        UNION ALL SELECT 2, CAST('10:30:00' AS TIME), 1
        UNION ALL SELECT 2, CAST('14:30:00' AS TIME), 2
        UNION ALL SELECT 2, CAST('18:30:00' AS TIME), 3
        UNION ALL SELECT 2, CAST('21:30:00' AS TIME), 1
    )
    SELECT d.showDate, s.startTime, s.roomId, m.id AS movieId, m.duration
    FROM (SELECT CURDATE() + INTERVAL days.n DAY AS showDate FROM days) d
    JOIN movies m ON d.showDate BETWEEN m.releaseDate AND m.endDate
    JOIN slots s ON s.movieNo = m.rn
    WHERE NOT EXISTS (
        SELECT 1 FROM tblShowtime4 st
        WHERE st.showDate = d.showDate
          AND st.startTime = s.startTime
          AND st.tblScreeningRoom4id = s.roomId
    )
) x;
