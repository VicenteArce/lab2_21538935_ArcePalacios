%---------------------------------------TDA Option---------------------------------------

%---------------------------------------Constructores---------------------------------------
%---------------------------------------RF2---------------------------------------
% Metas Primarias: option
% Metas Secundarias: -
% Descripcion: Predicado que representa a una opcion
% Dominio: Code (Int)  X Message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o mas palabras claves) X Option
option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keyword, [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]):-
    downcaseKeywords(Keyword, [], Keywords).


%---------------------------------------Selectores---------------------------------------
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


%---------------------------------------Otros Predicados---------------------------------------
% Meta Primaria: downcaseKeywords/3
% Metas Secundarias: downcase_atom/2, atom_string/2
% Descripcion: Predicado que dado una lista de string, lo convierte a minusculas y los pone en una lista
% Dominio: Lista(contiene strings que son Keywords) X Lista(Acumulador) X Lista(Keywords ya convertidos a minusculas)
downcaseKeywords([], Acc, Acc).
downcaseKeywords([H|T], Acc, NextAcc):-
    downcase_atom(H, Hatom),
    atom_string(Hatom, Hmin), 
    downcaseKeywords(T, [Hmin|Acc], NextAcc).
