# TestCI
=======
# Fluxo de CI/CD do Projeto TestCI

Este documento descreve o fluxo de CI implementado para este projeto, garantindo a qualidade e a segurança antes da integração de código na branch principal.

## Fluxograma do Processo

O diagrama abaixo ilustra a interação entre os três workflows: o bloqueio automático de PRs, a verificação manual que orquestra os testes, e a suíte de testes reutilizável.

```mermaid
%%{init: { 'theme': 'base', 'themeVariables': { 'background': '#ffffff' } } }%%
flowchart TD
    subgraph "Bloqueio Automático (pr-gatekeeper.yml)"
        spacerA[" "]
        A["Desenvolvedor abre ou<br>atualiza um PR"]
        B{"Workflow 'PR Gatekeeper'<br>é acionado"}
        C["Job 'create_pending_check' define o<br>status do commit como 'failure'"]
        D(("PR Inicialmente Bloqueado"))
    end

    relay[" "]

    subgraph "Orquestração Manual (manual-pr-check.yml)"
        spacerE[" "]
        E["Usuário aciona manualmente o<br>workflow 'Check TestCi in PR'"]
        F["Job: find-pr-and-mark-pending<br>---<br>1. Encontra o PR pela branch<br>2. Define o status como 'pending'"]
        H{"Job 'exec-tests'<br>é executado"}
        I(("reusable-test-suite.yml"))
        J{"Resultado final dos testes?"}
        K["Job: mark-pr-with-approve-or-failure<br>---<br>Define o status final como 'success'"]
        L["Job: mark-pr-with-approve-or-failure<br>---<br>Define o status final como 'failure'"]
        S(("PR Desbloqueado para Merge ✅"))
    end

    subgraph "Suíte de Testes (reusable-test-suite.yml)"
        P["Job 'security_check'"]
        Q["Job 'features_tests'"]
        R["Job 'non_features_tests'"]
    end
    
    %% --- Seção de Conexões --- %%
    spacerA --> A
    spacerE --> E

    D -.-> relay
    relay --> E

    A --> B
    B --> C
    C --> D
    D -.-> E
    E --> F
    F --> H
    H -. Chama o workflow<br>reutilizável .-> I
    I -- Inicia a execução --> J
    J -- Sucesso --> K
    J -- Falha --> L
    K --> S
    L --> D
    J -- Chamada Interna --> P
    P --> Q
    P --> R
    
    %% --- Seção de Estilização --- %%
    style spacerA fill:transparent,stroke:transparent
    style spacerE fill:transparent,stroke:transparent
    style relay fill:transparent,stroke:transparent

    linkStyle 0,1,2,4 stroke:transparent

    style A fill:#E0FFFF,stroke:#008B8B
    style D fill:#FFB6C1,stroke:#DC143C
    style E fill:#E0FFFF,stroke:#008B8B
    style I fill:#DDA0DD,stroke:#8A2BE2
    style J fill:#FFFACD,stroke:#FF8C00
    style K fill:#90EE90,stroke:#2E8B57
    style L fill:#FFB6C1,stroke:#DC143C
    style S fill:#2E8B57,stroke:#2E8B57,color:#fff
```