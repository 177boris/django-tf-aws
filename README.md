# Django-TF-AWS: Deploying Django application to AWS ECS using Terraform


A basic Django web application hosted on AWS. Underlying IaC in Terraform 

Sets up the following AWS infrastructure:

- Networking:
    - VPC
    - Public and private subnets
    - Routing tables
    - Internet Gateway
    - Key Pairs
- Security Groups
- Load Balancers, Listeners, and Target Groups
- IAM Roles and Policies
- ECS:
    - Task Definition (with multiple containers)
    - Cluster
    - Service
- Launch Config and Auto Scaling Group
- RDS
- Health Checks and Logs


## Instructions

1. Install Terraform

2. Sign up for an AWS account

3. Create two ECR repositories, `django-app` and `nginx`.

4. Fork/Clone

5. Build the Django and Nginx Docker images and push them up to ECR:

    ```sh
    $ cd app
    $ docker build -t <AWS_ACCOUNT_ID>.dkr.ecr.us-west-1.amazonaws.com/django-app:latest .
    $ docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-west-1.amazonaws.com/django-app:latest
    $ cd ..

    $ cd nginx
    $ docker build -t <AWS_ACCOUNT_ID>.dkr.ecr.us-west-1.amazonaws.com/nginx:latest .
    $ docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-west-1.amazonaws.com/nginx:latest
    $ cd ..
    ```

6. Update the variables in *terraform/variables.tf*.

7. Set the following environment variables, init Terraform, create the infrastructure:

    ```sh
    $ cd terraform
    $ export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
    $ export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"

    $ terraform init
    $ terraform apply
    $ cd ..
    ```

8. Terraform will output an ALB domain. Create a CNAME record for this domain
   for the value in the `allowed_hosts` variable.

9. Open the EC2 instances overview page in AWS. Use `ssh ec2-user@<ip>` to
   connect to the instances until you find one for which `docker ps` contains
   the Django container. Run
   `docker exec -it <container ID> python manage.py migrate`.

10. Now you can open `https://your.domain.com/admin`. Note that `http://` won't work.

11. You can also run the following script to bump the Task Definition and update the Service:

    ```sh
    $ cd deploy
    $ python update-ecs.py --cluster=production-cluster --service=production-service
    ```