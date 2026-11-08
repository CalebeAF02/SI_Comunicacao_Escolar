UNIVERSIDADE DE BRASÍLIA
INSTITUTO DE CIÊNCIAS EXATAS
DEPARTAMENTO DE CIÊNCIA DA COMPUTAÇÃO
DISCIPLINA: CIC0101 - SISTEMAS DE INFORMAÇÃO

# MODELO ENTIDADE-RELACIONAMENTO TEXTUAL (ENTREGA 3)

## TEMA: SISTEMA DE COMUNICAÇÃO ESCOLAR

### Descrição Conceitual e Regras de Negócio do Modelo

1. **PESSOA e NIVEL_ACESSO:** PESSOA possui id como identificador, além de usuario, email, nome, cpf, telefone, senha_hash e nivel_acesso_id. usuario e email são únicos. NIVEL_ACESSO possui id, descricao e os atributos de permissão criar_msm, dist_msm, resp_msm, criar_aviso, aval_aviso e rcb_aviso. Um nível de acesso define uma ou mais Pessoas, enquanto cada Pessoa possui exatamente um nível de acesso.

2. **Especialização de PESSOA:** ALUNO, RESPONSAVEL e FUNCIONARIO são especializações de PESSOA. A chave pessoa_id identifica cada especialização e é herdada da Pessoa correspondente. ALUNO possui matricula e serie; RESPONSAVEL possui telefone_emergencia; FUNCIONARIO possui registro_funcional e um tipo entre PROFESSOR, CORDENADOR, DIRETOR, CANTINA, SEGURANCA e FAXINA. Uma Pessoa pode pertencer a uma das especializações permitidas pelo sistema.

3. **PARENTESCO:** A associação entre ALUNO e RESPONSAVEL é representada por PARENTESCO. A chave primária composta é formada por aluno_id e responsavel_id, e a entidade possui grau_parentesco. Um Aluno pode possuir vários responsáveis, um Responsável pode estar relacionado a vários Alunos e cada associação representa exatamente um vínculo.

4. **TURMA:** TURMA possui id, nome, ano, sala, inicio_vigencia e fim_vigencia. Uma Turma pode receber matrículas de vários Alunos e pode possuir várias ofertas acadêmicas.

5. **DISCIPLINA:** DISCIPLINA possui id, nome e codigo. Uma Disciplina pode aparecer em várias ofertas acadêmicas, permitindo que ela seja oferecida para diferentes Turmas ou períodos.

6. **ALUNO_TURMA (Matrícula):** ALUNO_TURMA representa o relacionamento entre ALUNO e TURMA. Sua chave composta é formada por aluno_id e turma_id. Possui data_matricula e status_matricula, limitado a MATRICULADO, DESMATRICULADO, TRANSFERIDO ou CONCLUIDO. Um Aluno pode ter matrículas em várias Turmas, e uma Turma pode conter vários Alunos.

7. **OFERTA_ACADEMICA:** OFERTA_ACADEMICA possui id, turma_id, disciplina_id, professor_id, dias, turnos, horarios, hora_inicio e hora_fim. dias é limitado aos dias úteis; turnos assume MANHA, TARDE ou NOITE; e horarios assume 1 a 6. Uma Turma possui várias ofertas, uma Disciplina compõe várias ofertas e um funcionário do tipo professor pode ministrar várias ofertas.

8. **NOTA:** NOTA possui id, oferta_academica_id, aluno_id, valor_nota, nome_avaliacao e data_lancamento. Cada Nota é registrada em uma única Oferta Acadêmica e pertence a um único Aluno. Uma Oferta Acadêmica pode registrar várias notas, e um Aluno pode receber várias notas.

9. **FREQUENCIA:** FREQUENCIA possui id, oferta_academica_id, aluno_id, data_aula e status_presenca. Seu status é PRESENTE, AUSENTE ou JUSTIFICADO. Uma Oferta Acadêmica controla várias frequências, e um Aluno acumula registros de frequência em várias ofertas.

10. **AVISO:** AVISO possui id, autor_id, titulo, descricao, formato, url, exige_autorizacao, nivel_urgencia, data_criacao, data_publicacao e status. autor_id referencia o funcionário que criou o Aviso. formato é TEXTO, IMAGEM ou DOCUMENTO. Um funcionário pode criar vários Avisos, mas cada Aviso possui um único autor.

11. **AVISO_SEGMENTACAO:** AVISO_SEGMENTACAO possui id, aviso_id, tipo_alvo e alvo_id. tipo_alvo assume TURMA, SERIE, PESSOA ou TODOS. Um Aviso pode possuir várias segmentações, mas cada segmentação pertence a um único Aviso. Quando aplicável, alvo_id identifica o alvo específico definido por tipo_alvo.

12. **MENSAGEM:** MENSAGEM possui id, remetente_id, destinatario_id, titulo, descricao, formato, url, tipo, data_criacao e status. remetente_id referencia RESPONSAVEL(pessoa_id), enquanto destinatario_id referencia FUNCIONARIO(pessoa_id). O formato é TEXTO, IMAGEM ou DOCUMENTO; o tipo é SUGESTAO, DUVIDA, CRITICA, ELOGIO, DENUNCIA ou OUTRO; e o status é AGUARDANDO DISTRIBUIÇÃO, EM ANÁLISE, AGUARDANDO REDISTRIBUIÇÃO ou RESPONDIDO. Um Responsável pode enviar várias Mensagens e um Funcionário pode receber várias Mensagens.

13. **RESPOSTA_MENSAGEM:** RESPOSTA_MENSAGEM possui id, mensagem_id, titulo, descricao e data_criacao. mensagem_id referencia a Mensagem respondida. Uma Mensagem pode possuir várias respostas, e cada Resposta está associada a uma única Mensagem.

14. **AUTORIZACAO_AVISO:** AUTORIZACAO_AVISO possui id, aviso_id, avaliador_id, data_solicitacao, data_avaliacao, status e feedback. Seu status é CONFIRMADA, RECUSADA, EM_ANALISE, NAO_VISUALIZADA ou CORRECAO. Um Aviso pode exigir ou gerar várias autorizações, enquanto cada autorização é avaliada por um único Funcionário. Funcionários podem avaliar várias autorizações.

15. **ENVIO:** ENVIO possui id, aviso_id, data_envio, canal e tipo_segmentacao. Um Aviso pode gerar vários Envios, mas cada Envio pertence a um único Aviso.

16. **VISUALIZACAO:** VISUALIZACAO relaciona AVISO e PESSOA. Suas chaves primárias compostas são aviso_id e pessoa_id, além de possuir data_hora_visualizacao. Um Aviso pode ser visualizado por várias Pessoas, uma Pessoa pode visualizar vários Avisos e cada par Aviso-Pessoa representa uma visualização registrada.

17. **REACAO_AVISO:** REACAO_AVISO relaciona AVISO e PESSOA por meio da chave composta aviso_id e pessoa_id. O atributo tipo assume CURTIR, DUVIDA ou IMPORTANTE. Um Aviso pode receber várias reações e uma Pessoa pode reagir a vários Avisos.

18. **COMENTARIO:** COMENTARIO possui id, aviso_id, pessoa_id, texto e data_criacao. Um Aviso pode conter vários Comentários, uma Pessoa pode compor vários Comentários, e cada Comentário pertence a um único Aviso e a uma única Pessoa.
