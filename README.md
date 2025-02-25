🔐 Setup GitHub SSH & Git Config

Ce script automatise la configuration de Git avec SSH en générant une clé SSH, l'ajoutant à GitHub et configurant Git avec votre nom et email.

🚀 Fonctionnalités

Génère une clé SSH (si inexistante)

Ajoute automatiquement la clé publique sur GitHub

Configure Git avec votre nom et email

Vérifie la connexion SSH avec GitHub

📌 Prérequis

Un compte GitHub

Un token GitHub avec la permission admin:public_key

Outils installés : curl, ssh-keygen, git

🛠 Installation et Utilisation

1️⃣ Générer un token GitHub

Accédez à GitHub Tokens

Cliquez sur "Generate new token (classic)"

Cochez uniquement admin:public_key

Copiez le token généré

2️⃣ Exécuter le script

chmod +x setup_git_agent.sh
./setup_git_agent.sh

3️⃣ Fournir les informations demandées

Votre nom Git

Votre email Git

Votre token GitHub

4️⃣ Vérification

Après l'exécution, testez la connexion avec :

ssh -T git@github.com

Si tout fonctionne, vous verrez un message confirmant votre authentification. 🎉

🔄 Désinstallation

Si besoin, supprimez la clé SSH et sa configuration :

rm -f ~/.ssh/github_ssh_key*  # Supprime les clés SSH
ssh-add -D  # Retire les clés de l'agent SSH
git config --global --unset user.name
git config --global --unset user.email

📖 Licence

Ce script est sous licence MIT. Libre à vous de le modifier et l'utiliser ! 🚀

