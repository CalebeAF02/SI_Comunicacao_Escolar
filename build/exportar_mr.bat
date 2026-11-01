@echo off
echo ==========================================
echo Gerando diagramas PlantUML para o projeto...
echo ==========================================

:: Cria a pasta de bin se não existir
if not exist "bin" mkdir bin

:: Comando para gerar a imagem PNG do diagrama lógico
echo Gerando imagem PNG...
java -jar bin/plantuml.jar -tpng src/uml/logico/mr.puml

echo Gerando documento PDF...
java -jar bin/plantuml.jar -tpdf src/uml/logico/mr.puml

echo Processo concluido!