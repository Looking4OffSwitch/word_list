#!/bin/sh
set -e

echo "=== Word List Python Server Setup ==="

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

# Display Python version
python_version=$(python3 --version)
echo "Using $python_version"

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# Activate the virtual environment
echo "Activating virtual environment..."
. venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating default .env file from template..."
    cp .env.example .env
    echo "Please edit the .env file to configure your server settings."
fi

echo "=== Setup completed successfully! ==="
echo "You can now start the server with './start_server.sh' or 'python app.py'"
