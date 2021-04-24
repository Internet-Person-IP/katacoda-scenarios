
#!/bin/bash

echo "Waiting to complete Please Do not Click Ctrl-C it will cancel the background process and you will need to reload the tutorial"; while [ ! -f /opt/.backgroundfinished ]; do sleep 2; done; echo "Done"