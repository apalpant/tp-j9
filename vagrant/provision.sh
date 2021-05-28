#!/bin/sh

apt update

apt install -y ansible

# On installe le pare-feu
apt install -y ufw

# On le met en route
ufw --force enable 

# On lui fixe de nouvelles regles
ufw allow ssh
ufw allow http
ufw allow https
ufw allow 8080
ufw allow 5000

# On prepare l'installation de jenkins
apt install -y gnupg
apt install -y openjdk-11-jre

# On installe jenkins suivant les preconisations du site
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -

sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
	
# On met a jour la base de donnees des paquets
apt update
	
# On installe le paquet jenkins
apt install -y jenkins

# On demarre le service
service jenkins start

# On ajoute le nouvel utilisateur userjob
useradd -m userjob

# On lui donne un mot de passe
echo "userjob:userjob" | chpasswd

# On sauvegarde le fichier avant modification
cp /etc/sudoers /etc/sudoers.old

# On mets les droits sur la commande apt pour l'utilisateur userjob
echo "userjob ALL=(ALL) /usr/bin/apt" | tee -a /etc/sudoers

# On sauvegarde le fichier sshd_config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bck

# On change l'option PasswordAuthentication de no à yes dans le fichier sshd_config
sed "s/PasswordAuthentication no/PasswordAuthentication yes/" \
/etc/ssh/sshd_config.bck > /etc/ssh/sshd_config

# On restart le service
systemctl restart sshd

apt install git

# install python
apt install python3 python3-dev python3-pip python3-venv -q -y
apt remove -y python 

cp /usr/bin/python3 /usr/bin/python

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
	
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io


### Docker compose ###

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

usermod -aG docker $USER

# On ajoute jenkins aux utilisateurs authorises
usermod -aG docker jenkins


