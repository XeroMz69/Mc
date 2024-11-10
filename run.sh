#!/bin/bash

# Install Playit
echo "Installing Playit"
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list
sudo apt update
sudo apt install playit
echo "Done"

mkdir -p mc
cd mc
curl https://raw.githubusercontent.com/hexlo/minecraft-bedrock-server/refs/heads/main/.scripts/download-latest-version.sh | bash
timeout 300m tmux new-session -d -s './start-server.sh'
timeout 300m playit
