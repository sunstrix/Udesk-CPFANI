<p align="center"><a href="https://github.com/sunstrix/Udesk-CPFANI" target="_blank">
    <img src="https://s3-ap-southeast-1.amazonaws.com/cdn.uvdesk.com/uvdesk/bundles/webkuldefault/images/uvdesk-wide.svg">
</a></p>

<p align="center">
    <a href="https://packagist.org/packages/uvdesk/community-skeleton"><img src="https://poser.pugx.org/uvdesk/community-skeleton/v/stable.svg" alt="Versão Estável Mais Recente"></a>
    <a href="https://packagist.org/packages/uvdesk/community-skeleton"><img src="https://poser.pugx.org/uvdesk/community-skeleton/d/total.svg" alt="Total de Downloads"></a>
    <a href="#backers"><img src="https://opencollective.com/uvdesk/backers/badge.svg" alt="Apoiadores no Open Collective"></a>
    <a href="#sponsors"><img src="https://opencollective.com/uvdesk/sponsors/badge.svg" alt="Patrocinadores no Open Collective"></a>
    <a href="https://gitter.im/uvdesk/community"><img src="https://badges.gitter.im/uvdesk/community-skeleton.svg" alt="conecte-se no gitter"></a>
    <a href="https://forums.uvdesk.com"><img src="https://img.shields.io/badge/Pergunte%20me-qualquer%20coisa-1abc9c.svg" alt="discuta no fórum uvdesk"></a>
    <a href="https://github.com/collections/made-in-india"><img src="https://badges.frapsoft.com/os/v3/open-source.png?v=103" alt="Confira projetos open source da Índia"></a>
</p>

<p align="center">
    <a href="https://twitter.com/intent/follow?screen_name=uvdesk"><img src="https://img.shields.io/twitter/follow/uvdesk?style=social"></a>
    <a href="https://www.youtube.com/channel/UCKKt4IOC7ynLwhJMP35uFeQ"><img src="https://img.shields.io/youtube/channel/subscribers/UCKKt4IOC7ynLwhJMP35uFeQ?style=social"></a>
</p>

<p align="center">
    ➡️ <a href="https://www.uvdesk.com/en/opensource/">Website</a> | <a href="https://docs.uvdesk.com/">Documentação</a> | <a href="https://www.uvdesk.com/en/blog/open-source-helpdesk-installation-on-ubuntu-uvdesk/">Guia de Instalação</a> | <a href="https://forums.uvdesk.com/">Fóruns</a> | <a href="https://www.facebook.com/uvdesk/">Comunidade</a> ⬅️
</p>

<p align="center" style="display: inline;">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/ar.svg" alt="Árabe" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/de.svg" alt="Alemão" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/us.svg" alt="Inglês" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/es.svg" alt="Espanhol" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/fr.svg" alt="Francês" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/it.svg" alt="Italiano" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/dk.svg" alt="Dinamarquês" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/pl.svg" alt="Polonês" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/tr.svg" alt="Turco" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/cn.svg" alt="Chinês" width="24" height="24">
    <img class="flag-img" src="https://flagicons.lipis.dev/flags/4x3/br.svg" alt="Brasil" width="24" height="24">
</p>

O projeto [Helpdesk CP Fani][1] é baseado no skeleton do UVDesk Community, empacotado com utilitários e ferramentas essenciais para construir e personalizar suas próprias soluções de helpdesk.

Visite nosso site oficial de demonstração para [ver em ação!][15]

Confira o Helpdesk CP Fani no **Site Oficial do Symfony** – [Symfony][24]

Começando
-----------------

* [Sobre](#sobre)
* [Recursos](#recursos)
* [Documentação](#documentação)
* [Módulos](#módulos)
* [Requisitos](#requisitos)
* [Instalação](#instalação)
* [Docker Runtime](#docker-runtime)
* [Container Persistente Docker](#container-persistente-docker)
* [Ambiente Virtual Vagrant](#ambiente-virtual-vagrant)
* [Licença](#licença)
* [Vulnerabilidades de Segurança](#vulnerabilidades-de-segurança)
* [Feedback](#feedback)
* [Contribuições](#contribuições)

Sobre
-----------------

Construído sobre [symfony](https://symfony.com/) e [backbone.js](https://backbonejs.org/), o Helpdesk CP Fani é um sistema de helpdesk open-source, orientado a serviços e baseado em eventos, projetado para fácil personalização e suporte ao cliente sem falhas. Sua arquitetura extensível permite que as organizações forneçam um atendimento ao cliente eficiente e personalizado com esforço mínimo.

A distribuição padrão inclui um conjunto abrangente de pacotes de helpdesk para suportar uma ampla gama de casos de uso e necessidades operacionais.

  * [**Core Framework**][2] - No coração do sistema de helpdesk, o core framework consiste em todas as APIs necessárias pelo seu projeto e pacotes dependentes para manter tudo funcionando sem problemas

  * [**Extension Framework**][3] - Introduz suporte para integração e desenvolvimento de pacotes de terceiros para facilmente construir e estender as funcionalidades do seu sistema de helpdesk conforme suas necessidades

  * [**Automation Bundle**][4] - Adiciona suporte para workflows e respostas preparadas para automatizar qualquer operação específica dentro do seu sistema de helpdesk

  * [**Mailbox Component**][11] - Converta e gerencie todos os seus emails para tickets de suporte no Helpdesk CP Fani e gerencie as consultas dos clientes facilmente.

  * [**Support Center Bundle**][5] - Integra o portal do centro de suporte facilmente personalizável para permitir que os usuários interajam facilmente com a equipe de suporte através do seu sistema de helpdesk

Entre em contato conosco em nosso [chat oficial no gitter][20] ou participando do [fórum][21] para quaisquer dúvidas, preocupações e discussões de solicitações de recursos.

O desenvolvimento da edição community do Helpdesk CP Fani é liderado pela equipe [uvdesk][10] e apoiado pela [Webkul][9]. Visite nosso [website][1] para saber mais sobre o Sistema de Helpdesk Helpdesk CP Fani.

Recursos
----------------

* [Suporte a Tradução (Multilíngue)][32]
* Agentes, grupos, equipes, clientes, tickets e mais ilimitados.
* Privilégios de Agente
* Sem limite no número de integrações de mailbox/email.
* Respostas Salvas – Responda rapidamente a perguntas frequentes.
* Filtre tickets por status, ID, agente, cliente e mais.
* Bloqueio de Spam
* [Atividade do Agente][29]
* [Anúncios de Marketing][30]
* [Módulos de Marketing][35]
* [Kudos][31]
* [Aplicativos Microsoft][36]
* Opção reCAPTCHA.
* Workflows automatizados padrão.
* Notas para agentes.
* Branding personalizado.
* Alterar logo e favicon.
* Mensagens de transmissão.
* Encaminhamento de Tickets.
* Resposta Preparada.
* Notificação por Email.
* Busca eficaz.
* Instalador Web Amigável.
* Suporta múltiplos anexos.
* Um poderoso sistema de base de conhecimento e FAQ – organize conteúdo por artigos, categorias e pastas.
* Tipos de tickets, Múltiplas Tags.
* Templates de Email.
* [API Bundle][16] e [Documentação][25]
* Editar/Excluir/Fixar ticket e thread.
* Adicione colaboradores facilmente e desbloqueie ainda mais recursos.
* [Explorar Aplicativos][26]

Documentação
--------------

Visite [docs.uvdesk.com](https://docs.uvdesk.com/) para ler nossa documentação oficial e saber mais sobre o projeto Helpdesk CP Fani.

Usamos Jekyll para desenvolver e manter nossa documentação. Considere contribuir enviando um pull request para o [repositório jekyll](https://github.com/uvdesk/uvdesk.github.io) do nosso projeto.

Requisitos
--------------

* **SO**: Ubuntu 16.04 LTS ou superior / Windows 7 ou Superior (WAMP / XAMPP).
* **SERVIDOR**: Apache 2 ou NGINX.
* **RAM**: 4GB ou superior.
* **PHP**: 8.1
* **Processador**: Clock Cycle 1 Ghz ou superior.
* **Para usuários SQLite**: Extensão pdo_sqlite habilitada (padrão na maioria das instalações PHP).
* **Composer**: 2 ou superior.
* **PHP IMAP** **&** **PHP Mailparse** para [Ubuntu][7], [Windows][23], [Centos][28], [Mac][27].

Instalação
--------------

O processo de instalação é dividido em duas etapas distintas:

* Setup
* Configuração

### Configurando seu projeto helpdesk

Nesta etapa, você baixará o skeleton do projeto Helpdesk CP Fani e instalará suas dependências.

Você pode usar o Composer para baixar e instalar tudo automaticamente, ou baixar um arquivo pré-empacotado que inclui todas as dependências. Recomendamos usar o Composer sempre que possível para atualizações mais fáceis e melhor gerenciamento de dependências. No entanto, se você estiver em um sistema com recursos limitados (por exemplo, hospedagem compartilhada), o download do arquivo pode ser mais confiável.

Independentemente do método escolhido, o processo de configuração do Helpdesk CP Fani permanece o mesmo.

#### Composer

Você pode usar o composer para configurar seu projeto simplesmente executando o seguinte comando no seu terminal:

```bash
$ composer create-project uvdesk/community-skeleton helpdesk-project
```

#### Download Direto

Alternativamente, você também pode [baixar o arquivo zip](https://cdn.uvdesk.com/uvdesk/downloads/opensource/uvdesk-community-current-stable.zip) da versão estável mais recente e extrair seu conteúdo executando os seguintes comandos no seu terminal:

```bash
$ wget "https://cdn.uvdesk.com/uvdesk/downloads/opensource/uvdesk-community-current-stable.zip" -P /var/www/
$ unzip -q /var/www/uvdesk-community-current-stable.zip -d /var/www/ \
```

### Configurando seu projeto helpdesk

Depois de baixar e instalar todas as dependências do projeto, você pode configurar sua instalação do helpdesk usando uma das seguintes maneiras:

#### Usando Terminal

```bash
$ php bin/console uvdesk:configure-helpdesk
```

#### Usando o Assistente de Instalação Web

##### Extraia o conteúdo do zip e execute o projeto no seu navegador em caso de download do zip do projeto:

~~~
http(s)://localhost/community-skeleton/public
~~~

##### Em caso de projeto criado usando comando, execute o projeto no seu navegador:

~~~
http(s)://localhost/helpdesk-project/public
~~~

ou

~~~
http(s)://example.com/public
~~~

Após abrir seu projeto no navegador web, você será recebido pelo instalador web que o guiará na configuração do seu projeto.

##### Executar projeto em localhost (modo dev)
```bash
php bin/console server:run
```

**Como limpar o cache:**

```bash
php bin/console c:c
```

#### ☁️ Implante Helpdesk CP Fani na Nuvem com Amazon AMI

Inicie facilmente o Helpdesk CP Fani na nuvem usando nossa Amazon Machine Image (AMI) pré-configurada, disponível diretamente no AWS Marketplace:

👉 [**Iniciar Helpdesk CP Fani na AWS**](https://aws.amazon.com/marketplace/pp/prodview-c4pibdsnipim4)

Esta AMI oferece uma maneira rápida e sem complicações de configurar o Helpdesk CP Fani em um ambiente AWS seguro e escalável. Perfeito para implantações de produção e fins de teste, sem necessidade de configuração manual.

**Como fazer login como admin/agente:**

*A URL abaixo é a URL padrão para login de admin/agente se você não fez nenhuma alteração para o prefixo /member.*

> *http(s)://example.com/en/member/login* 

**Como fazer login como cliente:**

*A URL abaixo é a URL padrão para login de cliente se você não fez nenhuma alteração para o prefixo /customer.*

> *http(s)://example.com/en/customer/login*

Docker Runtime
--------------

[Containerize seu projeto helpdesk][22]

Container Persistente Docker
--------------

[Comece com Helpdesk CP Fani agora usando container persistente docker][34]

Ambiente Virtual Vagrant
--------------

[Comece com Helpdesk CP Fani agora usando vagrant para configurar ambiente virtual][33]

Módulos
--------------

[Módulos/Apps Disponíveis](https://store.webkul.com/UVdesk/UVdesk-Open-Source.html)

Precisa de algo mais? envie um email para support@uvdesk.com

Licença
--------------

Todas as bibliotecas e bundles incluídos na Edição Community do Helpdesk CP Fani são liberados sob a licença [OSL-3.0][12].

Vulnerabilidades de Segurança
--------------

Por favor, não divulgue publicamente nenhuma vulnerabilidade de segurança. Se você encontrar alguma vulnerabilidade de segurança em nossa plataforma, por favor escreva para [support@uvdesk.com](mailto:support@uvdesk.com).

Feedback
---------
#### Feedback (Apoie o projeto Community enviando feedback)

* [Trustpilot][17]
* [Capterra][18]
* [Software suggest][19]

Contribuições
--------------
Este projeto é hospedado no [Open Collective][13] e existe graças aos nossos contribuidores:

<a href="https://github.com/uvdesk/community-skeleton/graphs/contributors"><img src="https://opencollective.com/uvdesk/contributors.svg?width=890&button=false"/></a>

#### Apoiadores

Obrigado a todos os nossos apoiadores! 🙏

<a href="https://opencollective.com/uvdesk#contributors" target="_blank"><img src="https://opencollective.com/uvdesk/backers.svg?width=890"></a>

#### Patrocinadores

Apoie este projeto tornando-se um patrocinador. Seu logo aparecerá aqui com um link para o seu website.

<a href="https://opencollective.com/uvdesk/contribute/sponsor-7372/checkout" target="_blank"><img src="https://images.opencollective.com/static/images/become_sponsor.svg"></a>

[1]: https://github.com/sunstrix/Udesk-CPFANI
[2]: https://github.com/uvdesk/core-framework
[3]: https://github.com/uvdesk/extension-framework
[4]: https://github.com/uvdesk/automation-bundle
[5]: https://github.com/uvdesk/support-center-bundle
[6]: https://support.uvdesk.com/en/blog/prerequisites-ubuntu
[7]: https://support.uvdesk.com/en/blog/prerequisites-ubuntu
[8]: https://getcomposer.org/
[9]: https://webkul.com/
[10]: https://www.uvdesk.com/en/team/
[11]: https://github.com/uvdesk/mailbox-component
[12]: https://github.com/uvdesk/community-skeleton/blob/master/LICENSE.txt
[13]: https://opencollective.com/uvdesk
[14]: https://docs.uvdesk.com/
[15]: https://demo.uvdesk.com/
[16]: https://github.com/uvdesk/api-bundle
[17]: https://www.trustpilot.com/review/uvdesk.com
[18]: https://www.capterra.com/p/158346/UVdesk/
[19]: https://www.softwaresuggest.com/uvdesk
[20]: https://gitter.im/uvdesk/community
[21]: https://forums.uvdesk.com/
[22]: https://github.com/uvdesk/community-skeleton/wiki/dockerize-helpdesk-project
[23]: https://support.uvdesk.com/en/blog/prerequisites-windows
[24]: https://symfony.com/projects/uvdesk
[25]: https://github.com/uvdesk/api-bundle/wiki/Ticket-Related-APIs
[26]: https://store.webkul.com/UVdesk/UVdesk-Open-Source.html
[27]: https://support.uvdesk.com/en/blog/prerequisites-mac
[28]: https://support.uvdesk.com/en/blog/prerequisites-centos7
[29]: https://www.uvdesk.com/en/blog/uvdesk-agent-activity/
[30]: https://www.uvdesk.com/en/blog/uvdesk-marketing-announcement/
[31]: https://support.uvdesk.com/es/blog/uvdesk-what-is-kudos
[32]: https://www.uvdesk.com/en/blog/language-translation-in-uvdesk-open-source-helpdesk/
[33]: https://github.com/uvdesk/community-skeleton/wiki/Vagrant-Virtual-Machine-Environment
[34]: https://github.com/uvdesk/community-skeleton/wiki/Docker-Persistent-Container
[35]: https://www.uvdesk.com/en/blog/marketing-module/
[36]: https://www.uvdesk.com/en/how-to-integrate-microsoft-app-to-your-opensource-uvdesk/