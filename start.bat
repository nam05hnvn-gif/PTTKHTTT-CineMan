@echo off
setlocal
set "PROJECT_DIR=%~dp0"
if not defined CATALINA_HOME set "CATALINA_HOME=%PROJECT_DIR%tools\apache-tomcat-11.0.27"
if not exist "%CATALINA_HOME%\bin\startup.bat" (
    echo Tomcat not found. Set CATALINA_HOME to your Tomcat 11 installation.
    exit /b 1
)
cd /d "%PROJECT_DIR%"

rem Deploy webapp vao Tomcat
if exist "%CATALINA_HOME%\webapps\CineMan" rmdir /s /q "%CATALINA_HOME%\webapps\CineMan"
xcopy /s /e /i /q /y "%PROJECT_DIR%webapp" "%CATALINA_HOME%\webapps\CineMan"

rem Cau hinh UTF-8 cho Tomcat
(
    echo set CATALINA_OPTS=-Dfile.encoding=UTF-8
) > "%CATALINA_HOME%\bin\setenv.bat"

call "%CATALINA_HOME%\bin\startup.bat"
echo.
echo CineMan dang chay tai: http://localhost:8080/CineMan/
