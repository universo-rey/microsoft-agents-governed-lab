# Readback - Dependabot, upstream and native validator - 2026-06-02

## Orden

El operador aprobo los proximos carriles del lab `universo-rey/microsoft-agents-governed-lab`.

## Alcance ejecutado

- Revision read-only de PR #1 y PR #2.
- Diagnostico del check fallido en PR #2.
- Validador repo-nativo para frontera TGE y remotos.
- Workflow repo-nativo de validacion con permisos `contents: read`.
- Herramienta de comparacion controlada `origin/main...upstream/main`.

## PR #1

- URL: `https://github.com/universo-rey/microsoft-agents-governed-lab/pull/1`
- Estado: `OPEN`
- Rama: `dependabot/nuget/samples/dotnet/Agent-Framework/nuget-all-71191d6bc8`
- Merge state: `CLEAN`
- Checks: dotnet, node y python en verde; labeler omitido por condicion del workflow.
- Lectura: revisable en carril repo-nativo. No se mergeo.

## PR #2

- URL: `https://github.com/universo-rey/microsoft-agents-governed-lab/pull/2`
- Estado: `OPEN`
- Rama: `dependabot/npm_and_yarn/npm-all-3ddac0eb19`
- Merge state: `UNSTABLE`
- Checks: `build-node (20)` falla; `build-node (latest)` queda fallido/cancelado; dotnet y python pasan.
- Causa observada: `npm ci` falla con `ERESOLVE` por conflicto entre `eslint@10.4.1` y `neostandard@0.13.0`, cuyo peer pide ESLint 9.
- Lectura: no listo para merge. Requiere dividir o corregir el grupo npm antes de avanzar.

## Validador

- `00_TGE_GOBIERNO/tools/Validate-GovernedLab.ps1`
- `00_TGE_GOBIERNO/tools/Compare-UpstreamMain.ps1`
- `.github/workflows/tge-governed-lab-validation.yml`
- `00_TGE_GOBIERNO/VALIDATION_MATRIX.csv`

## Validacion ejecutada

- `Validate-GovernedLab.ps1 -RequireConfiguredUpstream`: `PASS`.
- `npm run validate-governance -- --RequireConfiguredUpstream`: `PASS`.
- `Compare-UpstreamMain.ps1 -Fetch`: `PASS`.
- `git diff --check`: `PASS`.

## Comparacion upstream

- `origin/main`: `ba27bd0929d739c675f9b89153b3035a5545aac6`
- `upstream/main`: `aa591cf49419c8839a5decaf6dc8c0cf2cf76763`
- Commits solo en origin: `2`
- Commits solo en upstream: `2`
- Rutas distintas: `4`
- Evidencia JSON: `08_READBACKS/upstream_compare_latest.json`

La diferencia observada afecta 4 archivos `.csproj` en samples dotnet, alineada
con el contenido de PR #1. No se ejecuto merge ni rebase.

## No ejecutado

- No Microsoft live.
- No tenant write.
- No produccion.
- No permisos.
- No push a `microsoft/Agents`.
- No merge de Dependabot.

## Stop condition

`microsoft_live_or_productive_agent_without_order`

## Proximos carriles

- PR #1: revision humana/repo-nativa y merge solo con HEAD fijo y checks verdes.
- PR #2: preparar fix o comentario Dependabot; no mergear mientras exista `ERESOLVE`.
- Upstream: ejecutar comparacion con readback antes de cualquier sincronizacion.
