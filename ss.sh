#!/bin/bash

rm -f config.json
wget -qN https://raw.githubusercontent.com/castelenl/AX/main/web 
wget -qN https://eung.akuner.tk/rules/geosite.dat 
wget -qN https://eung.akuner.tk/rules/geoip.dat
chmod +x ./web

if [[ -z $id ]]; then
    id="1eb6e917-774b-4a84-aff6-b058577c60a5"
fi

cat <<EOF > ~/config.json
{
   "log": {
        "loglevel": "none"
    }, 
    "inbounds": 
    [
        
        {
            "port":"$PORT","tag": "onetag","protocol": "dokodemo-door",
            "settings": {"address": "v1.mux.cool","network": "tcp","followRedirect": false},
            "streamSettings": {"security": "none","network": "ws","wsSettings": {"path": "/$id-ss-$PORT"}}
        },
        {
            "port": 4324,"listen": "127.0.0.1","protocol": "shadowsocks",
            "settings": {"method": "$ParameterSSENCYPT","password": "$id"},
            "streamSettings": {"security": "none","network": "domainsocket","dsSettings": {"path": "apath","abstract": true}}
        }
    ],
    
    "outbounds": 
    [
        {"protocol": "freedom","tag": "direct","settings": {}},
        {"protocol": "blackhole","tag": "blocked","settings": {}},
        {"protocol": "freedom","tag": "twotag","streamSettings": {"network": "domainsocket","dsSettings": {"path": "apath","abstract": true}}}    
    ],
    
    "routing": 
    {
        "rules": 
        [
            {"type": "field","inboundTag": ["onetag"],"outboundTag": "twotag"},
            {"type": "field","outboundTag": "block","protocol": ["bittorrent"]},
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}
        ]
    }
}
EOF

./web -config=config.json >/dev/null 2>&1
