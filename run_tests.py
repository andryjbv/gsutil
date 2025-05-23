#!/usr/bin/env python
import sys
import unittest
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'app'))
import gslib.tests.util as util
# Disable integration tests because dependencies and credentials are unavailable
util.RUN_INTEGRATION_TESTS = False
util.RUN_UNIT_TESTS = True

def main():
    test_files = sys.argv[1:]
    loader = unittest.TestLoader()
    if test_files:
        suite = loader.loadTestsFromNames(test_files)
    else:
        suite = loader.discover('gslib/tests', top_level_dir='.', pattern='test_*.py')
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    sys.exit(0 if result.wasSuccessful() else 1)

if __name__ == '__main__':
    main()
