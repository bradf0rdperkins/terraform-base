# acedirect-tf

## Usage
* Install and configure Environment
  * Install AWS cli and configure
  * Install Terraform
  * Install Packer
  ```
  cd ~
  mkdir packer_new
  cd packer_new/
  sudo yum update -y
  sudo wget https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip
  sudo unzip packer_1.5.1_linux_amd64.zip
  sudo ln -s ~/packer_new/packer /usr/bin/packer.io
  # Add it to your path
  export PATH=$HOME/packer_new:$PATH
  source ~/.bash_profile
  # Test that it installed correctly
  packer.io
  ```
  * Create local terraform environment
  * Install git and clone repository
* Generate an SSH key  
`ssh-keygen -f mykey`
* Create a .gitignore file and add the SSH keys to it  
```
touch .gitignore
vim .gitignore
# Add the filenames to ignore on each line
```
* Run terraform
```
terraform init
terrafrom plan
# Validate configuration that will be applied
terrafrom apply
# Add modifiable variables with the -var switch
# Unassigned variables that prompt at runtime should be avoided
# Ideal to use Vault or similar product that stores secure and secret variables
```
* Install Packer 
