@echo off
chcp 1252 >nul
setlocal enabledelayedexpansion

:: =========================================================
:: Script de Instalacao de Dependencias - Udesk-CPFANI
:: =========================================================

:: Verificacao de privilegios administrativos (Elevacao UAC)
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Solicitando elevacao de privilegios administrativos...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: Configuracao do arquivo de log
set "LOGFILE=%~dp0instalar.log"
echo [%date% %time%] Iniciando processo de instalacao. > "%LOGFILE%"

echo =========================================================
echo  Script de Instalacao de Dependencias - Udesk-CPFANI
echo =========================================================
echo.
echo O log completo sera salvo em: %LOGFILE%
echo.

:: ---------------------------------------------------------
:: 1. Verificar e Instalar PHP 8.2
:: ---------------------------------------------------------
echo [INFO] Verificando instalacao do PHP...
echo [%date% %time%] Verificando PHP... >> "%LOGFILE%"

php -v >nul 2>&1
if %errorlevel% neq 0 (
    echo [AVISO] PHP nao encontrado. Instalando PHP 8.2 via WinGet...
    echo [%date% %time%] PHP nao encontrado. Instalando via WinGet... >> "%LOGFILE%"
    
    winget install PHP.PHP.8.2 --accept-source-agreements --accept-package-agreements >> "%LOGFILE%" 2>&1
    
    if %errorlevel% neq 0 (
        echo [ERRO] Falha ao instalar PHP. Verifique o log para mais detalhes.
        echo [%date% %time%] ERRO ao instalar PHP. >> "%LOGFILE%"
        pause
        exit /b 1
    )
    
    :: Atualizar variaveis de ambiente na sessao atual (Fallback para caminho do WinGet)
    echo [INFO] Atualizando variaveis de ambiente...
    set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WinGet\Packages\PHP.PHP.8.2_Microsoft.Winget.Source_8wekyb3d8bbwe"
    
    echo [SUCESSO] PHP instalado com sucesso.
    echo [%date% %time%] PHP instalado com sucesso. >> "%LOGFILE%"
) else (
    echo [SUCESSO] PHP ja esta instalado.
    echo [%date% %time%] PHP ja estava instalado. >> "%LOGFILE%"
)

:: ---------------------------------------------------------
:: 2. Verificar e Instalar Composer
:: ---------------------------------------------------------
echo.
echo [INFO] Verificando instalacao do Composer...
echo [%date% %time%] Verificando Composer... >> "%LOGFILE%"

composer -V >nul 2>&1
if %errorlevel% neq 0 (
    echo [AVISO] Composer nao encontrado. Instalando Composer via WinGet...
    echo [%date% %time%] Composer nao encontrado. Instalando via WinGet... >> "%LOGFILE%"
    
    winget install Composer.Composer --accept-source-agreements --accept-package-agreements >> "%LOGFILE%" 2>&1
    
    if %errorlevel% neq 0 (
        echo [ERRO] Falha ao instalar Composer. Verifique o log para mais detalhes.
        echo [%date% %time%] ERRO ao instalar Composer. >> "%LOGFILE%"
        pause
        exit /b 1
    )
    
    :: Atualizar PATH para Composer
    set "PATH=%PATH%;%APPDATA%\Composer\vendor\bin;%LOCALAPPDATA%\Composer\vendor\bin"
    
    echo [SUCESSO] Composer instalado com sucesso.
    echo [%date% %time%] Composer instalado com sucesso. >> "%LOGFILE%"
) else (
    echo [SUCESSO] Composer ja esta instalado.
    echo [%date% %time%] Composer ja estava instalado. >> "%LOGFILE%"
)

:: ---------------------------------------------------------
:: 3. Instalar Dependencias do Projeto (Composer Install)
:: ---------------------------------------------------------
echo.
echo [INFO] Instalando dependencias do projeto (Composer)...
echo [%date% %time%] Executando composer install... >> "%LOGFILE%"

cd /d "%~dp0"
composer install --no-interaction --prefer-dist >> "%LOGFILE%" 2>&1

if %errorlevel% neq 0 (
    echo [ERRO] Falha ao instalar dependencias do projeto.
    echo [%date% %time%] ERRO no composer install. >> "%LOGFILE%"
    pause
    exit /b 1
)

echo [SUCESSO] Dependencias do projeto instaladas.
echo [%date% %time%] Dependencias do projeto instaladas com sucesso. >> "%LOGFILE%"

:: ---------------------------------------------------------
:: 4. Configurar SQLite (Verificar/criar arquivo de banco)
:: ---------------------------------------------------------
echo.
echo [INFO] Verificando configuracao do banco de dados SQLite...
echo [%date% %time%] Verificando SQLite... >> "%LOGFILE%"

:: O SQLite ja vem embutido no PHP (pdo_sqlite). Apenas garantimos que o arquivo exista.
if not exist "%~dp0database" mkdir "%~dp0database"
if not exist "%~dp0database\app.db" (
    echo [INFO] Criando arquivo de banco de dados vazio...
    type nul > "%~dp0database\app.db"
    echo [%date% %time%] Arquivo app.db criado. >> "%LOGFILE%"
) else (
    echo [INFO] Arquivo de banco de dados ja existe.
    echo [%date% %time%] Arquivo app.db ja existia. >> "%LOGFILE%"
)

echo.
echo =========================================================
echo  Instalacao concluida com sucesso!
echo  Verifique o arquivo de log: %LOGFILE%
echo =========================================================
echo [%date% %time%] Processo concluido com sucesso. >> "%LOGFILE%"

pause