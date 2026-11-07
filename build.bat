@echo off
setlocal
set "PROJECT_DIR=%~dp0"
if defined JAVA_HOME set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%PROJECT_DIR%"

if not exist webapp\WEB-INF\classes mkdir webapp\WEB-INF\classes

javac --release 21 -encoding UTF-8 -cp "webapp\WEB-INF\lib\*" -d webapp\WEB-INF\classes src\model\*.java src\dao\*.java
if %ERRORLEVEL% neq 0 (
    echo BUILD FAILED
    exit /b 1
)
echo BUILD OK
