echo off
mkdir binaries
pushd binaries
attrib +r +s .gitignore
del /f /q *
attrib -r -s .gitignore
curl -k -fsSL https://dl.bintray.com/mitchellh/consul/0.5.2_windows_386.zip > 0.5.2_windows_386.zip
curl -k -fsSL https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip > 0.5.2_web_ui.zip
curl -k -fsSL https://dl.bintray.com/mitchellh/consul/0.5.2_SHA256SUMS > 0.5.2_SHA256SUMS
curl -k -fsSL https://nssm.cc/release/nssm-2.24.zip > nssm-2.24.zip
popd
