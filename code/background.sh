#!/bin/bash


echo "This is a background script with a long running process"

ls -a
git clone https://github.com/Internet-Person-IP/GKE-CI-CD-Tutorial/tree/initialState
cd GKE-CI-CD-Tutorial
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
echo "done" >> /opt/.backgroundfinished

