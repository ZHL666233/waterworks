$port = 8777
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

# Start browser
Start-Process "http://127.0.0.1:$port"

# MIME types
$mime = @{
    '.html' = 'text/html'
    '.js'   = 'application/javascript'
    '.css'  = 'text/css'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.json' = 'application/json'
    '.xml'  = 'application/xml'
    '.ogg'  = 'audio/ogg'
    '.mp3'  = 'audio/mpeg'
    '.ttf'  = 'font/ttf'
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://127.0.0.1:$port/")
$listener.Start()
Write-Host "Waterworks! 汉化版 - http://127.0.0.1:$port/"
Write-Host "关闭此窗口停止服务器"

while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $path = $ctx.Request.Url.LocalPath.TrimStart('/')
    if ($path -eq '') { $path = 'index.html' }
    $file = Join-Path $root $path
    if (Test-Path $file) {
        $ext = [IO.Path]::GetExtension($file).ToLower()
        $ctx.Response.ContentType = if ($mime[$ext]) { $mime[$ext] } else { 'application/octet-stream' }
        $buf = [IO.File]::ReadAllBytes($file)
        $ctx.Response.OutputStream.Write($buf, 0, $buf.Length)
    }
    $ctx.Response.Close()
}
