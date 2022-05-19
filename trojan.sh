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
            "port": "$PORT","protocol": "trojan",
            "settings": {"clients": [{"password": "$id"}]},
            "streamSettings": {"network": "ws","wsSettings": {"path": "/$id-trojan-$PORT"}}
        }
    ],
    "outbounds": 
    [
        {"protocol": "freedom","tag": "direct","settings": {}},
        {"protocol": "blackhole","tag": "blocked","settings": {}}
    ],
    "routing": 
    {
        "rules": 
        [
            {"type": "field","outboundTag": "blocked","ip": ["geoip:private"]},
            {"type": "field","outboundTag": "block","protocol": ["bittorrent"]},
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}
        ]
    }
}
EOF

./web -config=config.json >/dev/null 2>&1
