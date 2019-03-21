Set-Location (Split-Path ( & { $myInvocation.ScriptName } ) -parent)
Add-Type -Path ".\WebAuthnModokiDesktop.dll";

$rpid= Read-Host "Authenticator RPID"
$pin= Read-Host "Authenticator PIN"

$ip=Read-Host "RDP Host"
$user= Read-Host "RDP User"
$pass= Read-Host "RDP Password"

$cmd = "Cmdkey /generic:TERMSRV/${ip} /user:${user} /pass:${pass} & Start mstsc /v:${ip} & Timeout 2 & Cmdkey /delete:TERMSRV/${ip}";

$blockcount = [gebo.CTAP2.Util.CmdExecuter]::CheckWriteBlockCount($cmd)
$msg = "Register Count = " + [string]$blockcount
Read-Host "Message : ${msg}"

$result = [gebo.CTAP2.Util.CmdExecuter]::RegisterCmd($rpid,$pin,$cmd).GetAwaiter().GetResult()

Read-Host "Message : ${result}"
