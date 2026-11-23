UNIVERSIDADE DE BRASÍLIA  
INSTITUTO DE CIÊNCIAS EXATAS  
DEPARTAMENTO DE CIÊNCIA DA COMPUTAÇÃO  
DISCIPLINA: CIC0101 - SISTEMAS DE INFORMAÇÃO  

# MODELO ENTIDADE-RELACIONAMENTO (MER) CONCEITUAL — ENTREGA 3

## TEMA: SISTEMA DE COMUNICAÇÃO ESCOLAR

Este documento formaliza o **Modelo Entidade-Relacionamento (MER) Conceitual** do
**Sistema de Comunicação Escolar**, descrevendo o minimundo, as entidades do
domínio, a hierarquia de generalização/especialização, as entidades associativas,
os atributos próprios e as cardinalidades que regem as regras de negócio.

---

## 1. Minimundo e Regras de Negócio

O **Sistema de Comunicação Escolar** tem como objetivo centralizar a gestão
acadêmica básica e a comunicação institucional entre a escola, seus funcionários,
alunos e responsáveis. Toda pessoa cadastrada no sistema possui uma conta de
acesso vinculada a exatamente um **Nível de Acesso**, que define suas permissões
operacionais para criar, distribuir, avaliar, receber ou responder comunicados.

No domínio institucional, uma **Pessoa** especializa-se em **Aluno**,
**Responsável** ou **Funcionário** (podendo este atuar como professor,
coordenador, diretor, cantina, segurança ou faxina). **Alunos** e **Responsáveis**
vinculam-se por meio de relações de **Parentesco**, enquanto a vida acadêmica é
organizada em **Turmas** e **Disciplinas**, articuladas por **Ofertas Acadêmicas**
ministradas por professores. Nessas ofertas, os alunos são matriculados e têm
suas **Notas** e **Frequências** registradas.

No eixo de comunicação, **Funcionários** autorizados publicam **Avisos**, que
podem exigir fluxo de **Autorização**, ser direcionados por **Segmentações**
(para turmas, séries, pessoas específicas ou público geral) e gerar registros de
**Envio** por diferentes canais. Os usuários interagem com os avisos por meio de
**Visualizações**, **Reações** e **Comentários**. Além disso, **Responsáveis**
podem enviar **Mensagens** diretas a **Funcionários**, estabelecendo um fluxo
de atendimento que comporta múltiplas **Respostas**.

---

## 2. Entidades do Domínio, Especializações e Entidades Associativas

### 2.1. Entidades Fortes (Fundamentais)

| Entidade | Papel Conceitual no Domínio |
| :--- | :--- |
| **`NIVEL_ACESSO`** | Perfil de permissões que determina as ações permitidas aos usuários no fluxo de avisos e mensagens. |
| **`PESSOA`** | Entidade genérica que representa qualquer indivíduo cadastrado e autenticado no sistema. |
| **`TURMA`** | Agrupamento escolar definido por nome, ano letivo, sala e período de vigência. |
| **`DISCIPLINA`** | Componente curricular identificado por nome e código institucional. |
| **`OFERTA_ACADEMICA`** | Instância de ensino que vincula uma disciplina a uma turma e a um professor em horários específicos. |
| **`NOTA`** | Registro de avaliação acadêmica obtida por um aluno em uma oferta acadêmica. |
| **`FREQUENCIA`** | Registro diário de presença ou ausência de um aluno em uma aula de uma oferta acadêmica. |
| **`AVISO`** | Comunicado institucional produzido por um funcionário para divulgação escolar. |
| **`AVISO_SEGMENTACAO`** | Critério de direcionamento que define o público-alvo de um aviso. |
| **`AUTORIZACAO_AVISO`** | Registro de análise e aprovação (ou recusa) de um aviso antes de sua publicação. |
| **`ENVIO`** | Registro operacional da transmissão de um aviso através de um canal de comunicação. |
| **`COMENTARIO`** | Manifestação textual publicada por uma pessoa em um aviso. |
| **`MENSAGEM`** | Comunicação direta enviada por um responsável a um funcionário da instituição. |
| **`RESPOSTA_MENSAGEM`** | Retorno institucional vinculado a uma mensagem enviada anteriormente. |

### 2.2. Hierarquia de Generalização / Especialização

A entidade genérica **`PESSOA`** especializa-se nas seguintes subentidades, as
quais herdam integralmente sua identificação e atributos cadastrais básicos:

* **`ALUNO`:** Estudante vinculado à instituição de ensino.
* **`RESPONSAVEL`:** Pessoa encarregada legal ou familiarmente por um ou mais alunos.
* **`FUNCIONARIO`:** Colaborador da escola (professor, coordenador, diretor, cantina, segurança ou faxina).

### 2.3. Entidades Associativas

Representam relacionamentos N:N que possuem atributos próprios de negócio e são
identificados conceitualmente pelas entidades participantes:

* **`PARENTESCO`:** Materializa o vínculo familiar/legal entre **`ALUNO`** e **`RESPONSAVEL`**.
* **`ALUNO_TURMA` (Matrícula):** Materializa o vínculo acadêmico entre **`ALUNO`** e **`TURMA`**.
* **`VISUALIZACAO`:** Materializa o registro de leitura de um **`AVISO`** por uma **`PESSOA`**.
* **`REACAO_AVISO`:** Materializa a interação rápida (curtida, dúvida ou importância) de uma **`PESSOA`** em um **`AVISO`**.

---

## 3. Atributos Conceituais das Entidades

Cada entidade possui apenas seus atributos próprios de domínio, destacando-se o
**atributo identificador único (`id`)** e omitindo chaves estrangeiras (`*_id`):

* **`NIVEL_ACESSO`:** **`id`** *(identificador)*, `descricao`, `criar_msm`, `dist_msm`, `resp_msm`, `criar_aviso`, `aval_aviso`, `rcb_aviso`.
* **`PESSOA`:** **`id`** *(identificador)*, `usuario`, `email`, `nome`, `cpf`, `telefone`, `senha_hash`.
* **`ALUNO`** *(especialização de `PESSOA`)*: `matricula`, `serie`.
* **`RESPONSAVEL`** *(especialização de `PESSOA`)*: `telefone_emergencia`.
* **`FUNCIONARIO`** *(especialização de `PESSOA`)*: `registro_funcional`, `tipo`.
* **`PARENTESCO`** *(entidade associativa `ALUNO`–`RESPONSAVEL`)*: `grau_parentesco`.
* **`TURMA`:** **`id`** *(identificador)*, `nome`, `ano`, `sala`, `inicio_vigencia`, `fim_vigencia`.
* **`DISCIPLINA`:** **`id`** *(identificador)*, `nome`, `codigo`.
* **`ALUNO_TURMA`** *(entidade associativa `ALUNO`–`TURMA`)*: `data_matricula`, `status_matricula`.
* **`OFERTA_ACADEMICA`:** **`id`** *(identificador)*, `dias`, `turnos`, `horarios`, `hora_inicio`, `hora_fim`.
* **`NOTA`:** **`id`** *(identificador)*, `valor_nota`, `nome_avaliacao`, `data_lancamento`.
* **`FREQUENCIA`:** **`id`** *(identificador)*, `data_aula`, `status_presenca`.
* **`AVISO`:** **`id`** *(identificador)*, `titulo`, `descricao`, `formato`, `url`, `exige_autorizacao`, `nivel_urgencia`, `data_criacao`, `data_publicacao`, `status`.
* **`AVISO_SEGMENTACAO`:** **`id`** *(identificador)*, `tipo_alvo`, `referencia_alvo` *(identificador lógico do alvo quando aplicável)*.
* **`AUTORIZACAO_AVISO`:** **`id`** *(identificador)*, `data_solicitacao`, `data_avaliacao`, `status`, `feedback`.
* **`ENVIO`:** **`id`** *(identificador)*, `data_envio`, `canal`, `tipo_segmentacao`.
* **`VISUALIZACAO`** *(entidade associativa `AVISO`–`PESSOA`)*: `data_hora_visualizacao`.
* **`REACAO_AVISO`** *(entidade associativa `AVISO`–`PESSOA`)*: `tipo`.
* **`COMENTARIO`:** **`id`** *(identificador)*, `texto`, `data_criacao`.
* **`MENSAGEM`:** **`id`** *(identificador)*, `titulo`, `descricao`, `formato`, `url`, `tipo`, `data_criacao`, `status`.
* **`RESPOSTA_MENSAGEM`:** **`id`** *(identificador)*, `titulo`, `descricao`, `data_criacao`.

---

## 4. Relacionamentos, Verbos e Cardinalidades (Mínima, Máxima)

A tabela a seguir especifica os relacionamentos semânticos e suas cardinalidades
`(mínima, máxima)`:

| Entidade Origem | Card. (Origem) | Verbo | Card. (Destino) | Entidade Destino | Regra de Negócio Associada |
| :--- | :---: | :---: | :---: | :--- | :--- |
| **`NIVEL_ACESSO`** | `(1,1)` | *define* | `(1,n)` | **`PESSOA`** | Um nível de acesso define uma ou mais pessoas; cada pessoa possui exatamente um nível de acesso. |
| **`ALUNO`** | `(0,n)` | *possui* (`PARENTESCO`) | `(0,n)` | **`RESPONSAVEL`** | Um aluno pode possuir vários responsáveis e um responsável pode vincular-se a vários alunos. |
| **`ALUNO`** | `(0,n)` | *engloba* (`ALUNO_TURMA`) | `(0,n)` | **`TURMA`** | Um aluno pode matricular-se em várias turmas e uma turma pode conter vários alunos. |
| **`TURMA`** | `(1,1)` | *possui* | `(0,n)` | **`OFERTA_ACADEMICA`** | Uma turma possui várias ofertas acadêmicas; cada oferta pertence a uma única turma. |
| **`DISCIPLINA`** | `(1,1)` | *compõe* | `(0,n)` | **`OFERTA_ACADEMICA`** | Uma disciplina compõe várias ofertas; cada oferta refere-se a uma única disciplina. |
| **`FUNCIONARIO`** | `(1,1)` | *ministra* | `(0,n)` | **`OFERTA_ACADEMICA`** | Um funcionário (professor) ministra várias ofertas; cada oferta é ministrada por um professor. |
| **`OFERTA_ACADEMICA`** | `(1,1)` | *registra* | `(0,n)` | **`NOTA`** | Uma oferta acadêmica registra várias notas; cada nota pertence a uma única oferta. |
| **`ALUNO`** | `(1,1)` | *recebe* | `(0,n)` | **`NOTA`** | Um aluno recebe várias notas; cada nota pertence a um único aluno. |
| **`OFERTA_ACADEMICA`** | `(1,1)` | *controla* | `(0,n)` | **`FREQUENCIA`** | Uma oferta acadêmica controla vários registros de frequência; cada registro pertence a uma oferta. |
| **`ALUNO`** | `(1,1)` | *acumula* | `(0,n)` | **`FREQUENCIA`** | Um aluno acumula vários registros de frequência; cada registro pertence a um aluno. |
| **`FUNCIONARIO`** | `(1,1)` | *cria* | `(0,n)` | **`AVISO`** | Um funcionário cria vários avisos; cada aviso possui um único autor. |
| **`AVISO`** | `(1,1)` | *segmenta* | `(1,n)` | **`AVISO_SEGMENTACAO`** | Um aviso possui uma ou mais segmentações de público; cada segmentação pertence a um aviso. |
| **`AVISO`** | `(1,1)` | *requer* | `(0,n)` | **`AUTORIZACAO_AVISO`** | Um aviso pode gerar várias solicitações de autorização; cada autorização refere-se a um aviso. |
| **`FUNCIONARIO`** | `(1,1)` | *avalia* | `(0,n)` | **`AUTORIZACAO_AVISO`** | Um funcionário avalia várias autorizações; cada autorização é avaliada por um funcionário. |
| **`AVISO`** | `(1,1)` | *gera* | `(0,n)` | **`ENVIO`** | Um aviso pode gerar vários envios; cada envio pertence a um único aviso. |
| **`AVISO`** | `(0,n)` | *realiza* (`VISUALIZACAO`) | `(0,n)` | **`PESSOA`** | Um aviso pode ser visualizado por várias pessoas e uma pessoa pode visualizar vários avisos. |
| `AVISO` | `(0,n)` | *realiza* (`REACAO_AVISO`) | `(0,n)` | **`PESSOA`** | Um aviso pode receber reações de várias pessoas e uma pessoa pode reagir a vários avisos. |
| `AVISO` | `(1,1)` | *possui* | `(0,n)` | **`COMENTARIO`** | Um aviso pode conter vários comentários; cada comentário pertence a um único aviso. |
| `PESSOA` | `(1,1)` | *compõe* | `(0,n)` | **`COMENTARIO`** | Uma pessoa pode escrever vários comentários; cada comentário tem um único autor. |
| `RESPONSAVEL` | `(1,1)` | *envia* | `(0,n)` | **`MENSAGEM`** | Um responsável pode enviar várias mensagens; cada mensagem possui um único remetente. |
| `FUNCIONARIO` | `(1,1)` | *recebe* | `(0,n)` | **`MENSAGEM`** | Um funcionário pode receber várias mensagens; cada mensagem possui um único destinatário. |
| `MENSAGEM` | `(1,1)` | *possui* | `(0,n)` | **`RESPOSTA_MENSAGEM`** | Uma mensagem pode possuir várias respostas; cada resposta vincula-se a uma única mensagem. |

## 5. Regras de Integridade Semântica e Domínios Conceituais

### 5.1. Unicidade de Identificação: Os atributos usuario e email de PESSOA são únicos em todo o domínio.

### 5.2. Domínio de Especialização (FUNCIONARIO): O atributo tipo assume exclusivamente PROFESSOR, COORDENADOR, DIRETOR, CANTINA, SEGURANCA ou FAXINA.

### 5.3. Domínio de Matrícula (ALUNO_TURMA): O atributo status_matricula assume MATRICULADO, DESMATRICULADO, TRANSFERIDO ou CONCLUIDO.

### 5.4. Domínio de Oferta Acadêmica: Em OFERTA_ACADEMICA, dias restringe-se aos dias úteis; turnos assume MANHA, TARDE ou NOITE; e horarios assume valores de 1 a 6.

### 5.5. Domínio de Frequência: Em FREQUENCIA, status_presenca assume PRESENTE, AUSENTE ou JUSTIFICADO.

### 5.6. Domínio de Comunicação (AVISO, SEGMENTACAO, REACAO):
	• formato (em AVISO e MENSAGEM) assume TEXTO, IMAGEM ou DOCUMENTO.
	• tipo_alvo (em AVISO_SEGMENTACAO) assume TURMA, SERIE, PESSOA ou TODOS.
	• status (em AUTORIZACAO_AVISO) assume CONFIRMADA, RECUSADA, EM_ANALISE, NAO_VISUALIZADA ou CORRECAO.
	• tipo (em REACAO_AVISO) assume CURTIR, DUVIDA ou IMPORTANTE.
	• tipo (em MENSAGEM) assume SUGESTAO, DUVIDA, CRITICA, ELOGIO, DENUNCIA ou OUTRO.
	• status (em MENSAGEM) assume AGUARDANDO DISTRIBUIÇÃO, EM ANÁLISE, AGUARDANDO REDISTRIBUIÇÃO ou RESPONDIDO.

## 6. Diagrama Entidade-Relacionamento (DER Conceitual)

O diagrama visual correspondente a este MER utiliza a notação conceitual de Peter Chen (brModelo), onde:
• Retângulos representam as entidades do domínio e as especializações de PESSOA;
• Losangos representam os relacionamentos verbais e suas cardinalidades (mínima, máxima);
• Retângulos com losango interno representam as entidades associativas (PARENTESCO, ALUNO_TURMA, VISUALIZACAO e REACAO_AVISO);
• Elipses representam os atributos próprios de cada entidade, destacando apenas o identificador id em preenchimento sólido e omitindo chaves estrangeiras.

## 7. Diagrama do Modelo Relacional (MR em PlantUML)

O diagrama lógico correspondente à tradução deste MER para o paradigma relacional
utiliza a **notação de Engenharia de Informação (Crow's Foot / Pé-de-Galinha)
gerada via PlantUML**, organizado em três pacotes de domínio (*Módulo Acadêmico*,
*Pessoas e Controle de Acesso* e *Comunicação e Avisos*), onde:
* **Blocos de entidade (`entity`)** representam as tabelas relacionais com seus
  respectivos tipos de dados;
* **Atributos internos** discriminam explicitamente as chaves primárias (**`PK`**),
  chaves estrangeiras (**`FK`**), restrições de unicidade (**`UNIQUE`**) e
  regras de domínio (**`CHECK`**);
* **Linhas de conexão** representam as associações de integridade referencial
  entre as tabelas e suas respectivas cardinalidades relacionais.
