#!/usr/bin/env bash -l

export SCRIPT_BASE=$1
export VIEW_FACTS=${SCRIPT_BASE}_views

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$VIEW_FACTS'].
['rules/general_rules'].
['rules/simple_view_rules'].

%set_prolog_flag(unknown, fail).

rule_banner('data(Data)').
printall(data(_)).

rule_banner('step(Step)').
printall(step(_)).

rule_banner('workflow_in(Data)').
printall(workflow_in(_)).

rule_banner('workflow_out(Data)').
printall(workflow_out(_)).

rule_banner('step_in(Data, Step)').
printall(step_in(_, _)).

rule_banner('step_out(Step, Data)').
printall(step_out(_, _)).

rule_banner('flow(From, To)').
printall(flow(_, _)).

END_XSB_STDIN
