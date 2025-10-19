# Maverick-MCP Makefile
# Central command interface for agent-friendly development

.PHONY: help dev dev-sse dev-http dev-stdio stop test test-all test-watch test-specific test-parallel test-cov test-speed test-speed-quick test-speed-emergency test-speed-comparison test-strategies lint format typecheck clean tail-log backend check migrate setup redis-start redis-stop experiment experiment-once benchmark-parallel benchmark-speed docker-up docker-down docker-logs

# Default target
help:
	@echo "Maverick-MCP Development Commands:"
	@echo ""
	@echo "  make dev          - Start development environment (SSE transport, default)"
	@echo "  make dev-sse      - Start with SSE transport (same as dev)"
	@echo "  make dev-http     - Start with Streamable-HTTP transport (for curl/testing)"
	@echo "  make dev-stdio    - Start with STDIO transport (for direct connections)"
	@echo "  make backend      - Start backend MCP server (dev mode)"
	@echo "  make stop         - Stop all services"
	@echo ""
	@echo "  make test         - Run unit tests (fast)"
	@echo "  make test-all     - Run all tests including integration"
	@echo "  make test-watch   - Auto-run tests on file changes"
	@echo "  make test-specific TEST=name - Run specific test"
	@echo "  make test-parallel - Run tests in parallel"
	@echo "  make test-cov     - Run tests with coverage report"
	@echo "  make test-fixes   - Validate MCP tool fixes are working"
	@echo "  make test-speed   - Run speed optimization validation tests"
	@echo "  make test-speed-quick - Quick speed validation for CI"
	@echo "  make test-speed-emergency - Emergency mode speed tests"
	@echo "  make test-speed-comparison - Before/after performance comparison"
	@echo "  make test-strategies - Validate ALL backtesting strategies"
	@echo ""
	@echo "  make lint         - Run code quality checks"
	@echo "  make format       - Auto-format code"
	@echo "  make typecheck    - Run type checking"
	@echo "  make check        - Run all checks (lint + type check)"
	@echo ""
	@echo "  make tail-log     - Follow backend logs"
	@echo ""
	@echo "  make experiment   - Watch and auto-run .py files"
	@echo "  make benchmark-parallel - Test parallel screening"
	@echo "  make benchmark-speed - Run comprehensive speed benchmark"
	@echo "  make migrate      - Run database migrations"
	@echo "  make setup        - Initial project setup"
	@echo "  make clean        - Clean up generated files"
	@echo ""
	@echo "  make docker-up    - Start with Docker"
	@echo "  make docker-down  - Stop Docker services"
	@echo "  make docker-logs  - View Docker logs"

# Development commands
dev:
	@echo "Starting Maverick-MCP development environment (SSE transport)..."
	@./scripts/dev.sh

dev-sse:
	@echo "Starting Maverick-MCP development environment (SSE transport)..."
	@./scripts/dev.sh

dev-http:
	@echo "Starting Maverick-MCP development environment (Streamable-HTTP transport)..."
	@MAVERICK_TRANSPORT=streamable-http ./scripts/dev.sh

dev-stdio:
	@echo "Starting Maverick-MCP development environment (STDIO transport)..."
	@MAVERICK_TRANSPORT=stdio ./scripts/dev.sh

backend:
	@echo "Starting backend in development mode..."
	@./scripts/start-backend.sh --dev

stop:
	@echo "Stopping all services..."
	@pkill -f "maverick_mcp.api.server" || true
	@echo "All services stopped."

# Testing commands
test:
	@echo "Running unit tests..."
	@uv run pytest -v

test-all:
	@echo "Running all tests (including integration)..."
	@uv run pytest -v -m ""

test-watch:
	@echo "Starting test watcher..."
	@if ! uv pip show pytest-watch > /dev/null 2>&1; then \
		echo "Installing pytest-watch..."; \
		uv pip install pytest-watch; \
	fi
	@uv run ptw -- -v

test-specific:
	@if [ -z "$(TEST)" ]; then \
		echo "Usage: make test-specific TEST=test_name"; \
		exit 1; \
	fi
	@echo "Running specific test: $(TEST)"
	@uv run pytest -v -k "$(TEST)"

test-parallel:
	@echo "Running tests in parallel..."
	@if ! uv pip show pytest-xdist > /dev/null 2>&1; then \
		echo "Installing pytest-xdist..."; \
		uv pip install pytest-xdist; \
	fi
	@uv run pytest -v -n auto

test-cov:
	@echo "Running tests with coverage..."
	@uv run pytest --cov=maverick_mcp --cov-report=html --cov-report=term

test-fixes:
	@echo "Running MCP tool fixes validation..."
	@uv run python maverick_mcp/tests/test_mcp_tool_fixes.py

test-fixes-verbose:
	@echo "Running MCP tool fixes validation (verbose)..."
	@uv run python -u maverick_mcp/tests/test_mcp_tool_fixes.py

# Speed optimization testing commands
test-speed:
	@echo "Running speed optimization validation tests..."
	@uv run pytest -v tests/test_speed_optimization_validation.py

test-speed-quick:
	@echo "Running quick speed validation for CI..."
	@uv run python scripts/speed_benchmark.py --mode quick

test-speed-emergency:
	@echo "Running emergency mode speed tests..."
	@uv run python scripts/speed_benchmark.py --mode emergency

test-speed-comparison:
	@echo "Running before/after performance comparison..."
	@uv run python scripts/speed_benchmark.py --mode comparison

test-strategies:
	@echo "Validating ALL backtesting strategies with real market data..."
	@uv run python scripts/test_all_strategies.py

# Code quality commands
lint:
	@echo "Running linter..."
	@uv run ruff check .

format:
	@echo "Formatting code..."
	@uv run ruff format .
	@uv run ruff check . --fix

typecheck:
	@echo "Running type checker..."
	@uv run pyright

check: lint typecheck
	@echo "All checks passed!"

# Utility commands
tail-log:
	@echo "Following backend logs (Ctrl+C to stop)..."
	@tail -f backend.log

experiment:
	@echo "Starting experiment harness..."
	@python tools/experiment.py

experiment-once:
	@echo "Running experiments once..."
	@python tools/experiment.py --once

migrate:
	@echo "Running database migrations..."
	@./scripts/run-migrations.sh upgrade

setup:
	@echo "Setting up Maverick-MCP..."
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "Created .env file - please update with your configuration"; \
	fi
	@uv sync
	@echo "Setup complete! Run 'make dev' to start development."

clean:
	@echo "Cleaning up..."
	@rm -rf .pytest_cache
	@rm -rf htmlcov
	@rm -rf .coverage
	@rm -rf .ruff_cache
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete
	@echo "Cleanup complete."

# Service management
redis-start:
	@echo "Starting Redis..."
	@if command -v brew &> /dev/null; then \
		brew services start redis; \
	else \
		redis-server --daemonize yes; \
	fi

redis-stop:
	@echo "Stopping Redis..."
	@if command -v brew &> /dev/null; then \
		brew services stop redis; \
	else \
		pkill redis-server || true; \
	fi

# Quick shortcuts
d: dev
dh: dev-http
ds: dev-stdio
b: backend
t: test
l: lint
c: check

# Performance testing
benchmark-parallel:
	@echo "Benchmarking parallel screening performance..."
	@python -c "from tools.quick_test import test_parallel_screening; import asyncio; asyncio.run(test_parallel_screening())"

benchmark-speed:
	@echo "Running comprehensive speed benchmark..."
	@uv run python scripts/speed_benchmark.py --mode full


# Docker commands
docker-up:
	@echo "Starting Docker services..."
	@docker-compose up --build -d

docker-down:
	@echo "Stopping Docker services..."
	@docker-compose down

docker-logs:
	@echo "Following Docker logs (Ctrl+C to stop)..."
	@docker-compose logs -f