if exist binaries rmdir /s /q binaries
SET CONSUL_VERSION=0.6.3
mkdir binaries
pushd binaries
curl -k -fsSL https://releases.hashicorp.com/consul/%CONSUL_VERSION%/consul_%CONSUL_VERSION%_windows_amd64.zip > %CONSUL_VERSION%_windows_386.zip
curl -k -fsSL https://releases.hashicorp.com/consul/%CONSUL_VERSION%/consul_%CONSUL_VERSION%_web_ui.zip > %CONSUL_VERSION%_web_ui.zip
curl -k -fsSL https://releases.hashicorp.com/consul/%CONSUL_VERSION%/consul_%CONSUL_VERSION%_SHA256SUMS > %CONSUL_VERSION%_SHA256SUMS
curl -k -fsSL https://nssm.cc/release/nssm-2.24.zip > nssm-2.24.zip
popd
