@ECHO OFF
PUSHD "%~dp0"

ECHO Setting up WRVM...
for /f "usebackq tokens=2,*" %%A in (`reg query HKCU\Environment /v PATH`) do set value=%%B
setx PATH "%%WRVM_RUBY%%;%%WRVM_RUBY_PATH%%;%value%"
setx WRVM_RUBY "%~dp0/bin;"
setx WRVM_RUBY_PATH "%~dp0\system\bin"
setx SSL_CERT_FILE "%~dp0\bin\cacert.pem"
ECHO You will now be prompted to install git wich is required by WRVM.  
ECHO "If you already have git installed, this process is not necessary."
ECHO "If not, you will be prompted after this setup to install git. Please install it."
timeout /T 10
"%~dp0\installers\git.exe"
ECHO "Setup is now complete. Please make sure git is installed to proceed to using WRVM."

ECHO "Type WRVM to start using WRVM"
exit
goto:eof