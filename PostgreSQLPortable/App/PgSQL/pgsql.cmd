@echo off
title PostgreSQL Portable
cls

:: set default code page
chcp 1252 > nul

:: initialise a new database on first use
if not exist "%PGDATA%" (
    echo.
    echo Initialising database for first use, please wait...
    "%PGSQL%\bin\initdb" -U %PGUSER% -A trust -E utf8 --locale=C >nul
)

:: startup postgres server
echo.
"%PGSQL%\bin\pg_ctl" -D "%PGDATA%" -l "%PGLOG%" -w start
cls
echo.
echo Type \q to quit and shutdown server
echo.
"%PGSQL%\bin\psql.exe"
echo.
"%PGSQL%\bin\pg_ctl" -D "%PGDATA%" stop
