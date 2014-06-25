@ECHO OFF
:: CONTINUE IF REQUIEREMENTS ARE SATISFIED
GOTO Requirements
:: Check for GIT
:Requirements
git --version >nul 2>&1 && (
:: IF git continue
	ruby -v >nul 2>&1 && (
	ruby "%~dp0/lib/current"
	) || (
	ECHO Installing the latest ruby.
	git clone https://github.com/wilfriedE/Ruby.git "%~dp0%~dp0/Ruby/"
	ruby "%~dp0/lib/current"
	GOTO Set_ssl
	GOTO Set_devkit
	)
	GOTO WRVMConditions
)
:: IF Not git require installation of git and quit
ECHO "You do not have git installed, please make sure to git is install to continue."
ECHO "For more info refer to https://github.com/wilfriedE/WRVM/wiki/Installing-git ."
goto:eof 

:: WRVM conditions
:WRVMConditions
IF	"%1"=="install"  IF	"%2"=="imagemagick"	GOTO Install_Image_Magick
IF	"%1"=="install"						GOTO Install_Rubies
IF	"%1"=="update"    					GOTO Update
:: IF	"%1"=="use"	IF	"%2"=="system"		GOTO System
IF	"%1"=="use"							GOTO Default_Ruby
IF	"%1"=="-v"							GOTO Version
IF	"%1"=="-h"							GOTO WRVMHelp
IF	"%1"=="--help"						GOTO WRVMHelp
IF	"%1"==""							GOTO No_Input
IF	"%1"=="--path"						GOTO WRVM_Path
IF	"%1"=="-p"						GOTO WRVM_Path
Echo That was not a valid input
goto:eof 

:: Install Rubies
:Install_Rubies
ECHO.
ruby "%~dp0/lib/delegate" "%2" %~dp0
:: use git here to update WRVM first
GOTO Set_ssl
GOTO Set_devkit
ECHO.
goto:eof

:: Update WRVM
:Update
ECHO "You may stop the update at anytime by pressing ctl+c"
timeout /T 10
git pull https://github.com/wilfriedE/WRVM.git "%~dp0/." -f
wrvm 
ECHO.
goto:eof

:: Set default Ruby
:Default_Ruby
ECHO.
ECHO setting "%2" as default
ruby "%~dp0/lib/current"
goto:eof

::Set ssl CA-Cert Rubies
:Set_ssl
ruby "%~dp0/lib/cert_ssl" %~dp0
goto:eof

::Set ssl CA-Cert Rubies
:Set_devkit
ruby "%~dp0/Ruby/Devkit/dk.rb" 
ruby "%~dp0/Ruby/Devkit/dk.rb" init
ruby "%~dp0/Ruby/Devkit/dk.rb" install
goto:eof

:Install_Image_Magick
ECHO.
ECHO Installing imagemagick
goto:eof

:WRVMHelp
ECHO You May try the following functions.
ECHO -v 			--to check version.
ECHO -h 			--to view "help" instructions.
ECHO install rubies 	--to install a specific ruby.
ECHO update 		--to update WRVM.
ECHO use 			--Choose which ruby you wish as your current default.
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

:WRVM_Path
ECHO %~dp0
ECHO.
goto:eof
POPD