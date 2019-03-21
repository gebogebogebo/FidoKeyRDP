Set-Location (Split-Path ( & { $myInvocation.ScriptName } ) -parent)
Add-Type -Path ".\WebAuthnModokiDesktop.dll";
$result = [gebo.CTAP2.Util.CmdExecuter]::Execute($Args[0],$Args[1]).GetAwaiter().GetResult()
return $result
