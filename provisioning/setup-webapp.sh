
echo "Provisioning web application."
sudo apt-get -y update
sudo apt-get -y install python-pip
sudo apt-get -y install libpq-dev
sudo apt-get -y install python-dev
sudo apt-get -y install emacs

#cd /vagrant/rest_demo
#python manage.py makemigrations snippets
#python manage.py migrate
#python manage.py runserver 0.0.0.0:80
