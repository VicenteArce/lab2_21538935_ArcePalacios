:- consult('tda_option_21538935_ArcePalacios.pl').
:- consult('tda_flow_21538935_ArcePalacios.pl').
:- consult('tda_chatbot_21538935_ArcePalacios.pl').
:- consult('tda_system_21538935_ArcePalacios.pl').
:- consult('tda_chatHistory_21538935_ArcePalacios.pl').
:- consult('tda_user_21538935_ArcePalacios.pl').

%---------------------------------------RF12---------------------------------------
% Meta Primaria: systemTalkRec/3
% Metas secundarias: isEmpty/1, atom_number/2, getPrimerElemento/2, recuperarElemento/3, getNameChatbot/2, getFlowsChatbot/2,getStartFlowIdChatbot/2,getNameMessageFlow/2, getOptionsFlow/2, getMessagesOptions/2, get_time/1, reverse/2,
%                    append/3, concat_atom/2, agregarMensajeUsuario/4, getChatbotCodeLinkOption/2,getInitialFlowCodeLinkOption/2, downcase_atom/2, atom_string/2, system2/10
% Descripcion: Predicado que permite interactuar con el sistema, este soporta mensajes que contegan el numero de la opcion del numero o mensajes que sean parte de las palabras claves de la opciones disponibles,
%              el sistema de salida contendra en el historial del usuario logueado, las conversaciones que se hayan tenido con el sistema.
% Dominio: System X Message X System

    
%Caso1: Hay usuario logueado y el sistema no se ha iniciado
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate], Message, SystemOut):-
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
    system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ActualChatbotCodeLink, StartFlowId, PlaceHolderSimulate, SystemOut).
    
    
%Caso2: Hay un usuario logueado, el sistema ya inicio y el mensaje es un numero
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate], Message, SystemOut):-
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
	system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ChatbotActualCode, FlowActualCode, PlaceHolderSimulate, SystemOut).
    
%Caso3: Hay un usuario logueado, el sistema ya inicio y el mensaje es un string
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, ChatHistory, RegisterUsers, LogUsers, ActualChatbotCodeLink, ActualFlowCodeLink, PlaceHolderSimulate],
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
	system2(Name, InitialChatbotCodeLink, Chatbots, ChatHistoryOut, RegisterUsers, LogUsers, ChatbotActualCode, FlowActualCode, PlaceHolderSimulate, SystemOut).
    
    

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
    StringAux = "Tu usuario no esta registrado",
    append(["\n-----------------", User, "-----------------\n"], [StringAux], ListaAux),
    concat_atom(ListaAux, Atom_String),
    atom_string(Atom_String, String).

%Caso2: El usuario no ha interactuado con el sistema
systemSynthesis(System, User, String):-
    getChatHistorySystem(System, CH),
    recuperarElemento(User, CH, HistorialUser),
    getHistorialCH(HistorialUser, Historial),
    isEmpty(Historial),
    StringAux = "Tu usuario no ha interactuado con el sistema aun",
    append(["\n-----------------", User, "-----------------\n"], [StringAux], ListaAux),
    concat_atom(ListaAux, Atom_String),
    atom_string(Atom_String, String).
    
%Caso3: El usuario dado si tiene un historial
systemSynthesis(System, User, String):-
    getChatHistorySystem(System, CH),
    recuperarElemento(User, CH, HistorialUser),
    getHistorialCH(HistorialUser, Historial),
    append(["\n-----------------", User, "-----------------\n"], Historial, ListaAux),
    concat_atom(ListaAux, Atom_String),
    atom_string(Atom_String, String).





%---------------------------------------RF14---------------------------------------
% Meta Primaria: systemSimulate/4
% Metas secundarias: systemLogout/2, getPlaceHolderSimulateSystem/2, user/3, systemLogout/2, systemAddUser/3, systemLogin/3, systemTalkRec/3, setPlaceHolderSimulateSystem/3, myRandom/2,getNumberOptions/2, setRandomChoose/3, number_string/2,
% Descripcion: Predicado que permite la simulacion de una interaccion con un sistema, es decir, se crea un usuario, se loguea, y dada una semilla se eligiran opciones pseudo-aleatorias junto con el predicado systemTalkRec
% Dominio: System X Message X System


%Caso base: Las maximas interacciones son menores a 0
systemSimulate(System, MaxInteractions, _, SystemOut):-
    MaxInteractions < 0,
    systemLogout(System, SystemOut).

% Caso en el que la simulacion no se ha iniciado y hay un usuario logueado
systemSimulate(System, MaxInteractions, Seed, SystemOut):-
    getPlaceHolderSimulateSystem(System, PlaceHolderSimulate),
    PlaceHolderSimulate == -1,	% Si la simulacion no se ha iniciado, entonces creara al usuario user + seed
    user("user", Seed, User),	
    systemLogout(System, SystemAux),	% Hago un systemLogout por si ya existiese un usuario logueado
    systemAddUser(SystemAux, User, SystemAux2),
    systemLogin(SystemAux2, User, SystemAux3), % Logueo en el sistema al usuario nuevo
    systemTalkRec(SystemAux3, "Hola", SystemAux4), % Se supondra que el primer mensaje en la simulacion siempre sera un "Hola"
    setPlaceHolderSimulateSystem(SystemAux4, 1, SystemOutAux),	% Seteo el PlaceHolderSimulateSystem en 1 para que, una vez iniciada la simulacion, no pase por este caso de nuevo
    MaxInteractionsAux is MaxInteractions - 1,			
    myRandom(Seed, SeedOut),
    systemSimulate(SystemOutAux, MaxInteractionsAux, SeedOut, SystemOut).	
   
% Caso en el que la simulacion no se ha iniciado y no hay un usuario logueado
systemSimulate(System, MaxInteractions, Seed, SystemOut):-
    getPlaceHolderSimulateSystem(System, PlaceHolderSimulate),
    PlaceHolderSimulate == -1,	% Si la simulacion no se ha iniciado, entonces creara al usuario user + seed
    user("user", Seed, User),	
    systemAddUser(System, User, SystemAux2),
    systemLogin(SystemAux2, User, SystemAux3), % Logueo en el sistema al usuario nuevo
    systemTalkRec(SystemAux3, "Hola", SystemAux4), % Se supondra que el primer mensaje en la simulacion siempre sera un "Hola"
    setPlaceHolderSimulateSystem(SystemAux4, 1, SystemOutAux),	% Seteo el PlaceHolderSimulateSystem en 1 para que, una vez iniciada la simulacion, no pase por este caso de nuevo
    MaxInteractionsAux is MaxInteractions - 1,			
    myRandom(Seed, SeedOut),
    systemSimulate(SystemOutAux, MaxInteractionsAux, SeedOut, SystemOut).	

% Caso en el que la simulacion ya inicio
systemSimulate(System, MaxInteractions, Seed, SystemOut):-
    getPlaceHolderSimulateSystem(System, PlaceHolderSimulate),
    PlaceHolderSimulate == 1,	% Se comprueba que la simulacion ya se inicio
    getNumberOptions(System, NumberOptions),	% Obtengo la cantidad de opciones que hay en el chatbot y flujo actual
    setRandomChoose(Seed, NumberOptions, RandomChoose),
    number_string(RandomChoose, Message),
    systemTalkRec(System, Message, SystemOutAux),
    MaxInteractionsAux is MaxInteractions - 1,			
    myRandom(Seed, SeedOut),
    systemSimulate(SystemOutAux, MaxInteractionsAux, SeedOut, SystemOut).	


%---------------------------------------OTROS PREDICADOS---------------------------------------
% Meta Primaria: getNumberOptions/2
% Metas Secundarias:recuperarElemento/3, getFlowsChatbot/2, recuperarElemento/3, getOptionsFlow/2, len/2
% Descripcion: Predicado permite obtener la cantidad de opciones que hay en el chatbot y flujo actual en el que se encuentra el sistema
% Dominio: System X NumberOptions(Integer)
getNumberOptions([_, _, Chatbots, _, _, _, ActualChatbotCodeLink, ActualFlowCodeLink, _], NumberOptions):-
    recuperarElemento(ActualChatbotCodeLink, Chatbots, ChatbotOut),
    getFlowsChatbot(ChatbotOut, Flows),
    recuperarElemento(ActualFlowCodeLink, Flows, FlowOut),
    getOptionsFlow(FlowOut, Options),
    len(Options, NumberOptions).


% Meta Primaria: setRandomChoose/3
% Metas Secundarias: -
% Descripcion: Predicado que permite obtener un numero de una opcion de manera pseudo-aleatoria, este numero ira entre 1 y n, siendo n el NumberOptions, se supondra que las opciones son consecutivas.
% Dominio: System X NumberOptions(Integer)
setRandomChoose(Seed, NumberOptions, NumberRandomChoose):-
   	NumberRandomChooseAux is Seed mod NumberOptions,
    NumberRandomChoose is NumberRandomChooseAux + 1.


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