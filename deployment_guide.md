## Deployment guide

### Overview

These deployment instructions apply for most of our python and nodejs projects (If we are not using heroku). We currently have
the following deployment flow:

1. push project to github 
2. circleci triggered via .circleci config file
3. circleci automatically runs tests 
4. circleci automatically SSH into DO droplet and runs bash deployment script
6. bash script automatically pulls repo onto droplet
7. bash script automatically kills previous container, creates new tmux container and runs the specified file

Deployment workflow is adapted from this article: https://circleci.com/blog/build-cicd-piplines-using-docker/. 

Note that we should be dockerizing our python projects but are unable to currently do so due to @mrnewguy's computer that cannot
run Docker's windows containers. 

### Setting up of deployment workflow

As the 7 step workflow suggests, we need to set up the following items: 
- Github (no brainer)
- DigitalOcean droplet + bash script
- Circleci + config.yml file

See the sample_deployment_files folder for examples of those files. 


Detailed instructions for each of the items are as follows:

#### DigitalOcean droplet
##### If creating a DO droplet from scratch: 

1. Create new ubuntu 20.04 (LTS) x64 droplet. ($5/month plan will suffice.) 

2. Set SSH key (do not set password as circleci does not work with password).

3. Update the server and install pip: 

```
sudo apt update
sudo apt install python3-pip
```
Then, create a snapshot of the server for future use.

##### If base image already exists: 

Note that as of this current commit, we have a base image stored in DO.

1. Create a server from the base image.

2. SSH into the server and pull the repo.

3. The pulled repo should contain a deployment bash script. Run the following command to copy and paste the deployment script 
to the root folder ``cp <SCRIPT_NAME> ..``

#### Circleci
1. See the environment variables that are inside the config.yml file in the .circleci folder. Examples include the $PARENT_SCRAPER_1_SERVER_ADDRESS variable. 
 You will have to go to the circleci project settings to set those environment variables. 
 
2. The final command in the config.yml file is essentially asking circleci to ssh into the DO server and call the deploy_app.sh
script. To ssh in, you will first need to set the SSH keys in the circleci project settings.

