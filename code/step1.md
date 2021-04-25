# Research
Currently in the background there is a script running to install Terraform CLI and GCP CLI.

### Docker
You decided to do some research into the topic on Containerization. You did not have time to dig deep since the client is stressing you about some deadlines but essentially you understood that a container is similar to a virtual machine but there where some advantages. It builds a predictable enviroment where you run your code, which minimizes the issues with different OS version, config files and so on. The main technology to keep an eye on is Docker. The main concepts to look at seems to be the Dockerfile (describing the envrionment)¸ Image (a build of the environment) and container (Running the actual envrionment).

### Kubernetes
The second concept that you were unfamiliar with was Kubernetes, which deals with Orchestrating the Docker Containers. You tried looking into to it but the technology was quite extensive. People started talking about Control Plane, ETCD files and you are confused with a deadline. Ultimately the picture you got was that Kubernetes was used to provision and deal with scaling, healing and loadbalancing between different containers. There seemed to be some important components which you decided to write down:

- Cluster - A cluster a bunch of nodes running containerized applications
- Node - A node is similar physical machine that the containers are running on. 
- Pod - Is a container running in a Node in a Cluster

There are some more details but you are currently thinking eh why worry about those details right now? We will deal with them when we deal with them.

### CI/CD
CI/CD just refers to us Contiously Testing and Deploying. In your experience as a consultant this often means that company want to be able to push to github and that code gets automatically tested and deployed to production. You decided to replicate that for this assignment.

### Terraform 
Terraform is a technology you are familiar with. Terraform is an open-source infrastructure as code software tool. Terraform enables us to provision cloud resources using declarative configuration files.

### What now?
Well, after doing all your research you realize that this entire things is going to be pain to do a Kubernetes cluster completely from scratch. You realize that you need something to deal with some of the more complex details. Enter Cloud and GCP. GCP offers a service called GKE which deals with some of the more complex topics of Kubernetes, so you decided:

"LETS GO" - Da Baby