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

:: ---------------------------------------------------------
:: 1. GIT
:: ---------------------------------------------------------
call :Log "[1/5] Verificando Git..."
call git --version >nul 2>&1
if !errorlevel! equ 0 (
    call :Log "  -> OK: Git encontrado e funcional."
) else (
    call :Log "  -> Git não encontrado. Tentando instalar via winget..."
    call winget install --id Git.Git --silent --accept-package-agreements --accept-source-agreements >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (call :Log "  -> Git instalado com sucesso.") else (call :Log "  -> AVISO: Falha na instalação automática do Git. Instale manualmente: https://git-scm.com/download/win")
)

:: ---------------------------------------------------------
:: 2. PHP 8.1+
:: ---------------------------------------------------------
call :Log "[2/5] Verificando PHP..."
call php -v >nul 2>&1
if !errorlevel! equ 0 (
    call :Log "  -> OK: PHP encontrado e funcional."
) else (
    call :Log "  -> PHP não encontrado. Tentando instalar PHP 8.1 via winget..."
    call winget install --id PHP.PHP.8.1 --silent --accept-package-agreements --accept-source-agreements >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (call :Log "  -> PHP instalado com sucesso.") else (call :Log "  -> AVISO: Falha na instalação automática do PHP. Use XAMPP/WAMP ou baixe em: https://windows.php.net/download/")
)

:: ---------------------------------------------------------
:: 3. COMPOSER 2+
:: ---------------------------------------------------------
call :Log "[3/5] Verificando Composer..."
call composer --version >nul 2>&1
if !errorlevel! equ 0 (
    call :Log "  -> OK: Composer encontrado e funcional."
) else (
    call :Log "  -> Composer não encontrado. Tentando instalar via winget..."
    call winget install --id Composer.Composer --silent --accept-package-agreements --accept-source-agreements >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (call :Log "  -> Composer instalado com sucesso.") else (call :Log "  -> AVISO: Falha na instalação automática do Composer. Baixe em: https://getcomposer.org/Downloader/")
)

:: ---------------------------------------------------------
:: 4. EXTENSÕES PHP (pdo_sqlite, imap, mailparse)
:: ---------------------------------------------------------
call :Log "[4/5] Verificando extensões PHP exigidas pelo Udesk-CPFANI..."
call php -v >nul 2>&1
if !errorlevel! neq 0 (
    call :Log "  -> PHP indisponível no PATH. Pulando verificação de extensões."
) else (
    call php -m > "%TEMP%\php_mods_tmp.txt" 2>nul
    for %%E in (pdo_sqlite imap mailparse) do (
        findstr /i "%%E" "%TEMP%\php_mods_tmp.txt" >nul 2>&1
        if !errorlevel! equ 0 (
            call :Log "  -> Extensão '%%E': HABILITADA"
        ) else (
            call :Log "  -> Extensão '%%E': FALTANDO ou DESABILITADA"
            call :Log "     -> ACAO MANUAL: Abra seu php.ini e descomente/adicione: extension=%%E"
            if "%%E"=="mailparse" (
                call :Log "     -> OBS: mailparse pode exigir DLL manual ou PECL no Windows."
            )
        )
    )
    del "%TEMP%\php_mods_tmp.txt" >nul 2>&1
)

:: ---------------------------------------------------------
:: 5. DEPENDÊNCIAS DO PROJETO (Composer Install)
:: ---------------------------------------------------------
call :Log "[5/5] Instalando dependências do projeto via Composer..."
if exist "%SCRIPT_DIR%composer.json" (
    cd /d "%SCRIPT_DIR%"
    call :Log "  -> Executando: composer install --no-interaction --optimize-autoloader"
    call composer install --no-interaction --optimize-autoloader >> "%LOG_FILE%" 2>&1
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
exit /b

:: =========================================================
:: FUNÇÕES (SEMPRE NO FINAL)
:: =========================================================
:Log
echo %~1
echo [%date% %time%] %~1 >> "%LOG_FILE%"
exit /b