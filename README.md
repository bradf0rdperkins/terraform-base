# acedirect-tf

## Usage
* Install and configure Environment
  * Install AWS cli and configure
  * Install Terraform
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
