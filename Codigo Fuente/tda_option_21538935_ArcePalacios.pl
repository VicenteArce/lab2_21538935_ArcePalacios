:- module(tda_option_21538935_ArcePalacios, [getCodeOption/2, getMessageOption/2, getChatbotCodeLinkOption/2, getInitialFlowCodeLinkOption/2, getKeywordOption/2, downcaseKeywords/3]).

% El constructor option se encuentra en el Main RF2

%--------------------Selectores---------------
% Metas Primarias: getCodeOption/2
% Metas Secundarias: -
% Descripcion: Predicado obtiene el codigo de una opcion
% Dominio: Option X Code
getCodeOption([Code|_], Code).


% Metas Primarias: getMessageOption/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el mensaje de una opcion
% Dominio: Option X Message
getMessageOption([_,Message|_], Message).

% Metas Primarias: getChatbotCodeLinkOption/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el codigo asociado a un chatbot de una opcion
% Dominio: Option X ChatbotCodeLink
getChatbotCodeLinkOption([_,_,ChatbotCodeLink|_], ChatbotCodeLink).


% Metas Primarias: getInitialFlowCodeLinkOption/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene el codigo asociado a un flujo de una opcion
% Dominio: Option X InitialFlowCodeLink
getInitialFlowCodeLinkOption([_,_,_,InitialFlowCodeLink|_], InitialFlowCodeLink).


% Metas Primarias: getKeywordOption/2
% Metas Secundarias: -
% Descripcion: Predicado que obtiene las palabras clave de una opcion
% Dominio: Option X Keyword
getKeywordOption([_,_,_,_,Keyword], Keyword).


%---------Otras funciones----------
downcaseKeywords([], Acc, Acc).
downcaseKeywords([H|T], Acc, NextAcc):-
    downcase_atom(H, Hatom),
    atom_string(Hatom, Hmin), 
    downcaseKeywords(T, [Hmin|Acc], NextAcc).
