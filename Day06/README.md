# Create S3 bucket manually using AWS CLI
We need to check the AWS CLI version using the following command.
```
aws --version
```

We can start using the AWS CLI. Use ‘aws’ command to get started. For example, using S3 commands, we can use ‘aws s3 help’
```
aws
aws s3 help
aws s3 ls
```

We can use s3api to create a bucket using AWS CLI

```
aws s3api help
DESCRIPTION
AVAILABLE COMMANDS
o abort-multipart-upload
o complete-multipart-upload
o copy-object
o create-bucket
o delete-bucket-lifecycle
o delete-bucket-metrics-configuration
o delete-bucket-policy
o delete-bucket-replication
o get-bucket-location
#...

```

Run the following command to create a sample bucket on us-west-2 region.
```
aws s3api create-bucket --bucket pslterraformbucket --region us-west-2
```


#