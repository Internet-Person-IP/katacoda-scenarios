# Init
You start looking around in the project and you realize that it is a react project. That you need to deploy to GKE. You see in src/App.js this is a counter app that seems to be counting up. There should also be counting down feature but it should be added later when the CI/CD pipeline is done.
## GCP

We first need to initialize GCP.

1. Create a GCP account [here](https://cloud.google.com/free)
2. Create a Project [Here](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project). 
You decided to call your kubernetes-cicd-react
3. In the Terminal do gcloud init. When the terminal gives a link paste in the browser and login with your account. Pick the project that you created. This will create an environment and connect your local environment to the correct project.
4. Using your own Github account create a new Repo name it whatever you want.
5. Add a new Remote because you will need to push to a new production environment use command

```
git remote add prod <your repo>

```

6. In the GCP Console you need to search for IAM. Here you will need to create a new IAM user. Go to the GCP IAM console to fix IAM policy. You are going to add a new Service Account Key. Select JSON as Key. Click Create and save the JSON file. Drag and Drop it into the VSCode section of this interactive tutorial.

7. You enable the API neccasry for the project by typing in this command:

