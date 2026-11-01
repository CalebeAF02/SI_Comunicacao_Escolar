# 🏫 SI_Comunicacao_Escolar

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **Quadro Digital de Avisos — Solução para Falhas na Comunicação Escolar**

Este repositório contém o planejamento, a engenharia de requisitos, a modelagem de dados e o design de interface de um Sistema de Informação (SI) voltado para a centralização, moderação e segmentação da comunicação institucional em escolas de ensino fundamental.

O projeto foi desenvolvido para a disciplina **CIC0101 — Sistemas de Informação (Turma 02 - 2026.2)** do Departamento de Ciência da Computação (CIC) da **Universidade de Brasília (UnB)**, sob a orientação da Profa. Drª. Patrícia Araújo de Oliveira.

---

## 🎯 O Problema & Oportunidade
A comunicação escolar atual é descentralizada e fragmentada entre grupos de WhatsApp, murais físicos e bilhetes impressos. Isso resulta em perda de prazos, excesso de ruído informativo, falta de controle editorial e baixa participação dos responsáveis na rotina dos alunos.

A solução proposta redesenha o processo organizacional, substituindo canais informais por uma plataforma centralizada capaz de:
*   **Segmentar mensagens** por público-alvo (evitando enxurradas de avisos aleatórios).
*   **Moderar conteúdos** por meio de uma esteira digital de aprovação antes da publicação oficial.

---

## 🛠️ Escopo do Planejamento & Artefatos (Entregas 1 a 4)

Embora o sistema não seja implementado em código, o projeto cumpre rigorosamente o ciclo completo de análise e design de sistemas de informação:

*   **Entrega 1: Diagnóstico e Visão Sistêmica**
    *   Alinhamento sociotécnico, árvore de sintomas/causas e modelagem do processo atual (**AS-IS**).
*   **Entrega 2: Engenharia de Requisitos e Dados Iniciais**
    *   Matriz de Rastreabilidade de Requisitos (**RF01 a RF06**).
    *   Histórias de Usuário e Cenários de Teste em **BDD** (*Behavior-Driven Development*).
    *   Organização e agrupamento inicial dos dados por assunto.
*   **Entrega 3: Modelagem Conceitual e Lógica**
    *   **MER** (Modelo Entidade-Relacionamento).
    *   **DER** (Diagrama Entidade-Relacionamento).
    *   **MR** (Modelo Relacional — Esquema lógico de tabelas com chaves `PK` e `FK`).
*   **Entrega 4: Prototipação e Integration**
    *   Design de interface de usuário (UI/UX) mapeando as jornadas de Emissão, Avaliação e Recebimento de avisos.

---

## 📊 Matriz de Requisitos Funcionais (RF)

O núcleo operacional planejado para o sistema baseia-se em 6 requisitos fundamentais:

1.  **RF01 (Criar Aviso):** Permite que emissores (professores, secretaria, coordenação) registrem comunicados com campos obrigatórios.
2.  **RF02 (Verificar Autorização):** Motor de regras do sistema que identifica se a categoria do aviso exige ou não moderação prévia.
3.  **RF03 (Solicitar Autorização):** Encaminha automaticamente avisos restritos para a fila de aprovação dos responsáveis.
4.  **RF04 (Avaliar Solicitação):** Interface do avaliador (direção/coordenação) para deferir, indeferir ou solicitar ajustes no texto.
5.  **RF05 (Comunicar Inviabilidade):** Cancela o fluxo de avisos inadequados e notifica o emissor com a devida justificativa.
6.  **RF06 (Receber Aviso):** Disponibiliza o aviso de forma limpa e segmentada no feed dos destinatários corretos (alunos, pais ou tutores).

---

## 📁 Estrutura de Pastas do Repositório

```text
├── entregas/         # Relatórios textuais consolidados das entregas em formato PDF
│   ├── CIC0101_SI_Entrega_1_Projeto_Integrador.pdf
│   └── CIC0101_SI_Entrega_2_Projeto_Integrador.pdf
├── src/              # Artefatos visuais, diagramas e modelos lógicos
│   └── uml/          # Modelagem unificada do sistema
│       ├── conceitual/
│       │   └── mer.md          # Especificação textual do Modelo Entidade-Relacionamento
│       ├── diagrama/
│       │   ├── DER.brM3        # Arquivo fonte de modelagem conceitual no brModelo
│       │   └── der.jpeg        # Imagem exportada do Diagrama Entidade-Relacionamento
│       └── logico/
│           └── mr.puml        # 
├── prototipos/       # Telas, Wireframes e links de navegação (ex: Figma)
└── README.md         # Página principal com a visão geral do projeto
```

---

## Licença

Este projeto está licenciado sob a licença **MIT**. Consulte o arquivo [LICENSE](LICENSE) para obter os termos completos.

---

*Este é um projeto estritamente acadêmico com fins didáticos focados em Governança de TI, Engenharia de Requisitos e Arquitetura de Dados.*
