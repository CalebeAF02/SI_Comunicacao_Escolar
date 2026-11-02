# Guia: TeXstudio, LaTeX e `exemplo.pdf`

Este guia explica como instalar e configurar o ambiente para editar o documento
LaTeX do projeto e como executar o script
[`build/exemplo.bat`](../build/exemplo.bat).

## 1. Pré-requisitos do Windows

É necessário ter instalado:

- **TeXstudio**: editor de código LaTeX;
- **MiKTeX**: distribuição LaTeX que fornece `pdflatex` e outros programas;
- **Perl**, recomendado para usar `latexmk` no Windows.

Não é necessário instalar o LaTeX dentro do TeXstudio: as duas ferramentas são
projetos separados. O TeXstudio é usado para editar e visualizar, enquanto o
MiKTeX realiza a compilação.

## 2. Instalar o MiKTeX

1. Baixe o instalador do MiKTeX em <https://miktex.org/download>.
2. Escolha a instalação para o usuário atual, salvo em:

   ```text
   C:\Users\<seu-usuario>\AppData\Local\Programs\MiKTeX
   ```

3. Marque a opção para instalar automaticamente os pacotes ausentes.
4. Finalize a instalação.
5. Feche e reabra o terminal e o TeXstudio.

Para confirmar que o MiKTeX está disponível, execute no PowerShell ou Prompt
de Comando:

```bat
pdflatex --version
```

O comando deve mostrar informações sobre o executável. Caso não seja encontrado,
abra o console do MiKTeX e execute as atualizações necessárias.

## 3. Instalar o Perl

O script procura primeiro por `latexmk`. No Windows, essa ferramenta pode exigir
Perl. Uma opção compatível é o Strawberry Perl:

1. Baixe o instalador em <https://strawberryperl.com/>.
2. Instale o Perl no Windows.
3. Feche e reabra o terminal.
4. Confirme a instalação:

   ```bat
   perl --version
   ```

O Perl é especialmente importante para o funcionamento de `latexmk`. Se não for
possível instalá-lo, o script faz uma tentativa automática com `pdflatex`,
executado diretamente.

## 4. Instalar o TeXstudio

1. Baixe o TeXstudio em <https://www.texstudio.org/>.
2. Execute o instalador e mantenha as opções padrão.
3. Abra o TeXstudio.
4. Selecione o idioma desejado na primeira execução, se solicitado.

## 5. Configurar o TeXstudio

1. No menu, abra `Options` > `Configure TeXstudio`.
2. Em `Commands`, verifique se os comandos do compilador apontam para a
   distribuição do MiKTeX.
3. Em `Build`, configure:
   - **Default Compiler**: `PdfLaTeX`;
   - **Default Bibliography Tool**: mantenha o padrão, salvo alteração do projeto;
   - **Default Viewer**: `Internal PDF Viewer`.
4. Clique em `OK`.

Se o TeXstudio não detectar os executáveis automaticamente, abra o console do
MiKTeX e localize o diretório de binários. Normalmente ele é:

```text
C:\Users\<seu-usuario>\AppData\Local\Programs\MiKTeX\miktex\bin\x64
```

Em alguns sistemas, é necessário reiniciar o Windows depois de instalar o
MiKTeX ou adicionar o diretório ao `PATH` do sistema.

## 6. Abrir o projeto

1. Abra o TeXstudio.
2. Use `File` > `Open`.
3. Selecione:

   ```text
   docs\exemplo\exemplo.tex
   ```

4. No TeXstudio, pressione `F5` para compilar e visualizar.

Para a compilação completa do projeto, é possível usar o botão
`Build & View`. O TeXstudio é útil para editar, localizar erros e visualizar
as páginas, mas o arquivo final solicitado pelo projeto é produzido pelo script
`.bat`.

## 7. Executar `exemplo.bat`

Abra o terminal na **raiz do repositório**. No Prompt de Comando ou no
PowerShell, execute:

```bat
build/exemplo.bat
```

Também é possível:

1. Abrir a pasta `build` no Explorador de Arquivos;
2. Dar dois cliques em `exemplo.bat`.

Na abertura pelo Explorador, uma janela pode permanecer aberta apenas enquanto
houver erro ou até o usuário fechar a janela.

## 8. Como o script funciona

O arquivo `build/exemplo.bat` executa estas etapas:

1. Resolve automaticamente a raiz do projeto usando a localização própria do
   script. Assim, o caminho não depende de qual diretório foi usado para chamar
   o arquivo.
2. Verifica se existe:

   ```text
   docs\exemplo\exemplo.tex
   ```

3. Verifica se `latexmk` e `pdflatex` estão disponíveis no `PATH`.
4. Cria, quando necessário, estas pasta:
   - `out`: arquivos temporários e resultado intermediário da compilação;
   - `entregas`: local do documento final.
5. Primeira tentativa de compilação:

   ```bat
   latexmk -pdf -synctex=1 -interaction=nonstopmode -outdir="..\out" exemplo.tex
   ```

6. Se o `latexmk` falhar, por exemplo por falta de Perl, o script tenta:

   ```bat
   pdflatex -synctex=1 -interaction=nonstopmode -output-directory="..\out" exemplo.tex
   ```

7. Executa duas passagens do `pdflatex` para atualizar corretamente sumário,
   referências cruzadas, listas e links internos.
8. Copia `out\exemplo.pdf` para:

   ```text
   entregas\exemplo.pdf
   ```

9. Remove `out\exemplo.pdf`, deixando temporários e PDF final separados.

## 9. Estrutura utilizada

```text
docs\
└── exemplo\
    ├── exemplo.tex
    ├── preamble\
    ├── sections\
    ├── imagens\
    └── code\

build\
└── exemplo.bat

out\
└── arquivos temporarios da compilacao

entregas\
└── exemplo.pdf
```

Arquivos como `.aux`, `.log`, `.out`, `.toc` e `.synctex.gz` são temporários.
Quando o `latexmk` funciona corretamente, o script usa a limpeza do próprio
LaTeX nesses arquivos. Arquivos temporários devem continuar em `out`.

## 10. Testar a instalação

### Teste pelo TeXstudio

1. Abra `docs\exemplo\exemplo.tex`.
2. Pressione `F5`.
3. Verifique se o visualizador interno mostra um PDF.
4. Confirme que não há erros graves em vermelho na aba `Messages`.

### Teste pelo script

1. Na raiz do repositório, execute:

   ```bat
   build/exemplo.bat
   ```

2. Aguarde o término da compilação.
3. Confirme a mensagem:

   ```text
   PDF final gerado em "...\entregas\exemplo.pdf"
   ```

4. Abra:

   ```text
   entregas\exemplo.pdf
   ```

O PDF final deve ter o nome exatamente `exemplo.pdf`.

## 11. Diagnóstico de problemas

### `latexmk` não encontrou Perl

Mensagem semelhante:

```text
MiKTeX could not find the script engine 'perl'
```

Instale o Strawberry Perl e abra novamente o terminal. O script tenta novamente
usar o fallback de `pdflatex`, mas `latexmk` continua sendo a opção recomendada.

### `pdflatex` não é encontrado

1. Confirme que o MiKTeX foi instalado.
2. Abra novamente o terminal.
3. Execute:

   ```bat
   pdflatex --version
   ```

4. Reinicie o TeXstudio caso ele continue sem detectar o compilador.

### Arquivo não encontrado

Verifique se o arquivo existe em:

```text
docs\exemplo\exemplo.tex
```

Não renomeie nem mova esse arquivo sem atualizar a variável `TEX_FILE` no script.

### Erros dentro do documento

Leia o final do terminal ou abra:

```text
out\main.log
```

No TeXstudio, abra o arquivo `.tex` correspondente, prossiga para a linha
indicada pelo compilador e corrija o trecho antes de executar o script novamente.

### Pasta do PDF final não existe

O script cria automaticamente a pasta `entregas`. Caso o repositório não permita
a criação, confirme as permissões da pasta raiz e execute o terminal sem executar
como administrador, salvo quando necessário pelas políticas do computador.

## 12. Resumo

- Edite o conteúdo em `docs\exemplo/exemplo.tex` e nos arquivos da pasta
  `docs/exemplo/sections`.
- Use o TeXstudio para visualizar erros e testar alterações.
- Execute `build/exemplo.bat` na raiz do projeto para gerar a entrega.
- O resultado final fica em `entregas/exemplo.pdf`.
