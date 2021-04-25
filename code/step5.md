# CI/CD by leveraging CloudBuild and Terraform

Now you realized that you needed some CI/CD for building your application. You look at the service called CloudBuild which seems to be a serverless CI/CD tool that you can leverage and works pretty smoothly with GKE since it is a google provided service.

The first thing you need to do is to connect the Repo to CloudBuild. This is done through the settings and enables us to actually connect to the Repo.

You realize that you have no understanding of the CI/CD workflow for a Kubernetes cluster. You start looking around leveraging Google, StackOverflow, and your small faith in a higher being and start to understand that the CI/CD flow can be described however you want it. It is unique to each environment and there is no clear universal perfect way to do it. The only thing that CI/CD pipeline needs to do is test and deploy.

You start reading more and realize that when you use a container you often have to push builds to something called a container registry and then the Kubernetes cluster will pull the latest build from that container registry. Essentially, in our pipeline we need to:

1. Install all the packages necessary
2. Run all Tests
3. Deploy it to Googles Container Registry
4. Have our cluster pull from that Deployed Docker Build


We start reading a bit and this can be done by using something called a CloudBuild.yaml which describes all the steps for our CI/CD pipeline. You start to realize that you also need something called a CloudBuild Trigger and decided to google and found that you can actually leverage terraform for creating that CloudBuild Trigger.

In the new main.tf file you will see at the bottom a cloudbuild trigger that triggers when you push to the repo you cloned. However, you want it to trigger your production repo. Change the production repo and the branch you want to the cloud build to trigger on.

Lastly, you decided to open up the cloudbuild.yaml file in here you see the step that was needed in your CI/CD pipeline. You will see some variables starting with $ which is something GCP adds at runtime.

1. Install: which install all packages
2. Test: which runs all your code
3. Build: Which build the Docker Image
4. Push: Which Pushes the Docker Image to your Container Registry
5. GKE-deploy: Which changes the image in the deployment.yaml file to the one that is your most current build.

There is one final thing you need to do and that is make the Container Regsitry public (in a real production environment you would not do this but it can be complicated to setup the correct permissons with GCP so I decided to skip it)

Now you realize that you understand the CI/CD pipeline and that it is finally time for you to deploy to your Kubernetes cluster. 





