# AGENTS

## Rol de este repo

`universo-rey/microsoft-agents-governed-lab` es un laboratorio privado gobernado por TGE para estudiar, adaptar y evidenciar trabajo sobre Microsoft Agents y Agent 365 MCP Frontier.

Este repo nace desde `microsoft/Agents` y conserva esa procedencia tecnica. No reemplaza al repositorio oficial de Microsoft.

Repos TGE relacionados que no deben olvidarse:

- `SeshatSgin/tge-agentic-runtime-control-escribania`.
- `SeshatSgin/seshat-bootstrap-sdu-cn`.

SharePoint Escribania aprobado para escritura gobernada:

- `https://escribaniabitsch.sharepoint.com/sites/SYS-GobiernoOperativo-PILOTO` primero.
- `https://escribaniabitsch.sharepoint.com/sites/Soporte-Gobierno-Sistema-Declarativo-Torre-Control`.

## Estado rector

`TGE_GOVERNED_REPO_ACTIVE`

`TGE_RUNTIME_APPROVED_GOVERNED_ACTIVE_20260530`

Interpretacion vigente:

- Este repo no se trata como superficie "gateada".
- Este repo queda gobernado por TGE con trazabilidad, evidencia y orden operativo.
- Runtime TGE esta aprobado y gobernado; las acciones sensibles se ordenan por superficie, evidencia y postcheck.
- TGE define criterio local, evidencia, ramas, readbacks y sincronizacion con upstream.
- La organizacion GitHub `universo-rey` aloja el repo privado.
- La cuenta operativa usada para publicar es `SeshatSgin`.

## Jerarquia operativa

1. TGE como gobierno tecnico-operativo del repo.
2. SDU-CN como agentes canonicos con autoridad rectora de criterio, consistencia, evidencia y escalamiento.
3. CDF staff como apoyo tecnico delegado.
4. Agentes SDK/laboratorio y automatizaciones como ejecutores subordinados.
5. Upstream `microsoft/Agents` como fuente externa de codigo base.

## Conducta obligatoria

- Leer antes de escribir.
- Mantener `upstream` apuntando a `https://github.com/microsoft/Agents.git`.
- Mantener `origin` apuntando a `https://github.com/universo-rey/microsoft-agents-governed-lab.git`.
- Registrar cambios de gobierno o pruebas bajo `00_TGE_GOBIERNO/` y `08_READBACKS/`.
- No persistir secretos, tokens, claves, cookies, dumps ni credenciales.
- No usar datos regulados reales dentro del repo.
- No ejecutar acciones live de Microsoft 365, tenant, SharePoint, Power Platform, Outlook, Teams, Calendar, OneDrive o Windows 365 desde este repo sin orden gobernada explicita.
- Toda cadena de agentes debe pasar por `cdf.project_manager_delegador`, `cdf.prompt_router`, prompt pack/receta, agente asignado, contraparte SDU-CN y `cdf.evidence_validator`.
- No confundir este repo con el runtime productivo de Escribania.
- No declarar readiness productiva si solo existe readiness documental o de laboratorio.
- Respetar autoridad canonica SDU-CN por encima de CDF staff, agentes SDK, conectores, tools, plugins y automatizaciones.

## Autoridad canonica SDU-CN

Estado: `SDU_CN_CANONICAL_AGENT_AUTHORITY_ACTIVE_20260530`.

Agentes canonicos:

- `Seshat Normativa`.
- `Horus de Riesgo`.
- `Maat de Cumplimiento`.
- `Anubis de Gate`.
- `Thot Tecnico`.
- `Narrador Normativo`.

Si una decision de laboratorio, adaptacion de upstream, prueba MCP, cambio documental o ejecucion tecnica entra en conflicto con criterio SDU-CN, prevalece SDU-CN. Esta autoridad no reemplaza la autoridad institucional humana de Escribania.

Los demas agentes operan en la torre o en este laboratorio cuando tienen asignacion gobernada a una superficie o carril. Si no estan asignados, quedan en espera hasta recibir owner, contraparte SDU-CN, superficie, evidencia y postcheck.

## Flujo GitHub

- Branch por defecto: `main`.
- Cambios exploratorios: ramas `codex/<frente>`.
- Commits: chicos, descriptivos y auditables.
- Sincronizacion upstream: traer cambios desde `upstream/main`, revisar, validar y luego publicar a `origin`.
- Main puede recibir el bootstrap inicial autorizado por el usuario. Cambios posteriores deberian quedar en PR salvo orden explicita.

## Cadena end-to-end

`SDU-CN canonico -> cdf.project_manager_delegador -> cdf.prompt_router -> prompt pack/receta -> agente asignado -> contraparte SDU-CN -> cdf.evidence_validator -> GitHub canon -> SharePoint piloto cuando aplique`.

`cdf.prompt_router` es obligatorio para preparar prompts y recetas antes de asignar agentes.

## Frontera de ejecucion

Permitido:

- Analizar codigo y documentacion del upstream.
- Crear adaptaciones documentales, matrices, readbacks, pruebas locales y evidencia sanitizada.
- Preparar manifiestos, scripts no secretos y fixtures dummy.
- Usar GitHub como canon tecnico de este laboratorio.

No permitido sin orden gobernada explicita:

- Acciones live contra tenants Microsoft.
- Lectura amplia de datos de usuarios, correos, calendarios, Teams, OneDrive o SharePoint.
- Cambios de permisos, usuarios, conectores, entornos, apps, flows o admin center.
- Computer-use remoto o control de escritorio Windows 365.
- Publicacion externa o produccion.
