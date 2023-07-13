# createNDCluster

This is intended to deploy automatically a Cisco Nexus Dashboard cluster.
The script is made of two components:

- Terraform - will provision 3 node VMs for Nexus Dashboard cluster. This assumes that you have access to a VCenter where VMs can be deployed.

- Postman collection - will setup the ND cluster, download and enable NDI app on top.


Before executing the terraform script, update the vm_variables.auto.tfvars and provider.auto.tfvars files with all the relevant information needed.

Once the ND cluster is up, you can import the postman variables and postman collection.
Please update all the postman variables according to your ND setup and execute the postman collection.
