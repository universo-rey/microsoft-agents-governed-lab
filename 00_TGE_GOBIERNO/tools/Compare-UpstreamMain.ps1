param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path,
  [string]$OriginName = "origin",
  [string]$UpstreamName = "upstream",
  [switch]$Fetch,
  [string]$OutPath = ""
)

$ErrorActionPreference = "Stop"

function Git-Lines([string[]]$GitArgs) {
  $output = @(& git -C $RepoRoot @GitArgs 2>&1)
  if ($LASTEXITCODE -ne 0) {
    throw ($output -join "`n")
  }
  return $output
}

function Git-OneLine([string[]]$GitArgs) {
  $lines = Git-Lines $GitArgs
  return ($lines | Select-Object -First 1)
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

$originFetch = Git-OneLine @("remote", "get-url", $OriginName)
$upstreamFetch = Git-OneLine @("remote", "get-url", $UpstreamName)
$upstreamPush = Git-OneLine @("remote", "get-url", "--push", $UpstreamName)

if ((Normalize-GithubRemote $originFetch) -ne "universo-rey/microsoft-agents-governed-lab") {
  throw "origin fetch URL mismatch: $originFetch"
}
if ((Normalize-GithubRemote $upstreamFetch) -ne "microsoft/Agents") {
  throw "upstream fetch URL mismatch: $upstreamFetch"
}
if ([string]::IsNullOrWhiteSpace($upstreamPush) -or (Normalize-GithubRemote $upstreamPush) -eq "microsoft/Agents") {
  throw "upstream push URL must be disabled before comparison"
}

if ($Fetch) {
  Git-Lines @("fetch", "--prune", $OriginName, "main") | Out-Null
  Git-Lines @("fetch", "--prune", $UpstreamName, "main") | Out-Null
}

$originHead = Git-OneLine @("rev-parse", "$OriginName/main")
$upstreamHead = Git-OneLine @("rev-parse", "$UpstreamName/main")
$countsRaw = Git-OneLine @("rev-list", "--left-right", "--count", "$OriginName/main...$UpstreamName/main")
$countParts = @($countsRaw -split "\s+" | Where-Object { $_ -ne "" })
$nameStatus = @(Git-Lines @("diff", "--name-status", "$OriginName/main...$UpstreamName/main", "--"))
$stat = @(Git-Lines @("diff", "--stat", "$OriginName/main...$UpstreamName/main", "--"))

$payload = [ordered]@{
  status = "PASS"
  mode = if ($Fetch) { "FETCH_AND_COMPARE_NO_MERGE" } else { "COMPARE_EXISTING_REFS_NO_MERGE" }
  repo_root = $RepoRoot
  origin = $originFetch
  upstream = $upstreamFetch
  upstream_push = $upstreamPush
  origin_main = $originHead
  upstream_main = $upstreamHead
  origin_only_commits = [int]$countParts[0]
  upstream_only_commits = [int]$countParts[1]
  changed_path_count = $nameStatus.Count
  changed_paths_sample = @($nameStatus | Select-Object -First 100)
  stat = @($stat | Select-Object -First 80)
  blocked_actions = @(
    "merge",
    "rebase",
    "push_to_upstream",
    "microsoft_live",
    "tenant_write",
    "production"
  )
}

if (-not [string]::IsNullOrWhiteSpace($OutPath)) {
  $target = if ([System.IO.Path]::IsPathRooted($OutPath)) { $OutPath } else { Join-Path $RepoRoot $OutPath }
  $parent = Split-Path -Parent $target
  if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
  }
  $payload | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $target -Encoding UTF8
}

$payload | ConvertTo-Json -Depth 8
