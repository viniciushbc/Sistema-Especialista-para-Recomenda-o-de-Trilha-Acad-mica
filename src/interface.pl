:- dynamic resposta/2.  % resposta(IdPergunta, sim|nao).

limpa_respostas :- retractall(resposta(_,_)).

le_sn(Ans) :-
    read_line_to_string(user_input, S0),
    normalize_space(string(S1), S0),
    string_lower(S1, L),
    ( L = "sim" -> Ans = sim
    ; L = "nao" -> Ans = nao
    ; writeln('Por favor responda apenas com sim ou nao.'),
      le_sn(Ans)
    ).

faz_perguntas :-
    forall(pergunta(Id, Texto, _Carac),
        ( format('~w', [Texto]),
          flush_output,
          le_sn(Ans),
          assertz(resposta(Id, Ans))
        )
    ).

exibe_explicacoes([]).
exibe_explicacoes([(Carac,Peso)|Ts]) :-
    format('   - ~w (+~d)~n', [Carac, Peso]),
    exibe_explicacoes(Ts).

exibe_ranking([]).
exibe_ranking([(Pont, Trilha, Explic)|Rs]) :-
    trilha(Trilha, Desc),
    format('~nTrilha: ~w (~w pontos)~n', [Trilha, Pont]),
    format('Descricao: ~w~n', [Desc]),
    ( Explic = [] ->
        format('  (Nenhuma resposta positiva contribuiu)~n', [])
    ; format('  Contribuicoes:~n', []),
      exibe_explicacoes(Explic)
    ),
    exibe_ranking(Rs).

exibe_resultado :-
    ranking_trilhas(R),
    ( R = [] ->
        writeln('Nenhuma trilha cadastrada ou nenhum calculo possivel.')
    ; exibe_ranking(R),
      nl, writeln('Recomendacao principal (topo do ranking) exibida acima.')
    ).

iniciar :-
    limpa_respostas,
    writeln('=== Sistema Especialista: Trilha Academica ==='),
    writeln('Responda sim/nao as perguntas.'),
    faz_perguntas,
    nl, writeln('=== Resultado ==='),
    exibe_resultado.
