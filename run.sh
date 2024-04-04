#!/bin/bash

# Check if the first argument is 'build'
if [ "$1" == "build" ]; then
    # Call setup.py to build the wheel
    python setup.py bdist_wheel

    # Check if WHEEL_OUTPUT_PATH is set and is not empty
    if [ -n "$WHEEL_OUTPUT_PATH" ]; then
        # Copy the wheel file(s) to the specified output path
        cp /mesh-intersection/dist/*.whl "$WHEEL_OUTPUT_PATH"
    fi
else
    # If the first argument is not 'build', just execute the command (default to bash)
    exec "$@"
fi
