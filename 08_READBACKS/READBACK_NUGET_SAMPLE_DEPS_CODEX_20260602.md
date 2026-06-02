# Readback - NuGet sample dependencies codex replacement - 2026-06-02

## Orden

Resolver el carril Dependabot #1 bajo gobierno TGE y regla de ramas `codex/*`.

## Fuente

- PR fuente: `https://github.com/universo-rey/microsoft-agents-governed-lab/pull/1`
- HEAD fuente: `e6b1fdd16bd23d07f381ce64968e17205591d038`
- Rama gobernada: `codex/lab-nuget-sample-deps-20260602`

## Alcance

Se replica el update NuGet de samples dotnet en una rama `codex/*` para cumplir
el preflight de cabina antes de merge automatizable.

## Archivos de dependencia

- `samples/dotnet/Agent Framework/AgentFrameworkWeather.csproj`
- `samples/dotnet/RetrievalBot/RetrievalBot.csproj`
- `samples/dotnet/RetrievalBot/dotnet/tests/Microsoft.Agents.M365Copilot.Beta.Tests/Microsoft.Agents.M365Copilot.Beta.Tests.csproj`
- `samples/dotnet/semantic-kernel-multiturn/SemanticKernelMultiturn.csproj`

## No ejecutado

- No Microsoft live.
- No tenant write.
- No produccion.
- No permisos.
- No push a `microsoft/Agents`.

## Stop condition

`automated_merge_precheck_failed`
