param(
  [string]$Root = $PSScriptRoot,
  [string]$Bind = 'localhost',
  [int]$Port = 8000
)
$Prefix = "http://$Bind`:$Port/"
try { $Root = (Resolve-Path $Root).Path } catch { $Root = $PSScriptRoot }
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($Prefix)
try { $listener.Start() } catch { Write-Host "Error: $($_.Exception.Message)"; exit 1 }
Write-Host "Serving $Root at $Prefix"
$mime = @{
  ".html"="text/html; charset=utf-8"
  ".htm"="text/html; charset=utf-8"
  ".css"="text/css; charset=utf-8"
  ".js"="application/javascript; charset=utf-8"
  ".json"="application/json; charset=utf-8"
  ".png"="image/png"
  ".jpg"="image/jpeg"
  ".jpeg"="image/jpeg"
  ".webp"="image/webp"
  ".svg"="image/svg+xml; charset=utf-8"
  ".mp3"="audio/mpeg"
  ".wav"="audio/wav"
  ".txt"="text/plain; charset=utf-8"
}
while ($true) {
  $ctx = $listener.GetContext()
  $path = [uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath)
  if ($path -eq "/") { $path = "/romantica.html" }
  $safe = $path -replace "[/\\]+","\"
  $safe = $safe -replace "\.\.",""
  $safe = $safe.TrimStart("\")
  $file = Join-Path $Root $safe
  if (-not (Test-Path $file -PathType Leaf)) {
    $ctx.Response.StatusCode = 404
    $bytes = [System.Text.Encoding]::UTF8.GetBytes("404")
    $ctx.Response.OutputStream.Write($bytes,0,$bytes.Length)
    $ctx.Response.Close()
    continue
  }
  $ext = [System.IO.Path]::GetExtension($file).ToLowerInvariant()
  $type = $mime[$ext]
  if (-not $type) { $type = "application/octet-stream" }
  try {
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $ctx.Response.ContentType = $type
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes,0,$bytes.Length)
    $ctx.Response.Close()
  } catch {
    $ctx.Response.StatusCode = 500
    $msg = [System.Text.Encoding]::UTF8.GetBytes("500")
    $ctx.Response.OutputStream.Write($msg,0,$msg.Length)
    $ctx.Response.Close()
  }
}
