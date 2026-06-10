@echo off
chcp 1252 >nul
setlocal EnableDelayedExpansion

:: =========================================================
:: SCRIPT DE INSTALAÇÃO E VERIFICAÇÃO DE DEPENDÊNCIAS
:: Projeto: Udesk-CPFANI
:: Codificação: ANSI (Windows-1252)
:: =========================================================

set "SCRIPT_DIR=%~dp0"
set "LOG_FILE=%SCRIPT_DIR%instalacao.log"

:: Limpa/Inicia o arquivo de log
echo. > "%LOG_FILE%"
call :Log "============================================================"
call :Log "INICIANDO VERIFICAÇÃO E INSTALAÇÃO DE DEPENDÊNCIAS"
call :Log "Data/Hora: %date% %time%"
call :Log "Diretório Base: %SCRIPT_DIR%"
call :Log "============================================================"

:: Função de Log (Console + Arquivo)
:Log
echo %~1
echo [%date% %time%] %~1 >> "%LOG_FILE%"
goto :eof

:: ---------------------------------------------------------
:: 1. GIT
:: ---------------------------------------------------------
call :Log "[1/5] Verificando Git..."
git --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('git --version') do call :Log "  -> OK: %%i"
) else (
    call :Log "  -> Git não encontrado. Instalando via winget..."
    winget install --id Git.Git --silent --accept-package-agreements --accept-source-agreements >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (
        call :Log "  -> Git instalado com sucesso."
        set "PATH=%PATH%;C:\Program Files\Git\cmd"
    ) else (
        call :Log "  -> AVISO: winget indisponível ou falhou. Instale manualmente: https://git-scm.com/download/win"
    )
)

:: ---------------------------------------------------------
:: 2. PHP 8.1+
:: ---------------------------------------------------------
call :Log "[2/5] Verificando PHP..."
php -v >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=1,2" %%a in ('php -v ^| findstr "PHP"') do call :Log "  -> OK: %%a %%b"
) else (
    call :Log "  -> PHP não encontrado. Instalando PHP 8.1 via winget..."
    winget install --id PHP.PHP.8.1 --silent --accept-package-agreements --accept-source-agreements >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (
        call :Log "  -> PHP 8.1 instalado com sucesso."
        set "PATH=%PATH%;C:\Program Files\PHP\v8.1"
    ) else (
        call :Log "  -> AVISO: Falha na instalação automática. Use XAMPP/WAMP ou baixe em: https://windows.php.net/download/"
    )
)

:: ---------------------------------------------------------
:: 3. COMPOSER 2+
:: ---------------------------------------------------------
call :Log "[3/5] Verificando Composer..."
composer -V >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('composer -V') do call :Log "  -> OK: %%i"
) else (
    call :Log "  -> Composer não encontrado. Instalando via winget..."
    winget install --id Composer.Composer --silent --accept-package-agreements --accept-source-agreements >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (
        call :Log "  -> Composer instalado com sucesso."
        set "PATH=%PATH%;C:\ProgramData\ComposerSetup\bin"
    ) else (
        call :Log "  -> AVISO: Falha na instalação automática. Baixe em: https://getcomposer.org/Downloader/"
    )
)

:: ---------------------------------------------------------
:: 4. EXTENSÕES PHP (pdo_sqlite, imap, mailparse)
:: ---------------------------------------------------------
call :Log "[4/5] Verificando extensões PHP exigidas pelo Udesk-CPFANI..."
php -m > "%TEMP%\php_mods_tmp.txt" 2>nul
for %%E in (pdo_sqlite imap mailparse) do (
    findstr /i "%%E" "%TEMP%\php_mods_tmp.txt" >nul
    if !errorlevel! equ 0 (
        call :Log "  -> Extensão '%%E': HABILITADA"
    ) else (
        call :Log "  -> Extensão '%%E': FALTANDO ou DESABILITADA"
        call :Log "     -> ACAO MANUAL: Abra seu php.ini e descomente: extension=%%E"
        if "%%E"=="mailparse" (
            call :Log "     -> OBS: mailparse pode exigir instalação via PECL ou DLL manual no Windows."
        )
    )
)
del "%TEMP%\php_mods_tmp.txt" >nul 2>&1

:: ---------------------------------------------------------
:: 5. DEPENDÊNCIAS DO PROJETO (Composer Install)
:: ---------------------------------------------------------
call :Log "[5/5] Instalando dependências do projeto via Composer..."
if exist "%SCRIPT_DIR%composer.json" (
    cd /d "%SCRIPT_DIR%"
    call :Log "  -> Executando: composer install --no-interaction --optimize-autoloader"
    composer install --no-interaction --optimize-autoloader >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (
        call :Log "  -> Dependências instaladas/atualizadas com sucesso."
    ) else (
        call :Log "  -> ERRO: composer install falhou. Verifique o log ou execute manualmente."
    )
) else (
    call :Log "  -> AVISO: composer.json não encontrado no diretório atual."
)

call :Log "============================================================"
call :Log "VERIFICAÇÃO E INSTALAÇÃO CONCLUÍDAS."
call :Log "Log completo salvo em: %LOG_FILE%"
call :Log "============================================================"
pause