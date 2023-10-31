:- module(tda_chatHistory_21538935_ArcePalacios, [chatHistory/3, getUserCH/2, getHistorialCH/2, agregarMensajeUsuario/4]).


<<<<<<< HEAD
%---------------Constructor----------------
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


%---------Otros predicados---------------------

% Meta Primaria: agregarMensajeUsuario/4
% Metas Secundarias: append/3, concat_atom/2
% Descripcion: Predicado que permite introducir a un Historial un mensaje, sirve para introducir el string ya formateado en el RF12 a el Historial de un usuario x 
% Dominio: Lista X User(String) X Mensaje(String) X Lista

agregarMensajeUsuario([[Usuario, Lista] | RestoUsuarios], UsuarioAgregar, Mensaje, [[Usuario, [NuevaLista2]] | RestoUsuarios]) :-
    Usuario = UsuarioAgregar,         
    append(Lista, [Mensaje], NuevaLista), 
=======
chatHistory(User, Historial, [User, Historial]).

getUserCH([User,_], User).

getHistorialCH([_,Historial], Historial).



% Predicado para agregar un mensaje en la segunda lista de la sublista que contiene a un usuario dado
agregarMensajeUsuario([[Usuario, Lista] | RestoUsuarios], UsuarioAgregar, Mensaje, [[Usuario, [NuevaLista2]] | RestoUsuarios]) :-
    Usuario = UsuarioAgregar,          % Comprobamos si el usuario coincide
    append(Lista, [Mensaje], NuevaLista), % Agregamos el mensaje a la lista existente
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55
	concat_atom(NuevaLista, NuevaLista2).
agregarMensajeUsuario([Usuario | RestoUsuarios], UsuarioAgregar, Mensaje, [Usuario | RestoNuevaUsuarios]) :-
    agregarMensajeUsuario(RestoUsuarios, UsuarioAgregar, Mensaje, RestoNuevaUsuarios).

<<<<<<< HEAD
% Caso base: si la lista esta vacia, no hay nada que hacer
=======
% Caso base: si la lista está vacía, no hay nada que hacer
>>>>>>> da7099cfb0b1df2ef28e3f54b94e14131f568b55
agregarMensajeUsuario([], _, _, []).