# Sistema Especialista para Recomendação de Trilha Acadêmica (Prolog)

Projeto em **SWI-Prolog** que recomenda uma ou mais **trilhas de especialização** (IA, Web, Segurança, Ciência de Dados, Redes/Infra) com base em um **questionário interativo** de respostas `sim/nao`.  
O sistema calcula uma **pontuação por trilha**, exibe um **ranking** e **justifica** a recomendação pelas características que contribuíram.

---

## Requisitos

- **SWI-Prolog**
  - Windows: instale pelo `.exe` oficial. Se `swipl` não estiver no PATH, use o caminho completo:
    `C:\Program Files\swipl\bin\swipl.exe`
  - macOS: `brew install swi-prolog`
  - Debian/Ubuntu: `sudo apt install swi-prolog`

---

## Estrutura do repositório

```text
PROLOGTRILHAACADEMICA/
├─ src/
│  ├─ base_conhecimento.pl    # trilha/2, perfil/3, pergunta/3
│  ├─ motor_inferencia.pl     # respondeu_positivo/1, calcula_pontuacao/3, ranking_trilhas/1
│  ├─ interface.pl            # I/O e fluxo: le_sn/1, faz_perguntas/0, exibe_resultado/0, iniciar/0
│  ├─ main.pl                 # (Núcleo) inclui os módulos e runners de teste
│  └─ cli.pl                  # (Launcher) ponto de entrada via terminal (initialization/2)
└─ tests/
   ├─ perfil_1.pl             # respostas predefinidas
   ├─ perfil_2.pl
   └─ perfil_3.pl
````

> **Formato esperado dos testes**
>
> * Nativo (`sim/nao`):
>
>   ```prolog
>   resposta(1, sim).
>   resposta(2, nao).
>   ```
> * Alternativo (enunciado `s/n`) — use o comando `teste_sn`:
>
>   ```prolog
>   resposta(1, s).
>   resposta(2, n).
>   ```

---

## Como executar

> Rode os comandos a partir da **raiz do projeto**.
> O launcher aceita argumentos **case-insensitive** e não permite **misturar modos** na mesma chamada.

### Interativo (questionário `sim/nao`)

* **Windows (caminho completo):**

  ```powershell
  & "C:\Program Files\swipl\bin\swipl.exe" -q -s ".\src\cli.pl" -- interativo
  ```

* **Se `swipl` estiver no PATH (Windows/macOS/Linux):**

  ```bash
  swipl -q -s src/cli.pl -- interativo
  ```

### Testes automatizados (arquivos em `tests/`)

**Arquivos no formato `sim/nao`:**

```bash
swipl -q -s src/cli.pl -- teste tests/perfil_1.pl
swipl -q -s src/cli.pl -- teste tests/perfil_2.pl
swipl -q -s src/cli.pl -- teste tests/perfil_3.pl
```

**Arquivos no formato `s/n`:**

```bash
swipl -q -s src/cli.pl -- teste_sn tests/perfil_1.pl
swipl -q -s src/cli.pl -- teste_sn tests/perfil_2.pl
swipl -q -s src/cli.pl -- teste_sn tests/perfil_3.pl
```

> **Dica (Windows):** se o caminho tiver espaços, mantenha as aspas:
> `-- teste ".\tests\perfil_1.pl"`

---

## O que cada arquivo faz

* **`src/base_conhecimento.pl`**
  Fatos do domínio: `trilha/2`, `perfil/3`, `pergunta/3`.

* **`src/motor_inferencia.pl`**
  Regras: `respondeu_positivo/1`, `calcula_pontuacao/3`, `soma_pesos/2`, `ranking_trilhas/1`
  (ordenado com `predsort/3` por pontuação **decrescente**).

* **`src/interface.pl`**
  Entrada/saída e fluxo: `resposta/2 (dynamic)`, `limpa_respostas/0`, `le_sn/1`,
  `faz_perguntas/0`, `exibe_explicacoes/1`, `exibe_ranking/1`, `exibe_resultado/0`, `iniciar/0`.

* **`src/main.pl`**
  Inclui os módulos e fornece:

  * `rodar_teste/1` (para arquivos `sim/nao`)
  * `rodar_teste_sn/1` (para arquivos `s/n`)

* **`src/cli.pl`**
  Ponto de entrada via terminal (`:- initialization(main, main).`) aceitando:

  * `-- interativo`
  * `-- teste <arquivo.pl>`
  * `-- teste_sn <arquivo.pl>`

---

## Como criar novos testes

1. Crie um arquivo em `tests/` **apenas** com fatos `resposta/2`:

   ```prolog
   % tests/perfil_meu.pl
   resposta(1, sim).
   resposta(2, nao).
   ...
   ```
2. Execute:

   ```bash
   swipl -q -s src/cli.pl -- teste tests/perfil_meu.pl
   ```

   (ou `teste_sn` se estiver usando `s/n`).

> **Não** é necessário declarar `:- dynamic resposta/2.` dentro dos arquivos de teste (mas não há problema se existir).

---

## SWISH (online)

O SWISH roda em **sandbox** e bloqueia `:- initialization/2` e `consult/1`.
Para testar no SWISH:

* cole os módulos numa aba (ou use a versão “arquivo único” sem `initialization/consult`),
* chame `iniciar.` diretamente.
  Testes via arquivos externos não funcionam no SWISH.

---

## Solução de problemas

* **`swipl` não é reconhecido (Windows)**
  Use o executável completo:

  ```powershell
  & "C:\Program Files\swipl\bin\swipl.exe" --version
  ```

  ou adicione `C:\Program Files\swipl\bin` ao PATH e reabra o PowerShell.

* **“script_file … does not exist”**
  Verifique que o `-s` aponta para um **arquivo .pl** e que você está na **raiz** do projeto:

  ```powershell
  dir .\src\cli.pl
  ```

* **Erros de inclusão**
  Confirme que `main.pl` contém:

  ```prolog
  :- [base_conhecimento].
  :- [motor_inferencia].
  :- [interface].
  ```

* **Ranking não ordena corretamente**
  O projeto usa `predsort/3` com comparador próprio, compatível com versões antigas e novas do SWI-Prolog.

---

## Créditos

* **Instituição / Disciplina / Professor:** *Pontifícia Universidade Católica do Paraná / Programação Lógica e Funcional / FRANK COELHO DE ALCANTARA*
* **Grupo (ordem alfabética):**

  * Davi Marques Caldeira — davi-caldeira
  * Hiago Bernardo da Silva — MISTICxxx
  * João Victor Balvedi — JoaoVictorBalvedi
  * Vinícius Henrique Budag Coelho — viniciushbc

---

## Como validar agora

* **Interativo**

  ```bash
  swipl -q -s src/cli.pl -- interativo
  ```

* **Teste `sim/nao`**

  ```bash
  swipl -q -s src/cli.pl -- teste tests/perfil_1.pl
  ```

* **Teste `s/n`**

  ```bash
  swipl -q -s src/cli.pl -- teste_sn tests/perfil_2.pl
  ```

