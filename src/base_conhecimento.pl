% Trilhas
trilha(inteligencia_artificial, 'IA: aprendizado de maquina, raciocinio e agentes.').
trilha(desenvolvimento_web,   'Web: front-end/back-end, APIs e UX.').
trilha(seguranca_da_informacao,'Seguranca: defesa, ofensiva etica e conformidade.').
trilha(ciencia_de_dados,      'Ciencia de Dados: estatistica, ML e visualizacao.').
trilha(redes_e_infraestrutura,'Redes/Infra: sistemas, redes, DevOps e nuvem.').

% Caracteristicas (Trilha, Caracteristica, Peso)
perfil(ciencia_de_dados,        matematica_estatistica,     5).
perfil(ciencia_de_dados,        programacao_python,         4).
perfil(inteligencia_artificial, pensamento_abstrato,        4).
perfil(inteligencia_artificial, programacao_python,         4).
perfil(desenvolvimento_web,     design_visual,              3).
perfil(desenvolvimento_web,     programacao_javascript,     5).
perfil(seguranca_da_informacao, curiosidade_forense,        4).
perfil(seguranca_da_informacao, mentalidade_defensiva,      5).
perfil(redes_e_infraestrutura,  sistemas_operacionais,      5).
perfil(redes_e_infraestrutura,  redes_computadores,         5).

% Perguntas (Id, Texto, Caracteristica)
pergunta(1, 'Voce tem afinidade com matematica e estatistica? (sim/nao) ', matematica_estatistica).
pergunta(2, 'Voce se sente confortavel programando em Python? (sim/nao) ', programacao_python).
pergunta(3, 'Voce gosta de pensar em modelos/algoritmos abstratos? (sim/nao) ', pensamento_abstrato).
pergunta(4, 'Voce curte criar interfaces e se preocupa com UX/design? (sim/nao) ', design_visual).
pergunta(5, 'Voce programa em JavaScript e gosta de Web? (sim/nao) ', programacao_javascript).
pergunta(6, 'Voce tem interesse em investigar incidentes e fraudes? (sim/nao) ', curiosidade_forense).
pergunta(7, 'Voce pensa bastante em mitigacao de riscos? (sim/nao) ', mentalidade_defensiva).
pergunta(8, 'Voce gosta de mexer com SOs (Linux/Windows) e servidores? (sim/nao) ', sistemas_operacionais).
pergunta(9, 'Voce gosta de redes, roteamento e protocolos? (sim/nao) ', redes_computadores).
