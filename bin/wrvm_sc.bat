@ECHO OFF

:: WRVM secondary cloner for those with tags
cd "%1"
git checkout tags/%2
POPD