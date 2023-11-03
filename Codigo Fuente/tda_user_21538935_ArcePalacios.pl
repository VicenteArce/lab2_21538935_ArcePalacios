%---------------------------------------TDA User---------------------------------------
%---------------------------------------Constructores---------------------------------------

% Meta Primaria: user/3
% Metas Secundarias: append/3, concat_atom/2, atom_string/2
% Descripcion: Predicado que permite crear un usuario mediante una semilla, ejemplo, dado un "user" y una seed 1323 el UserSeed: "user1323"
% Dominio: User (String) X Seed(integer) X UserSeed(String)
user(User, Seed, UserSeed):-
    append([User], [Seed], UserSeedAux),
    concat_atom(UserSeedAux, UserSeedAux2),
    atom_string(UserSeedAux2, UserSeed).