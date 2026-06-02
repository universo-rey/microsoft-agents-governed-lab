# Readback - npm refresh peer fix - 2026-06-02

## Orden

Resolver el carril Dependabot #7 bajo gobierno TGE y regla de ramas `codex/*`.

## Fuente

- PR fuente: `https://github.com/universo-rey/microsoft-agents-governed-lab/pull/7`
- HEAD fuente: `9dd103f539c7faef67d8016918b9617c98ef85c5`
- Rama gobernada: `codex/lab-npm-refresh-peer-fix-20260602`

## Alcance

Se replica el update npm de 4 directorios en una rama `codex/*` y se corrige
el conflicto recurrente de peer dependency que intentaba subir `eslint` y
`@eslint/js` a `10.x`, incompatible con `neostandard@0.13.0`.

## Ajustes gobernados

- `eslint` queda en `^9.39.4`.
- `@eslint/js` queda en `^9.39.4`.
- `typescript-eslint` queda actualizado a `^8.60.1`.
- Se conservan los updates Dependabot compatibles en samples Node.
- No se agrega dependencia directa nueva para `flatted`.

## Validadores locales

- `npm ci`: PASS
- `npm run lint`: PASS
- `npm audit --json`: PASS, `total=0`
- `pwsh -NoProfile -File ./00_TGE_GOBIERNO/tools/Validate-GovernedLab.ps1 -RequireConfiguredUpstream`: PASS
- `npm run validate-governance -- --RequireConfiguredUpstream`: PASS
- `git diff --check`: PASS

## No ejecutado

- No Microsoft live.
- No tenant write.
- No produccion.
- No permisos.
- No push a `microsoft/Agents`.

## Stop condition

`automated_merge_precheck_failed`
