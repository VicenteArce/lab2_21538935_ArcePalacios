:- module(tda_chatbot_21538935_ArcePalacios, [chatbot/6, chatbot2/6, getChatbotIdChatbot/2, getNameChatbot/2, getWelcomeMessageChatbot/2, getStartFlowIdChatbot/2, getFlowsChatbot/2, chatbotAddFlow/3, getIdsFlows/2, addFlow/3]).

:- use_module(tda_option_21538935_ArcePalacios).
:- use_module(tda_flow_21538935_ArcePalacios).



%-------------Constructores-----------
% Meta primaria: chatbot/6
% Metas secundarias: addFlow/3
% Descripción: predicado que representa un chatbot, permite la verificación de que todos los flujos sean distintos
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X Chatbot
chatbot(ChatbotId, Name, WelcomeMessage, StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage, StartFlowId, FlowOut]):-
    addFlow(Flows,[], FlowOut).

% Meta primaria: chatbot2/6
% Metas secundarias: addFlow/3
% Descripcion: predicado que representa un chatbot, no verifica los id de los flujos
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X Chatbot
chatbot2(ChatbotId, Name, WelcomeMessage, StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage, StartFlowId, Flows]).

%-----------Selectores----------

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


%-----------Modificadores------

% Meta Primaria: chatbotAddFlow/2
% Metas secundarias: getIdFlow/2, getFlowsChatbot/2, getIdsFlows/2, member/2, getChatbotIdChatbot/2, getNameChatbot/2, getWelcomeMessageChatbot/2
%					 getStartFlowIdChatbot/2, getFlowsChatbot/2, chatbot2/2
% Descripcion: Predicado que permite consultar los Flows de un chatbot
% Dominio: Chatbot X FLow X Chatbot

% Caso 1: Si el id del flow no es parte de ningun flow ya agregado, entonces agrega el flow al chatbot
chatbotAddFlow(ChatbotIn, Flow, ChatbotOut):-
    getIdFlow(Flow, FlowId),
    getFlowsChatbot(ChatbotIn, Flows),
    getIdsFlows(Flows, IdsFlows),
    \+ member(FlowId, IdsFlows),
    getChatbotIdChatbot(ChatbotIn, ChatbotIdOut),
    getNameChatbot(ChatbotIn, NameOut),
    getWelcomeMessageChatbot(ChatbotIn, WelcomeMessageOut),
    getStartFlowIdChatbot(ChatbotIn, StartFlowIdOut),
    getFlowsChatbot(ChatbotIn, FlowsOut),
    chatbot2(ChatbotIdOut, NameOut, WelcomeMessageOut, StartFlowIdOut, [Flow|FlowsOut], ChatbotOut).

%Caso 2: Si el id del flow es parte de ningun flow ya agregado, entonces no lo agrega al flow del chatbot
chatbotAddFlow(ChatbotIn, Flow, ChatbotOut):-
    getIdFlow(Flow, FlowId),
    getFlowsChatbot(ChatbotIn, Flows),
    getIdsFlows(Flows, IdsFlows),
    member(FlowId, IdsFlows),
    getChatbotIdChatbot(ChatbotIn, ChatbotIdOut),
    getNameChatbot(ChatbotIn, NameOut),
    getWelcomeMessageChatbot(ChatbotIn, WelcomeMessageOut),
    getStartFlowIdChatbot(ChatbotIn, StartFlowIdOut),
    getFlowsChatbot(ChatbotIn, FlowsOut),
    chatbot2(ChatbotIdOut, NameOut, WelcomeMessageOut, StartFlowIdOut, FlowsOut, ChatbotOut).


%----------Otras Funciones--------
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

% Caso 2: El id del flujo se encuentra en los id de los flujos ya agregados, por ende no se agrega el flow a Acc
addFlow([Flow|Flows], Acc, AccOut):-
    getIdFlow(Flow, Id),
    getIdsFlows(Acc, ListaIds),
    member(Id, ListaIds),
    addFlow(Flows, Acc, AccOut).
