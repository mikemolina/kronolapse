..
    manpage.rst - Manpage for script kronolapse.

:orphan:

KRONOLAPSE
==========

SYNOPSIS
--------
**kronolapse** [*options*] [*CSV file*]

DESCRIPTION
-----------
**kronolapse** processes a list of image files to display on a monitor,
according to a predetermined schedule of times and intervals.

The list of files and their schedule are read from a CSV file with an
array of three fields (or columns), where the first line must begin with
a header similar to:

::
    
    Image document,Start time,End time

Next, list each image with its absolute path, the start and end times of
the display; the times are entered in *ISO 8601 format*, that is, in the
format `YYYY-mm-dd HH:mm:ss`. Here is an example for a schedule file:

::

    Image document,Start time,End time
    /home/user/image-1.jpg,2025-12-01 09:00:00,2025-12-01 09:04:59
    /home/user/image-2.jpg,2025-12-01 09:05:00,2025-12-01 09:07:00

save the *CSV file*; for example, as `schedule.csv`.

OPTIONS
-------
-h, --help
    Show this help message and exit.

-V, --version
    Show program's version number and exit.

-s, --show
    Only shows the schedule file.

REMARKS
-------
The start and end times of the schedule for each file should not
coincide to avoid overlapping of two simultaneous images.

EXAMPLES
--------
An example of use:

::
    
    kronolapse path/to/schedule.csv

Verify and display the schedule:

::
    
    kronolapse -s path/to/schedule.csv

BUGS
----
On Linux operating systems, with 4K monitors using fractional scaling
(GNOME desktop environment), the display is not shown in full screen.

LICENSE
-------
License GPLv3+:
GNU GPL version 3 or later
<https://www.gnu.org/licenses/gpl-3.0.html>.
This is free software: you can redistribute it and/or modify. There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
