.PHONY: build test test-rust test-python dev install lint fmt clean

# Build Rust release binary
build:
	cargo build --release

# Run Rust tests
test-rust:
	cargo test --verbose

# Run all tests (Rust + Python)
test: test-rust test-python

# Run Python tests (builds extension first)
test-python:
	maturin build --release
	uv pip install target/wheels/*.whl --force-reinstall
	uv run pytest tests/python/ -v

# Local development: build Python extension in-place
dev:
	maturin develop --release

# Install Python package for local use
install:
	maturin build --release
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
