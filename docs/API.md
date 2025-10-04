# Verba Volant API Documentation

This document describes the HTTP API endpoints exposed by the Verba Volant server.

The API is compatible with the official [Verba API](https://verba.civio.es).

## Base URL

When running locally, the default base URL is:
```
http://localhost:8080
```

## Endpoints

### GET /

Returns a simple welcome message.

**Response:**
```
Hello, Darkness https://youtu.be/_T2X7z1Akiw
```

---

### GET /api

Returns API information and version.

**Response:**
```json
{
  "name": "Verba Volant API",
  "version": "1.0"
}
```

---

### GET /api/search

Search through transcripts using full-text search.

**Query Parameters:**
- `q` (required): Search query string

**Response:**
```json
{
  "page": 0,
  "length": 10,
  "results": [
    {
      "id": 123,
      "title": "Programme Title",
      "content": "Transcript content matching the search...",
      "link": "https://example.com/link",
      "time_start": 0,
      "time_end": 300,
      "programme": {
        "id": 456,
        "date": "2024-01-15T10:00:00Z"
      }
    }
  ]
}
```

**Example:**
```
GET /api/search?q=keyword
```

---

### GET /api/search/{q}

Alternative search endpoint with query in URL path. Prints results to console instead of returning JSON.

**Path Parameters:**
- `q` (required): Search query string

**Example:**
```
GET /api/search/keyword
```

---

### GET /api/search.csv

Search endpoint that returns results in CSV format (console output).

**Query Parameters:**
- `q` (required): Search query string

**Example:**
```
GET /api/search.csv?q=keyword
```

---

### GET /api/fetchProgrammeList

Retrieve a list of all programmes in the database.

**Response:**
```json
[
  {
    "id": "123",
    "date": "2024-01-15",
    "title": "Programme Title"
  },
  {
    "id": "124",
    "date": "2024-01-16",
    "title": "Another Programme"
  }
]
```

**Example:**
```
GET /api/fetchProgrammeList
```

---

### GET /api/fetchProgrammeTranscription

Retrieve the full transcription for a specific programme.

**Query Parameters:**
- `programme_id` (required): The ID of the programme

**Response:**
```json
[
  {
    "id": "transcript_123",
    "link": "https://example.com/link",
    "content": "Transcript segment content...",
    "time_start": 0,
    "time_end": 300,
    "entities": [],
    "programme": {
      "id": "456",
      "date": "2024-01-15",
      "title": "Programme Title"
    }
  }
]
```

**Example:**
```
GET /api/fetchProgrammeTranscription?programme_id=123
```

---

### GET /api/fetchContext

Retrieve context for a specific programme (endpoint stub - not yet implemented).

**Query Parameters:**
- `programme_id` (required): The ID of the programme

**Example:**
```
GET /api/fetchContext?programme_id=123
```

---

## Error Responses

Endpoints return HTTP 400 (Bad Request) when required parameters are missing.

## Notes

- All timestamps are in seconds
- Dates are formatted as ISO 8601 (YYYY-MM-DD or RFC3339)
- The search functionality uses SQLite FTS5 (Full-Text Search) for efficient querying
- Results are ordered by programme date in ascending order
