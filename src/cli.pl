% launcher do programa
% Recebe os argumentos da linha de comando e chama o modo adequado (iniciar ou rodar_teste)

:- [main].  % carrega base_conhecimento, motor_inferencia e interface

:- initialization(main, main).

main(ArgvRaw) :-
    % Normaliza todos os argumentos para átomos minúsculos (para comparar)
    maplist(to_lower_atom, ArgvRaw, ArgsLower),
    % Também preserva os argumentos originais para repassar caminhos (com maiúsculas/espacos)
    ( ArgsLower = [interativo] ->
        iniciar, halt
    ; ArgsLower = [teste, _] ->
        % pega o segundo argumento original (pode ser string/átomo) e converte para string
        nth1(2, ArgvRaw, ArqRaw),
        to_string_any(ArqRaw, ArqStr),
        rodar_teste(ArqStr), halt
    ; ArgsLower = [teste_sn, _] ->
        nth1(2, ArgvRaw, ArqRaw2),
        to_string_any(ArqRaw2, ArqStr2),
        rodar_teste_sn(ArqStr2), halt
    ;
        usage, halt(1)
    ).

% Converte qualquer termo para átomo minúsculo (para comparação de comandos)
to_lower_atom(Term, LowerAtom) :-
    (  atom(Term)    -> atom_string(Term, S0)
    ;  string(Term)  -> S0 = Term
    ;  number(Term)  -> number_string(Term, S0)
    ;  % fallback
       term_string(Term, S0)
    ),
    string_lower(S0, S1),
    atom_string(LowerAtom, S1).

% Converte qualquer termo para string (para repassar caminhos de arquivo ao consult/1)
to_string_any(Term, Str) :-
    (  string(Term) -> Str = Term
    ;  atom(Term)   -> atom_string(Term, Str)
    ;  number(Term) -> number_string(Term, Str)
    ;  term_string(Term, Str)
    ).

usage :-
    format(user_error,
        "Uso: -- interativo | teste <arquivo.pl> | teste_sn <arquivo.pl>~n", []).
