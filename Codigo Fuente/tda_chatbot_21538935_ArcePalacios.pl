:- consult('tda_option_21538935_ArcePalacios.pl').
:- consult('tda_flow_21538935_ArcePalacios.pl').

%---------------------------------------TDA Chatbot---------------------------------------

%---------------------------------------Constructores---------------------------------------
%---------------------------------------RF5---------------------------------------
% Meta primaria: chatbot/6
% Metas secundarias: addFlow/3
% Descripcion: predicado que representa un chatbot, permite la verificacion de que todos los flujos sean distintos
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X Chatbot
chatbot(ChatbotId, Name, WelcomeMessage, StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage, StartFlowId, FlowOut]):-
    addFlow(Flows,[], FlowOut).

% Meta primaria: chatbot2/6
% Metas secundarias: addFlow/3
% Descripcion: predicado que representa un chatbot, no verifica los id de los flujos
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X Chatbot
chatbot2(ChatbotId, Name, WelcomeMessage, StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage, StartFlowId, Flows]).

%---------------------------------------Selectores---------------------------------------

% Meta Primaria: getChatbotIdChatbot/2
% Metas secundarias: -
% Descripcion: Predicado que permite consultar el ChatbotId de un chatbot
% Dominio: Chatbot X ChatbotId
getChatbotIdChatbot([ChatbotId|_], ChatbotId).

% Meta Primaria: getNameChatbot/2
% Metas secundarias: -
% Descripcion: Predicado que permite consultar el Name de un chatbot
% Dominio: Chatbot X Name
getNameChatbot([_,Name|_], Name).


% Meta Primaria: getWelcomeMessageChatbot/2
% Metas secundarias: -
% Descripcion: Predicado que permite consultar el WelcomeMessage de un chatbot
% Dominio: Chatbot X WelcomeMessage
getWelcomeMessageChatbot([_,_,WelcomeMessage|_], WelcomeMessage).

% Meta Primaria: getStartFlowIdChatbot/2
% Metas secundarias: -
% Descripcion: Predicado que permite consultar el StartFlowId de un chatbot
% Dominio: Chatbot X StartFlowId
getStartFlowIdChatbot([_,_,_,StartFlowId|_], StartFlowId).

% Meta Primaria: getFlowsChatbot/2
% Metas secundarias: chatbot2/6
% Descripcion: Predicado que permite consultar los Flows de un chatbot
% Dominio: Chatbot X Flows
getFlowsChatbot([_,_,_,_,Flows], Flows).


%---------------------------------------Modificadores---------------------------------------
%---------------------------------------RF6---------------------------------------
% Meta Primaria: chatbotAddFlow/2
% Metas secundarias: getIdFlow/2, getFlowsChatbot/2, getIdsFlows/2, member/2, getChatbotIdChatbot/2, getNameChatbot/2, getWelcomeMessageChatbot/2
%					 getStartFlowIdChatbot/2, getFlowsChatbot/2, chatbot2/2
% Descripcion: Predicado que permite ingresar un flujo a un chatbot solo si el id de este no se encuentra en la lista de flujos del chatbot. Si ya estaba en el chatbot el flujo, entonces devuelve false
% Dominio: Chatbot X FLow X Chatbot
% Recursivo por predicado appendFinal

% Si el id del flow no es parte de ningun flow ya agregado, entonces agrega el flow al chatbot, de lo contario arrojara false
chatbotAddFlow(ChatbotIn, Flow, ChatbotOut):-
    getIdFlow(Flow, FlowId),
    getFlowsChatbot(ChatbotIn, Flows),
    getIdsFlows(Flows, IdsFlows),
    \+ member(FlowId, IdsFlows),
    getChatbotIdChatbot(ChatbotIn, ChatbotIdOut),
    getNameChatbot(ChatbotIn, NameOut),
    getWelcomeMessageChatbot(ChatbotIn, WelcomeMessageOut),
    getStartFlowIdChatbot(ChatbotIn, StartFlowIdOut),
    getFlowsChatbot(ChatbotIn, FlowsAux),
    appendFinal(Flow, FlowsAux, FlowsOut),
    chatbot2(ChatbotIdOut, NameOut, WelcomeMessageOut, StartFlowIdOut, FlowsOut, ChatbotOut).


%---------------------------------------Otros Predicados---------------------------------------
% Metas Primarias: getIdsFlows/2
% Metas Secundarias: -
% Descripcion: Predicado que representa los primeros elementos en una lista de listas (En este caso de una lista de flujos)
% Dominio: Lista X Lista
getIdsFlows([], []).
getIdsFlows([[PrimerElemento|_]|Resto], [PrimerElemento|ListaPrimeros]) :-
    getIdsFlows(Resto, ListaPrimeros).


% Meta primaria: addFlow/3
% Metas secundarias: getIdFlow/2, getIdsFlows/2, member/2
% Descripcion: Predicado que sirve para introducir flujos a una lista acumuladora sin que los codigos se repitan
% Dominio: Lista X Lista X Lista

% Caso Base: Al no haber flujos, la consulta entrega la lista de flujos acumuladas
addFlow([], Acc, Acc).

% Caso 1: El id del flujo no se encuentra en los id de los flujos ya agregados, por ende se agrega el flow a Acc
addFlow([Flow|Flows], Acc, AccOut):-
    getIdFlow(Flow, Id),
    getIdsFlows(Acc, ListaIds),
    \+ member(Id, ListaIds),
    addFlow(Flows, [Flow|Acc], AccOut).


% Meta primaria: appendFinal/3
% Metas secundarias: -
% Descripcion: Predicado que sirve para introducir un flujo a una lista de manera recursiva al final de la misma
% Dominio: Elemento X Lista X Lista
appendFinal(Elem, [], [Elem]).
appendFinal(Elem, [Cabecera|Cola], [Cabecera|NuevaCola]) :-
    appendFinal(Elem, Cola, NuevaCola).