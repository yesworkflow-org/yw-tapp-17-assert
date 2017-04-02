% dlv2gv - turn ugly dlv models into pretty GV graphs .. 
%
% For any example/1 folder, run DLV rules idb.dlv over facts idb.dlv,
% ... generating a GV output file (a quick and dirty hack)

:- discontiguous(dot_node/2).  % for styling GV-nodes
:- discontiguous(dot_edge/2).  % .. and GV-edges

% EXAMPLE FOLDERS with edb.dlv and idb.dlv files :
% example('pm').   % Anand's toy process model
example('c3c4'). % DataONE C3C4 example (based on Yang's YW annotations)
example('simulate_data_collection').

% RUN EXAMPLE in folder F
go(F) :-
    example(F),
    format('*** RUNNING example in folder >>> examples/~w/ <<<...~n',[F]),
    run_dlv(F),
    format('*** READING model file...~n'),
    read_model(F,Xs),
    sort(Xs,Ys), 
    format('*** GENERATING Graphviz file ...~n'),
    gv_start(F),
    gv_write_model(Ys),
    gv_stop,
    format('*** DONE.~n~n').

% run all examples
go :- go(_), fail ; true. 

% RUN DLV
run_dlv(F) :-
    format(
	atom(Cmd),
	'dlv -silent examples/~w/edb.dlv examples/~w/idb.dlv > examples/~w/model.dlv; echo \'.\' >> examples/~w/model.dlv',
	[F, F, F, F] ),
    shell(Cmd, ExitCode),
    (ExitCode = 0 -> true
    ; format('DLV ERROR: ~w', [ExitCode])
    ).

% READ DLV model output
read_model(F,Xs) :-
    format(atom(File), 'examples/~w/model.dlv',[F]),
    see(File),
    read(T),
    arg(1,T,V),
    args_to_list(V,Xs),
    seen.

% picking apart the big DLV model term
args_to_list(A,[A]) :-
    A \= (_,_).
args_to_list((A,As),[A|Xs]) :-
    args_to_list(As,Xs).

% GENERATE Graphviz from model
gv_write_model(Xs) :-
    member(X,Xs),
    format('~p',[X]),  % try ~w for debugging
    fail
    ;
    true.

% portray/1 intercept predicate for pretty-printing (GV-reformatted) output
portray(viz_node(L,N))  :-
    !,
    gv_node(L,N).
portray(viz_edge(L,F,T))  :-
    !,
    gv_edge(F,L,T).
portray(_).


% OPEN GV output file and write GV HEADER
gv_start(F):-
    format(atom(File), 'examples/~w/g.gv',[F]),
    tell(File),
    format('digraph {~n'),
    format('rankdir=TB~n'),
    format('node [shape=box,fontname=Helvetica,fontsize=14,height=0,width=0]~n'),
    format('edge [fontname=Helvetica,fontsize=12]~n').

% CLOSE GV output file (after writing FOOTER)
gv_stop:-
    format('}'),
    told.

%%% STYLESHEET stuff

% Anand's PM nodes
dot_node(process,'style="filled" fontname=Courier fillcolor="#CCFFCC"').
dot_node(artifact,'style="filled,rounded" fillcolor="#FFFFCC"').
dot_node(agent,'shape=octagon style=filled,fillcolor="#CCCCFF"').

% Anand's PM edges
dot_edge(read,'color="#FF0000"').  
dot_edge(write,'color="#00BB00"').  
dot_edge(wasControlledBy,'color="#0000BB" dir=none').  

% YW nodes
dot_node(source,'style="filled,rounded" fillcolor="#EEEEFF"').
dot_node(sink,'style="filled,rounded" fillcolor="#FFEEEE"').
dot_node(step,'style="filled" fontname=Courier fillcolor="#CCFFCC"').
dot_node(data,'style="filled,rounded" fillcolor="#FFFFCC"').

% YW edges
dot_edge(default,'color="#000000"').  
dot_edge(delta,'color="#888888" style=dashed constraint=true penwidth=0.2').  
dot_edge(upEqv,'constraint=true color="#FF0000" dir=none penwidth=3').  

% Write styled GV node
gv_node(L, N) :-
    !,
    dot_node(L, DotCode),
    format('"~w"[~w,label="~w"]~n', [N,DotCode,N]).

% Write styled GV node
gv_edge(From, Label, To):-
    !,
    dot_edge(Label, DotCode),
    format('~w -> ~w [~w]~n', [From,To,DotCode]).


