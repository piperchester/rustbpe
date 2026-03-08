.PHONY: build test test-rust test-python dev install setup lint fmt clean

# Create venv and install build dependencies
setup:
	uv venv
	uv pip install maturin pytest

# Build Rust release binary
build:
	cargo build --release

# Run Rust tests
test-rust:
	cargo test --verbose

# Run all tests (Rust + Python)
test: test-rust test-python

# Run Python tests (builds extension first, run make setup first)
test-python:
	uv run maturin build --release
	uv pip install target/wheels/*.whl --force-reinstall
	uv run pytest tests/python/ -v -s

# Local development: build Python extension in-place (run make setup first)
dev:
	uv run maturin develop --release

# Install Python package for local use (run make setup first)
install:
	uv run maturin build --release
	uv pip install target/wheels/*.whl

# Lint Rust code
lint:
	cargo fmt --all -- --check
	cargo clippy -- -D warnings

# Format Rust code
fmt:
	cargo fmt --all

# Clean build artifacts
clean:
	cargo clean
	rm -rf target/
