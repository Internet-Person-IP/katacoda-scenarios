# Kubernetes Cluster
Kubernetes seems like quite a lot to learn but you decide to use to at least learn some of the basics. There seems to be a couple of topics you need to keep in your head which are deployments(describes which pods are being deployed and ports and such), services(describe additional port mappings and additional services such as load balancing), pods(just the smallest type of container, in this case, it is defined in the same file as deployment) and ingress(which describes certain firewalls rules for the cluster). These concepts can often be defined as a declarative yaml file makes it easy for them to deploy to the Kubernetes cluster.

You will now create a small deployment, service and ingress rule.

> `cd .. && mkdir kubernetes && cd kubernetes`{{copy}}

**You first create a file called deployment.yaml in the kubernetes directory which includes something like this:**

<pre class="file" data-target="clipboard">
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kube-cicd-react-deployment
  namespace: default
spec:
  selector:
    matchLabels:
      run: kube-cicd-react
  template:
    metadata:
      labels:
        run: kube-cicd-react
    spec:
      containers:
      - image: gcr.io/:PROJECT_ID/kube-cicd-react:COMMIT_SHA
        imagePullPolicy: IfNotPresent
        name: kube-cicd-react
        ports:
        - containerPort: 3000
          protocol: TCP
</pre>

This creates a container with a small nginx server.

**Next you decide to create a service.yaml in the kubernetes directory which includes something like this:**


<pre class="file" data-target="clipboard">
apiVersion: v1
kind: Service
metadata:
  name: kube-cicd-react-service
  namespace: default
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 3000
  selector:
    run: kube-cicd-react
  type: LoadBalancer
</pre>

**The last file you will add is a ingress.yaml file in the kubernetes directory which includes something like this:**

<pre class="file" data-target="clipboard">
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-ingress
spec:
  rules:
    - http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
             name: kube-cicd-react
             port:
              number: 80
</pre>


The main way to deploy is to do:
`kubectl apply -f your-specific-file`


**However, you realize that seems like a bad idea to deploy right now**. Rather you think it's a better idea to start building the CI/CD pipeline since you can just leverage that to build and run your application.