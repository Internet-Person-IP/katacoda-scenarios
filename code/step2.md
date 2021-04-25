# Init

## GCP

We first need to initiliaze GCP.

1. Create a GCP account [here](https://cloud.google.com/free)
2. Create a Project [Here](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project). 
You decided to call yours kubernetes-cicd-react
3. In the Terminal do gcloud init. When the terminal gives a link paste in the browser and loggin with your account. Pick the project that you created. This will create an enviroment and connect your local environment to the correct project.
4. Using your own github account create a new Repo name it whatever you want.
5. Add a new Remote because you will need to push to a new production environment use command

```
git remote add prod <your repo>

```

6. In the GCP Console you need to search for IAM. In here you will need to create a new IAM user.Go to GCP IAM console to fix IAM policy. You are going to add a new Service Account Key. Select JSON as Key. Click Create and save the JSON file. Drag and Drop it into the VSCode section of this interactive tutorial.
