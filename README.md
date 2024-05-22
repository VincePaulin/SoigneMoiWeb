# SoigneMoi

SoigneMoi est une application web destinée à améliorer l'efficacité de l'accueil des patients et la gestion des plannings des praticiens dans l'hôpital SoigneMoi de la région lilloise.

## Table des matières

- [Aperçu](#aperçu)
- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation](#installation)


## Aperçu

L'application SoigneMoi permet aux utilisateurs de :
- Créer des comptes utilisateur.
- Planifier des séjours hospitaliers.
- Visualiser l'historique de leurs séjours.

Les administrateurs peuvent :
- Gérer les plannings des médecins.
- Créer et gérer les comptes des médecins.

## Fonctionnalités

- **Page d'accueil** : Affiche une description de l'hôpital et la liste des prestations proposées.
- **Création de compte utilisateur** : Les visiteurs peuvent créer un compte avec un nom, prénom, email et adresse postale.
- **Espace utilisateur** : Les utilisateurs peuvent voir l'historique de leurs séjours.
- **Planification des séjours** : Les utilisateurs peuvent planifier des séjours avec des dates, des motifs et des médecins choisis.
- **Gestion des plannings des médecins** : Les administrateurs peuvent créer des médecins et leur associer des plannings.

## Prérequis

Avant de commencer, assurez-vous d'avoir lancer le backend et avoir suivi les instructions:
https://github.com/VincePaulin/SoigneMoiBackend

Vous devez aussi avoir installé Flutter.



## Installation

1. Clonez le dépôt GitHub :

    ```bash
    git clone https://github.com/VincePaulin/SoigneMoiWeb.git
    cd soignemoi
    ```

2. Lancer l'application en mode debug

    flutter run -d chrome --web-browser-flag "--disable-web-security"

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.
