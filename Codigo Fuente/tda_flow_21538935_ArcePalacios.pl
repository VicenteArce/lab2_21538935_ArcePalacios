:- consult('tda_option_21538935_ArcePalacios.pl').

%---------------------------------------TDA FLOW---------------------------------------

%---------------------------------------Constructores---------------------------------------
%---------------------------------------RF3---------------------------------------
% Meta Primaria: flow/4
% Metas Secundarias: addOption/3
% Descripcion: Predicado que representa a un flujo, se encarga de verificar que las opciones introducidas no se repitan en base al id y lo introuce a un flujo
% Dominio: Id X NameMessage X Option X Flow
flow(Id, NameMessage, Option, [Id, NameMessage, OptionOut]):-
    addOption(Option, [], OptionOut).

% Meta Primaria: flow2/4
% Metas secundarias: -
% Descripcion: Predicado que representa un flujo, no verifica si las opciones se repiten
% Dominio: Id X NameMessage X Option X Flow
flow2(Id, NameMessage, Option, [Id, NameMessage, Option]).
   
%---------------------------------------Selectores---------------------------------------

% Meta Primaria: getIdFlow/2
% Metas secundarias: -
% Descripcion: Predicado que permite consultar el id de un flujo
% Dominio: Id X FLow
getIdFlow([Id|_], Id).

% Meta Primaria: getNameMessageFlow/2
% Metas secundarias: -
% Descripcion: Predicado que permite consultar el NameMessage de un flujo
% Dominio: NameMessage X FLow
getNameMessageFlow([_,NameMessage|_], NameMessage).

% Meta Primaria: getOptionsFlow/2
% Metas secundarias:-
% Descripcion: Predicado que permite consultar el id de un flujo
% Dominio: Id X FLow
getOptionsFlow([_,_,Options], Options).

%---------------------------------------Modificadores---------------------------------------
%---------------------------------------RF4---------------------------------------
% Meta Primaria: flowAddOption/3
% Metas Secundarias: getCodeOption/2, getOptionsFlow/2, getCodesOptions/2, member/2, getNameMessageFlow/2, getIdFlow/2, flow2/4
% Descripcion: predicado que permite introducir una opcion a un flujo sin que se repita en base a su id
% Dominio: Flujo X Option X Flujo

%Caso1: La opcion a introducir no esta introucida en las opciones(Se basa en los codigos de las opciones al momento de comparar) 
flowAddOption(FlowIn, Option, FlowOut):-
    getCodeOption(Option, Code),
    getOptionsFlow(FlowIn, Options),
    getCodesOptions(Options, CodeOptions),
    \+ member(Code,CodeOptions),
    getNameMessageFlow(FlowIn, NameMessage),
    getIdFlow(FlowIn, Id),
    flow2(Id, NameMessage, [Option|Options], FlowOut).

%Caso2: El codigo de la opcion a introducir ya esta introucida en las opciones de flujo (construye el flow sin esa opcion)
flowAddOption(FlowIn, Option, FlowOut):-
    getCodeOption(Option, Code),
    getOptionsFlow(FlowIn, Options),
    getCodesOptions(Options, CodeOptions),
    member(Code,CodeOptions),
    getNameMessageFlow(FlowIn, NameMessage),
    getIdFlow(FlowIn, Id),
    flow2(Id, NameMessage, Options, FlowOut).

%---------------------------------------Otros Predicados---------------------------------------
    
% Metas Primarias: getCodesOptions/2
% Metas Secundarias: -
% Descripcion: Predicado que representa los primeros elementos en una lista de listas (En este caso una lista de opciones)
% Dominio: Lista X Lista
getCodesOptions([], []).
getCodesOptions([[PrimerElemento|_]|Resto], [PrimerElemento|ListaPrimeros]) :-
    getCodesOptions(Resto, ListaPrimeros).



% Meta primaria: addOption/3
% Metas secundarias: getCodeOption/2, getCodesOptions/2, member/2
% Descripcion: Predicado que sirve para introducir opciones a una lista acumuladora sin que los codigos se repitan
% Dominio: Lista X Lista X Lista

%Caso Base: Al no haber opciones, la consulta entrega la lista de opciones acumuladas
addOption([], Acc, Acc).

%Caso 1: el elemento codigo de la opcion no pertenece a la lista de codigos de opciones acumuladas
% 		por ende lo agrega y llama nuevamente a addOption/3 agregando la opcion a la lista Acc.
addOption([Option|Options], Acc, AccOut):-
    getCodeOption(Option, Code),
	getCodesOptions(Acc, ListaCodigosAcc),
  	\+ member(Code, ListaCodigosAcc),
    addOption(Options, [Option|Acc], AccOut).

%Caso 2: el elemento codigo de la opcion pertenece a la lista de codigos de opciones acumuladas
% 		por ende no lo agrega y llama nuevamente a addOption/3 pero sin "modificar" la lista de Acc.
addOption([Option|Options], Acc, AccOut):-
    getCodeOption(Option, Code),
	getCodesOptions(Acc, ListaCodigosAcc),
  	member(Code, ListaCodigosAcc),
    addOption(Options, Acc, AccOut).
