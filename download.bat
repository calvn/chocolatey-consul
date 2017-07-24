if "%CONSUL_VERSION%"=="" exit /b 1
if exist binaries rmdir /s /q binaries
mkdir binaries
pushd binaries
curl -k -fsSL https://releases.hashicorp.com/consul/%CONSUL_VERSION%/consul_%CONSUL_VERSION%_windows_amd64.zip > %CONSUL_VERSION%_windows_amd64.zip
curl -k -fsSL https://releases.hashicorp.com/consul/%CONSUL_VERSION%/consul_%CONSUL_VERSION%_windows_386.zip > %CONSUL_VERSION%_windows_386.zip
curl -k -fsSL https://releases.hashicorp.com/consul/%CONSUL_VERSION%/consul_%CONSUL_VERSION%_SHA256SUMS > %CONSUL_VERSION%_SHA256SUMS
popd
