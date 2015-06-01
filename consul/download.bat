echo off
mkdir binaries
pushd binaries
attrib +r +s .gitignore
del /f /q *
attrib -r -s .gitignore
wget --no-check-certificate -O 0.5.0_windows_386.zip https://dl.bintray.com/mitchellh/consul/0.5.0_windows_386.zip
wget --no-check-certificate -O 0.5.0_web_ui.zip https://dl.bintray.com/mitchellh/consul/0.5.0_web_ui.zip
wget --no-check-certificate https://dl.bintray.com/mitchellh/consul/0.5.0_SHA256SUMS
wget --no-check-certificate -O nssm-2.24.zip https://nssm.cc/release/nssm-2.24.zip
popd
