

SCRIPT_BASE = simulate_data_collection
SCRIPT = $(SCRIPT_BASE).py
SCRIPT_ARGS = q55 --cutoff 12 --redundancy 1
SCRIPT_STDOUT = script_stdout.txt
SCRIPT_RUN_DIR = run

YW_GRAPH_OPTIONS = -c extract.language=PYTHON -c graph.layout=TB -c graph.view=COMBINED

WORKFLOW_GRAPH_BASE = $(SCRIPT_BASE)_wf
WORKFLOW_GRAPH_DOT = $(WORKFLOW_GRAPH_BASE).gv
WORKFLOW_GRAPH_PNG = $(WORKFLOW_GRAPH_BASE).png
WORKFLOW_GRAPH_PDF = $(WORKFLOW_GRAPH_BASE).pdf
WORKFLOW_GRAPHS = $(WORKFLOW_GRAPH_DOT) $(WORKFLOW_GRAPH_PNG) $(WORKFLOW_GRAPH_PDF)

SCRIPT_RUN_CMD = python $(SCRIPT) $(SCRIPT_ARGS)

.SUFFIXES:
.SUFFIXES: .gv .pdf .png

.gv.pdf:
	dot -Tpdf $*.gv -o $*.pdf

.gv.png:
	dot -Tpng $*.gv -o $*.png

all: run graphs

run: $(SCRIPT_STDOUT) 

graphs: $(WORKFLOW_GRAPHS)

$(SCRIPT_STDOUT): $(SCRIPT)
	$(SCRIPT_RUN_CMD) > $(SCRIPT_STDOUT)

$(WORKFLOW_GRAPH_DOT): $(SCRIPT)
	yw graph $(SCRIPT) $(YW_GRAPH_OPTIONS) > $(WORKFLOW_GRAPH_DOT)

clean:
	rm -rf $(SCRIPT_STDOUT) $(SCRIPT_RUN_DIR) $(WORKFLOW_GRAPHS)