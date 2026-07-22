Theoretical Answers

```text
Theoretical Questions (Screening Level)
```

1.	What are the main differences between Cloud Run, Compute Engine, and GKE in GCP? When would you choose each one?
-	Cloud Run adalah platform serverless yang dikelola sepenuhnya, tempat saya hanya perlu mendeploy kontainer tanpa harus memikirkan infrastruktur dasarnya. 
-	Compute Engine menyediakan mesin virtual dengan kendali penuh atas sistem operasi, jaringan, dan lingkungan runtime, sehingga cocok untuk aplikasi yang memerlukan konfigurasi khusus. 
-	GKE adalah layanan Kubernetes yang dikelola oleh Google yang dirancang untuk aplikasi berbasis kontainer yang memerlukan orkestrasi, skalabilitas, dan strategi deploymen. 

2.	Explain the concept of Infrastructure as Code (IaC) and its main benefits.
Infrastructure as Code adalah pengelolaan infrastruktur menggunakan kode, bukan melalui konfigurasi manual. IaC memungkinkan infrastruktur untuk dikelola versinya, dimaintain, dan diterapkan secara konsisten di berbagai lingkungan. 

3.	How would you configure IAM roles & policies to ensure secure CI/CD deployment in GCP?
Saya akan menerapkan prinsip least privilege dengan hanya memberikan izin yang diperlukan untuk deployment kepada pipeline CI/CD. Alih-alih menggunakan kredensial pribadi, saya akan membuat service account khusus untuk pipeline tersebut dengan peran IAM tertentu—seperti Cloud Run Admin atau Artifact Registry Writer—yang disesuaikan dengan target deployment. Informasi sensitif, seperti kunci service account atau kredensial API, sebaiknya disimpan di Secret Manager atau, lebih baik lagi, diakses melalui Workload Identity Federation untuk menghindari penggunaan kunci yang berlaku dalam jangka waktu lama. Saya juga akan memisahkan izin antara lingkungan pengembangan (development) dan produksi, serta mengaktifkan Cloud Audit Logs untuk memantau aktivitas deployment. Pendekatan ini mengurangi risiko keamanan sekaligus menjaga kemudahan pengelolaan deployment.

4.	If an application in Cloud Run frequently experiences latency spikes during autoscaling, what troubleshooting steps would you take?
Pertama, saya akan memeriksa Cloud Monitoring untuk memastikan apakah peningkatan latensi tersebut berkaitan dengan pembuatan instance baru atau kinerja aplikasi. Jika masalah disebabkan oleh cold start, saya akan mempertimbangkan untuk menambah jumlah minimum instance agar beberapa kontainer tetap dalam kondisi siap pakai (warm). Saya juga akan memeriksa waktu startup aplikasi, alokasi sumber daya seperti CPU dan memori, serta apakah ada dependensi eksternal seperti basis data atau API pihak ketiga yang memperlambat proses request. Memeriksa Cloud Logging untuk melihat apakah ada pesan kesalahan atau timeout juga akan membantu mengidentifikasi masalah di aplikasi.

5.	What is the difference between monitoring and logging, and how would you integrate both in GCP?
-	Monitoring berfokus pada metrik seperti penggunaan CPU, konsumsi memori, latensi permintaan, dan tingkat kesalahan untuk memahami kesehatan serta kinerja sistem. 
-	Logging merekam data kejadian yang membantu menganalisa saat terjadi masalah. Di GCP, saya akan menggunakan Cloud Monitoring untuk membuat dashboard dan alert bagi metrik-metrik utama, sementara Cloud Logging akan mengumpulkan log dari aplikasi dan infrastruktur.


```text
Troubleshooting Scenario (Case Study)
```

1. Dalam jangka pendek, fokus saya adalah menjaga application availability. Saya akan memverifikasi bahwa penyebabnya memang memory leak melalui monitoring dan log OOM Killer, kemudian menerapkan auto-restart menggunakan systemd atau Docker/Kubernetes restart policy. Saya juga akan menambahkan monitoring dan alerting pada penggunaan memori, serta mempertimbangkan penambahan RAM atau swap sebagai solusi sementara. Jika aplikasinya stateless, saya akan menjalankannya pada beberapa instance di belakang Load Balancer agar restart satu instance tidak menyebabkan downtime.

2. Untuk jangka panjang, solusi utamanya adalah memperbaiki memory leak melalui profiling dan code review bersama tim developer. Saya juga akan menambahkan load testing, stress testing, monitoring heap memory, serta memasukkan pengujian performa ke dalam pipeline CI/CD. Jika diperlukan, arsitektur aplikasi dapat dipecah menjadi layanan yang lebih kecil dan dijalankan dengan autoscaling agar lebih tahan terhadap lonjakan beban.