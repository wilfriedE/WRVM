@ECHO OFF
PUSHD "%~dp0"
:: WRVM conditions
IF	"%1"=="setup"    					GOTO Setup
IF	"%1"=="install"  IF	"%2"=="rubies"	GOTO Install_Rubies
IF	"%1"=="install"  IF	"%2"=="imagemagick"	GOTO Install_Image_Magick
IF	"%1"=="update"    					GOTO Update
IF	"%1"=="use"							GOTO Default_Ruby
IF	"%1"=="-v"							GOTO Version
IF	"%1"=="-h"							GOTO WRVMHelp
IF	"%1"==""							GOTO No_Input
Echo That was not a valid input
goto:eof 


:: WRVM setup
:Setup
ECHO.
ruby -v >nul 2>&1 && (
	ECHO "You might want to remove the current ruby from path"
)
ECHO Setting up WRVM...
for /f "usebackq tokens=2,*" %%A in (`reg query HKCU\Environment /v PATH`) do set value=%%B
setx PATH "%%WRVM_RUBY%%;%value%"
setx WRVM_RUBY "%~dp0;%~dp0/rubies/WRVMRuby/bin/"
"%~dp0/rubies/WRVMRuby/bin/ruby.exe" "%~dp0/lib/setup.rb"
exit
goto:eof


:: Install Rubies
:Install_Rubies
ECHO.
ECHO wait...
ruby "%~dp0/lib/install_rubies.rb"
goto:eof

:: Update WRVM
:Update
ECHO.
ruby "%~dp0/lib/update.rb"
goto:eof

:: Set default Ruby
:Default_Ruby
ECHO.
ruby "%~dp0/lib/set_default.rb"
goto:eof

:Install_Image_Magick
ECHO.
ECHO Installing imagemagick
goto:eof

:WRVMHelp
ECHO You May try the following functions.
ECHO -setup 		--Setup WRVM environment
ECHO -v 			--to check version.
ECHO -h 			--to view "help" instructions.
ECHO -install rubies 	--to install a specific ruby.
ECHO -update 		--to update WRVM.
ECHO -use 			--Choose which ruby you wish as your current default.
goto:eof

:: No input
:No_Input
ECHO.
ECHO You have entered no inputs.
ECHO.
GOTO WRVMHelp
goto:eof

:Version
ECHO.
ECHO WRVM Version 0.0.0 -pre
goto:eof

POPD