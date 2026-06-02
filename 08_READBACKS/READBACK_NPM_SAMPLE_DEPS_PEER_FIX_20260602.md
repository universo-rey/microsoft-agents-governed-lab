# Readback - npm sample dependencies peer fix - 2026-06-02

## Orden

Resolver el carril Dependabot #2 bajo gobierno TGE y regla de ramas `codex/*`.

## Fuente

- PR fuente: `https://github.com/universo-rey/microsoft-agents-governed-lab/pull/2`
- HEAD fuente: `fc69ad3447fa7a1df4f1ecfb774590b9666dc1ad`
- Rama gobernada: `codex/lab-npm-deps-peer-fix-20260602`

## Alcance

Se replica el update npm de samples en una rama `codex/*` y se corrige el
conflicto de peer dependency que dejaba `eslint@10.x` incompatible con
`neostandard@0.13.0`, cuyo peer declarado es `eslint ^9.0.0`.

## Ajustes gobernados

- `eslint` queda en `^9.39.4`.
- `@eslint/js` queda en `^9.39.4`.
- `flatted` transitivo queda actualizado a version parcheada por lockfile.
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
