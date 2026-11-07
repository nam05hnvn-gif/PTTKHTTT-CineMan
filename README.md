# PTTKHTTT-CineMan

Web application for cinema ticket sales, built with Java 21, JSP, MySQL, and Tomcat 11.

## Requirements

- JDK 21
- MySQL with the CineMan database schema
- Apache Tomcat 11

## Build and run on Windows

Set the database connection in the current terminal before starting Tomcat:

```powershell
$env:CINEMAN_DB_URL = "jdbc:mysql://localhost:3306/cineman?characterEncoding=UTF-8"
$env:CINEMAN_DB_USER = "root"
$env:CINEMAN_DB_PASSWORD = "<your-local-database-password>"
$env:CATALINA_HOME = "C:\path\to\apache-tomcat-11"
.\build.bat
.\start.bat
```

`JAVA_HOME` may point to JDK 21; otherwise `javac` must be available on `PATH`.
The MySQL connector is included in `webapp/WEB-INF/lib`.

The SQL files in `db/` add demo data to an already-created CineMan schema.
