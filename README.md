# Bootcamp Terraform



 ** https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials/
 ** https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials/aws-remote

The terraform {} block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure. For each provider, the source attribute defines an optional hostname, a namespace, and the provider type. 


The provider block configures the specified provider, in this case aws. A provider is a plugin that Terraform uses to create and manage your resources.

Resource blocks to define components of your infrastructure. A resource might be a physical or virtual component such as an EC2 instance, or it can be a logical resource such as a Heroku application.


The terraform destroy command terminates resources managed by your Terraform project. This command is the inverse of terraform apply in that it terminates all the resources specified in your Terraform state. It does not destroy resources running elsewhere that are not managed by the current Terraform project.

- Day 00 (Prerequisites)
    - Installed Visual Studio Code
    - Installed AWS CLI (for AWS Practice)
    - Open Free AWS Account and Create Access Id
    - Read AWS Terraform Help

- Day 01
    - Read about Introduction to Infrastructure as Code with Terraform
    - Installed Terraform
    - Read about Lock and Upgrade Provider Versions
    - Build Infrastructure as per given terraform config files
    - Destroy Infrastructure created in aws 
    - Store Remote State

- Day 02 
    - Created a simple EC2 intance /VM manually & learned about its configurations. 
    - Created a similar EC2 instance/VM with different name using Terraform
    - Compare the configuration. 
    - Destroyed both Manually created instance and instance created through Terraform. 
    
Terraform Cloud allows teams to easily version, audit, and collaborate on infrastructure changes. It also securely stores variables, including API tokens and access keys, and provides a safe, stable environment for long-running Terraform processes.
https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials/aws-remote

syntax : 

terraform {
  cloud {
    organization = "organization-name"  // org name is compulsory
    workspaces {
      name = "learn-tfc-aws"            // it will get created after terraform init
    }
  }

  OR


  terraform {
  backend  "remote" {
    organization = "organization-name"  // org name is compulsory
    workspaces {
      name = "learn-tfc-aws"            // it will get created after terraform init
    }
  }


- migrate state to terraform cloud 

    - https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials/cloud-migrate?in=terraform%2Fcertification-associate-tutorials




    - Terraform calls these types of variables simple. Terraform also supports collection variable types that contain more than one value. Terraform supports several collection variable types.

    - List: A sequence of values of the same type.
    - Map: A lookup table, matching keys to values, all of the same type.
    - Set: An unordered collection of unique values, all of the same type.


    - The lists and maps you used are collection types. Terraform also supports two structural types. Structural types have a fixed number of values that can be of different types.

    - Tuple: A fixed-length sequence of values of specified types.
    - Object: A lookup table, matching a fixed set of keys to values of specified types.

    -   The Terraform console command opens an interactive console that you can use to evaluate    expressions in the context of your configuration. This can be very useful when working with and troubleshooting variable definitions.

    Note: The terraform console command loads your Terraform configuration only when it starts. Be sure to exit and restart the console to pick up your most recent changes.


    - Validate variables
        This configuration has a potential problem. AWS load balancers have naming restrictions. Load balancer names must be no more than 32 characters long, and can only contain a limited set of characters.
        Now, use variable validation to restrict the possible values for the project and environment tags.
        The regexall() function takes a regular expression and a string to test it against, and returns a list of matches found in the string. In this case, the regular expression will match a string that contains anything other than a letter, number, or hyphen.

        This ensures that the length of the load balancer name does not exceed 32 characters, or contain invalid characters. Using variable validation can be a good way to catch configuration errors early.
                        <!-- variable "resource_tags" {
                    description = "Tags to set for all resources"
                    type        = map(string)
                    default     = {
                        project     = "my-project",
                        environment = "dev"
                    }

                    validation {
                        condition     = length(var.resource_tags["project"]) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["project"])) == 0
                        error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."
                    }

                    validation {
                        condition     = length(var.resource_tags["environment"]) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["environment"])) == 0
                        error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
                    }
                    } -->

    - Output Data from Terraform
        Terraform output values let you export structured data about your resources. You can use this data to configure other parts of your infrastructure with automation tools, or as a data source for another Terraform workspace. Outputs are also how you expose data from a child module to a root module.

    -- terraform output lb_url
    "http://lb-5YI-project-alpha-dev-2144336064.us-east-1.elb.amazonaws.com/"

    //Starting with version 0.14, Terraform wraps string outputs in quotes by default. You can use the -raw flag when querying a specified output for machine-readable format.

    -- terraform output -raw lb_url
    http://lb-5YI-project-alpha-dev-2144336064.us-east-1.elb.amazonaws.com/


    //Use the lb_url output value with the -raw flag to cURL the load balancer and verify the response.
    curl $(terraform output -raw lb_url)
    <html><body><div>Hello, world!</div></body></html>



    - Redact sensitive outputs
        - You can designate Terraform outputs as sensitive. Terraform will redact the values of sensitive outputs to avoid accidentally printing them out to the console. Use sensitive outputs to share sensitive data from your configuration with other Terraform modules, automation tools, or Terraform Cloud workspaces.

        - Terraform will redact sensitive outputs when planning, applying, or destroying your configuration, or when you query all of your outputs. Terraform will not redact sensitive outputs in other cases, such as when you query a specific output by name, query all of your outputs in JSON format, or when you use outputs from a child module in your root module.

        syntax : Add the following output blocks to your outputs.tf file. Note that the sensitive attribute is set to true.
                <!-- output "db_username" {
                description = "Database administrator username"
                value       = aws_db_instance.database.username
                sensitive   = true
                }

                output "db_password" {
                description = "Database administrator password"
                value       = aws_db_instance.database.password
                sensitive   = true
                } -->

                - After apply you can notice that Terraform redacts the values of the outputs marked as sensitive.

                - Use terraform output to query the database password by name, and notice that Terraform will not redact the value when you specify the output by name.

                for e.g.
                    - terraform output db_password
                        "notasecurepassword"


    - Query Data Sources
        - Terraform data sources let you dynamically fetch data from APIs or other Terraform state backends. Examples of data sources include machine image IDs from a cloud provider or Terraform outputs from other configurations. Data sources make your configuration more flexible and dynamic and let you reference values from other configurations, helping you scope your configuration while still referencing any dependent resource attributes. In Terraform Cloud, workspaces let you share data between workspaces.


    - Manage explicit dependencies
        - Implicit dependencies are the primary way that Terraform understands the relationships between your resources. Sometimes there are dependencies between resources that are not visible to Terraform, however. The depends_on argument is accepted by any resource or module block and accepts a list of resources to create explicit dependencies for.