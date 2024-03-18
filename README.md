# Azure Terraform Project

This repository contains the Terraform configuration files for creating resources in Azure.

## Project Structure

- `main.tf`: This is the main Terraform configuration file. It defines the Azure provider, the resource group, the service principal, and the role assignment.
- `variables.tf`: This file defines the variables used in `main.tf`.
- `modules/service_principal`: This module creates a service principal in Azure.
  - `main.tf`: This file defines the resources for creating a service principal.
  - `output.tf`: This file defines the outputs of the service principal module.
  - `variables.tf`: This file defines the variables used in the service principal module.

## How to Use

0. Create `terraoform.tfvars` file to set the values. Example:

```
rgname                 = "test-rg"
location               = "canadacentral"
service_principal_name = "test-sp"
```

1. Install Terraform.
2. Clone this repository.
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform plan` to create an execution plan.
5. Run `terraform apply` to apply the desired changes.

## Contributing

Contributions are welcome. Please open a pull request with your changes.

## License

This project is licensed under the MIT License.
