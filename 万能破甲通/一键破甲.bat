@echo off
rem ==================================================================
rem  WanNeng PoJiaTong v8.0  --  launcher
rem
rem  This file is deliberately 100% ASCII. A .bat containing any
rem  non-ASCII byte gets mangled when cmd.exe parses it under the
rem  wrong code page. All Chinese text lives inside the Python file.
rem
rem  The core .py is located by wildcard + size, because its name is
rem  non-ASCII -- never write that name here.
rem
rem    double-click (no args) -> interactive CLI menu
rem    any argument           -> command line (--status / --apply ...)
rem ==================================================================

cd /d "%~dp0"

rem ---- locate the core .py: the only .py over 100 KB in this folder ----
set "SCRIPT="
for %%F in ("%~dp0*.py") do if %%~zF GTR 100000 set "SCRIPT=%%~fF"

if not defined SCRIPT (
    echo.
    echo   [!] Core .py not found next to this launcher.
    echo       Keep the .bat and the core .py in the same folder.
    echo.
    pause
    exit /b 1
)

rem ---- 1) python on PATH ----
set "PYEXE="
where python >nul 2>&1
if %errorlevel%==0 set "PYEXE=python"

rem ---- 2) Windows py launcher ----
if not defined PYEXE (
    where py >nul 2>&1
    if %errorlevel%==0 set "PYEXE=py"
)

if not defined PYEXE (
    echo.
    echo   [!] Python was not found on PATH. Install Python 3.8+ first.
    echo.
    pause
    exit /b 1
)

"%PYEXE%" "%SCRIPT%" %*
set "RC=%errorlevel%"

rem ---- keep the window open only for double-click runs ----
if "%~1"=="" pause
exit /b %RC%
