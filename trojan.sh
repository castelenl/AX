#!/bin/bash

wget -N https://raw.githubusercontent.com/castelenl/AX/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="1eb6e917-774b-4a84-aff6-b058577c60a5"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "none"
    },
    "inbounds": [
        {
            "port": "$PORT",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json >/dev/null 2>&1
