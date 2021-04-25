# Init
You start looking around in the project and you realize that it is a react project. That you need to deploy to GKE. You see in src/App.js this is a counter app that seems to be counting up. There should also be counting down feature but it should be added later when the CI/CD pipeline is done.
## GCP



We first need to initialize GCP.

1. Create a GCP account [here](https://cloud.google.com/free)
2. Run command ```gcloud init``` in Console.
3. Type y when the Console prints: You must log in to continue. Would you like to log in (Y/n)? 
4. You’re supposed to open a link on your browser and log into your google cloud account. Parse the verification code in the link to Console and you will see: You are logged in as: [XXX@gmail.com].
5. Now you can pick up an already existing project or create a new project. In our case, you may type in 2 to create a new project named [kubernetes-cicd-react].
6. Now your local environment is connected to the correct project, as you can see: Your current project has been set to: [kubernetes-cicd-react].
7. Create a IAM user for this project. In Console, you can use command 
``` gcloud iam service-accounts create terraform-service-account  --display-name="Terraform Builder" ```
8. Download keys for this project. Use command below 
``` gcloud iam service-accounts keys create key.json  --iam-account=terraform-service-account@kubernetes-cicd-react.iam.gserviceaccount.com ```
9. You enable the API neccasry for the project by typing in this command:
``` gcloud services enable container.googleapis.com cloudbuild.googleapis.com sourcerepo.googleapis.com containeranalysis.googleapis.com ```
10. Congradulations! You’ve made a huge step.


# Create a Github Repository

1. Use your own github account to create a new Repo and name it whatever you want.
2. Add a new Remote because you will need to push to a new production environment use command git remote add prod <your repo>

```
git remote add prod <your repo>

```


