MININET = mininet/*.py
TEST = mininet/test/*.py
EXAMPLES = examples/*.py
BIN = bin/mn
PYSRC = $(MININET) $(TEST) $(EXAMPLES) $(BIN)
MNEXEC = mnexec
P8IGN = E251,E201,E302,E202

all: codecheck test

clean:
	rm -rf build dist *.egg-info *.pyc $(MNEXEC)

codecheck: $(PYSRC)
	-echo "Running code check"
	pyflakes $(PYSRC)
	pylint --rcfile=.pylint $(PYSRC)
	pep8 --repeat --ignore=$(P8IGN) $(PYSRC)

errcheck: $(PYSRC)
	-echo "Running check for errors only"
	pyflakes $(PYSRC)
	pylint -E --rcfile=.pylint $(PYSRC)

test: $(MININET) $(TEST)
	-echo "Running tests"
	mininet/test/test_nets.py

install: $(MNEXEC)
	install $(MNEXEC) /usr/local/bin/
	python setup.py install

develop: $(MNEXEC)
	install $(MNEXEC) /usr/local/bin/
	python setup.py develop

doc:
	doxygen doxygen.cfg

