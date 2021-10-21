#!/bin/bash
echo -e "Введите название агента:"
read agentname
echo -e "\033[31m Infura endpoint (Mainnet):"
read endpoint
echo -e "\033[32m Infura Project ID:"
read pid
echo -e "\033[33m Infura Project Secret"
read secret
sudo apt update
sudo apt install curl -y
sudo apt install docker.io -y
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo mkdir $agentname
cd ~/$agentname && sudo npx forta-agent@latest init --typescript
sudo npm install
cd ~/.forta && rm forta.config.json
authkey=`echo $pid:$secret | base64`
rm ~/.forta/forta.config.json
bash -c 'cat > ~/.forta/forta.config.json<<EOF
{
"jsonRpcUrl": "$endpoint",
"ipfsGatewayUrl": "https://ipfs.infura.io:5001",
"ipfsGatewayAuth": "$authkey"
}
EOF'
