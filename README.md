# TruthLens with AI-Arena 🔍🛡️

> **AI-Powered Content Trust Scoring & Multimodal Deepfake Forensics Platform**

TruthLens with AI-Arena is an enterprise-grade content verification and trust scoring platform. Built on **Spring Boot 3 (Java 21)**, it combines heuristic forensics, RAG (Retrieval-Augmented Generation), neural text classification, and pixel-level media analysis to detect AI-generated media, synthetic text, and deepfakes while reliably verifying authentic content.

---

## 🌟 Key Features

- **Multimodal AI Detection**:
  - **Images & Photos**: Binary header parsing for WebP (VP8/VP8L/VP8X), resolution grid matching (1024x1024, 1536x1024), EXIF metadata analysis, smoothness/saturation anomaly detection, and AI generator signature recognition (DALL-E 3, Midjourney, Bing Creator / Copilot, Stable Diffusion).
  - **Text & News Analysis**: Hybrid RAG retrieval, synthetic writing pattern inspection, stylistic perplexity checks, and source credibility scoring.
  - **Audio & Video Forensics**: Voice deepfake analysis, lip-sync anomaly checks, and audio spectrum inspection.
- **Calibrated Trust Score System (0 - 100)**:
  - Low Score ($\le 25$): **Not AI Generated / Likely Authentic** (Zero false-positive protection for WhatsApp, mobile camera, and compressed real photos).
  - High Score ($\ge 65$): **Highly AI Generated** (Accurate classification for Midjourney, DALL-E, Bing/Copilot, etc.).
- **Interactive Web Interface**:
  - Modern, responsive dashboard with real-time analysis, history tracking, complaint portal, and admin audit tools.
- **Secure Architecture**:
  - Spring Security with JWT authentication, role-based access control (USER / ADMIN), and embedded H2 persistence.

---

## 🏗️ Technology Stack

| Component | Technology |
|---|---|
| **Backend Framework** | Spring Boot 3.3.2 |
| **Language** | Java 21 (LTS) |
| **Build Tool** | Maven (`mvnw`) |
| **Database** | Embedded H2 Database |
| **Security** | Spring Security & JWT (`jjwt 0.12.6`) |
| **Frontend** | Responsive Vanilla HTML5, CSS3, Modern JavaScript |
| **Deployment** | Docker / Render / Railway / Cloud Native |

---

## 🚀 Quick Start (Local Run)

### Prerequisites
- **Java 21** or higher installed.
- Git.

### 1. Clone the Repository
```bash
git clone https://github.com/ksp-Abhishek/Truthlens-with-Ai-Arena.git
cd Truthlens-with-Ai-Arena
```

### 2. Run the Application
**On Windows:**
```powershell
.\mvnw.cmd spring-boot:run
```

**On Linux / macOS:**
```bash
./mvnw spring-boot:run
```

### 3. Open in Browser
Visit [http://localhost:8080](http://localhost:8080) to access the TruthLens dashboard.

---

## ☁️ Live Cloud Deployment (Free with Render)

Deploy the entire backend + UI live with a free public URL on [Render](https://render.com):

1. Go to [Render Dashboard](https://dashboard.render.com/) and click **New +** $\rightarrow$ **Web Service**.
2. Configure the settings:
   - **Name**: `truthlens-ai`
   - **Runtime**: `Docker` (or Java)
   - **Region**: Closest to you (e.g., Singapore / Frankfurt)
   - **Instance Type**: Free
3. Click **Deploy Web Service**.
4. Once built, you'll receive your live URL: `https://truthlens-ai.onrender.com`.

---

## 🐳 Docker Support

To build and run as a standalone container:

```bash
docker build -t truthlens-ai .
docker run -p 8080:8080 truthlens-ai
```

---

## 📁 Repository Structure

```text
├── src/
│   ├── main/
│   │   ├── java/com/Abhishekkashyap/AI_trust_Score_System/
│   │   │   ├── controller/      # REST API Controllers (/api/analyze-upload, /api/auth, etc.)
│   │   │   ├── service/         # MediaForensics, ContentAnalysis, FusionCalibrator
│   │   │   ├── model/           # Data entities and DTOs
│   │   │   ├── repository/      # Spring Data JPA repositories
│   │   │   └── security/        # JWT filters and auth config
│   │   └── resources/
│   │       ├── application.properties
│   │       └── static/          # Full web frontend (HTML, CSS, JS, assets)
│   └── test/                    # Comprehensive unit and integration tests (21+ tests)
├── tools/                       # ML models, training scripts & calibration weights
├── pom.xml                      # Maven dependencies
├── Dockerfile                   # Production container definition
├── render.yaml                  # 1-Click Render cloud deployment spec
└── README.md
```

---

## 🧪 Running Automated Tests

Run the full test suite (21 unit and integration tests):
```bash
.\mvnw.cmd test
```

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
