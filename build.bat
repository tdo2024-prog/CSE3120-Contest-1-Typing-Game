@echo off
setlocal
cd /d "%~dp0"
REM Run from the Visual Studio 2022 Developer Command Prompt.
REM Requires MASM and Irvine32 installed at C:\Irvine.
if not exist "C:\Irvine\Irvine32.lib" (
   echo ERROR: Irvine32.lib not found at C:\Irvine.
   exit /b 1
)
where msbuild >nul 2>nul
if errorlevel 1 (
   echo ERROR: Open a Developer Command Prompt for VS 2022.
   exit /b 1
)
msbuild "Project.vcxproj" /t:Rebuild /p:Configuration=Debug /p:Platform=Win32 /m:1
if errorlevel 1 exit /b 1
echo Build succeeded. See the Debug folder for the executable.
endlocal
