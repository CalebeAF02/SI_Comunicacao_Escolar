UNIVERSIDADE DE BRASÍLIA
INSTITUTO DE CIÊNCIAS EXATAS
DEPARTAMENTO DE CIÊNCIA DA COMPUTAÇÃO
DISCIPLINA: CIC0101 - SISTEMAS DE INFORMAÇÃO

# MODELO ENTIDADE-RELACIONAMENTO TEXTUAL (ENTREGA 3)

## TEMA: SISTEMA DE COMUNICAÇÃO ESCOLAR

### Descrição Conceitual e Regras de Negócio do Modelo Conceitual

1. **PESSOA, ALUNO, PAIS, PROFESSOR, COORDENADOR e DIRETOR (Herança e Nível de Acesso):** A entidade Pessoa concentra os dados comuns necessários ao sistema: id, nome, email, telefone, senha_hash e nivel_acesso. Pessoa se especializa de forma exclusiva em ALUNO, PAIS, PROFESSOR, COORDENADOR ou DIRETOR, sendo cada especialização identificada pela chave pessoa_id, que referencia Pessoa.id. ALUNO possui matricula; PAIS possui grau_parentesco; PROFESSOR possui registro_funcional; COORDENADOR possui setor; DIRETOR não exige atributos próprios além dos dados herdados. O atributo nivel_acesso define as funcionalidades, permissões, segmentação dos avisos e visualização do feed: DIRETOR, COORDENADOR, PROFESSOR, PAIS ou ALUNO.

2. **TURMA:** A entidade Turma representa uma divisão acadêmica organizada pela escola. Seus atributos são id, professor_orientador_id, nome, ano, turno, inicio_vigencia e fim_vigencia. professor_orientador_id é uma chave estrangeira que referencia PROFESSOR e indica o professor responsável pela orientação da Turma. Uma Turma possui um professor orientador e pode oferecer uma ou mais Disciplinas.

3. **DISCIPLINA:** A entidade Disciplina corresponde aos componentes curriculares comunicados pela escola. Ela possui os atributos id, nome e codigo. Uma Disciplina pode estar associada a uma ou mais Turmas, dependendo da organização acadêmica do período.

4. **TURMA_DISCIPLINA_PROFESSOR_HORARIO (Oferta Acadêmica):** TURMA, DISCIPLINA e PROFESSOR se relacionam por meio da entidade associativa TURMA_DISCIPLINA_PROFESSOR_HORARIO. Cada registro contém turma_id, disciplina_id e professor_id e identifica a associação da disciplina ministrada pelo professor em uma turma. Esta entidade associativa se relaciona com HORARIO, que possui id, dia_semana, hora_inicio e hora_fim. O atributo dia_semana é um enum limitado aos dias úteis, podendo assumir SEGUNDA, TERCA, QUARTA, QUINTA ou SEXTA. hora_inicio e hora_fim são atributos do tipo time. Uma turma pode possuir várias ofertas, uma disciplina pode ser ministrada em várias turmas, um professor pode ministrar várias ofertas e cada oferta pode possuir um ou mais horários.

5. **ALUNO_TURMA (Matrícula na Turma):** ALUNO e TURMA se relacionam por meio da entidade associativa n:m ALUNO_TURMA. Cada registro contém aluno_id e turma_id, que juntas identificam de forma única o vínculo entre o estudante e a Turma. Um ALUNO pode estar vinculado a várias Turmas ao longo de sua trajetória escolar, enquanto uma Turma pode conter vários Alunos.

6. **CATEGORIA_AVISO:** A entidade Categoria_Aviso agrupa os avisos de acordo com sua finalidade institucional. Ela possui os atributos id, nome e exige_moderacao. Uma Categoria pode classificar vários Avisos, mas cada Aviso pertence a uma única Categoria. O atributo exige_moderacao determina se o fluxo de aprovação institucional deve ser iniciado antes da publicação.

7. **AVISO:** A entidade Aviso representa a comunicação criada e distribuída pelo sistema. Seus atributos são id, autor_id, categoria_id, titulo, descricao, arquivo, tipo, nivel_urgencia, data_criacao, data_publicacao e status. Cada Aviso é criado por uma única Pessoa, que exerce a função de autor, e deve estar vinculado a uma única Categoria_Aviso. O status registra se o Aviso está em elaboração, aguardando avaliação, aprovado, publicado ou rejeitado.

8. **SOLICITACAO_AUTORIZACAO (Moderação):** A entidade Solicitação_Autorizacao registra o fluxo de aprovação dos Avisos restritos ou sujeitos à moderação. Ela possui os atributos id, aviso_id, avaliador_id, data_solicitacao, data_avaliacao, decisao e feedback. Cada solicitação é vinculada a um único Aviso e a uma única Pessoa responsável pela avaliação. Um Aviso pode gerar uma ou mais solicitações, permitindo correções, nova avaliação ou histórico de decisões.

9. **ENVIO:** A entidade Envio representa a operacionalização da distribuição de um Aviso já liberado para publicação. Seus atributos são id, aviso_id, data_envio, canal e tipo_segmentacao. Um Aviso pode gerar um ou mais Envios, mas cada Envio pertence a um único Aviso. O canal indica o meio utilizado para a comunicação, enquanto tipo_segmentacao informa se os destinatários foram definidos por turma, grupo, função ou seleção específica.

10. **ENVIO_DESTINATARIO (Segmentação):** O relacionamento n:m entre Envio e Pessoa é representado pela entidade associativa Envio_Destinatario. Cada registro é identificado pelas chaves envio_id e pessoa_id, que juntas formam uma chave composta. Um Envio pode ser direcionado a várias Pessoas, e uma Pessoa pode receber vários Envios. Essa entidade permite segmentar cada comunicação sem duplicar o conteúdo do Aviso.

11. **CONTROLE_RECEBIMENTO:** A entidade Controle_Recebimento registra a interação dos destinatários com cada Envio. Seus atributos são id, envio_destinatario_envio_id, envio_destinatario_pessoa_id, data_visualizacao e data_recebimento. Cada registro é associado a um único par Envio-Destinatário e mantém o histórico da entrega e da visualização da comunicação. A identificação do perfil do destinatário é obtida por PESSOA.nivel_acesso, permitindo controlar separadamente o recebimento e a visualização dos avisos pelos perfis DIRETOR, COORDENADOR, PROFESSOR, PAIS e ALUNO.