#!/bin/bash
### COMMON SETUP; DO NOT MODIFY ###
set -e
cd /workspace

# --- CONFIGURE THIS SECTION ---
# Replace this with your command to run all tests
run_all_tests() {
  echo "Running all tests..."
  set +e
  PYTHONPATH=app python -m unittest discover -s app/gslib/tests -t app -p 'test_*.py' -v
  TEST_EXIT_CODE=$?
  set -e
  echo "Test run exited with code ${TEST_EXIT_CODE}"
}

# Replace this with your command to run specific test files
run_selected_tests() {
  local test_files=("$@")
  echo "Running selected tests: ${test_files[@]}"
  set +e
  PYTHONPATH=app python -m unittest -v "${test_files[@]}"
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
