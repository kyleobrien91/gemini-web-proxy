#!/bin/bash
set -e

echo "Setting up Gemini Web Proxy for OpenCode..."
echo "=========================================="

# Check Python version
if ! python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)'; then
    echo "Error: Python 3.8 or higher is required"
    exit 1
fi

echo "✓ Python version check passed"

# Check if running in a virtual environment
if ! python3 -c 'import sys; sys.exit(0 if sys.prefix != sys.base_prefix else 1)'; then
    echo ""
    echo "⚠️  WARNING: You are not running in a Python virtual environment."
    echo "We strongly recommend using a virtual environment to avoid conflicts with system packages."
    echo "To create and activate a virtual environment, you can run:"
    echo "  python3 -m venv venv"
    echo "  source venv/bin/activate"
    echo "Continuing with installation..."
    echo ""
fi

# Install Python dependencies
echo "Installing Python dependencies..."
if ! pip3 install -r requirements.txt; then
    echo ""
    echo "❌ Error: Failed to install Python dependencies."
    echo "This is likely due to your system's package manager preventing global pip installations (PEP 668)."
    echo "Please create a virtual environment and try again:"
    echo "  python3 -m venv venv"
    echo "  source venv/bin/activate"
    echo "  ./setup.sh"
    exit 1
fi

# Install Playwright browsers
echo "Installing Playwright browsers..."
if ! playwright install chromium; then
    echo ""
    echo "❌ Error: Failed to install Playwright browsers."
    echo "Make sure Playwright was successfully installed via requirements.txt."
    exit 1
fi

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run: python3 run.py"
echo "2. Log in to your Google account when browser opens"
echo "3. Configure OpenCode with the provider settings from README.md"
echo ""
echo "For detailed instructions, see README.md"
