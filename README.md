# PTTKHTTT-CineMan

Web application for cinema ticket sales, built with JSP (Model 1) + JDBC on Java 21, MySQL 8 and Tomcat 11.

Modules:

- **Sales staff (counter ticket sales):** search movie → pick showtime → pick seats → payment (optional membership code) → print ticket / invoice preview.
- **Customer:** login, register a member card, view account information.

## Requirements

- JDK 21 or newer (`build.bat` compiles with `javac --release 21`)
- MySQL 8
- Apache Tomcat 11 — not committed to this repository. Extract it to `tools/apache-tomcat-11.0.27`, or set `CATALINA_HOME` to your own Tomcat 11 installation.
- The MySQL Connector/J driver is included in `webapp/WEB-INF/lib`.

## Database setup

Create the database, then load structure and demo data in this order:

```powershell
mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS cineman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -p --default-character-set=utf8mb4 cineman < db/schema.sql
mysql -uroot -p --default-character-set=utf8mb4 cineman < db/seed.sql
mysql -uroot -p --default-character-set=utf8mb4 cineman < db/seed_showtimes.sql
mysql -uroot -p --default-character-set=utf8mb4 cineman < db/seed_seat_prices.sql
mysql -uroot -p --default-character-set=utf8mb4 cineman < db/seed_customers.sql
```

- `schema.sql` — table structure only (no data).
- `seed.sql` — staff account, seat types, rooms/seats, movies, first showtimes and prices. Run once on an empty database.
- `seed_showtimes.sql` — showtimes for the next ~60 days within each movie's release window. Safe to re-run.
- `seed_seat_prices.sql` — prices per showtime/seat type (normal 60,000 đ, VIP 90,000 đ). Safe to re-run.
- `seed_customers.sql` — test customer accounts, with and without member cards. Safe to re-run.

## Build and run on Windows

Set the database connection in the terminal that starts Tomcat:

```powershell
$env:CINEMAN_DB_USER = "root"
$env:CINEMAN_DB_PASSWORD = "<your-local-database-password>"
# optional; this is the default value
$env:CINEMAN_DB_URL = "jdbc:mysql://localhost:3306/cineman?characterEncoding=UTF-8"
.\build.bat
.\start.bat
```

`JAVA_HOME` may point to the JDK; otherwise `javac` must be on `PATH`.
`start.bat` replaces `%CATALINA_HOME%\webapps\CineMan` with the current `webapp/` folder and starts Tomcat.
Open <http://localhost:8080/CineMan/> — it redirects to the login page.

## Test accounts

All seeded accounts use the username as password.

| Username      | Role        | Member card |
|---------------|-------------|-------------|
| staff         | sales_staff | —           |
| testmember    | customer    | none        |
| phamthimai    | customer    | none        |
| hoangvannam   | customer    | none        |
| lethithu      | customer    | none        |
| nguyenthanh   | customer    | MC10000001  |
| tranvankhoa   | customer    | MC10000002  |
| doducanh      | customer    | MC10000003  |

Accounts without a card exercise the member registration flow; accounts with a card exercise applying a membership code at payment.

## Project structure

- `src/model`, `src/dao` — Java beans and JDBC DAOs (class suffix `4`)
- `webapp/view/nguoidung` — login, logout, generic home
- `webapp/view/khachhang` — customer home, member registration, account information
- `webapp/view/nhanvien` — sales wizard and ticket/invoice print preview
- `db/` — schema and seed scripts
- `build.bat`, `start.bat` — compile and deploy/start Tomcat

## Main flows

- Sales: `SalesStaffHome4` → `MovieSearch4` → `ShowtimeSelection4` → `SeatSelection4` → `Payment4` → `doPayment4` → `TicketInvoicePreview4` (print tickets or invoice).
- Customer: `Login4` → `CustomerHome4` → `MemberRegistration4` → `doMemberRegistration4` → `AccountInformation4`.

A seat can be sold only once per showtime (unique constraint on showtime + seat); invoice saving runs in a single transaction and reports the conflicting seat if it was sold concurrently.