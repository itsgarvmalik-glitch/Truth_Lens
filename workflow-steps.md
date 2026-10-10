# AI Trust Score System - Stepwise Workflow

1. User opens frontend pages from Spring static resources (`index.html`, `analyze.html`, `dashboard.html`).
2. User signs up/signs in via `/api/auth/signup` or `/api/auth/signin` and receives JWT token.
3. `JwtAuthenticationFilter` validates Bearer token; `SecurityConfig` enforces route authorization.
4. User submits analysis request:
   - Text/URL/metadata -> `POST /api/analyze`
   - Media upload -> `POST /api/analyze-upload`
5. `ContentAnalysisService` builds a unified analysis input. For uploads, `MediaForensicsService` also scans media.
6. AI detection executes:
   - If API key is configured -> OpenAI detector call.
   - Else or on failure -> `TrustScoreService` heuristic fallback.
7. Engine computes final output fields: trust score, AI probability, confidence, risk signals, fake likelihood, truth label, and explanation.
8. `ContentController.persistContent` saves result in DB (`ContentRepository`) and writes audit logs (`AuditLogService`).
9. If score >= 70, `AlertService` triggers high-risk alert and logs alert outcome.
10. Response is returned to UI; user can review history/feedback, and admins can access analytics/report/support workflows.
