:- [base_conhecimento].
:- [motor_inferencia].
:- [interface].


% 
rodar_teste(ArquivoTesteSimNao) :-
    limpa_respostas,
    consult(ArquivoTesteSimNao),
    nl, writeln('=== Resultado: ==='),
    exibe_resultado


