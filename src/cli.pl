% launcher do programa
$ Recebe os argumentos da linha de comando e chama o modo adequado (iniciar ou rodar_teste)

% só dispara depois do comando: swipl

:- initialization(main, main).

main(Argv) :-
    ( Argv = ["interativo"] ->
        iniciar, halt
    ; Argv = ["teste", Arq] ->
        rodar_teste(Arq), halt
    ; Argv = ["teste_sn", Arq] ->
        rodar_teste_sn(Arq), halt
    ;
      halt(1)
    ).