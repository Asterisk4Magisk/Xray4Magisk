rm accelerated-domains.china.conf bogus-nxdomain.china.conf toblock-without-shorturl-optimized.lst dnscrypt-proxy-cloaking.txt example-dnscrypt-proxy.toml

wget https://github.com/felixonmars/dnsmasq-china-list/raw/master/accelerated-domains.china.conf
echo '# Converted from https://github.com/felixonmars/dnsmasq-china-list/blob/master/accelerated-domains.china.conf' >dnscrypt-forwarding-rules.txt
echo '# https://github.com/felixonmars/dnsmasq-china-list' >>dnscrypt-forwarding-rules.txt
echo '# Thanks to all contributors.' >>dnscrypt-forwarding-rules.txt
echo '' >>dnscrypt-forwarding-rules.txt
cat accelerated-domains.china.conf | grep -v '^#server' | sed -e 's|/| |g' -e 's|^server= ||' | sed 's/114.114.114.114/114.114.114.114,114.114.115.115/g' >>dnscrypt-forwarding-rules.txt

wget https://github.com/felixonmars/dnsmasq-china-list/raw/master/bogus-nxdomain.china.conf
echo '# Converted from https://github.com/felixonmars/dnsmasq-china-list/blob/master/bogus-nxdomain.china.conf' >dnscrypt-blacklist-ips.txt
echo '# https://github.com/felixonmars/dnsmasq-china-list' >>dnscrypt-blacklist-ips.txt
echo '# Thanks to all contributors.' >>dnscrypt-blacklist-ips.txt
echo '' >>dnscrypt-blacklist-ips.txt
cat bogus-nxdomain.china.conf | grep -v '^#bogus' | grep bogus-nxdomain | sed 's/bogus-nxdomain=//g' >>dnscrypt-blacklist-ips.txt

#wget https://github.com/missdeer/blocklist/raw/master/toblock-without-shorturl-optimized.lst
#echo '# Converted from https://github.com/missdeer/blocklist/blob/master/toblock-without-shorturl-optimized.lst' >dnscrypt-blacklist-domains.txt
#echo '# https://github.com/missdeer/blocklist' >>dnscrypt-blacklist-domains.txt
#echo '# Thanks to all contributors.' >>dnscrypt-blacklist-domains.txt
#echo '' >>dnscrypt-blacklist-domains.txt
#echo 'ad.*' >>dnscrypt-blacklist-domains.txt
#echo 'ad[0-9]*' >>dnscrypt-blacklist-domains.txt
#echo 'ads.*' >>dnscrypt-blacklist-domains.txt
#echo 'ads[0-9]*' >>dnscrypt-blacklist-domains.txt
#cat toblock-without-shorturl-optimized.lst | grep -v '^#' | tr -s '\n' | tr A-Z a-z | grep -v '^ad\.' | grep -v -e '^ad[0-9]' | grep -v '^ads\.' | grep -v -e '^ads[0-9]' | rev | sort -n | uniq | rev >>dnscrypt-blacklist-domains.txt

#wget https://github.com/googlehosts/hosts/raw/master/hosts-files/dnscrypt-proxy-cloaking.txt
#echo '# Converted from https://github.com/googlehosts/hosts/blob/master/hosts-files/dnscrypt-proxy-cloaking.txt' >dnscrypt-cloaking-rules.txt
#echo '# https://github.com/googlehosts/hosts' >>dnscrypt-cloaking-rules.txt
#echo '# Thanks to all contributors.' >>dnscrypt-cloaking-rules.txt
#echo '' >>dnscrypt-cloaking-rules.txt
#cat dnscrypt-proxy-cloaking.txt >>dnscrypt-cloaking-rules.txt

rm accelerated-domains.china.conf bogus-nxdomain.china.conf toblock-without-shorturl-optimized.lst dnscrypt-proxy-cloaking.txt

wget https://raw.githubusercontent.com/jedisct1/dnscrypt-proxy/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
