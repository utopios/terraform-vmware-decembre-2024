## 📂 **Structure des fichiers**

```
project/
├── main.tf             # Fichier principal Terraform (définit les ressources)
├── variables.tf        # Variables partagées entre les environnements
├── terraform.tfvars    # Fichier de configuration par défaut
├── environments/
│    ├── dev.tfvars     # Variables spécifiques à l'environnement DEV
│    ├── test.tfvars    # Variables spécifiques à l'environnement TEST
│    └── prod.tfvars    # Variables spécifiques à l'environnement PROD
├── backend.tf          # Configuration du backend distant
└── modules/
     └── vm/
         └── main.tf    # Module pour la création des VMs
```

---

## 🛠️ **Étape 1 : Configurer les Credentials VMware**

Pour **se connecter à VMware** (vSphere ou ESXi), nous avons besoin de fournir les **informations d'authentification**. Cela se fait via le fichier **main.tf** ou en utilisant des **variables d'environnement**.

**Option 1** : Définir les credentials directement dans **variables.tf** (⚠️ **Pas recommandé**).  
**Option 2** : Utiliser des **variables d'environnement** (recommandé).

### 🔐 **Variables d'environnement**
Définissez les variables d'environnement suivantes sur votre machine :
```bash
export TF_VAR_vsphere_user="root"
export TF_VAR_vsphere_password="password123"
export TF_VAR_vsphere_server="192.168.1.10"
```

---

## 🛠️ **Étape 2 : Configurer le Backend**

Il est important de **stocker l'état de Terraform** de manière centralisée. Cela permet de partager l'état entre plusieurs équipes et de travailler sur plusieurs environnements. Le backend peut être stocké dans **S3**, **Azure Blob Storage**, ou même sur un serveur de fichiers distant compatible **VMware vSphere**.

### 📘 **Fichier backend.tf**
```hcl
terraform {
  backend "local" {
    path = "./terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
  }
}
```

> 🔥 **Explications** :
- Le fichier d'état **terraform.tfstate** est stocké dans **un répertoire différent pour chaque workspace** (`terraform.tfstate.d/dev/`, `terraform.tfstate.d/test/`, etc.).  
- Chaque **workspace a son propre fichier d'état**, ce qui permet de ne pas mélanger les environnements.  

---

## 🛠️ **Étape 3 : Définir les Variables**

Nous définissons les **variables communes** dans le fichier **variables.tf** et les **variables spécifiques par environnement** dans des fichiers **dev.tfvars, test.tfvars et prod.tfvars**.

### 📘 **Fichier variables.tf**
```hcl
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

variable "datacenter_name" {
  description = "Nom du datacenter"
  default     = "Datacenter"
}

variable "network_name" {
  description = "Nom du réseau pour les VMs"
  default     = "VM Network"
}

variable "vm_name" {
  description = "Nom de la machine virtuelle"
  default     = "test-vm"
}

variable "vm_count" {
  description = "Nombre de VMs à créer"
  default     = 1
}

variable "vm_cpus" {
  description = "Nombre de CPU par VM"
  default     = 2
}

variable "vm_memory" {
  description = "Taille de la mémoire par VM (Mo)"
  default     = 2048
}

variable "vm_disk_size" {
  description = "Taille du disque par VM (Go)"
  default     = 20
}
```

---

### 📘 **Fichier environments/dev.tfvars**
```hcl
vm_name = "dev-vm"
vm_count = 2
vm_cpus = 2
vm_memory = 2048
vm_disk_size = 20
```

---

### 📘 **Fichier environments/test.tfvars**
```hcl
vm_name = "test-vm"
vm_count = 1
vm_cpus = 4
vm_memory = 4096
vm_disk_size = 40
```

---

### 📘 **Fichier environments/prod.tfvars**
```hcl
vm_name = "prod-vm"
vm_count = 2
vm_cpus = 8
vm_memory = 8192
vm_disk_size = 80
```

---

## 🛠️ **Étape 4 : Définir les Ressources VMware**

Nous allons utiliser le module **modules/vm/main.tf** pour **provisionner des VMs** sur VMware.

---

### 📘 **Fichier main.tf**
```hcl
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

module "vm" {
  source          = "./modules/vm"
  datacenter_name = var.datacenter_name
  network_name    = var.network_name
  vm_name         = var.vm_name
  vm_count        = var.vm_count
  vm_cpus         = var.vm_cpus
  vm_memory       = var.vm_memory
  vm_disk_size    = var.vm_disk_size
}
```

---

### 📘 **Fichier modules/vm/main.tf**
```hcl
variable "datacenter_name" {}
variable "network_name" {}
variable "vm_name" {}
variable "vm_count" {}
variable "vm_cpus" {}
variable "vm_memory" {}
variable "vm_disk_size" {}

resource "vsphere_virtual_machine" "vm" {
  count            = var.vm_count
  name             = "${var.vm_name}-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpus
  memory   = var.vm_memory
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk_size
    thin_provisioned = true
  }
}
```

---

## 🛠️ **Étape 5 : Utiliser les Workspaces Terraform**

Les **workspaces** permettent de créer plusieurs environnements isolés (**dev, test, prod**).

### 📘 **Commandes Terraform**
1. **Créer un workspace pour DEV** :
   ```bash
   terraform workspace new dev
   ```

2. **Changer de workspace pour TEST** :
   ```bash
   terraform workspace new test
   ```

3. **Changer de workspace pour PROD** :
   ```bash
   terraform workspace new prod
   ```

4. **Afficher la liste des workspaces** :
   ```bash
   terraform workspace list
   ```

5. **Appliquer la configuration** pour le workspace en cours :
   ```bash
   terraform apply -var-file=environments/dev.tfvars
   ```

6. **Changer de workspace et déployer l'environnement** :
   ```bash
   terraform workspace select test
   terraform apply -var-file=environments/test.tfvars
   ```
