#!/usr/bin/env bash -l

export SCRIPT_BASE=$1
export ASSERTED_DEPENDENCIES=${SCRIPT_BASE}_assertions
export INFERRED_DEPENDENCIES=${SCRIPT_BASE}_inferred

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$ASSERTED_DEPENDENCIES'].
['$INFERRED_DEPENDENCIES'].
['rules/general_rules'].
['rules/assertion_rules'].

%set_prolog_flag(unknown, fail).

rule_banner('excess_workflow_output_input_dependency(Workflow, Output, Input).').
printall(excess_workflow_output_input_dependency(_,_,_)).

END_XSB_STDIN
