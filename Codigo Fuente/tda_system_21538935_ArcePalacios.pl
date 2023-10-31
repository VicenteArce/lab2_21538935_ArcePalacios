:- module(tda_system_21538935_ArcePalacios, [system2/9, getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2, getRegisterUsersSystem/2, getLogUsersSystem/2,
                                            getActualChatbotCodeLinkSystem/2, getActualFlowCodeLinkSystem/2, isEmpty/1, len/2, getChatbotIdsChatbot/2, addChatbot/3]).

:- use_module(tda_option_21538935_ArcePalacios).
:- use_module(tda_flow_21538935_ArcePalacios).
:- use_module(tda_chatbot_21538935_ArcePalacios).


%--------Constructor---------
% Constructor system se encuentra en el Main RF7

% Meta Primaria: system2/9
% Metas Secundarias: -
% Descripcion: Predicado que representa a un system, para constuir el sistema, se requieren todos los parametros del sistema
% Dominio: Name X InitialChatbotCodeLink X Chatbots X ChatHistory X RegisterUsers X LogUsers X ActualChatbotCodeLink X ActualFlowCodeLink X System

system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink,
        [Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink]).

%-------Selectores--------

% Meta Primaria: getNameSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el nombre de un sistema
% Dominio: System X Name
getNameSystem([Name|_], Name).


% Meta Primaria: getInitialChatbotCodeLinkSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el InitialChatbotCodeLink de un sistema
% Dominio: System X InitialChatbotCodeLink
getInitialChatbotCodeLinkSystem([_, InitialChatbotCodeLink|_], InitialChatbotCodeLink).


% Meta Primaria: getChatbotsSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene los chatbots de un sistema
% Dominio: System X Chatbots
getChatbotsSystem([_, _, Chatbots|_], Chatbots).


% Meta Primaria: getChatHistorySystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el ChatHistory de un sistema
% Dominio: System X ChatHistory
getChatHistorySystem([_, _, _, ChatHistory|_], ChatHistory).


% Meta Primaria: getRegisterUsersSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene la lista de usuarios registrados de un sistema
% Dominio: System X RegisterUsers
getRegisterUsersSystem([_, _, _, _, RegisterUsers|_], RegisterUsers).


% Meta Primaria: getLogUsersSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene los usuarios logueados de un sistema
% Dominio: System X LogUsers
getLogUsersSystem([_, _, _, _, _, LogUsers|_], LogUsers).

% Meta Primaria: getActualChatbotCodeLinkSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el ActualChatbotCodeLink de un sistema
% Dominio: System X Name
getActualChatbotCodeLinkSystem([_, _, _, _, _, _, ActualChatbotCodeLink|_], ActualChatbotCodeLink).

% Meta Primaria: getActualFlowCodeLinkSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el ActualFlowCodeLink de un sistema
% Dominio: System X Name
getActualFlowCodeLinkSystem([_, _, _, _, _, _, _, ActualFlowCodeLink], ActualFlowCodeLink).

%---------Modificadores-------
% systemAddChatbot se encuentra en el Main RF8

% systemAddUser se encuentra en el Main RF9

% systemLogin se encuentra en el Main RF10


% systemLogout se encuentra en el Main RF11




%-------Otras funciones-----
% Meta Primaria: len/2
% Metas Secundarias: -
% Descripcion: Predicado que cuenta la cantidad de elementos de un a lista
% Dominio: Lista X Acumulador(integer)
len([],0).
len([_|T],N) :- len(T,X), N is X+1.

% Meta Primaria: isEmpty/1
% Metas Secundarias: -
% Descripcion: Predicado se encarga de verificar si una lista esta vacia o no
% Dominio: Lista
isEmpty(L) :-
    len(L,X),
    X=:=0.


% Meta Primaria: getChatbotIdsChatbot/2
% Metas Secundarias: -
% Descripcion: Predicado se encarga de armar una nueva lista con los primeros elementos de una lista dada
% Dominio: Lista X NuevaLista
getChatbotIdsChatbot([], []).
getChatbotIdsChatbot([[PrimerElemento|_]|Resto], [PrimerElemento|ListaPrimeros]) :-
    getChatbotIdsChatbot(Resto, ListaPrimeros).


% Meta Primaria: addChatbot/3
% Metas Secundarias: getChatbotIdChatbot/2, getChatbotIdsChatbot/2, member/2
% Descripcion: Predicado que, por medio de la recursividad, crea una nueva lista con elementos en los cuales no se repitan los ids de los chatbots.
% Dominio: Lista X Lista X Lista

% Caso1: Si la primera lista esta vacia, entonces la lista de chatbots sin repetir estara en Acc
addChatbot([], Acc, Acc).

% Caso2: Si el ChatbotId del primer chatbot de la lista no esta en la lista de Ids de chatbots del acumulador, entonces se une a la lista Acc el primer chatbot
addChatbot([Chatbot|Chatbots], Acc, AccOut):-
    getChatbotIdChatbot(Chatbot, ChatbotId),
    getChatbotIdsChatbot(Acc, ListaChatbotIds),
    \+ member(ChatbotId, ListaChatbotIds),
    addChatbot(Chatbots, [Chatbot|Acc], AccOut).

% Caso3: Si el ChatbotId del primer chatbot de la lista esta en la lista de Ids de chatbots del acumulador, entonces se vuelve a consultar al predicado, avanzando con la cola de la primera lista y sin unir al acumulador el primer chatbot
addChatbot([Chatbot|Chatbots], Acc, AccOut):-
    getChatbotIdChatbot(Chatbot, ChatbotId),
    getChatbotIdsChatbot(Acc, ListaChatbotIds),
    member(ChatbotId, ListaChatbotIds),
    addChatbot(Chatbots, Acc, AccOut).

