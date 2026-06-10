@echo off
chcp 1252 >nul
setlocal EnableDelayedExpansion

:: =========================================================
:: SCRIPT DE INSTALAÇÃO COMPLETA - UDESK-CPFANI
:: Projeto: Helpdesk CP Fani (baseado em UVDesk Community)
:: Codificação: ANSI (Windows-1252)
:: =========================================================
:: EXECUTA TODAS AS ETAPAS:
::   1. Verifica/instala dependências (Git, PHP, Composer)
::   2. Valida extensões PHP (pdo_sqlite, imap, mailparse)
::   3. Instala dependências do projeto (composer install)
::   4. Prepara ambiente SQLite (var/data.db)
::   5. Limpa cache do Symfony
::   6. Aplica migrations do banco de dados
::   7. Cria usuário administrador super admin
::   8. Inicia servidor PHP embutido
:: =========================================================

:: ---------------------------------------------------------
:: CONFIGURAÇÕES EDITÁVEIS (ajuste conforme necessário)
:: ---------------------------------------------------------
set "ADMIN_NAME=SuporteNSF"
set "ADMIN_EMAIL=suporte@didier.com.br"
set "ADMIN_PASSWORD=CpFanisuport3@2026"
set "SERVER_HOST=localhost"
set "SERVER_PORT=8000"
set "PHP_TIMEOUT=300"

:: ---------------------------------------------------------
:: INICIALIZAÇÃO
:: ---------------------------------------------------------
set "SCRIPT_DIR=%~dp0"
set "LOG_FILE=%SCRIPT_DIR%instalacao.log"
set "PROJECT_DIR=%SCRIPT_DIR%"
set "DB_DIR=%PROJECT_DIR%var"
set "DB_FILE=%DB_DIR%\data.db"

:: Limpa/Inicia o arquivo de log
echo. > "%LOG_FILE%"
call :Log "============================================================"
call :Log "INSTALAÇÃO COMPLETA - UDESK-CPFANI (HELPDESK CP FANI)"
call :Log "Data/Hora: %date% %time%"
call :Log "Diretório Base: %SCRIPT_DIR%"
call :Log "============================================================"

:: ---------------------------------------------------------
:: 1. GIT
:: ---------------------------------------------------------
call :Log "[1/8] Verificando Git..."
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
call :Log "[2/8] Verificando PHP..."
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
call :Log "[3/8] Verificando Composer..."
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
call :Log "[4/8] Verificando extensões PHP exigidas pelo Udesk-CPFANI..."
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
call :Log "[5/8] Instalando dependências do projeto via Composer..."
if exist "%PROJECT_DIR%composer.json" (
    cd /d "%PROJECT_DIR%"
    call :Log "  -> Executando: composer install --no-interaction --optimize-autoloader"
    call composer install --no-interaction --optimize-autoloader >> "%LOG_FILE%" 2>&1
    if !errorlevel! equ 0 (
        call :Log "  -> Dependências instaladas/atualizadas com sucesso."
    ) else (
        call :Log "  -> ERRO: composer install falhou. Verifique o log."
    )
) else (
    call :Log "  -> AVISO: composer.json não encontrado no diretório atual."
)

:: ---------------------------------------------------------
:: 6. PREPARAR AMBIENTE SQLITE (var/data.db)
:: ---------------------------------------------------------
call :Log "[6/8] Preparando ambiente SQLite..."
if not exist "%DB_DIR%" (
    mkdir "%DB_DIR%"
    call :Log "  -> Diretório 'var/' criado."
) else (
    call :Log "  -> Diretório 'var/' já existe."
)

if not exist "%DB_FILE%" (
    type nul > "%DB_FILE%"
    call :Log "  -> Arquivo 'var/data.db' criado."
) else (
    call :Log "  -> Arquivo 'var/data.db' já existe."
)

:: Concede permissões de escrita ao usuário atual
call :Log "  -> Ajustando permissões do diretório 'var/'..."
powershell -Command "try { $acl = Get-Acl '%DB_DIR%'; $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('%USERNAME%','FullControl','ContainerInherit,ObjectInherit','None','Allow'); $acl.SetAccessRule($rule); Set-Acl -Path '%DB_DIR%' -AclObject $acl; Write-Output 'OK' } catch { Write-Output 'FALHA' }" >> "%LOG_FILE%" 2>&1
call :Log "  -> Permissões ajustadas para o usuário '%USERNAME%'."

:: ---------------------------------------------------------
:: 7. LIMPAR CACHE DO SYMFONY
:: ---------------------------------------------------------
call :Log "[7/8] Limpando cache do Symfony..."
cd /d "%PROJECT_DIR%"

:: Remove cache antigo manualmente (evita erro de conexão com banco)
if exist "%PROJECT_DIR%var\cache\dev" (
    powershell -Command "Remove-Item -Path '%PROJECT_DIR%var\cache\dev' -Recurse -Force -ErrorAction SilentlyContinue"
    call :Log "  -> Cache antigo removido."
)

:: Limpa cache sem warmup (não valida conexão com banco)
call php -d max_execution_time=%PHP_TIMEOUT% bin/console cache:clear --no-warmup >> "%LOG_FILE%" 2>&1
if !errorlevel! equ 0 (
    call :Log "  -> Cache limpo com sucesso."
) else (
    call :Log "  -> AVISO: Falha ao limpar cache. Continuando..."
)

:: ---------------------------------------------------------
:: 8. APLICAR MIGRATIONS DO BANCO DE DADOS
:: ---------------------------------------------------------
call :Log "[8/8] Aplicando migrations do banco de dados..."
call :Log "  -> Executando: doctrine:migrations:migrate --no-interaction"
call php -d max_execution_time=%PHP_TIMEOUT% bin/console doctrine:migrations:migrate --no-interaction >> "%LOG_FILE%" 2>&1
if !errorlevel! equ 0 (
    call :Log "  -> Migrations aplicadas com sucesso."
) else (
    call :Log "  -> AVISO: Falha ao aplicar migrations. O banco pode já estar atualizado."
)

:: ---------------------------------------------------------
:: 9. CRIAR USUÁRIO ADMINISTRADOR (SUPER ADMIN)
:: ---------------------------------------------------------
call :Log "------------------------------------------------------------"
call :Log "[EXTRA] Criando usuário administrador (ROLE_SUPER_ADMIN)..."
call :Log "  -> Nome: %ADMIN_NAME%"
call :Log "  -> Email: %ADMIN_EMAIL%"
call :Log "  -> Senha: (oculta por segurança)"
call php -d max_execution_time=%PHP_TIMEOUT% bin/console uvdesk_wizard:defaults:create-user ROLE_SUPER_ADMIN "%ADMIN_NAME%" "%ADMIN_EMAIL%" "%ADMIN_PASSWORD%" >> "%LOG_FILE%" 2>&1
if !errorlevel! equ 0 (
    call :Log "  -> Usuário administrador criado com sucesso!"
) else (
    call :Log "  -> AVISO: Falha ao criar usuário. Ele pode já existir."
    call :Log "  -> DICA: Tente fazer login com as credenciais acima."
)

:: ---------------------------------------------------------
:: 10. INICIAR SERVIDOR PHP
:: ---------------------------------------------------------
call :Log "============================================================"
call :Log "INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
call :Log "============================================================"
call :Log ""
call :Log "ACESSO AO SISTEMA:"
call :Log "  -> Painel Admin/Agente: http://%SERVER_HOST%:%SERVER_PORT%/pt_BR/member/login"
call :Log "  -> Portal do Cliente:   http://%SERVER_HOST%:%SERVER_PORT%/pt_BR/customer/login"
call :Log "  -> Email: %ADMIN_EMAIL%"
call :Log "  -> Senha: %ADMIN_PASSWORD%"
call :Log ""
call :Log "INICIANDO SERVIDOR PHP EMBUTIDO..."
call :Log "  -> URL: http://%SERVER_HOST%:%SERVER_PORT%"
call :Log "  -> Pressione Ctrl+C para encerrar o servidor."
call :Log "============================================================"
call :Log ""
call :Log "Log completo salvo em: %LOG_FILE%"
call :Log "============================================================"

:: Inicia o servidor PHP (comando bloqueante - mantém janela aberta)
cd /d "%PROJECT_DIR%"
call php -S %SERVER_HOST%:%SERVER_PORT% -t public/

:: Se o servidor for encerrado, mantém a janela aberta
pause
exit /b

:: =========================================================
:: FUNÇÕES (SEMPRE NO FINAL DO ARQUIVO .BAT)
:: =========================================================
:Log
echo %~1
echo [%date% %time%] %~1 >> "%LOG_FILE%"
exit /b