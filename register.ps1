Set-Location (Split-Path ( & { $myInvocation.ScriptName } ) -parent)
Add-Type -Path ".\WebAuthnModokiDesktop.dll";

Write-Host "キーをさしてください"
$poll = [gebo.CTAP2.Util.CmdExecuter]::Polling(5000).GetAwaiter().GetResult()
if( $poll -eq $false ) {
    Write-Host "Timeout"
    return
}

Write-Host "RDP接続情報を入力してください"
$ip=Read-Host "RDP Host"
$user= Read-Host "RDP User"
$pass= Read-Host "RDP Password"

Write-Host "登録情報を入力してください"
$rpid= Read-Host "Authenticator RPID"
$pin= Read-Host "Authenticator PIN"

$cmd = "Cmdkey /generic:TERMSRV/${ip} /user:${user} /pass:${pass} & Start mstsc /v:${ip} & Timeout 2 & Cmdkey /delete:TERMSRV/${ip}";

$blockcount = [gebo.CTAP2.Util.CmdExecuter]::CheckWriteBlockCount($cmd)
Write-Host "登録ブロック数 = ${blockcount}"

$result = [gebo.CTAP2.Util.CmdExecuter]::RegisterCmd($rpid,$pin,$cmd).GetAwaiter().GetResult()
Write-Host "${result}"
