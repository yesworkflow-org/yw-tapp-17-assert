#!/usr/bin/env bash -l

export SCRIPT_BASE=$1
export EXTRACT_FACTS=${SCRIPT_BASE}_extract
export MODEL_FACTS=${SCRIPT_BASE}_model
export MODEL_VIEWS=${SCRIPT_BASE}_views

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$EXTRACT_FACTS'].
['$MODEL_FACTS'].
['$MODEL_VIEWS'].
['rules/general_rules'].
['rules/yw_rules'].
['rules/inference_rules'].

%set_prolog_flag(unknown, fail).

%rule_banner('workflow_output_depends_on_input(Workflow, Output, Input).').
%printall(workflow_output_depends_on_input(_,_,_)).

%rule_banner('workflow_output_independent_of_input(Workflow, Output, Input).').
%printall(workflow_output_independent_of_input(_,_,_)).

END_XSB_STDIN
