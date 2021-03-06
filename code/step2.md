# Init
You start looking around in the project and you realize that it is a react project. That you need to deploy to GKE. You see in src/App.js this is a counter app that seems to be counting up. There should also be counting down feature but it should be added later when the CI/CD pipeline is done.
## GCP

We first need to initialize GCP. You will need to add your credit card information in the google cloud for the tutorial to be possible. If you start a GCP account for the first time and start the tutorial you will recive a free 300 dollar credits you can use for 3 months which garantees that no funds will be drawn. After the tutorial is over you can just remove your card from GCP and there should be no issues. Google requires credit card since some of their API such as Computing cost money and therefore they leverage the credit card to garentee that real people have access to the free tier and the platforms APIs.

1. Create a GCP account [here](https://cloud.google.com/free)
2. Run command ```gcloud init``` in Console.
3. Type y when the Console prints: You must log in to continue. Would you like to log in (Y/n)? 
4. You’re supposed to open a link on your browser and log into your google cloud account. Parse the verification code in the link to Console and you will see: You are logged in as: [XXX@gmail.com].
5. Now you can pick up an already existing project or create a new project. In our case, you may type in 2 to create a new project named [your_project_name].
**Remember this project name, it will be needing it later on**
6. Now your local environment is connected to the correct project, as you can see: Your current project has been set to: [your_project_name] which you can pick. You might recive an error that resource already exist and that is because project_names need to unique across the entire GCP. So just create it again with a more unique ID.
7. Create a IAM user for this project. In Console, you can use command 
``` gcloud iam service-accounts create terraform-service-account  --display-name="Terraform Builder" ```
8. Download keys for this project. Use command below 
``` gcloud iam service-accounts keys create key.json  --iam-account=terraform-service-account@your_project_name.iam.gserviceaccount.com ```
**remember which directory this key is stored, this will be relevant later on**
9. You will then need to add a role to your IAM service account using this command:
`gcloud projects add-iam-policy-binding your_project_name --member serviceAccount:terraform-service-account@your_project_name.iam.gserviceaccount.com --role=roles/owner`
**Remember this IAM service account, it will be needing it later on the IAM account in this case is `terraform-service-account@your_project_name.iam.gserviceaccount.com`**
10. You will now need to create a billing account and also connect to your project. This needs to be done using the Google Console. This can be done on this page
[here](https://console.cloud.google.com/home/dashboard) 
11. You enable the API neccasry for the project by typing in this command:
``` gcloud services enable container.googleapis.com cloudbuild.googleapis.com sourcerepo.googleapis.com containeranalysis.googleapis.com compute.googleapis.com cloudresourcemanager.googleapis.com```. This step might take over 3-5minutes to run.
12. Congradulations! You’ve made a huge step.


# Create a Github Repository

1. Use your own github account to create a new Repo and name it whatever you want.
2. change you directory into GKE-CI-CD-TUTORIAl
3. Add a new Remote because you will need to push to a new production environment use command:

```
git remote add prod <your repo>

```


