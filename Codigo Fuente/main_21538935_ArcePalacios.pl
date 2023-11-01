:- consult('tda_option_21538935_ArcePalacios.pl').
:- consult('tda_flow_21538935_ArcePalacios.pl').
:- consult('tda_chatbot_21538935_ArcePalacios.pl').
:- consult('tda_system_21538935_ArcePalacios.pl').
:- consult('tda_chatHistory_21538935_ArcePalacios.pl').

%---------------------------------------RF12---------------------------------------
% Meta Primaria: systemTalkRec/3
% Metas secundarias: isEmpty/1, atom_number/2, getPrimerElemento/2, recuperarElemento/3, getNameChatbot/2, getFlowsChatbot/2,getStartFlowIdChatbot/2,getNameMessageFlow/2, getOptionsFlow/2, getMessagesOptions/2, get_time/1, reverse/2,
%                    append/3, concat_atom/2, agregarMensajeUsuario/4, getChatbotCodeLinkOption/2,getInitialFlowCodeLinkOption/2, downcase_atom/2, atom_string/2, system2/9
% Descripcion: Predicado que permite interactuar con el sistema, este soporta mensajes que contegan el numero de la opcion del numero o mensajes que sean parte de las palabras claves de la opciones disponibles,
%              el sistema de salida contendra en el historial del usuario logueado, las conversaciones que se hayan tenido con el sistema.
% Dominio: System X Message X System



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
    append([ActualTime, " - ", User, ": ", Message, "\n", ActualTime, " - ", NameChatbotOut, ": ", MessageFlowOut], MessagesFormated, FinalAppendAux),
    append(FinalAppendAux, ["\n"], FinalAppend),
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
    append(["\n", ActualTime, " - ", User, ": ", Message, "\n", ActualTime, " - ", NameChatbotOut, ": ", MessageFlowOut], NextMessagesOptions, FinalAppendAux),
    append(FinalAppendAux, ["\n"], FinalAppend),
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
    append(["\n", ActualTime, " - ", User, ": ", Message, "\n", ActualTime, " - ", NameChatbotOut, ": ", MessageFlowOut], NextMessagesOptions, FinalAppendAux),
    append(FinalAppendAux, ["\n"], FinalAppend),
    concat_atom(FinalAppend, ConcatMessages),
    agregarMensajeUsuario(ChatHistory, User, ConcatMessages, ChatHistoryOut),
	system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ChatbotActualCode, FlowActualCode, SystemOut).
    
    

%---------------------------------------RF13---------------------------------------
% Meta Primaria: systemSynthesis/3
% Metas secundarias: getRegisterUsersSystem72, member/2, getHistorialCH/2, isEmpty/1, getPrimerElemento/2, getChatHistorySystem/2, recuperarElemento/3
% Descripcion: Predicado que permite interactuar con el sistema, este soporta mensajes que contegan el numero de la opcion del numero o mensajes que sean parte de las palabras claves de la opciones disponibles,
%              el sistema de salida contendra en el historial del usuario logueado, las conversaciones que se hayan tenido con el sistema.
% Dominio: System X Message X System


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
% Meta Primaria: myRandom/2
% Metas Secundarias: -
% Descripcion: Predicado que dado un numero, se puede obtener otro de manera pseudo-aleatoria
% Dominio: Xn(integer) X Xn1(integer)
myRandom(Xn, Xn1):-
	MulTemp is 1103515245 * Xn,
	SumTemp is MulTemp + 12345,
	Xn1 is SumTemp mod 2147483648.


% Meta Primaria: getPrimerElemento/2
% Metas secundarias: -
% Descripcion: Obtiene el primer elemento de una lista
% Dominio: Lista X Elemento
getPrimerElemento([E|_],E).
    

% Meta Primaria: recuperarElementoPorString/3
% Metas secundarias: member/2
% Descripcion: Predicado que permite obtener un Elemento de una lista relacionado a un string, es decir, si en una lista hay un elemento que contiene el mensaje "Hola", con este predicado se puede obtener todo el elemento que tiene el mensaje "Hola"
% Dominio: Mensaje X Lista X Lista


recuperarElementoPorString(Mensaje, [[C, M, CB, Init, Keywords]|_], [C, M, CB, Init, Keywords]):-
    member(Mensaje, Keywords).
recuperarElementoPorString(Mensaje,[_|Resto], ElementoRecuperado):-
    recuperarElementoPorString(Mensaje, Resto, ElementoRecuperado).



% Meta Primaria: recuperarElemento/3
% Metas secundarias: -
% Descripcion: Predicado que permite recuperar una lista si contiene un elemento en su primera posicion
% Dominio: Elemento X Lista X Lista

recuperarElemento(Elemento, [[Elemento|Resto]|_], [Elemento|Resto]) :- !.
recuperarElemento(Elemento, [_|Resto], ElementoRecuperado) :-
    recuperarElemento(Elemento, Resto, ElementoRecuperado).
    

% Meta Primaria: getMessagesOptions/2
% Metas Secundarias: -
% Descripcion: Predicado que permite poner en una lista todas las opciones de un flujo en especifico
% Dominio: Lista X Lista
getMessagesOptions([], []).
getMessagesOptions([[_,Message|_]|Resto],[Message, "\n" | ListaMensajes]) :-
    getMessagesOptions(Resto, ListaMensajes).