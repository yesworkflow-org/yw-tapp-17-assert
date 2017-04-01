#!/usr/bin/env bash -l

export SCRIPT_BASE=$1
export VIEW_FACTS=${SCRIPT_BASE}_views

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$VIEW_FACTS'].
['rules/general_rules'].
['rules/simple_view_rules'].

%set_prolog_flag(unknown, fail).

rule_banner('input(WorkflowInput).').
printall(input(_)).

END_XSB_STDIN
