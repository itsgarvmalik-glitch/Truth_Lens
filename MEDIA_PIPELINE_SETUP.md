# Media Pipeline Setup (Windows)

## FFmpeg / FFprobe
1. Install FFmpeg and ensure `ffprobe.exe` is in PATH.
2. Ensure `ffmpeg.exe` is also in PATH (needed for lip-sync stage audio extraction).
3. Or set explicit path:
   - `FFPROBE_PATH=C:\\ffmpeg\\bin\\ffprobe.exe`

## OpenCV Java (optional)
1. Add OpenCV Java dependency/JAR to classpath.
2. Set native DLL path:
   - `OPENCV_NATIVE_PATH=C:\\opencv\\build\\java\\x64\\opencv_java490.dll`

## OCR (Tesseract) for Photo Text
1. Install Tesseract OCR and ensure `tesseract.exe` is in PATH.
2. Or set explicit path:
   - `TESSERACT_PATH=C:\\Program Files\\Tesseract-OCR\\tesseract.exe`
3. The media pipeline will extract text from uploaded photos and add OCR risk signals.

## Voice Deepfake Service
1. Go to `tools/voice-deepfake-service`
2. Run:
   - `python -m venv .venv`
   - `.\.venv\Scripts\activate`
   - `pip install -r requirements.txt`
   - `uvicorn app:app --host 127.0.0.1 --port 8090`
3. Set in app env:
   - `VOICE_SERVICE_URL=http://127.0.0.1:8090`
4. This service now exposes:
   - `/detect` (voice deepfake heuristics)
   - `/lip-sync` (video frame-to-audio alignment scoring)
   - `/vlog-analyze` (speaker-face consistency, cut manipulation, audio tamper, credibility, frame evidence)
5. Optional ASR (for transcript-vs-claim):
   - Download Vosk model and set:
   - `VOSK_MODEL_PATH=C:\\vosk\\model`

## Image AI Detector (OpenAI + Local)
The photo pipeline can call two detectors and combine the probabilities.

### OpenAI detector
1. Set:
   - `IMAGE_AI_DETECTOR_MODE=both` (or `openai`)
   - `IMAGE_AI_OPENAI_KEY=sk-...`
2. Optional overrides:
   - `IMAGE_AI_OPENAI_MODEL=gpt-4o-mini`
   - `IMAGE_AI_OPENAI_BASE_URL=https://api.openai.com/v1/chat/completions`
   - `IMAGE_AI_OPENAI_TIMEOUT_MS=20000`

### Local detector (any HTTP service)
1. Run your local image-AI detector as an HTTP service.
2. It must accept `POST` JSON:
   - `image_base64`: base64 string
   - `mime_type`: image MIME (optional)
   - `filename`: original filename (optional)
3. It must return JSON:
   - `ai_probability` (0..1)
   - `confidence` (0..1)
   - `explanation` (string)
4. Set:
   - `IMAGE_AI_DETECTOR_MODE=both` (or `local`)
   - `IMAGE_AI_LOCAL_URL=http://127.0.0.1:8095/detect`

## Spring Boot env quick set (PowerShell)
$env:FFPROBE_PATH='ffprobe'
$env:VOICE_SERVICE_URL='http://127.0.0.1:8090'
$env:LIP_SYNC_TIMEOUT_MS='12000'
$env:TESSERACT_PATH='tesseract'
$env:VLOG_TIMEOUT_MS='18000'
$env:OPENCV_NATIVE_PATH='C:\\opencv\\build\\java\\x64\\opencv_java490.dll'
$env:IMAGE_AI_DETECTOR_MODE='both'
$env:IMAGE_AI_OPENAI_KEY='sk-...'
$env:IMAGE_AI_LOCAL_URL='http://127.0.0.1:8095/detect'
