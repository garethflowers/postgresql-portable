@echo off
title PostgreSQL 8.4
cls

:: set default code page
chcp 1252 > nul

:: find base directories
for %%? in ("%~dp0..\..") do set APPBASE=%%~f?
for %%? in ("%~dp0..\..\..") do set BASE=%%~f?

:: set up postgres variables
set PGSQL=%APPBASE%\App\PgSQL
set PGDATA=%APPBASE%\Data\data
set PGLOG=%APPBASE%\Data\log.txt
set PGLOCALEDIR=%PGSQL%\share\
set PGDATABASE=postgres
set PGUSER=postgres
set PATH=%PGSQL%\bin;%PATH%

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
