

USER_SCRIPT = simulate_data_collection.py
USER_SCRIPT_ARGS = q55 --cutoff 12 --redundancy 1
USER_SCRIPT_STDOUT = user_script_stdout.txt
USER_SCRIPT_RUN_DIR = run

SCRIPT_RUN_CMD = python $(USER_SCRIPT) $(USER_SCRIPT_ARGS)

all: run

run: $(USER_SCRIPT_STDOUT)

$(USER_SCRIPT_STDOUT): $(USER_SCRIPT)
	$(SCRIPT_RUN_CMD) > $(USER_SCRIPT_STDOUT)

clean:
	rm -rf $(USER_SCRIPT_STDOUT) $(USER_SCRIPT_RUN_DIR)