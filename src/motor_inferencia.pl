% Uma caracteristica conta ponto se a(s) pergunta(s) associada(s) recebeu/ram "sim".
respondeu_positivo(Carac) :-
    pergunta(Id, _, Carac),
    resposta(Id, sim).

% Calcula pontuacao por trilha e coleta explicacoes (Carac,Peso)
calcula_pontuacao(Trilha, Pontuacao, Explicacoes) :-
    findall((Carac,Peso),
        ( perfil(Trilha, Carac, Peso),
          respondeu_positivo(Carac)
        ),
        Pares),
    soma_pesos(Pares, Pontuacao),
    Explicacoes = Pares.

% Soma de pesos
% Soma de pesos
-soma_pesos([(_,P)|Ts], S) :-
-    soma_pesos(Ts, S1),
-    S is S1 + P.
+soma_pesos([(Carac,P)|Ts], S) :-
+    soma_pesos(Ts, S1),
+    S is S1 + P.

% Ranking decrescente (Pontuacao, Trilha, Explicacoes)
ranking_trilhas(Ranking) :-
    findall((Pont, Trilha, Explic),
        ( trilha(Trilha,_),
          calcula_pontuacao(Trilha, Pont, Explic)
        ),
        Pares),
    sort(0, @>=, Pares, Ranking).
