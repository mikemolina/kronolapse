# -*- Makefile -*-
#
# Makefile for build, install, test package kronolapse

# Check virtualenv package
PYTHON ?= /usr/bin/env python3
PIP ?= pip3
MOD_VENV := $(shell $(PYTHON) -m virtualenv --version > /dev/null 2>&1; echo $$?)

# Define variables for enviroment virtual
VENVDIR ?= venv
VENVACTIVATE := $(VENVDIR)/bin/activate
VENVSCRIPT := $(VENVDIR)/bin/kronolapse
# Windows
#VENVACTIVATE = $(VENVDIR)\Scripts\activate.bat
ifeq ($(MOD_VENV),0)
PYTHON = $(VENVDIR)/bin/python
PIP = $(VENVDIR)/bin/pip
endif

# Define variables for to compile documentation
SPHINXBUILD = $(VENVDIR)/bin/sphinx-build
ABOUT_RST = docs/source/LEAME_rst.md


all:
	@echo "==== Makefile for build Kronolapse package ===="
	@echo "Prepare an enviroment virtual:"
	@echo "  make prepare-venv"
	@echo "Build source distribution and wheel:"
	@echo "  make build"
	@echo "Build source distribution only:"
	@echo "  make build_sdist"
	@echo "Build wheel distribution only:"
	@echo "  make build_wheel"
	@echo "Installation in editable mode:"
	@echo "  make install"
	@echo "Test module and script:"
	@echo "  make tests"
	@echo "Run demo (modules screeninfo opencv-python should are installed):"
	@echo "  make run"
	@echo "Prepare Sphinx package for to build documentation:"
	@echo "  make prepare-sphinx"
	@echo "Build documentation format HTML:"
	@echo "  make html"
	@echo "Build documentation format PDF (requires TeX Live or MiKTeX):"
	@echo "  make pdf"
	@echo "Build documentation format manpage (for Unix-like OS):"
	@echo "  make man"
	@echo "Check code with flake8 (requires Flake8): level minimal"
	@echo "  make linter-minimal "
	@echo "Check code with flake8 (requires Flake8): level strict"
	@echo "  make linter-strict "
	@echo "Actual Python interpreter executable:"
	@echo "  PYTHON = $(PYTHON)"

prepare-venv:
	@echo "Check virtual environment ..."
ifeq ($(MOD_VENV),0)
	@if ! [ -d $(VENVDIR) ]; then \
	  virtualenv $(VENVDIR); \
	  echo "Virtual environment installed."; \
	  echo "Installing dependencies ..."; \
	  $(PIP) install --upgrade pip; \
	  $(PIP) install -r requirements-dev.txt; \
	  echo "Installation complete. Activate virtual environment (only if necessary):"; \
	  echo "  . $(VENVACTIVATE)"; \
	else \
	  echo "Virtual environment already exists."; \
	fi
else
	@if ! [ -d $(VENVDIR) ]; then \
	  echo "Is recommended install virtualenv package:"; \
	  echo "  pip install --user virtualenv"; \
	else \
	  echo "Virtual environment already exists."; \
	fi
endif

$(VENVACTIVATE): prepare-venv

venv: $(VENVACTIVATE)

build: clean-build venv
	@echo "Building source and wheel distributions ..."
	$(PYTHON) -m build

build_sdist: clean-build venv
	@echo "Building source distribution ..."
	$(PYTHON) -m build --sdist

build_wheel: clean-build venv
	@echo "Building wheel distribution ..."
	$(PYTHON) -m build --wheel

install: venv
	@if ! [ -f $(VENVSCRIPT) ]; then \
	  echo "Installation in editable mode (for development) ..."; \
	  $(PIP) install -e .; \
	else \
	  echo "Package 'kronolapse' already installed."; \
	fi

$(VENVSCRIPT): install

script: $(VENVSCRIPT)

run: clean-test venv script
	$(PYTHON) tests/gen_demo_files.py
	$(PYTHON) -m kronolapse schedule_test.csv

tests: venv script
	$(PYTHON) -m pytest tests/

uninstall: venv
	@echo "Uninstallation in editable mode (for development) ..."
	$(PIP) uninstall -y kronolapse

$(ABOUT_RST): LEAME.md
	@echo "Build readme.rst ..."
	@cat $< | \
	sed -e '/\# KRoNoLAPSE/,/^<video/c \# KRoNoLAPSE\ ' | \
	sed -e '/^<p align/,/^<\/p>$$/c \
	```{image} _static/dgrm-kronolapse.jpg\ \
	:width: 80%\ \
	:align: center\ \
	```' > $@

prepare-sphinx: prepare-venv script
	@if ! [ -f $(SPHINXBUILD) ]; then \
	  echo "Installing sphinx for build documentation ..."; \
	  $(PIP) install --upgrade pip; \
	  $(PIP) install -r requirements-doc.txt; \
	else \
	  echo "Package 'sphinx' already installed."; \
	fi

html: prepare-sphinx $(ABOUT_RST)
	. $(VENVACTIVATE); \
	$(MAKE) -C docs html

man: prepare-sphinx
	. $(VENVACTIVATE); \
	$(MAKE) -C docs man

pdf: prepare-sphinx $(ABOUT_RST)
	. $(VENVACTIVATE); \
	$(MAKE) -C docs latexpdf

linter-minimal:
	@for d in kronolapse tests docs/source; do \
	  echo "Check code into $$d ..."; \
	  flake8 --max-line-length 90 $$d; \
	done

linter-strict:
	@for d in kronolapse tests docs/source; do \
	  echo "Check code into $$d ..."; \
	  flake8 --count --max-complexity=10 --max-line-length=90 --show-source --statistics $$d; \
	done

clean-build:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -fR build/ dist/ *.egg-info/

clean-test:
	rm -f fGauss.jpg RGBSquare.jpg Rings.jpg schedule_test.csv
	rm -fR .pytest_cache

clean-doc:
	rm -f $(ABOUT_RST)
	$(MAKE) -C docs clean

clean: clean-build clean-test clean-doc

maintainerclean: clean
	find . -type f -name "*~" -print0 | xargs -0 rm -f
	@if [ -d $(VENVDIR) ]; then \
	  echo "rm -fR $(VENVDIR)/"; \
	  rm -fR $(VENVDIR)/; \
	fi

.PHONY: tests
