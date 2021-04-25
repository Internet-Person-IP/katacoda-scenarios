# Kubernetes Cluster
Kubernetes seems like quite a lot to learn but you decide to use to at least learn some of the basics. There seems to be a couple of topics you need to keep in your head which are deployments(describes which pods are being deployed and ports and such), services(describe additional port mappings and additional services such as load balancing), pods(just the smallest type of container, in this case, it is defined in the same file as deployment) and ingress(which describes certain firewalls rules for the cluster). These concepts can often be defined as a declarative yaml file makes it easy for them to deploy to the Kubernetes cluster. In this project, they can be found in the kubernetes/ folder. The main way to deploy is to do:

kubectl apply -f <specific file>


However, you realize that seems like a bad idea to deploy right now. Rather you think it's a better idea to start building the CI/CD pipeline since you can just leverage that to build and run your application.