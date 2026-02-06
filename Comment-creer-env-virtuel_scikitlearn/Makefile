VENV := $(HOME)/Environnement_virtuel
PYTHON := python3
PIP := $(VENV)/bin/pip

.PHONY = install

install:
	$(PYTHON) -m venv $(VENV)
	$(PIP) install scikit-learn matplotlib
	$(PIP) install jupyterlab numpy
	echo 'source bin/activate' > $(VENV)/start.sh
	echo 'jupyter-lab' >> $(VENV)/start.sh
	chmod +x $(VENV)/start.sh
	


