% opciones chatbot 0
option(1, "1) Peliculas", 1, 1, ["Pelicula", "Peliculas", "Movies"], OP1),
option(2, "2) Musica", 2, 1, ["Musica", "Music"], OP2),


% opciones chatbot 1
% opciones flujo 1 chatbot 1
option(1, "1) Accion", 1, 2, ["Accion", "Action"], OP3),
option(2, "2) Animación", 1, 3, ["Animacion", "Animation"], OP4),
option(3, "3) Ninguna, volver", 0, 1, ["volver", "ninguna"], OP5),

% opciones flujo 2 chatbot 1
option(1, "1) The Matrix", 1, 2, ["Matrix", "The Matrix"], OP6),
option(2, "2) Jhon Wick", 1, 2, ["Jhon Wick", "perro"], OP7),
option(3, "3) The Dark Night", 1, 2, ["Batman", "The Dark Night"], OP8),
option(4, "4) ninguna pelicula más, volver", 1, 1, ["volver", "ninguna"], OP9),

% opciones flujo 5 chatbot 1
option(1, "1) Toy Story", 1, 3, ["Toy Story", "juguetes"], OP10),
option(2, "2) Ratatouille", 1, 3, ["rata", "Ratatouille"], OP11),
option(3, "3) ninguna pelicula más, volver", 1, 1, ["volver", "ninguna"], OP12),


% opciones chatbot 2
% opciones flujo 1 chatbot 2
option(1, "1) Hip Hop", 2, 2, ["Hip Hop", "Rap"], OP13),
option(2, "2) Jazz", 2, 3, ["Jazz"], OP14),
option(3, "3) Volver", 0, 1, ["volver", "ninguna"], OP15),

% opciones flujo 2 chatbot 2
option(1, "1) Biggie Smalls", 2, 2, ["Biggie Smalls", "Biggie"], OP16),
option(2, "2) Kanye West", 2, 2, ["Kanye West", "Kanye"], OP17),
option(3, "3) 2Pac", 2, 2, ["2Pac", "Tupac"], OP18),
option(4, "4) ningun artista más, volver", 2, 1, ["volver", "ninguno"], OP19),

% opciones flujo 3 chatbot 2
option(1, "1) Louis Armstrong", 2, 3, ["Louis", "Armstrong"], OP20),
option(2, "2) Miles Davis", 2, 3, ["Miles Davis", "Miles"], OP21),
option(3, "3) Sarah Vaughan", 2, 3, ["Sarah", "Sarah Vaughan"], OP22),
option(4, "4) ningun artista más, volver", 2, 1, ["volver", "ninguno"], OP23),

%--------------------------------------flow------------------------------------------
% flow(1, "Flujo Principal Chatbot 0\nBienvenido\n¿De qué deseas hablar?", [OP1, OP2, OP1, OP1, OP2], F99), % Si se descomenta debe dar false ya que hay mas de una ocurrencia de OP1 y OP2

% Flujos Chatbot 0 
flow(1, "Flujo Principal Chatbot 0\nBienvenido\n¿De qué deseas hablar?", [OP1, OP2], F1),

% Flujos Chatbot 1
% Flujo 1 Chatbot 1
flow(1, "Flujo 1 Chatbot 1\n¿Qué tipo de películas te gustan?", [OP3, OP4, OP5], F2),
% flujo 2 chatbot 1
flow(2, "Flujo 2 Chatbot 1\n¿Cuáles son tus películas de Acción favoritas?", [OP6, OP7, OP8, OP9], F3),
% flujo 3 chatbot 1
flow(3, "Flujo 3 Chatbot 1\n¿Cuáles son tus películas de Animación favoritas?", [OP10, OP11, OP12], F4),

% Flujos chatbot 2
% Flujo 1 chatbot 2
flow(1, "Flujo 1 Chatbot 2\n¿Qué tipo de música te gusta?", [OP13, OP14, OP15], F5),
% Flujo 2 chatbot 2
flow(2, "Flujo 2 Chatbot 2\n¿Cuál es tu rapero favorito?", [OP16, OP17, OP18, OP19], F6),
% flujo 3 chatbot 2
flow(3, "Flujo 3 Chatbot 2\n¿Cuál es tu artista de Jazz favorito?", [OP20], F70),

%------------------------------flowAddOption--------------------------------
% flowAddOption(F70 , OP20, F71) % Si se descomenta da false, ya que se esta intentando introducir una opcion que ya esta en el flujo

% poniendo OP21 en F70
flowAddOption(F70 , OP21, F72),
% poniendo OP22 en F72
flowAddOption(F72, OP22, F73),
% poniendo OP23 en F73
flowAddOption(F73, OP23, F7),

%----------------------------Chatbot-----------------------------------
% chatbot(0, "Chatbot Inicial", "Bienvenido\n¿De qué quieres hablar?", 1, [F1, F1, F1], CB0), %Si se descomenta da false puesto a que hay mas de una ocurrencia de F1

% chatbot 0
chatbot(0, "Chatbot Inicial", "Bienvenido\n¿De qué quieres hablar?", 1, [F1], CB0), 

% chatbot 1
chatbot(1, "Chatbot Peliculas", "Bienvenido\n¿Qué tipos de películas te gustan?", 1, [F2,F3], CB98),

% chatbot 2
chatbot(2, "Chatbot Musica", "Bienvenido\n¿Qué tipo de música te gusta?", 1, [F5], CB100),

%---------------------------chatbotAddFlow--------------------------
% chatbotAddFlow(CB100, F5, CB101), % Si se descomenta arroja false puesto a que F5 ya esta en el chatbot

% poniendo F4 en CB98
chatbotAddFlow(CB98, F4, CB1),

% poniendo F6 en CB100
chatbotAddFlow(CB100, F6, CB102),

% poniendo F7 en CB102
chatbotAddFlow(CB102, F7, CB2),

%------------------------system-------------------------------
% system("Sistema de ejemplo1", 100, [CB0, CB1, CB0, CB2, CB0, CB2, CB1], S101), %Si se descomenta se retorna false, puesto a que hay mas de una ocurrencia de CB0, CB1, CB2

% Creando sistema de ejemplo2
system("Sistema de ejemplo2",100, [], S100),


% Creando sistema que se usara para los demas predicados
system("Chatbots Paradigmas", 0 , [CB0], S0),

%----------------------systemAddChatbot-----------------------
% systemAddChatbot(S0, CB0, S101), % Si se descomenta retorna false

% poniendo CB1 en CB1
systemAddChatbot(S0, CB1, S1),

% poniendo CB2 en S2
systemAddChatbot(S1, CB2, S2),

%-----------------------systemAddUser--------------------
%Añadiendo user1
systemAddUser(S2, "user1", S3),

%Añadiendo user2
systemAddUser(S3, "user2", S4),


% systemAddUser(S4, "user2", S101), % Si se descomenta retorna false puesto a que el usuario ya esta registrado

%Añadiendo user3
systemAddUser(S4, "user3", S5),

%--------------------systemLogin---------------------

% systemLogin(S5, "user4", S101), % si se descomenta retorna false ya que no esta registrado

% Logueando user2
systemLogin(S5, "user2", S6),

% systemLogin(S6, "user1", S101), % Si se descomenta retorna false ya que ya hay un usuario logueado

%--------------------systemLogout---------------------
% Se desloguea
systemLogout(S6, S7),

% systemLogout(S7, S101), % si se descomenta retorna false ya que no hay ningun usuario logueado
% systemLogout(S7, S102), % si se descomenta retorna false ya que no hay ningun usuario logueado

%--------------------systemTalkRec---------------------

% systemTalkRec(S7, "Hola", S101), % si se descomenta retorna false puesto que no hay usuario logueado

%Logueo a un usuario para poder probar los demas casos 
systemLogin(S7, "user2", S8),

systemTalkRec(S8, "Hola", S9),
systemTalkRec(S9, "1", S10),
systemTalkRec(S10, "Accion", S11),

%--------------------systemSynthesis---------------------
% formatea el historial del user2 y luego se imprime
systemSynthesis(S11, "user2", String),
write(String),

% Como el user1 esta registrado pero no ha interactuado con el sistema, simplemente imprime un mensaje en relaciona eso
systemSynthesis(S11, "user1", String2),
write(String2),

% Como el user4 no tiene historial y tampoco esta registrado, se mostrara un mensaje en relacion a eso
systemSynthesis(S11, "user4", String3),
write(String3),

%--------------------systemSimulate---------------------
% se hace una simulacion de 5 interacciones del usuario 3826523
systemSimulate(S11, 5, 3826523, S12),

% Se imprime el historial del usuario 3826523
systemSynthesis(S12, "user3826523", String4),
write(String4).


