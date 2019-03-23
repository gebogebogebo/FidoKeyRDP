Set-Location (Split-Path ( & { $myInvocation.ScriptName } ) -parent)
Add-Type -Path ".\WebAuthnModokiDesktop.dll";

Write-Host "キーをさしてください"
$poll = [gebo.CTAP2.Util.CmdExecuter]::Polling(5000).GetAwaiter().GetResult()
if( $poll -eq $false ) {
    Write-Host "Timeout"
    return
}
Write-Host "登録情報を入力してください"
$rpid= Read-Host "Authenticator RPID"
$pin= Read-Host "Authenticator PIN"
$result = [gebo.CTAP2.Util.CmdExecuter]::Execute($rpid,$pin).GetAwaiter().GetResult()
return $result
