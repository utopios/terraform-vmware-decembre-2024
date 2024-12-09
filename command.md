### Commande d'initialisation
```bash
## Dans le dossier (projet) terraform
terraform init
```

## Commande avec fichier de valeurs des variables
```bash
tarraform plan -var-file="file_vars_value_tfvars"
```

## Ordre de priorité des valeurs variables 

1. Ligne de Commande (-var et -var-file): Les variables définies directement sur la ligne de commande avec -var ou -var-file ont la priorité la plus élevée.
2. Variables d'Environnement (TF_VAR_): Si les variables ne sont pas fournies sur la ligne de commande, Terraform cherche les variables d'environnement.
3. Fichier de Variables Terraform: Ensuite, Terraform cherche les variables dans les fichiers .tfvars ou .tfvars.json.
4. Valeurs par Défaut: Enfin, si aucune valeur n'est fournie par les méthodes ci-dessus, Terraform utilise la valeur par défaut définie dans les fichiers de configuration.
5. mode intéractif.