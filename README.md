# Automaton Tapis integration

This is an integration of the Automaton system for CloudyCluster environment creation and job submission with Tapis workflow management system. After initial setup, users can send messages to an [Abaco Actor](https://tapis.readthedocs.io/en/latest/technical/actors.html#executing-an-actor) to create a cluster on GCP, submit jobs to the cluster, and take down the cluster. 


## Initial Setup

User will have to create a project on google cloud with a google account and create a service account using the instructions found [here](http://docs.gcp.cloudycluster.com/gcp-quickstart-deployment-guide/gcp-prep/) up until **"The one-time prep work is now completed, and you can proceed to launch CloudyCluster"**.

On the device to run automaton, download Google Cloud SDK and log in to the google account that created the project. Clone this repository and create a folder called "secrets". This will contain private keys that you do not want shared to the public. In the secrets folder, create a ssh public private key pair called newkey and newkey.pub. Also, include the .json key for the service account. Change lines 3 and 4 of scripts/create_cluster.sh to reflect the names of your service account and the name of the .json private key file.

## Creating the Abaco Actor

**First need TACC credentials**

Build and Push the docker image with 

docker build -t <USER>/<IMAGE_NAME> . 
docker push  <USER>/<IMAGE_NAME>
  
Then follow the instructions in the jupyter notebook to create an Abaco actor from the docker image and send messages to CREATE a cluster, REMOVE a cluster, and SUBMIT jobs.
 
# TO DO

Add jupyter notebook with actor definition and example job script


