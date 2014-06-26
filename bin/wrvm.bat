@ECHO OFF

:: Some variables to rememeber
:: setx WRVM_RUBY_PATH  for current ruby
:: setx WRVM_RUBY for WRVM path and needed variables
set WRVM_BIN_HOME=%~dp0
set WRVM_HOME="%~dp0.."
:: CONTINUE IF REQUIEREMENTS ARE SATISFIED
GOTO Requirements
:: Check for GIT
:Requirements
git --version >nul 2>&1 && (
:: IF git continue
	GOTO Check_ruby_existence
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
IF	"%1"=="use"	IF	"%2"=="system"		GOTO System
IF	"%1"=="use"	IF	"%2"=="shoes"		GOTO Set_Shoes
IF	"%1"=="use"							GOTO Default_Ruby
IF	"%1"=="-v"							GOTO Version
IF	"%1"=="-h"							GOTO WRVMHelp
IF	"%1"=="--help"						GOTO WRVMHelp
IF	"%1"==""							GOTO No_Input
IF	"%1"=="--path"						GOTO WRVM_Path
IF	"%1"=="-p"							GOTO WRVM_Path
IF	"%1"=="stop"						GOTO WRVM_stop
Echo That was not a valid input
goto:eof 

:: Install Rubies
:Install_Rubies
ECHO.
ruby "%WRVM_HOME%/lib/install" %2 %WRVM_HOME%
:: use git here to update WRVM first
ECHO To use this ruby run 'WRVM use %2'
ECHO.
goto:eof

:: Set default Ruby
:Default_Ruby
ECHO.
ruby "%WRVM_HOME%/lib/delegate" %2 %WRVM_HOME%
GOTO Set_devkit
GOTO Set_ssl
ruby "%WRVM_HOME%/lib/current"
goto:eof

:: Set environements for using shoes
:Set_Shoes
ECHO.
ECHO Shoes is not yet available as of this version of WRVM
goto:eof

:: Update WRVM
:Update
ECHO "You may stop the update at anytime by pressing ctl+c"
timeout /T 10
git pull https://github.com/wilfriedE/WRVM.git "%WRVM_HOME%" -f
wrvm 
ECHO.
goto:eof

::Set ssl CA-Cert Rubies
:Set_ssl
ruby "%WRVM_HOME%/lib/cert_ssl" %WRVM_BIN_HOME%
goto:eof

::Set devkit for Rubies
:Set_devkit
ruby "%WRVM_HOME%/lib/setdevkit" %2 %WRVM_HOME%
goto:eof

:Install_Image_Magick
ECHO.
ECHO Imagemagick is not yet available as of this version
goto:eof

:: Check if ruby exists already or not
:Check_ruby_existence
	ruby -v >nul 2>&1 && (
	ruby "%WRVM_HOME%/lib/current"
	GOTO WRVMConditions
	)
	ECHO Installing the latest ruby.
	git clone https://github.com/wilfriedE/Ruby.git "%WRVM_HOME%/system"
	ruby "%WRVM_HOME%/lib/delegate" system "%WRVM_HOME%"
	ruby "%WRVM_HOME%/lib/current"
	GOTO Set_ssl
	GOTO Set_devkit
	GOTO WRVMConditions
goto:eof

:: System ruby is the main ruby that is installed
:System
ruby "%WRVM_HOME%/lib/delegate" system "%WRVM_HOME%"
ruby "%WRVM_HOME%/lib/current"
goto:eof

:WRVMHelp
ECHO You May try the following functions.
ECHO -v 			--to check version.
ECHO -h or --help			--to view "help" instructions.
ECHO install <ruby> 	--to install a specific ruby.
ECHO update 		--to update WRVM.
ECHO use 	<ruby>		--Choose which ruby you wish as your current default.
ECHO use 	system		--to use wrvm default ruby.
ECHO -p  or --path		--for wrvm installation path.
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
ECHO %WRVM_HOME%
ECHO.
goto:eof

:WRVM_stop
goto:eof

POPD

