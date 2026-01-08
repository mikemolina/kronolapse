# -*- mode: python -*-
# -*- coding: utf-8 -*-
#
# test_script_kronolapse.py
#
# This test check the functionality for script krononolapse.

import sys
import subprocess


# Check success or failure for the command
def parse_command(command: list)->bool:
    try:
        result = subprocess.run(command,
                                capture_output=True,
                                text=True,
                                check=True)
        print("Command executed successfully!")
        status = True
        return status
    except subprocess.CalledProcessError as e:
        print("Failed input:\n{}".format(e), file=sys.stderr)
        print("Error output:\n{}".format(e.stderr), file=sys.stderr)
        status = False
        return status

# Check read of schedule file
def test_script_read_schedule()->None:
    cmd = ["./venv/bin/python", "-m", "kronolapse", "-s", "schedule_test.csv"]
    process = parse_command(cmd)
    assert process == True, "The schedule was not displayed correctly"

# Check the schedule is shown
def test_script_show_schedule()->None:
    cmd = ["./venv/bin/python", "-m", "kronolapse", "schedule_test.csv"]
    process = parse_command(cmd)
    assert process == True, "The schedule was not displayed correctly"
