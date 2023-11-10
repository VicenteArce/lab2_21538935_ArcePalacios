:- consult('tda_option_21538935_ArcePalacios.pl').
:- consult('tda_flow_21538935_ArcePalacios.pl').
:- consult('tda_chatbot_21538935_ArcePalacios.pl').

%---------------------------------------Constructor---------------------------------------
%---------------------------------------RF7---------------------------------------
% Meta Primaria: system/4
% Metas Secundarias: addChatbot/3
% Descripcion: Predicado que representa a un system, se encarga de verificar que los chatbots que se pongan no se repitan
% Dominio: Name X InitialChatbotCodeLink X Chatbots X System

system(Name, InitialChatbotCodeLink, Chatbots, [Name, InitialChatbotCodeLink, ChatbotsOut, [], [], [], InitialChatbotCodeLink, -1, -1]):-
    addChatbot(Chatbots,[],ChatbotsOut).

% Meta Primaria: system2/10
% Metas Secundarias: -
% Descripcion: Predicado que representa a un system, para constuir el sistema, se requieren todos los parametros del sistema
% Dominio: Name X InitialChatbotCodeLink X Chatbots X ChatHistory X RegisterUsers X LogUsers X ActualChatbotCodeLink X ActualFlowCodeLink X PlaceHolderSimulate X System

system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate,
        [Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate]).

%---------------------------------------Selectores---------------------------------------

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
% Dominio: System X ActualChatbotCodeLink
getActualChatbotCodeLinkSystem([_, _, _, _, _, _, ActualChatbotCodeLink|_], ActualChatbotCodeLink).

% Meta Primaria: getActualFlowCodeLinkSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el ActualFlowCodeLink de un sistema
% Dominio: System X ActualFlowCodeLink
getActualFlowCodeLinkSystem([_, _, _, _, _, _, _, ActualFlowCodeLink|_], ActualFlowCodeLink).

% Meta Primaria: getPlaceHolderSimulateSystem/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el PlaceHolderSimulate de un sistema
% Dominio: System X PlaceHolderSimulate
getPlaceHolderSimulateSystem([_, _, _, _, _, _, _, _, PlaceHolderSimulate], PlaceHolderSimulate).

%---------------------------------------Modificadores---------------------------------------
% Meta Primaria: setPlaceHolderSimulateSystem/3
% Metas Secundarias: -
% Descripcion: Predicado que permite modificar el PlaceHolderSimulate
% Dominio: System X PlaceHolderSimulate(Integer) X System

setPlaceHolderSimulateSystem([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, _], 
                             PlaceHolderSimulateAux,
                             [Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulateAux]). 


%---------------------------------------RF8---------------------------------------
% Meta Primaria: systemAddChatbot/3
% Metas Secundarias: getChatbotIdChatbot/2, getChatbotsSystem/2, getChatbotIdsChatbot/2, member/2, getNameSystem/2, getInitialChatbotCodeLinkSystem/2,
%                  getChatHistorySystem/2, getRegisterUsersSystem/2, getLogUsersSystem/2, getActualChatbotCodeLinkSystem/2, getActualFlowCodeLinkSystem/2, system2/10
% Descripcion: Predicado que introduce a un sistema un chatbot siempre y cuando este no se encuentre ya en el sistema
% Dominio: System X Chatbot X System

% Si el Chatbot (Comparando por id) no esta en el sistema, se introduce al sistema el chatbot, de lo contrariose arrojara false
systemAddChatbot(SystemIn, Chatbot, SystemOut):-
    getChatbotIdChatbot(Chatbot, ChatbotId),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatbotIdsChatbot(Chatbots, ChatbotsIds),
    \+ member(ChatbotId, ChatbotsIds),
    getNameSystem(SystemIn, Name),
    getInitialChatbotCodeLinkSystem(SystemIn, InitialChatbotCodeLink),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatHistorySystem(SystemIn, ChatHistory),
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    getLogUsersSystem(SystemIn, LogUsers),
    getActualChatbotCodeLinkSystem(SystemIn, ActualChatbotCodeLink),
    getActualFlowCodeLinkSystem(SystemIn, ActualFlowCodeLink),
    getPlaceHolderSimulateSystem(SystemIn, PlaceHolderSimulate),
    system2(Name, InitialChatbotCodeLink, [Chatbot| Chatbots], ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate, SystemOut).


%---------------------------------------RF9---------------------------------------
% Meta Primaria: systemAddUser/3
% Metas Secundarias: getRegisterUsersSystem/2, member/2, getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2,
%                     getLogUsersSystem/2, getActualChatbotCodeLinkSystem/2,getActualFlowCodeLinkSystem/2, system2/10
% Descripcion: Predicado que registra un usuario a un sistema siempre y cuando este no se encuentre previamente registrado 
% Dominio: System X User(String) X System


% Si el usuario no se encuentra registrado, entonces lo agrega a la lista de usuarios. De lo contrario, si se intenta introducir un usuario que ya se encuentra en la lista de usuarios, arrojara false
systemAddUser(SystemIn, User, SystemOut):-
    getRegisterUsersSystem(SystemIn, RegisterUsers),
   	\+ member(User, RegisterUsers),
    getNameSystem(SystemIn, Name),
 	getInitialChatbotCodeLinkSystem(SystemIn, InitialChatbotCodeLink),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatHistorySystem(SystemIn, ChatHistory),
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    getLogUsersSystem(SystemIn, LogUsers),
    getActualChatbotCodeLinkSystem(SystemIn, ActualChatbotCodeLink),
    getActualFlowCodeLinkSystem(SystemIn, ActualFlowCodeLink),
    getPlaceHolderSimulateSystem(SystemIn, PlaceHolderSimulate),
    system2(Name, InitialChatbotCodeLink, Chatbots, [[User,[]]| ChatHistory], [User|RegisterUsers], LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate, SystemOut).


%---------------------------------------RF10---------------------------------------
% Meta Primaria: systemLogin/3
% Metas Secundarias: getRegisterUsersSystem/2, member/2, getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2, isEmpty/1
%                     getLogUsersSystem/2, getActualChatbotCodeLinkSystem/2, getActualFlowCodeLinkSystem/2, system2/10
% Descripcion: Predicado que Loguea un usuario a un sistema siempre y cuando este se este en la lista de usuarios registrados y no este ningun usuario logueado
% Dominio: System X User(String) X System

% En el caso ideal en el cual el usuario se encuentra registrado y no hay ningun usuario logueado, simplemente lo introduce a la lista de usuarios logueados.
% En el caso en el cual el usuario no se encuentra registrado, arrojara false. Si ya hay algun usuario logueado, se arrojara false
systemLogin(SystemIn, User, SystemOut):-
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    getLogUsersSystem(SystemIn, LogUsersSystem),
    member(User, RegisterUsers),
    isEmpty(LogUsersSystem),
    getNameSystem(SystemIn, Name),
 	getInitialChatbotCodeLinkSystem(SystemIn, InitialChatbotCodeLink),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatHistorySystem(SystemIn, ChatHistory),
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    getActualChatbotCodeLinkSystem(SystemIn, ActualChatbotCodeLink),
    getActualFlowCodeLinkSystem(SystemIn, ActualFlowCodeLink),
    getPlaceHolderSimulateSystem(SystemIn, PlaceHolderSimulate),
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, [User], ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate, SystemOut).



%---------------------------------------RF11---------------------------------------
% Meta Primaria: systemLogout/2
% Metas secundarias: getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2, getRegisterUsersSystem, system2/10
% Descripcion: Predicado que desloguea al usuario y devuelve a la forma original al sistema (resetea los codigos de chatbot y flujo, ademas desloguea al usuario)
% Dominio: System X System

systemLogout(SystemIn, SystemOut):-
    getLogUsersSystem(SystemIn, LogUsers),
    \+ isEmpty(LogUsers),
    getNameSystem(SystemIn, Name),
 	getInitialChatbotCodeLinkSystem(SystemIn, InitialChatbotCodeLink),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatHistorySystem(SystemIn, ChatHistory),
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, [], InitialChatbotCodeLink, -1, -1, SystemOut).


%---------------------------------------Otros Predicados---------------------------------------
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


