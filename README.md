# Web application deployment demo

Demo Django application including automated development environment with Vagrant and
infrastrucutre as code using aws and terraform. Deployment automation handled with fabric.

## Creating the local development environment

These steps will create an exact multi-machine local clone
of what we will later run in production.  If your code is working
here it is almost certainly going to work in our production environments
we will create in the next step.

1. Install vagrant and virtualbox.

2. clone this repository.

3. ```cd <path>/vagrant-django-rest-demo```

4. ```vagrant up```

5. ```vagrant ssh web```

6. ```cd /var/www```

7. ```sudo pip install -r requirements.txt```

8. ```python manage.py migrate```

9. ```python manage.py createsuperuser```

10. ```sudo python manage.py runserver 0.0.0.0:80```

On host machine visit http://localhost:8000/snippets/ in your browser.

## Creating the staging/production environment and deploying

These steps will create a production environment in EC2 using Terraform.
fabric will be used to automate deployment.

* Install Terraform (https://www.terraform.io/intro/getting-started/install.html)

* Create the terraform.tfvars file in this directory
```
user_name = "<yourname>"
environment = "<what you want to call this environment>"
access_key = "####################"
secret_key = "########################################"
ssh_key_path = "<path 2 your key for connecting to ec2 instances>"
ssh_key_name = "<name of the key>"
vpc_id = "vpc-########"
```

* install fabric ```pip install fabric```

* run ```terraform plan``` to see a list of infrastructure to bring up and make sure your .tfvars file is OK.

* run ```terraform apply``` to provision infrastructure

* After provisioning your infrastructure deploy your code
```fab deploy```

* To see if the website is working
```fab show_me```



Thanks to http://www.django-rest-framework.org/ for the great tutorial which I used to get this example going.
Also, thanks to https://github.com/jackdb/pg-app-dev-vm for the postgres provisioning script.
