fn main() {
    // Fix macOS "Library not loaded: @rpath/...Python3" when running cargo test.
    // Adds rpath so the test binary can find the Python framework.
    pyo3_build_config::add_python_framework_link_args();
}
