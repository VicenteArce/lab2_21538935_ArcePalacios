%---------------------------------------TDA ChatHistory---------------------------------------

%---------------------------------------Constructor---------------------------------------
% Meta Primaria: chatHistory/3
% Metas Secundarias: -
% Descripcion: Predicado que permite representar un chatHistory
% Dominio: User (String) X Historial(Lista vacia o con elementos) X ChatHistory
chatHistory(User, Historial, [User, Historial]).

% Meta Primaria: getUserCH/2
% Metas Secundarias: -
% Descripcion: Predicado que permite obtener el usuario de un ChatHistory
% Dominio: ChatHistory X User(String)
getUserCH([User,_], User).


% Meta Primaria: getHistorialCH/2
% Metas Secundarias: -
% Descripcion: Predicado que permite obtener el Historial de un ChatHistory
% Dominio: ChatHistory X Historial
getHistorialCH([_,Historial], Historial).


%---------------------------------------Otros predicados---------------------------------------

% Meta Primaria: agregarMensajeUsuario/4
% Metas Secundarias: append/3, concat_atom/2
% Descripcion: Predicado que permite introducir a un Historial un mensaje, sirve para introducir el string ya formateado en el RF12 a el Historial de un usuario x 
% Dominio: Lista X User(String) X Mensaje(String) X Lista

agregarMensajeUsuario([[Usuario, Lista] | RestoUsuarios], UsuarioAgregar, Mensaje, [[Usuario, [NuevaLista2]] | RestoUsuarios]) :-
    Usuario = UsuarioAgregar,         
    append(Lista, [Mensaje], NuevaLista), 
	concat_atom(NuevaLista, NuevaLista2).
agregarMensajeUsuario([Usuario | RestoUsuarios], UsuarioAgregar, Mensaje, [Usuario | RestoNuevaUsuarios]) :-
    agregarMensajeUsuario(RestoUsuarios, UsuarioAgregar, Mensaje, RestoNuevaUsuarios).

% Caso base: si la lista esta vacia, no hay nada que hacer
agregarMensajeUsuario([], _, _, []).