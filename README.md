![Static Badge](https://img.shields.io/badge/python-3.12%2B-blue)
![Static Badge](https://img.shields.io/badge/license-%20%20GNU%20GPLv3+%20-red?style=plastic)

# KRoNoLAPSE
**kronolapse** is a Python tool that manages the display of content, automating
the display of images on a monitor according to custom schedules (`cronologic
time`) and times (`lapses`), ensuring the correct presentation of the content at
the precise moment.

## Key features!
- **Easy planning.** Content, schedules, and duration are planned in a plain text
  file.
- **Simple to use.** Although **kronolapse** uses a Command Line Interface (CLI),
  after installation, simply run the tool from your system's default terminal
  using the plan saved in the text file.
- **Content Display.** Initially, **kronolapse** supports conventional image
  formats such as JPG, PNG, BMP.

## Installation
### User mode
1. [Python](https://www.python.org/downloads/) and
   [pip](https://pip.pypa.io/en/stable/installation/#get-pip-py) must be installed
   on your system. Version 3.12 or higher is recommended for Python.
2. Install the latest version from the repository with this line:

   ```bash
   pip install @git+https://github.com/mikemolina/kronolapse.git
   ```

### Development mode
1. [Python](https://www.python.org/downloads/),
   [pip](https://pip.pypa.io/en/stable/installation/#get-pip-py) and [GNU
   Make](https://www.gnu.org/software/make/) must be installed on your
   system. Version 3.12 or higher is recommended for Python.

2. Clone the repository and navigate to its directory:

   ```bash
   git clone https://github.com/mikemolina/kronolapse.git kronolapse-dev
   cd kronolapse-dev
   ```

3. Prepare a virtual environment and compile the package. Requires the
   [virtualenv](https://pypi.org/project/virtualenv/) package installed on your
   system.

   ```bash
   make prepare-venv
   make build
   ```

4. Install the package in editable mode into the virtual environment:

   ```bash
   make install
   ```

   Required dependencies such as
   [opencv-python](https://pypi.org/project/opencv-python/) and
   [screeninfo](https://pypi.org/project/screeninfo/) are automatically installed
   in this step.

## Usage
### User mode
1. Plan the content, schedule, and duration of your presentation in a plain text
   file formatted as
   [CSV](https://en.wikipedia.org/wiki/Comma-separated_values). The duration of
   the presentation is determined by the start and end times.

   The `CSV file` must have three comma-separated fields or columns (`,`), and the
   first line must begin with a header similar to:
   
   > Image document,Start time,End time

   Next, list each image with its absolute path (depending on the operating
   system), the start and end times of the display; the times are entered in [ISO
   8601 format](https://en.wikipedia.org/wiki/ISO_8601), that is, in the format
   _YYYY-mm-dd HH:mm:ss_. As an example of a scheduling list, here is an example
   for a Windows system:

   ```none
   Image document,Start time,End time
   C:\Users\user\Documents\image-1.jpg,2025-12-01 09:00:00,2025-12-01 09:04:59
   C:\Users\user\Documents\image-2.jpg,2025-12-01 09:05:00,2025-12-01 09:07:00
   ```

   Finally, save the CSV file; for example, as `schedule.csv`.

2. From the terminal, use:

   ```bash
   kronolapse ruta\a\cronograma.csv
   ```
      
### Development mode
Presentation files must be in JPG, PNG, or another image format supported by
[OpenCV](https://docs.opencv.org/4.x/db/deb/tutorial_display_image.html).

**Recommendation:** The start and end times of the schedule for each file should
not coincide to avoid overlapping of two simultaneous images.

1. Design a program as indicated above and from the terminal, use:

   ```bash
   python3 -m kronolapse ruta/a/cronograma.csv
   ```

2. For an automated demonstration, use:

   ```bash
   make run
   ```

3. A tests sequence is executed with:

   ```bash
   make tests
   ```

4. For more options, use:

   ```bash
   $ python3 -m kronolapse --help
   ```

## kronolapse flowchart

![](../misc/dgrm-flow/dgrm-kronolapse.jpg){ width=80% }

This flowchart was developed using [draw.io](https://www.draw.io/).

## Bugs
- On Linux operating systems, with 4K monitors using fractional scaling (GNOME
  desktop environment), the display is not shown in full screen.

## License
Kronolapse is open-source software distributed under the terms of the **GNU Public
License v3** (or later) included with the source code in the `LICENSE` file.

## About versioning
This project follows the guidelines set by [Semantic Versioning
2.0.0](https://semver.org/spec/v2.0.0.html).
