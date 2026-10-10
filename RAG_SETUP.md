# RAG Setup

This project now includes a local retrieval-augmented generation pipeline for text analysis and a direct query API.

## What is configured

- `RagService` builds a local hybrid index from files in `data/rag`
- Retrieval can run in `lexical`, `semantic`, or `hybrid` mode
- If an API key is available, semantic retrieval uses OpenAI embeddings
- `POST /api/rag/answer` returns a grounded answer plus source chunks
- Text analysis attaches `ragAnswer` and `ragSources` to saved analysis records
- Fact verification risk is adjusted using RAG evidence quality
- The analyze UI and detail page show RAG output when available
- The analyze page includes a standalone "Ask Knowledge Base" panel

## Corpus layout

The knowledge base is now split by domain:

- `data/rag/fact-checking-guidelines/`
- `data/rag/deepfake-indicators/`
- `data/rag/source-credibility-rules/`
- `data/rag/cyber-reporting-procedure/`

Supported formats: `.txt`, `.md`, `.markdown`, `.json`

## Corpus rules

- Use trusted, structured documents with headings
- Keep one topic per file when possible
- Remove duplicate or weak notes
- Prefer actionable guidance over vague summaries

## Environment

RAG works in retrieval-only mode without an API key, but answer generation needs one of these:

```powershell
$env:OPENAI_API_KEY="your_key_here"
```

or

```powershell
$env:RAG_OPENAI_API_KEY="your_key_here"
```

Optional configuration is already present in `src/main/resources/application.properties`.

Important RAG properties:

- `rag.retrieval-mode=hybrid`
- `rag.embeddings.enabled=true`
- `rag.hybrid-alpha=0.55`
- `rag.openai.embedding-model=text-embedding-3-small`

## Run

```powershell
./mvnw.cmd spring-boot:run
```

After adding or changing files in `data/rag`, restart the application so the index rebuilds.

## Testing

Retrieval tests should confirm:

- domain-specific queries return the expected folder/file source
- extractive fallback works without an API key
- unrelated queries do not return misleading answers

## API example

```http
POST /api/rag/answer
Content-Type: application/json

{
  "query": "How should I evaluate a viral forwarded claim with no source?",
  "topK": 4
}
```

## Notes

Without an API key, retrieval still works with lexical search and an extractive fallback answer.
With an API key, the system can build embedding vectors and produce better semantic retrieval plus generated grounded answers.
