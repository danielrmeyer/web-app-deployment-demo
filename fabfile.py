from fabric.api import env, put, run, local, cd, settings
from StringIO import StringIO
import re


code_dir = "/var/www/rest_demo"

def get_host():
    host_patt = r'webapp = ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)'
    output = local("terraform show", capture=True)
    host = re.search(host_patt, output).group(1)
    env.host_string = host


def get_ssh_key():
    with open('terraform.tfvars', 'r') as f:
        for line in f.read().split('\n'):
            try:
                l,r = line.split('=')
            except:
                continue
            else:
                if 'ssh_key_path' in l:
                    env.key_filename = r.strip().replace('"','')


def grok_env(func):
    def grok_env_and_call(*args, **kwargs):
        get_host()
        get_ssh_key()
        env.user = 'ubuntu'
        return func(*args, **kwargs)
    return grok_env_and_call

@grok_env
def copy_code():
    put('rest_demo', '/var/www')

@grok_env
def clear_code_dir():
    run("sudo rm -r /var/www/*")

@grok_env
def install_requirements():
    with cd(code_dir):
        run("sudo pip install -r requirements.txt")

@grok_env
def run_db_migration():
    with cd(code_dir):
        run("python manage.py migrate")

@grok_env
def make_db_migrations():
    with cd(code_dir):
        run("python manage.py makemigrations")

@grok_env
def start_server():
    with cd(code_dir):
        run("screen -d -m sudo python manage.py runserver 0.0.0.0:80; sleep 1")

@grok_env
def kill_server():
    with settings(warn_only=True):
        run("sudo pkill python")

    
def deploy():
    kill_server()
    clear_code_dir()
    copy_code()
    install_requirements()
    make_db_migrations()
    run_db_migration()
    start_server()

@grok_env
def show_me():
    import webbrowser
    url = "http://"+env.host_string+"/snippets"
    webbrowser.open_new(url)
