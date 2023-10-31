:- use_module(tda_option_21538935_ArcePalacios).
:- use_module(tda_flow_21538935_ArcePalacios).
:- use_module(tda_chatbot_21538935_ArcePalacios).
:- use_module(tda_system_21538935_ArcePalacios).
:- use_module(tda_chatHistory_21538935_ArcePalacios).


%---------------------------------------RF2---------------------------------------
% Metas Primarias: option
% Metas Secundarias: -
% Descripcion: Predicado que representa a una opcion
% Dominio: Code (Int)  X Message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o mas palabras claves) X Option
option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keyword, [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]):-
    downcaseKeywords(Keyword, [], Keywords).

%---------------------------------------RF3---------------------------------------
% Meta Primaria: flow/4
% Metas Secundarias: addOption/3
% Descripcion: Predicado que representa a un flujo, se encarga de verificar que las opciones introducidas no se repitan en base al id y lo introuce a un flujo
% Dominio: Id X NameMessage X Option X Flow
flow(Id, NameMessage, Option, [Id, NameMessage, OptionOut]):-
    addOption(Option, [], OptionOut).

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

%---------------------------------------RF5---------------------------------------
% Meta primaria: chatbot/6
% Metas secundarias: addFlow/3
% Descripcion: predicado que representa un chatbot, permite la verificacion de que todos los flujos sean distintos
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X Chatbot
chatbot(ChatbotId, Name, WelcomeMessage, StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage, StartFlowId, FlowOut]):-
    addFlow(Flows,[], FlowOut).

%---------------------------------------RF6---------------------------------------
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

%---------------------------------------RF7---------------------------------------
% Meta Primaria: system/4
% Metas Secundarias: addChatbot/3
% Descripcion: Predicado que representa a un system, se encarga de verificar que los chatbots que se pongan no se repitan
% Dominio: Name X InitialChatbotCodeLink X Chatbots X System

system(Name, InitialChatbotCodeLink, Chatbots, [Name, InitialChatbotCodeLink, ChatbotsOut, [], [], [], InitialChatbotCodeLink, -1]):-
    addChatbot(Chatbots,[],ChatbotsOut).

%---------------------------------------RF8---------------------------------------
% Meta Primaria: systemAddChatbot/3
% Metas Secundarias: getChatbotIdChatbot/2, getChatbotsSystem/2, getChatbotIdsChatbot/2, member/2, getNameSystem/2, getInitialChatbotCodeLinkSystem/2,
%                  getChatHistorySystem/2, getRegisterUsersSystem/2, getLogUsersSystem/2, getActualChatbotCodeLinkSystem/2, getActualFlowCodeLinkSystem/2, system2/9
% Descripcion: Predicado que introduce a un sistema un chatbot siempre y cuando este no se encuentre ya en el sistema
% Dominio: System X Chatbot X System

% Caso1: El Chatbot no esta en el sistema (Se introduce al sistema el chatbot)
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
    system2(Name, InitialChatbotCodeLink, [Chatbot| Chatbots], ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink,
        SystemOut).

% Caso2: El chatbot ya esta en el sistema, por ende se devuelve el mismo sistema
systemAddChatbot(SystemIn, Chatbot, SystemOut):-
    getChatbotIdChatbot(Chatbot, ChatbotId),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatbotIdsChatbot(Chatbots, ChatbotsIds),
    member(ChatbotId, ChatbotsIds),
    SystemOut = SystemIn.

%---------------------------------------RF9---------------------------------------
% Meta Primaria: systemAddUser/3
% Metas Secundarias: getRegisterUsersSystem/2, member/2, getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2,
%                     getLogUsersSystem/2, getActualChatbotCodeLinkSystem/2,getActualFlowCodeLinkSystem/2, system2/9
% Descripcion: Predicado que registra un usuario a un sistema siempre y cuando este no se encuentre previamente registrado 
% Dominio: System X User(String) X System

% Caso1: El usuario ya esta registrado
systemAddUser(SystemIn, User, SystemOut):-
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    member(User, RegisterUsers),
    SystemOut = SystemIn.

% Caso2: El usuario no se encuentra registrado
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
    system2(Name, InitialChatbotCodeLink, Chatbots, [[User,[]]| ChatHistory], [User|RegisterUsers], LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, SystemOut).


%---------------------------------------RF10---------------------------------------
% Meta Primaria: systemLogin/3
% Metas Secundarias: getRegisterUsersSystem/2, member/2, getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2, isEmpty/1
%                     getLogUsersSystem/2, getActualChatbotCodeLinkSystem/2, getActualFlowCodeLinkSystem/2, system2/9
% Descripcion: Predicado que Loguea un usuario a un sistema siempre y cuando este se este en la lista de usuarios registrados y no este ningun usuario logueado
% Dominio: System X User(String) X System

% Caso1: Caso ideal en el cual el usuario se encuentra registrado y no hay ningun usuario logueado
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
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, [User], ActualChatbotCodeLink, ActualFlowCodeLink, SystemOut).

% Caso2: Caso en el que el usuario no esta registrado, se crea el mismo sistema sin ingresar al usuario
systemLogin(SystemIn, User, SystemOut):-
	getRegisterUsersSystem(SystemIn, RegisterUsers),
    \+ member(User, RegisterUsers),
    SystemOut = SystemIn.

% Caso3: Caso en el que el usuario se encuentra registrado, pero ya hay un usuario previamente logueado (se crea el mismo sistema sin loguear al usuario)
systemLogin(SystemIn, User, SystemOut):-
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    getLogUsersSystem(SystemIn, LogUsersSystem),
    member(User, RegisterUsers),
    \+ isEmpty(LogUsersSystem),
    SystemOut = SystemIn.


%---------------------------------------RF11---------------------------------------
% Meta Primaria: systemLogout/2
% Metas secundarias: getNameSystem/2, getInitialChatbotCodeLinkSystem/2, getChatbotsSystem/2, getChatHistorySystem/2, getRegisterUsersSystem, system2/9
% Descripcion: Predicado que desloguea al usuario y devuelve a la forma original al sistema (resetea los codigos de chatbot y flujo, ademas desloguea al usuario)
% Dominio: System X System

systemLogout(SystemIn, SystemOut):-
    getNameSystem(SystemIn, Name),
 	getInitialChatbotCodeLinkSystem(SystemIn, InitialChatbotCodeLink),
    getChatbotsSystem(SystemIn, Chatbots),
    getChatHistorySystem(SystemIn, ChatHistory),
    getRegisterUsersSystem(SystemIn, RegisterUsers),
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, [], InitialChatbotCodeLink, -1, SystemOut).


%---------------------------------------RF12---------------------------------------
<<<<<<< HEAD
% Meta Primaria: systemTalkRec/3
% Metas secundarias: isEmpty/1, atom_number/2, getPrimerElemento/2, recuperarElemento/3, getNameChatbot/2, getFlowsChatbot/2,getStartFlowIdChatbot/2,getNameMessageFlow/2, getOptionsFlow/2, getMessagesOptions/2, get_time/1, reverse/2,
%                    append/3, concat_atom/2, agregarMensajeUsuario/4, getChatbotCodeLinkOption/2,getInitialFlowCodeLinkOption/2, downcase_atom/2, atom_string/2, system2/9
% Descripcion: Predicado que permite interactuar con el sistema, este soporta mensajes que contegan el numero de la opcion del numero o mensajes que sean parte de las palabras claves de la opciones disponibles,
%              el sistema de salida contendra en el historial del usuario logueado, las conversaciones que se hayan tenido con el sistema.
% Dominio: System X Message X System


=======
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55

%Caso0: No hay ningun usuario logueado, se construye el mismo sistema ingresado, tambien reinicia el ActualChatbotCodeLink y el ActualFlowCodeLink
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, _, _], _, SystemOut):-
    isEmpty(LogUsers),
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, InitialChatbotCodeLink, -1, SystemOut). 
    

%Caso1: Hay usuario logueado y el sistema no se ha iniciado
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink], Message, SystemOut):-
    \+ isEmpty(LogUsers),				
    -1 =:= ActualFlowCodeLink,		
   	 getPrimerElemento(LogUsers, User),
    recuperarElemento(InitialChatbotCodeLink, Chatbots, Chatbot),
    getNameChatbot(Chatbot, NameChatbotOut),
    getFlowsChatbot(Chatbot, Flows),
    getStartFlowIdChatbot(Chatbot, StartFlowId),
    recuperarElemento(StartFlowId, Flows, Flow),
    getNameMessageFlow(Flow, MessageFlowOut),
    getOptionsFlow(Flow, Options),
    getMessagesOptions(Options, Messages),
    get_time(ActualTime),
    reverse(Messages, MessagesFormated),
    append([ActualTime, " - ", User, ": ", Message, "\n", ActualTime, " - ", NameChatbotOut, ": ", MessageFlowOut], MessagesFormated, FinalAppend),
    concat_atom(FinalAppend, ConcatMessages),
    agregarMensajeUsuario(ChatHistory, User, ConcatMessages, ChatHistoryOut),
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ActualChatbotCodeLink, StartFlowId, SystemOut).
    
    
%Caso2: Hay un usuario logueado, el sistema ya inicio y el mensaje es un numero
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink],
              Message, 
              SystemOut):-
    \+ isEmpty(LogUsers),
    -1 \= ActualFlowCodeLink,
    atom_number(Message, OptionNumber),
    getPrimerElemento(LogUsers, User),
    recuperarElemento(ActualChatbotCodeLink, Chatbots, Chatbot),
    getFlowsChatbot(Chatbot, Flows),
	recuperarElemento(ActualFlowCodeLink, Flows, Flow),
    getOptionsFlow(Flow, Options),
    recuperarElemento(OptionNumber, Options, OpcionEscogida),
    getChatbotCodeLinkOption(OpcionEscogida, ChatbotActualCode),
    getInitialFlowCodeLinkOption(OpcionEscogida, FlowActualCode),
    recuperarElemento(ChatbotActualCode, Chatbots, NextChatbot),
    getNameChatbot(NextChatbot, NameChatbotOut),
    getFlowsChatbot(NextChatbot, NextFlows),
    recuperarElemento(FlowActualCode, NextFlows, NextFlow),
    getNameMessageFlow(NextFlow, MessageFlowOut),
   	getOptionsFlow(NextFlow, NextOptions),
    getMessagesOptions(NextOptions, NextMessagesOptionsaux),
    get_time(ActualTime),
    reverse(NextMessagesOptionsaux,NextMessagesOptions),
    append(["\n", ActualTime, " - ", User, ": ", Message, "\n", ActualTime, " - ", NameChatbotOut, ": ", MessageFlowOut], NextMessagesOptions, FinalAppend),
    concat_atom(FinalAppend, ConcatMessages),
    agregarMensajeUsuario(ChatHistory, User, ConcatMessages, ChatHistoryOut),
	system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ChatbotActualCode, FlowActualCode, SystemOut).
    
%Caso3: Hay un usuario logueado, el sistema ya inicio y el mensaje es un string
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink],
              Message, 
              SystemOut):-
    \+ isEmpty(LogUsers),
    -1 \= ActualFlowCodeLink,
    downcase_atom(Message, MinMessageAtom),
    atom_string(MinMessageAtom, MinMessage),
    getPrimerElemento(LogUsers, User),
    recuperarElemento(ActualChatbotCodeLink, Chatbots, Chatbot),
    getFlowsChatbot(Chatbot, Flows),
	recuperarElemento(ActualFlowCodeLink, Flows, Flow),
    getOptionsFlow(Flow, Options),
    recuperarElementoPorString(MinMessage, Options, OpcionEscogida),
    getChatbotCodeLinkOption(OpcionEscogida, ChatbotActualCode),
    getInitialFlowCodeLinkOption(OpcionEscogida, FlowActualCode),
    recuperarElemento(ChatbotActualCode, Chatbots, NextChatbot),
    getNameChatbot(NextChatbot, NameChatbotOut),
    getFlowsChatbot(NextChatbot, NextFlows),
    recuperarElemento(FlowActualCode, NextFlows, NextFlow),
    getNameMessageFlow(NextFlow, MessageFlowOut),
   	getOptionsFlow(NextFlow, NextOptions),
    getMessagesOptions(NextOptions, NextMessagesOptionsaux),
    get_time(ActualTime),
    reverse(NextMessagesOptionsaux,NextMessagesOptions),
    append(["\n", ActualTime, " - ", User, ": ", Message, "\n", ActualTime, " - ", NameChatbotOut, ": ", MessageFlowOut], NextMessagesOptions, FinalAppend),
    concat_atom(FinalAppend, ConcatMessages),
    agregarMensajeUsuario(ChatHistory, User, ConcatMessages, ChatHistoryOut),
	system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ChatbotActualCode, FlowActualCode, SystemOut).
    
    

%---------------------------------------RF13---------------------------------------
<<<<<<< HEAD
% Meta Primaria: systemSynthesis/3
% Metas secundarias: getRegisterUsersSystem72, member/2, getHistorialCH/2, isEmpty/1, getPrimerElemento/2, getChatHistorySystem/2, recuperarElemento/3
% Descripcion: Predicado que permite interactuar con el sistema, este soporta mensajes que contegan el numero de la opcion del numero o mensajes que sean parte de las palabras claves de la opciones disponibles,
%              el sistema de salida contendra en el historial del usuario logueado, las conversaciones que se hayan tenido con el sistema.
% Dominio: System X Message X System
=======
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55

%Caso1: El usuario dado no esta registrado
systemSynthesis(System, User, String):-
    getRegisterUsersSystem(System, RegisterUsers),
    \+ member(User, RegisterUsers),
    String = "Tu usuario no esta registrado".

%Caso2: El usuario no ha interactuado con el sistema
systemSynthesis(System, User, String):-
    getChatHistorySystem(System, CH),
    recuperarElemento(User, CH, HistorialUser),
    getHistorialCH(HistorialUser, Historial),
    isEmpty(Historial),
    String = "Tu usuario no ha interactuado con el sistema aun".
    
%Caso3: El usuario dado si tiene un historial
systemSynthesis(System, User, String):-
    getChatHistorySystem(System, CH),
    recuperarElemento(User, CH, HistorialUser),
    getHistorialCH(HistorialUser, Historial),
    getPrimerElemento(Historial, String).


%------------------------OTROS PREDICADOS-------------------

<<<<<<< HEAD
% Meta Primaria: getPrimerElemento/2
% Metas secundarias: -
% Descripcion: Obtiene el primer elemento de una lista
% Dominio: Lista X Elemento
getPrimerElemento([E|_],E).
    

% Meta Primaria: recuperarElementoPorString/3
% Metas secundarias: member/2
% Descripcion: Predicado que permite obtener un Elemento de una lista relacionado a un string, es decir, si en una lista hay un elemento que contiene el mensaje "Hola", con este predicado se puede obtener todo el elemento que tiene el mensaje "Hola"
% Dominio: Mensaje X Lista X Lista
=======
getPrimerElemento([E|_],E).
    
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55
recuperarElementoPorString(Mensaje, [[C, M, CB, Init, Keywords]|_], [C, M, CB, Init, Keywords]):-
    member(Mensaje, Keywords).
recuperarElementoPorString(Mensaje,[_|Resto], ElementoRecuperado):-
    recuperarElementoPorString(Mensaje, Resto, ElementoRecuperado).
<<<<<<< HEAD


% Meta Primaria: recuperarElemento/3
% Metas secundarias: -
% Descripcion: Predicado que permite recuperar una lista si contiene un elemento en su primera posicion
% Dominio: Elemento X Lista X Lista
=======
    
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55
recuperarElemento(Elemento, [[Elemento|Resto]|_], [Elemento|Resto]) :- !.
recuperarElemento(Elemento, [_|Resto], ElementoRecuperado) :-
    recuperarElemento(Elemento, Resto, ElementoRecuperado).
    
<<<<<<< HEAD

% Meta Primaria: getMessagesOptions/2
% Metas Secundarias: -
% Descripcion: Predicado que permite poner en una lista todas las opciones de un flujo en especifico
% Dominio: Lista X Lista
=======
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55
getMessagesOptions([], []).
getMessagesOptions([[_,Message|_]|Resto],[Message, "\n" | ListaMensajes]) :-
    getMessagesOptions(Resto, ListaMensajes).