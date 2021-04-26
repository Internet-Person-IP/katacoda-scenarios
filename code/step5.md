# CI/CD by leveraging CloudBuild and Terraform

Now you realized that you needed some CI/CD for building your application. You look at the service called CloudBuild which seems to be a serverless CI/CD tool that you can leverage and works pretty smoothly with GKE since it is a google provided service.

The first thing you need to do is to connect the Repo to CloudBuild. 

**This is done through the settings and enables us to actually connect to the Repo. This can be done in [here](https://console.cloud.google.com/cloud-build/triggers/connect)**
**You need to go to your CloudBuild settings in the console.**
**You go to the console, Click Triggers and click connect Repo**
**Once you are there connect to the Repo that you created earlier**

Next you need to enable GKE in CloudBuild.
**Go to Settings on Cloud Build and enable Kubernetes Engine**
You realize that you have no understanding of the CI/CD workflow for a Kubernetes cluster. You start looking around leveraging Google, StackOverflow, and your small faith in a higher being and start to understand that the CI/CD flow can be described however you want it. It is unique to each environment and there is no clear universal perfect way to do it. The only thing that CI/CD pipeline needs to do is test and deploy.

You start reading more and realize that when you use a container you often have to push builds to something called a container registry and then the Kubernetes cluster will pull the latest build from that container registry. Essentially, in our pipeline we need to:

1. Install all the packages necessary
2. Run all Tests
3. Deploy it to Googles Container Registry
4. Have our cluster pull from that Deployed Docker Build


We start reading a bit and this can be done by using something called a CloudBuild.yaml which describes all the steps for our CI/CD pipeline. You start to realize that you also need something called a CloudBuild Trigger and decided to google and found that you can actually leverage terraform for creating that CloudBuild Trigger.

**You will now update the main.tf file in the terraform directory by adding this to end of the file:**

<pre class="file" data-target="clipboard">
resource "google_cloudbuild_trigger" "filename-trigger" {
  github {
    owner = "your-git-user"
    name   = "your-git-repo"
    push {
      branch = "final"
    }
  }
  filename = "cloudbuild.yaml"
}
</pre>


In the new main.tf file you will see at the bottom a cloudbuild trigger that triggers when you push to the repo you cloned. However, you want it to trigger your production repo. <br/>

**Change the production repo and the branch you want to the cloud build to trigger on. We recommend a branch called 'final' since it will be different from the intial repo and will not create any issues. In this case change the owner and the name and the branch**

Now you need to apply the changes to terraform.

**Traverse to the terraform folder and do**
> `terraform init`{{copy}} <br/>
> `terraform plan`{{copy}} <br/>
> `terraform apply`{{copy}} <br/>

**Lastly create a cloudbuild.yaml at the root of the project with this added:**
<pre class="file" data-target="clipboard">
steps:
# This step install npm packages
- name: 'gcr.io/cloud-builders/npm'
  id: Install
  args: ['install']

# This step runs the unit tests on the app
- name: 'gcr.io/cloud-builders/npm'
  id: Test
  args: ['test']


# This step builds the container image.
- name: 'gcr.io/cloud-builders/docker'
  id: Build
  args:
  - 'build'
  - '-t'
  - 'gcr.io/$PROJECT_ID/kube-cicd-react:$SHORT_SHA'
  - '.'

# This step pushes the image to Container Registry
# The PROJECT_ID and SHORT_SHA variables are automatically
# replaced by Cloud Build.
- name: 'gcr.io/cloud-builders/docker'
  id: Push
  args:
  - 'push'
  - 'gcr.io/$PROJECT_ID/kube-cicd-react:$SHORT_SHA'

#This step deploys the new version of our container image
#in the demo-cloudbuild Kubernetes Engine cluster.


- name: "gcr.io/cloud-builders/gke-deploy"
  args:
  - run
  - --filename=./kubernetes/
  - --image=gcr.io/$PROJECT_ID/kube-cicd-react:$SHORT_SHA
  - --location=europe-west2
  - --cluster=gke-react-with-cicd
</pre>

In here you see the step that was needed in your CI/CD pipeline. You will see some variables starting with $ which is something GCP adds at runtime. This CI/CD pipeline does:

1. Install: which install all packages
2. Test: which runs all your code
3. Build: Which build the Docker Image
4. Push: Which Pushes the Docker Image to your Container Registry
5. GKE-deploy: Which changes the image in the deployment.yaml file to the one that is your most current build.

<!--**There is one final thing you need to do and that makes the Container Registry public (in a real production environment you would not do this but it can be complicated to set up the correct permissions with GCP so I decided to skip it)**-->

Now you realize that you understand the CI/CD pipeline and that it is finally time for you to deploy to your Kubernetes cluster. 





