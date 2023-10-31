:- module(tda_chatHistory_21538935_ArcePalacios, [chatHistory/3, getUserCH/2, getHistorialCH/2, agregarMensajeUsuario/4]).


chatHistory(User, Historial, [User, Historial]).

getUserCH([User,_], User).

getHistorialCH([_,Historial], Historial).



% Predicado para agregar un mensaje en la segunda lista de la sublista que contiene a un usuario dado
agregarMensajeUsuario([[Usuario, Lista] | RestoUsuarios], UsuarioAgregar, Mensaje, [[Usuario, [NuevaLista2]] | RestoUsuarios]) :-
    Usuario = UsuarioAgregar,          % Comprobamos si el usuario coincide
    append(Lista, [Mensaje], NuevaLista), % Agregamos el mensaje a la lista existente
	concat_atom(NuevaLista, NuevaLista2).
agregarMensajeUsuario([Usuario | RestoUsuarios], UsuarioAgregar, Mensaje, [Usuario | RestoNuevaUsuarios]) :-
    agregarMensajeUsuario(RestoUsuarios, UsuarioAgregar, Mensaje, RestoNuevaUsuarios).

% Caso base: si la lista está vacía, no hay nada que hacer
agregarMensajeUsuario([], _, _, []).