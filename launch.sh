#!/bin/bash

set -e  # Stoppe le script si une commande échoue

# Demande les infos utilisateur
read -p "Entrez votre nom Git : " git_name
read -p "Entrez votre email Git : " git_email
read -s -p "Entrez votre token GitHub (admin:public_key requis) : " github_token
echo ""

# Génération de la clé SSH
ssh_key="$HOME/.ssh/github_ssh_key"
if [ ! -f "$ssh_key" ]; then
    ssh-keygen -t rsa -b 4096 -C "$git_email" -f "$ssh_key" -N ""
    echo "✅ Clé SSH générée : $ssh_key"
else
    echo "⚠️ Une clé SSH existe déjà à cet emplacement : $ssh_key"
fi

# Démarrage de l'agent SSH et ajout de la clé privée
eval "$(ssh-agent -s)"
ssh-add "$ssh_key"

# Récupération de la clé publique
pub_key=$(cat "$ssh_key.pub")

# Ajout de la clé à GitHub
response=$(curl -s -X POST -H "Authorization: token $github_token" \
    -H "Accept: application/vnd.github+json" \
    https://api.github.com/user/keys \
    -d "{\"title\": \"$(hostname) - $(date +'%Y-%m-%d')\", \"key\": \"$pub_key\"}")

if echo "$response" | grep -q '"key":'; then
    echo "✅ Clé publique ajoutée à GitHub avec succès"
else
    echo "❌ Échec de l'ajout de la clé sur GitHub. Vérifie ton token."
    exit 1
fi

# Configuration Git
git config --global user.name "$git_name"
git config --global user.email "$git_email"

# Test de connexion
ssh -T git@github.com

echo "🚀 Setup terminé ! Vous pouvez maintenant utiliser GitHub avec SSH."
