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

6. ```cd /vagrant/rest_demo```

7. ```python manage.py migrate```

8. ```python manage.py createsuperuser```

9. ```sudo python manage.py runserver 0.0.0.0:80```

On host machine visit http://localhost:8000/snippets/ in your browser.

## Creating the staging/production environment and deploying

Thanks to http://www.django-rest-framework.org/ for the great tutorial which I used to get this example going.
Also, thanks to https://github.com/jackdb/pg-app-dev-vm for the postgres provisioning script.