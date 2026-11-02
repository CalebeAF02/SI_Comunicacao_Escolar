@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Resolve os caminhos a partir da pasta do script, independentemente de onde ele foi chamado.
set "ROOT_DIR=%~dp0.."
set "DOC_DIR=%ROOT_DIR%\docs\entrega1"
set "OUT_DIR=%ROOT_DIR%\out"
set "DELIVERY_DIR=%ROOT_DIR%\docs\entrega1"
set "TEX_FILE=entrega1.tex"
set "PDF_NAME=entrega1.pdf"
set "COMPILE_ERROR=0"

if not exist "%DOC_DIR%\%TEX_FILE%" (
    echo ERRO: arquivo "%DOC_DIR%\%TEX_FILE%" nao encontrado.
    goto :fim
)

where latexmk >nul 2>nul
set "LATEXMK_AVAILABLE=%ERRORLEVEL%"

where pdflatex >nul 2>nul
set "PDFLATEX_AVAILABLE=%ERRORLEVEL%"

if not "%LATEXMK_AVAILABLE%"=="0" if not "%PDFLATEX_AVAILABLE%"=="0" (
    echo ERRO: nem latexmk nem pdflatex foram encontrados no PATH.
    goto :fim
)

if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"
if errorlevel 1 (
    echo ERRO: nao foi possivel criar a pasta "%OUT_DIR%".
    goto :fim
)

if not exist "%DELIVERY_DIR%" mkdir "%DELIVERY_DIR%"
if errorlevel 1 (
    echo ERRO: nao foi possivel criar a pasta "%DELIVERY_DIR%".
    goto :fim
)

pushd "%DOC_DIR%"

echo Compilando "%DOC_DIR%\%TEX_FILE%"...
if "%LATEXMK_AVAILABLE%"=="0" (
    latexmk -pdf -synctex=1 -interaction=nonstopmode -outdir="%OUT_DIR%" "%TEX_FILE%"
    set "COMPILE_ERROR=!ERRORLEVEL!"
) else (
    set "COMPILE_ERROR=1"
)

if not "!COMPILE_ERROR!"=="0" if "%LATEXMK_AVAILABLE%"=="0" (
    echo.
    echo Aviso: latexmk falhou. Tentando compilacao direta com pdflatex...
)

if not "!COMPILE_ERROR!"=="0" if "%PDFLATEX_AVAILABLE%"=="0" (
    pdflatex -synctex=1 -interaction=nonstopmode -output-directory="%OUT_DIR%" "%TEX_FILE%"
    if errorlevel 1 set "COMPILE_ERROR=1" & goto :fim_sem_pausa

    pdflatex -synctex=1 -interaction=nonstopmode -output-directory="%OUT_DIR%" "%TEX_FILE%"
    set "COMPILE_ERROR=!ERRORLEVEL!"
)

if not "!COMPILE_ERROR!"=="0" (
    echo.
    echo ERRO: a compilacao terminou com codigo !COMPILE_ERROR!.
    goto :fim_sem_pausa
)

echo.
echo Limpando arquivos temporarios...
if "%LATEXMK_AVAILABLE%"=="0" latexmk -c -outdir="%OUT_DIR%" "%TEX_FILE%" >nul 2>&1

echo.
if not exist "%OUT_DIR%\entrega1.pdf" (
    echo ERRO: o PDF compilado nao foi encontrado em "%OUT_DIR%\entrega1.pdf".
    set "COMPILE_ERROR=1"
    goto :fim_sem_pausa
)

set "OFFICIAL_PDF=%ROOT_DIR%\entregas\CIC0101_SI_Entrega_1_Projeto_Integrador.pdf"
if exist "!OFFICIAL_PDF!" (
    copy /Y "!OFFICIAL_PDF!" "%DELIVERY_DIR%\%PDF_NAME%" >nul
) else (
    copy /Y "%OUT_DIR%\entrega1.pdf" "%DELIVERY_DIR%\%PDF_NAME%" >nul
)
if errorlevel 1 (
    echo ERRO: nao foi possivel copiar o PDF para "%DELIVERY_DIR%\%PDF_NAME%".
    set "COMPILE_ERROR=1"
    goto :fim_sem_pausa
)

del /Q "%OUT_DIR%\entrega1.pdf"

echo.
echo PDF final gerado em "%DELIVERY_DIR%\%PDF_NAME%"

:fim_sem_pausa
popd
endlocal & exit /b !COMPILE_ERROR!

:fim
echo.
pause
endlocal
exit /b 1
