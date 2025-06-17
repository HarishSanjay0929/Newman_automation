@echo off
setlocal enabledelayedexpansion

REM Set report directory to the current working directory
set "REPORT_DIR=%CD%"
set "REPORT_FILE=%REPORT_DIR%\report.html"
set "COLLECTION=Collection.json"
set "ENVIRONMENT=Environment.json"

echo Running collection...
call newman run "%COLLECTION%" -e "%ENVIRONMENT%" --reporters cli,htmlextra --reporter-htmlextra-export "%REPORT_FILE%" --reporter-htmlextra-title "Test Report" --reporter-htmlextra-browserTitle "Test Report" --reporter-htmlextra-darkTheme
set "NEWMAN_ERROR=!errorlevel!"

if exist "%REPORT_FILE%" (
    echo Report successfully generated at: "%REPORT_FILE%"
    echo Opening report...
    start "" "%REPORT_FILE%"
    set "REPORT_STATUS=Report opened successfully"

    echo Sending email with report...
    node sendMail.js
    if errorlevel 1 (
        echo ERROR: Failed to send email.
    ) else (
        echo Email sent successfully.
    )
) else (
    echo ERROR: Report file was not generated
    set "REPORT_STATUS=** REPORT GENERATION FAILED **"
)

echo --------------------------------------
echo Newman exit code : !NEWMAN_ERROR!
echo Report status    : !REPORT_STATUS!
echo --------------------------------------

pause
