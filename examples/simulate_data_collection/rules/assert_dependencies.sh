#!/usr/bin/env bash -l

export SCRIPT_BASE=$1
export MODEL_VIEWS=${SCRIPT_BASE}_views
export ASSERTED_DEPENDENCIES=${SCRIPT_BASE}_assertions
export INFERRED_DEPENDENCIES=${SCRIPT_BASE}_inferred

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$MODEL_VIEWS'].
['$ASSERTED_DEPENDENCIES'].
['$INFERRED_DEPENDENCIES'].
['rules/inference_rules'].
['rules/general_rules'].
['rules/yw_rules'].
['rules/assertion_rules'].

%set_prolog_flag(unknown, fail).

%rule_banner('excess_workflow_output_input_dependency(Workflow, Output, Input).').
%printall(excess_workflow_output_input_dependency(_,_,_)).

%rule_banner('missing_workflow_output_input_dependency(Workflow, Output, Input).').
%printall(missing_workflow_output_input_dependency(_,_,_)).

rule_banner('dependency_unsupported_by_dataflow_paths(WorkflowName, WorkflowOutput, Dependency).').
printall(dependency_unsupported_by_dataflow_paths(_, _, _)).

END_XSB_STDIN
