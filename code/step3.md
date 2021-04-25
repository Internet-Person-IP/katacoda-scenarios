# Building Kubernetes Cluster Terraform

So now you realize that you have a base for starting to build your application. You realize that you now need to create the Terraform template for the GKE cluster. 

After googling for hours you realize that you have found a tutorial that does something really similar to what you are trying to do. 

So you decided to copy it into your project. There are some main concepts that you are familiar with, which are a provider(describing which resource provider often cloud provider), variable(is used as env variables), modules(which are packages that makes development easier), resources (which are resources that you cloud provider offers) 

**You start by:**

> `mkdir terraform && cd terraform`{{copy}}

**You first create a file called variables.tf in the terraform directory which includes something like this:**
<pre class="file" data-target="clipboard">
variable "gcp_credentials"{
    default = "~/.config/gcloud/exec-tut-cicd-kubernetes-react-c4c2dc25b7b6.json"
}

variable "gcp_project_id"{
    default = "exec-tut-cicd-kubernetes-react"
}

variable "gcp_region" {
    default = "europe-west2"
}

variable "gcp_gke_cluster_name" {
    default = "gke-react-with-cicd"
}

variable "gcp_gke_zones"{
    default = ["europe-west2-a","europe-west2-b", "europe-west2-c"]
}

variable "node_pool_name" {
    default = "here-rests-my-little-pods"
  
}

variable "gcp_service_account" {
    default = "gcp-464@exec-tut-cicd-kubernetes-react.iam.gserviceaccount.com"
  
}
</pre>

The first file to look at is the variable.tf file in here you there are a lot of variables stored that seem to be relevant to your project. **There are however three things you need to change which is:** 

- gcp_credentials
- gcp_project_id
- gcp_service_account


**Change them to match your project, credentials, and service accounts.**

Next, you decided to look at a provider which just describes which cloud provider you will be leveraging and setting some variables related to your project. Nothing really needs to be changed since you set the variables in the variable.tf.

**Create a provider.tf file in the terraform directory with which includes this**
<pre class="file" data-target="clipboard">
data "google_client_config" "default" {}

provider "google" {
    credentials = file(var.gcp_credentials)
    project = var.gcp_project_id
    region = var.gcp_region
}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}
</pre>


**Now you need to create a main.tf file in the terraform directory which includes this**


<pre class="file" data-target="clipboard">
module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.gcp_project_id
  name                       = var.gcp_gke_cluster_name
  region                     = var.gcp_region
  regional                   = true
  ip_range_pods              = ""
  ip_range_services          = ""
  zones                      = var.gcp_gke_zones
  network                    = "default"
  subnetwork                 = "default"
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = false

  node_pools = [
    {
      name               = var.node_pool_name
      machine_type       = "e2-medium"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = var.gcp_service_account
      preemptible        = true
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
</pre>

The main topic that you focused on was the module which was GKE and you realize that there is a huge level of customizability for you that you can leverage later whenever you want to deploy the application again. For example such as load balancing, autoscaling, specific machine type, etc. You decided that what existed seemed appropriate you decided not to change anything.

Next, you started thinking about actually building the infrastructure. There seem to be 4 different commands that are most essential to terraform.

> `terraform init`{{copy}} (initialize template by download all necessary modules and resource, if new ones are added) <br/>
> `terraform plan`{{copy}} (plan test if the infrastructure is possible to create and if there are some errors in the declarative files)<br/>
> `terraform apply`{{copy}} (creates the actual infrastructure in the cloud and might take a long time to do)<br/>
> `terraform destroy`{{copy}} (destroys the entire infrastructure when it is no longer needed)<br/>


You decided to do:

> `terraform init`{{copy}} <br/>
> `terraform plan`{{copy}} <br/>
> `terraform apply`{{copy}} <br/>

One thing you stumbled upon that you forgot was that when you apply a terraform apply with additional resources only the additional resources gets added you do need to completely create your infrastructure again.

Now you started to look into your google cloud console and if you search for Kubernetes and start to look for a cluster you realize that a cluster is up and running!

Great now that the cluster is running it is important that you start looking into Kubernetes and the entire process of CI/CD