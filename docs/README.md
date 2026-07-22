# DevOps Engineer Technical Test (Google Cloud Platform)

## Project Overview

Repository ini dibuat sebagai jawaban untuk technical test DevOps Engineer dengan fokus pada Google Cloud Platform (GCP).

Project ini terdiri dari empat bagian utama:

- Infrastructure as Code (Terraform)
- CI/CD Pipeline menggunakan GitHub Actions
- Simple containerized application (Node.js + Express)
- Monitoring & Alerting

Seluruh konfigurasi dipisahkan berdasarkan fungsinya agar lebih mudah dimaintaince.

---

# Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml
├── app/
│   ├── Dockerfile
│   ├── package.json
│   ├── package-lock.json
│   └── server.js
├── cicd/
│   └── pipeline-config
├── docs/
│   └── README.md
└── iac/
    ├── terraform
    │   └──modules
    │       ├──artifact_registry
    │       │       ├──main.tf
    │       │       ├──outputs.tf
    │       │       └──variables.tf
    │       ├── cloudrun
    │       │       ├──main.tf
    │       │       ├──outputs.tf
    │       │       └──variables.tf
    │       ├── cloudsql
    │       │       ├──main.tf
    │       │       ├──outputs.tf
    │       │       └──variables.tf
    │       ├── iam
    │       │       ├──main.tf
    │       │       ├──outputs.tf
    │       │       └──variables.tf
    │       ├── monitoring
    │       │       ├──main.tf
    │       │       ├──outputs.tf
    │       │       └──variables.tf
    │       └── network
    │               ├──main.tf
    │               ├──outputs.tf
    │               └──variables.tf  
    ├── main.tf
    ├── provider.tf
    ├── versions.tf
    ├── variables.tf
    ├── terafform.tfvars
    ├── terraform.tfstate    
    ├── outputs.tf
    └── screenshots/

```

---

# Project Components

## 1. Infrastructure as Code

Seluruh resource cloud dibuat menggunakan Terraform sehingga proses provisioning dapat dilakukan secara konsisten tanpa membuat resource secara manual melalui Google Cloud Console.

Konfigurasi Terraform dipisahkan menjadi beberapa file agar setiap file mudah untuk dibaca dan dimaintaince.

- `provider.tf` berisi konfigurasi provider Google Cloud.
- `versions.tf` digunakan untuk menentukan versi Terraform dan provider.
- `variables.tf` berisi seluruh variabel yang digunakan.
- `outputs.tf` menampilkan output penting setelah proses provisioning.
- `main.tf` menjadi file utama yang memanggil seluruh module.

Selain itu konfigurasi juga dipisahkan menjadi beberapa module pada folder `iac/modules` sehingga setiap resource dapat dikelola secara terpisah dan dapat digunakan kembali apabila suatu saat akan membuat resource yg serupa.

Module yang digunakan antara lain:

- Network
- Cloud SQL
- Cloud Run
- Artifact Registry
- IAM
- Monitoring

---

## 2. Application

Folder `app` berisi aplikasi sederhana berbasis Node.js dan Express yang digunakan sebagai sample application.

Endpoint yang tersedia:

| Endpoint | Keterangan |
|----------|------------|
| /        | Menampilkan informasi aplikasi |
| /healthz | Digunakan untuk health check   |

Aplikasi ini menggunakan Docker agar dapat dijalankan secara konsisten baik di local ataupun di Cloud Run.

---

## 3. CI/CD Pipeline

Workflow CI/CD berada pada:

```text
.github/workflows/deploy.yml
```

Pipeline akan berjalan setiap kali terdapat perubahan pada branch `main`.

Tahapan pipeline:

1. Checkout source code
2. Authenticate ke Google Cloud menggunakan Workload Identity Federation (OIDC)
3. Build Docker Image
4. Push image ke Artifact Registry
5. Deploy image terbaru ke Cloud Run

Dengan alur tersebut proses deployment dapat dilakukan secara otomatis tanpa perlu deploy manual, tetapi saya juga membuat file pipeline-config di folder cicd sesuai dengan submission yg diberikan.

---

## 4. Monitoring

Monitoring digunakan untuk memastikan aplikasi tetap dapat diakses.

Health check dilakukan melalui endpoint:

```text
/healthz
```

Apabila endpoint tersebut gagal dalam periode tertentu maka Alert Policy akan mengirimkan notifikasi sesuai konfigurasi yang dibuat.

Saya juga melampirkan beberapa gambar pada folder `screenshots` pada repository dan mencoba membuat case sendiri

`Uptime Check.png` - Bukti bahwa Uptime Check monitoring pada GCP berhasil diimplementasikan
`CloudRun-Logs.png` - Memastikan log pada cloudrun berfungsi secara realtime
`CloudSql.png` - Memastikan bahwa konfigurasi sql menggunakan PostgreSQL sudah terdeploy pada CloudSQL GCPdan sesuai dengan konfigurasi pada terraform
`GCP - Alert.png` - Saya mencoba membuat satu case untuk mencoba bahwa Alert pada GCP Monitoring Alerting berfungsi
`Alert - Email Notification.png` - Bukti bahwa Alert dari case yang saya coba masuk ke email
`Alert - Email.png` - Isi dari Email Alert Notification

---

# Deployment Flow

```text
Developer - Push ke GitHub (main) - GitHub Actions - Build Docker Image - Artifact Registry - Deploy ke Cloud Run - Cloud Run menjalankan revision terbaru

```

---

# Cara Menjalankan Terraform

Masuk ke folder `iac`

```bash
terraform init
terraform plan
terraform apply
```

---

# Menjalankan Aplikasi Secara Lokal

Masuk ke folder `app`

```bash
npm install
npm start
```

atau menggunakan Docker

```bash
docker build -t hello-app .
docker run -p 8080:8080 hello-app
```

---

# Catatan

Repository yang saya buat ini untuk menjawab technical test yang berfokus pada implementasi IaC, automasi deploymen, dan untuk memonitoring aplikasi di GCP

Seluruh konfigurasi dan dokumentasi saya susun sedemikian rupa agar mudah dipahami serta dapat dijadikan dasar untuk penilaian proses recruitment.
