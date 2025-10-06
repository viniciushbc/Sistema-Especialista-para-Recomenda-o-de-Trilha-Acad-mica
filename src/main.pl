:- [base_conhecimento].
:- [motor_inferencia].
:- [interface].

% funcao que roda o arquivo de teste (sim/nao)
rodar_teste(ArquivoTesteSimNao) :-
    limpa_respostas,                    % limpa as respostas anteriores, no interface.pl
    consult(ArquivoTesteSimNao),        % carrega o arquivo.pl de teste
    nl, writeln('=== Resultado: ==='),
    exibe_resultado.                    % <--- ponto final aqui!

% Mesma funcao acima, mas converte as respostas 's/n' para 'sim/nao'
rodar_teste_sn(ArquivoTesteSN) :-
    limpa_respostas,
    consult(ArquivoTesteSN),
    forall(resposta(Id, Resp),
        ( (Resp == s -> R2 = sim ; Resp == n -> R2 = nao),
          retract(resposta(Id, Resp)),
          assertz(resposta(Id, R2))
        )
    ),
    nl, writeln('=== Resultado: ==='),
    exibe_resultado.
