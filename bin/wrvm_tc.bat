@ECHO OFF

:: WRVM Third configurer for rubinius
cd "%1"
gem install bundler
gem install rake
bundle
./configure --prefix="%1"
rake
POPD