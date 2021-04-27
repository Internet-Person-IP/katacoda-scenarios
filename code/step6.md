# Push Code
This is the final stretch and in here the only thing you will do is push the code to your new repo using. **Fristly Create a Branch called final**

`git checkout -b final`{{copy}}

**Make sure to add and commit the code.**

Now you can finally push the code using: 

`git push prod final`{{copy}}

You can now go to the google console and search for CloudBuild or click [here](https://console.cloud.google.com/cloud-build/builds). In here you will find a CloudBuild that will look like it's running. This run might take up to 5 minutes so please be patient. If click in the specific build you will most likely see and IP address next a service. You can search also for GKE in the console and pick services. In services, you will find a LoadBalancer with an IP Address. It should look something like this:

![](https://media.jfrog.com/wp-content/uploads/2020/05/27214311/7_GKE-Blog_Load-balancer-IP-address.png)

If you copy that IP address you will be able to your counter application running. There is a small easter egg if you count hard enough.