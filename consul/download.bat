if exist binaries rmdir /s /q binaries
mkdir binaries
pushd binaries
curl -k -fsSL https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_windows_amd64.zip > 0.6.3_windows_386.zip
curl -k -fsSL https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_web_ui.zip > 0.6.3_web_ui.zip
curl -k -fsSL https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_SHA256SUMS > 0.6.3_SHA256SUMS
curl -k -fsSL https://nssm.cc/release/nssm-2.24.zip > nssm-2.24.zip
popd
