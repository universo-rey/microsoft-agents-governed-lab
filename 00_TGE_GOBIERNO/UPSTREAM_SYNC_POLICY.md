# UPSTREAM_SYNC_POLICY

## Decision

`TGE_UPSTREAM_SYNC_GOVERNED_POLICY_ACTIVE`

Este repo conserva relacion con `microsoft/Agents` sin perder gobierno TGE.

## Remotos esperados

- `origin`: `https://github.com/universo-rey/microsoft-agents-governed-lab.git`.
- `upstream`: `https://github.com/microsoft/Agents.git`.

## Regla de sincronizacion

1. Leer estado local y remoto.
2. Traer cambios desde `upstream`.
3. Revisar diferencias antes de integrar.
4. Registrar decision o readback si la actualizacion cambia superficie relevante.
5. Publicar a `origin` solo luego de validacion local razonable.

## No hacer

- No sobrescribir gobierno TGE al sincronizar upstream.
- No subir tokens, credenciales ni salidas de autenticacion.
- No mezclar este repo con el repo TGE canonico.
- No tratar este laboratorio como produccion Microsoft 365.

