
#!/bin/bash

echo "Waiting to complete Please Do not Click Ctrl-C it will cancel the background process and you will need to reload the tutorial"; while [ ! -f /opt/.backgroundfinished ]; do sleep 2; done; echo "Done"

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk -y