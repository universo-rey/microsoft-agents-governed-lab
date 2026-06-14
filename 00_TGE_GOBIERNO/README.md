# TGE Gobierno

## Estado

`TGE_GOVERNED_REPO_ACTIVE`

Este directorio contiene la capa local de gobierno para `universo-rey/microsoft-agents-governed-lab`.

La regla corregida por el usuario es:

`YA_NO_DEBE_SER_GATEADA_ES_GOBERNADA`

Runtime TGE vigente:

`TGE_RUNTIME_APPROVED_GOVERNED_ACTIVE_20260530`

## Alcance

TGE gobierna este repo como laboratorio privado para:

- estudiar `microsoft/Agents`;
- preparar pruebas Agent 365 MCP Frontier;
- mantener evidencia y readbacks sanitizados;
- separar laboratorio, tenant live y produccion;
- conservar trazabilidad de decisiones.

## Regla de lenguaje

Usar:

- `gobernado`;
- `orden gobernada`;
- `readback`;
- `postcheck`;
- `evidencia`;
- `frontera operativa`;
- `alcance autorizado`.

Evitar presentar este repo como bloqueado por defecto. El control vigente no es bloqueo: es gobierno operativo TGE.

## Procedencia tecnica

- Upstream: `microsoft/Agents`.
- Repo gobernado: `universo-rey/microsoft-agents-governed-lab`.
- Cabina rectora: `TORRE_GEMELA_ESCRIBANIA`.
- Publicacion inicial: `2026-05-30`.

## SharePoint aprobado

Sitio aprobado de nombre historico primero:

`https://escribaniabitsch.sharepoint.com/sites/SYS-GobiernoOperativo-PILOTO`

Sitio secundario aprobado:

`https://escribaniabitsch.sharepoint.com/sites/Soporte-Gobierno-Sistema-Declarativo-Torre-Control`

## Cadena de agentes

`SDU-CN canonico -> cdf.project_manager_delegador -> cdf.prompt_router -> prompt pack/receta -> agente asignado -> contraparte SDU-CN -> cdf.evidence_validator -> GitHub canon -> SharePoint superficie gobernada cuando aplique`.

El laboratorio hereda la regla de TGE: siempre usar el agente de prompts y recetas antes de asignar trabajo.

## Validacion repo-nativa

El lab usa validadores locales versionados bajo `00_TGE_GOBIERNO/tools`:

- `Validate-GovernedLab.ps1`: valida archivos rectores, frontera, remotos y workflow de gobierno.
- `Compare-UpstreamMain.ps1`: compara `origin/main` contra `upstream/main` sin merge, rebase ni push.

El workflow `.github/workflows/tge-governed-lab-validation.yml` ejecuta la
validacion de gobierno con permisos `contents: read`.
