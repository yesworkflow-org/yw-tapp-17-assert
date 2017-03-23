
SCRIPT_BASE = simulate_data_collection
SCRIPT = $(SCRIPT_BASE).py

# make all --------------------------------------------------------------------
all: model graph run recon
#------------------------------------------------------------------------------

# make run --------------------------------------------------------------------
SCRIPT_ARGS = q55 --cutoff 12 --redundancy 1
SCRIPT_STDOUT = script_stdout.txt
SCRIPT_RUN_DIR = run
SCRIPT_RUN_CMD = python $(SCRIPT) $(SCRIPT_ARGS)

$(SCRIPT_STDOUT): $(SCRIPT)
	$(SCRIPT_RUN_CMD) > $(SCRIPT_STDOUT)

run: $(SCRIPT_STDOUT) 
#------------------------------------------------------------------------------

# make graph ------------------------------------------------------------------
YW_GRAPH_BASE = $(SCRIPT_BASE)_wf
YW_GRAPH_GV = $(YW_GRAPH_BASE).gv
YW_GRAPH_PNG = $(YW_GRAPH_BASE).png
YW_GRAPH_PDF = $(YW_GRAPH_BASE).pdf
YW_GRAPH_OPTIONS = -c graph.layout=TB -c graph.view=COMBINED
YW_GRAPHS = $(YW_GRAPH_GV) $(YW_GRAPH_PNG) $(YW_GRAPH_PDF)

$(YW_GRAPH_GV): $(SCRIPT)
	yw graph $(SCRIPT) $(YW_GRAPH_OPTIONS) > $(YW_GRAPH_GV)

.SUFFIXES:
.SUFFIXES: .gv .pdf .png
.gv.pdf:
	dot -Tpdf $*.gv -o $*.pdf
.gv.png:
	dot -Tpng $*.gv -o $*.png

graph: $(YW_GRAPHS)
#------------------------------------------------------------------------------

# make model ------------------------------------------------------------------
YW_EXTRACT_FACTS = $(SCRIPT_BASE)_extract.P
YW_MODEL_FACTS = $(SCRIPT_BASE)_model.P
YW_EXTRACT_OPTIONS = -c extract.factsfile=$(YW_EXTRACT_FACTS)
YW_MODEL_OPTIONS = -c model.factsfile=$(YW_MODEL_FACTS)
YW_FACTS = $(YW_EXTRACT_FACTS) $(YW_MODEL_FACTS)

$(YW_FACTS): $(SCRIPT)
	yw model $(SCRIPT) $(YW_EXTRACT_OPTIONS) $(YW_MODEL_OPTIONS)

model: $(YW_FACTS)
#------------------------------------------------------------------------------

# make recon ------------------------------------------------------------------
RECON_FACTS = $(SCRIPT_BASE)_recon.P
RECON_OPTIONS = -c recon.factsfile=$(RECON_FACTS) -c recon.rundir=.

$(RECON_FACTS): $(SCRIPT_STDOUT)
	yw recon $(SCRIPT) $(RECON_OPTIONS)

recon: $(RECON_FACTS)
#------------------------------------------------------------------------------


# make clean ------------------------------------------------------------------
clean:
	rm -rf $(SCRIPT_STDOUT) $(SCRIPT_RUN_DIR) $(YW_GRAPHS) $(YW_FACTS) $(RECON_FACTS)
#------------------------------------------------------------------------------
