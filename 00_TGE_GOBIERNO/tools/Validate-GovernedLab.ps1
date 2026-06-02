param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path,
  [switch]$RequireConfiguredUpstream
)

$ErrorActionPreference = "Stop"

function Add-Problem {
  param(
    [System.Collections.Generic.List[string]]$List,
    [string]$Message
  )
  $List.Add($Message) | Out-Null
}

function Read-Text([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) {
    return $null
  }
  return Get-Content -LiteralPath $Path -Raw
}

function Git-OneLine([string[]]$GitArgs) {
  $output = & git -C $RepoRoot @GitArgs 2>$null
  if ($LASTEXITCODE -ne 0) {
    return $null
  }
  return ($output | Select-Object -First 1)
}

function Normalize-GithubRemote([string]$Remote) {
  if ([string]::IsNullOrWhiteSpace($Remote)) {
    return ""
  }
  $trimmed = $Remote.Trim()
  if ($trimmed -match "^https://github\.com/(.+?)(?:\.git)?$") {
    return $Matches[1]
  }
  if ($trimmed -match "^git@github\.com:(.+?)(?:\.git)?$") {
    return $Matches[1]
  }
  return $trimmed
}

$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

$requiredFiles = @(
  "AGENTS.md",
  "00_TGE_GOBIERNO/README.md",
  "00_TGE_GOBIERNO/END_TO_END_AGENT_RUNTIME_CHAIN.md",
  "00_TGE_GOBIERNO/RELATED_REPOS_MUST_REMEMBER.md",
  "00_TGE_GOBIERNO/SDU_CN_CANONICAL_AGENT_AUTHORITY.md",
  "00_TGE_GOBIERNO/SHAREPOINT_APPROVED_WRITE_SITES.md",
  "00_TGE_GOBIERNO/UPSTREAM_SYNC_POLICY.md",
  "08_READBACKS/ACTA_INICIAL_TGE_GOBIERNO_MICROSOFT_AGENTS_LAB_20260530.md"
)

foreach ($relative in $requiredFiles) {
  $path = Join-Path $RepoRoot $relative
  if (-not (Test-Path -LiteralPath $path)) {
    Add-Problem $errors "Missing required governance file: $relative"
  }
}

$agents = Read-Text (Join-Path $RepoRoot "AGENTS.md")
$readme = Read-Text (Join-Path $RepoRoot "00_TGE_GOBIERNO/README.md")
$policy = Read-Text (Join-Path $RepoRoot "00_TGE_GOBIERNO/UPSTREAM_SYNC_POLICY.md")
$packageJson = Read-Text (Join-Path $RepoRoot "package.json")

if ($agents) {
  foreach ($requiredText in @(
      "TGE_GOVERNED_REPO_ACTIVE",
      "SDU_CN_CANONICAL_AGENT_AUTHORITY_ACTIVE_20260530",
      "https://github.com/microsoft/Agents.git",
      "https://github.com/universo-rey/microsoft-agents-governed-lab.git",
      "No ejecutar acciones live de Microsoft 365"
    )) {
    if ($agents -notmatch [regex]::Escape($requiredText)) {
      Add-Problem $errors "AGENTS.md missing required text: $requiredText"
    }
  }
}

if ($readme -and $readme -notmatch "YA_NO_DEBE_SER_GATEADA_ES_GOBERNADA") {
  Add-Problem $errors "00_TGE_GOBIERNO/README.md must preserve governed-not-gated language"
}

if ($policy) {
  foreach ($requiredText in @("TGE_UPSTREAM_SYNC_GOVERNED_POLICY_ACTIVE", "No sobrescribir gobierno TGE", "No tratar este laboratorio como produccion Microsoft 365")) {
    if ($policy -notmatch [regex]::Escape($requiredText)) {
      Add-Problem $errors "UPSTREAM_SYNC_POLICY.md missing required text: $requiredText"
    }
  }
}

if ($packageJson -and $packageJson -notmatch '"validate-governance"') {
  Add-Problem $errors "package.json missing validate-governance script"
}

$workflowPath = Join-Path $RepoRoot ".github/workflows/tge-governed-lab-validation.yml"
if (-not (Test-Path -LiteralPath $workflowPath)) {
  Add-Problem $errors "Missing TGE governed lab validation workflow"
} else {
  $workflow = Read-Text $workflowPath
  if ($workflow -notmatch "contents: read") {
    Add-Problem $errors "Validation workflow must use contents: read permissions"
  }
  if ($workflow -match "secrets\." -and $workflow -notmatch "secrets\.GITHUB_TOKEN") {
    Add-Problem $errors "Validation workflow must not reference repository secrets"
  }
}

$originFetch = Git-OneLine @("remote", "get-url", "origin")
if ($originFetch -and (Normalize-GithubRemote $originFetch) -ne "universo-rey/microsoft-agents-governed-lab") {
  Add-Problem $errors "origin fetch URL mismatch: $originFetch"
}

if ($RequireConfiguredUpstream) {
  $upstreamFetch = Git-OneLine @("remote", "get-url", "upstream")
  $upstreamPush = Git-OneLine @("remote", "get-url", "--push", "upstream")
  if ((Normalize-GithubRemote $upstreamFetch) -ne "microsoft/Agents") {
    Add-Problem $errors "upstream fetch URL mismatch: $upstreamFetch"
  }
  if ([string]::IsNullOrWhiteSpace($upstreamPush) -or (Normalize-GithubRemote $upstreamPush) -eq "microsoft/Agents") {
    Add-Problem $errors "upstream push URL must be disabled locally"
  }
}

$forbiddenNames = @(".env", ".env.local", ".env.production")
foreach ($name in $forbiddenNames) {
  $matches = @(Get-ChildItem -LiteralPath $RepoRoot -Recurse -Force -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -eq $name -and $_.FullName -notmatch "\\.git\\" })
  if ($matches.Count -gt 0) {
    Add-Problem $errors "Forbidden local environment file detected: $name"
  }
}

$payload = [ordered]@{
  status = if ($errors.Count -eq 0) { "PASS" } else { "FAIL" }
  repo_root = $RepoRoot
  validator = "Validate-GovernedLab.ps1"
  require_configured_upstream = [bool]$RequireConfiguredUpstream
  checked_files = $requiredFiles
  origin = $originFetch
  errors = @($errors)
  warnings = @($warnings)
}

$payload | ConvertTo-Json -Depth 8

if ($errors.Count -gt 0) {
  exit 1
}
