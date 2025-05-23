#!/bin/bash
### COMMON SETUP; DO NOT MODIFY ###
set -e
cd /workspace

# --- CONFIGURE THIS SECTION ---
# Replace this with your command to run all tests
run_all_tests() {
  echo "Running all tests..."
  set +e
  PYTHONPATH=app python - <<'EOF'
import sys, types, unittest
sys.modules['mock_storage_service'] = types.ModuleType('mock_storage_service')
import gslib.tests.util as util
util.RUN_INTEGRATION_TESTS = False
util.RUN_UNIT_TESTS = True
loader = unittest.TestLoader()
suite = loader.discover('gslib/tests', top_level_dir='app', pattern='test_*.py')
result = unittest.TextTestRunner(verbosity=2).run(suite)
sys.exit(0 if result.wasSuccessful() else 1)
EOF
  TEST_EXIT_CODE=$?
  set -e
  echo "Test run exited with code ${TEST_EXIT_CODE}"
}

# Replace this with your command to run specific test files
run_selected_tests() {
  local test_files=("$@")
  echo "Running selected tests: ${test_files[@]}"
  set +e
  PYTHONPATH=app python - "${test_files[@]}" <<'EOF'
import sys, types, unittest
sys.modules['mock_storage_service'] = types.ModuleType('mock_storage_service')
import gslib.tests.util as util
util.RUN_INTEGRATION_TESTS = False
util.RUN_UNIT_TESTS = True
test_files = sys.argv[1:]
loader = unittest.TestLoader()
suite = loader.loadTestsFromNames(test_files)
result = unittest.TextTestRunner(verbosity=2).run(suite)
sys.exit(0 if result.wasSuccessful() else 1)
EOF
  TEST_EXIT_CODE=$?
  set -e
  echo "Test run exited with code ${TEST_EXIT_CODE}"
}
# --- END CONFIGURATION SECTION ---


### COMMON EXECUTION; DO NOT MODIFY ###

# No args is all tests
if [ $# -eq 0 ]; then
run_all_tests
exit 0
fi

# Handle comma-separated input
if [[ "$1" == *","* ]]; then
  IFS=',' read -r -a TEST_FILES <<< "$1"
else
  TEST_FILES=("$@")
fi

# Run them all together
run_selected_tests "${TEST_FILES[@]}"
exit 0
