# Word List Python Server

A Python implementation of a Word List API server that provides random vocabulary words for the trmnl plugin.

NOTE: To deploy the server to vercel: https://www.youtube.com/watch?v=LaMVBDbUtMA

## Requirements

- Python 3.7+
- pip (Python package installer)

## Quick Start

```bash
# 1. Set up the server
./setup.sh

# 2. Start the server
./start_server.sh
```

## Setup

The setup script will automatically:

1. Create a Python virtual environment
2. Install all required dependencies
3. Create a default configuration file

```bash
./setup.sh
```

For manual setup:

```bash
# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate  # On Linux/Mac
# or
venv\Scripts\activate     # On Windows

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Create configuration file
cp .env.example .env
```

## Running the Server

After setup, you can start the server:

```bash
# Using the start script (recommended)
./start_server.sh
```

Or manually:

```bash
# Activate the virtual environment
source venv/bin/activate  # On Linux/Mac
# or
venv\Scripts\activate     # On Windows

# Run the server
python app.py
```

The server will start on port 3000 by default. You can access the API at:
- http://localhost:3000/ - Basic info
- http://localhost:3000/random-word - Get a random vocabulary word

## Configuration (.env file)

The server is configured using a `.env` file. A template file `.env.example` is provided. 
To configure the server:

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
2. Edit the `.env` file to customize your settings:
   - `PORT`: The port number to run the server on (default: 3000)
   - `WORD_LIST`: The name of the JSON file containing vocabulary words
   - `FIXED_WORD_KEY`: If set, the server will always return the word with this key instead of a random word (optional)

## Configuration

The server is configured using environment variables in the `.env` file:

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | The port number for the server | `3000` |
| `WORD_LIST` | Path to the word list JSON file | `data.json` |
| `FIXED_WORD_KEY` | (Optional) If set, always returns this specific word | - |

## Word List JSON Format

The word list file should be a JSON file with the following structure:

```json
{
  "metadata": {
    "total_words": 100,
    "created_date": "2025-07-14T08:31:43.829973",
    "last_updated": "2025-07-15T11:05:47.566089",
    "source": "Source information",
    "word_list_file": "original_file.txt",
    "longest_definition": "word_with_longest_def",
    "longest_example_sentence": "word_with_longest_example"
  },
  "words": {
    "example1": {
      "word": "example1",
      "definition": "The definition of the word",
      "part_of_speech": "noun",
      "synonyms": ["synonym1", "synonym2"],
      "antonyms": ["antonym1", "antonym2"],
      "phonetic_spelling": "ih-g-zam-pul",
      "first_known_usage": "19th century",
      "example_sentence": "An example sentence using the word."
    }
  }
}
```

### Required Structure

The server validates the word list file at startup and will fail to start if:

1. The word list file cannot be found
2. The file exists but is empty
3. The file contains invalid JSON
4. The JSON does not contain a `words` object
5. The `words` object is empty or not a dictionary
6. Word entries don't contain required fields (`word`, `definition`)

## API Endpoints

### `GET /`

Returns basic information about the API.

Response:
```json
{
  "message": "Welcome to the Word List API",
  "endpoints": {
    "randomWord": "/random-word",
    "health": "/health"
  }
}
```

### `GET /health`

Returns the health status of the server.

Response:
```json
{
  "status": "healthy",
  "message": "Server is running with 229 words available",
  "timestamp": "123456789"
}
```

### `GET /random-word`

Returns a random vocabulary word from the word list.

Response:
```json
{
  "word": {
    "word": "example",
    "definition": "Something that serves as a pattern",
    "part_of_speech": "noun",
    "synonyms": ["model", "sample"],
    "antonyms": ["counterexample"],
    "phonetic_spelling": "ig-zam-puhl",
    "example_sentence": "This is an example of how to use the word."
  }
}
```