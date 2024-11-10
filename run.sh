#!/bin/bash

# Install Playit
echo "Installing Playit"
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list
sudo apt update
sudo apt install playit -y
echo "Done"

# Install Ngrok
echo "Installing Ngrok"
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok

# Start the server
mkdir -p mc
cd mc
curl https://raw.githubusercontent.com/hexlo/minecraft-bedrock-server/refs/heads/main/.scripts/download-latest-version.sh | bash
timeout 300m tmux new-session -d -s './start-server.sh'
ngrok config add-authtoken 1rpIxjnw9FDx2Fcl3xZqWI3SsWr_59uKERPhAS7bn8cMTQX1P
