function get-fileversion {
  param([System.IO.FileInfo] $fileItem)
  $verInfo = $fileItem.VersionInfo
  "{0}.{1}.{2}" -f
    $verInfo.FileMajorPart,
    $verInfo.FileMinorPart,
    $verInfo.FileBuildPart
}

While($true){
	echo "Checking IDENA Node & Client ..."
	$ideapi = Invoke-RestMethod -Uri 'https://api.github.com/repos/idena-network/idena-go/releases/latest'
	$ideacpi = Invoke-RestMethod -Uri 'https://api.github.com/repos/idena-network/idena-desktop/releases/latest'
	$idenapinow = & $env:USERPROFILE\AppData\Roaming\Idena\node\idena-go.exe -v
	$ideacpinow = "$env:USERPROFILE\AppData\Local\Programs\idena-desktop\Idena.exe"
	$idenanoderes = $ideapi.tag_name
	$idenaclientres = $ideacpi.tag_name
	$randomtime = 1 | % {Get-Random -Minimum 550 -Maximum 670 }

	$idenalastnode = $idenanoderes.Trim("v"," ")
	$idenalastclient = $idenaclientres.Trim("v"," ")
	$idenanownode = $idenapinow.replace("idena-go.exe version ","")
	$idenanowclient = get-fileversion $ideacpinow

	if(-NOT ($idenanownode -eq $idenalastnode)){
		echo 'Node update detected to version :'
		$idenalastnode
		echo 'Updating...'
		Stop-Process -Name "Idena"
		cd $env:USERPROFILE\AppData\Roaming\Idena\node
		rm .\idena-go.exe
		Invoke-WebRequest -OutFile idena-go.exe https://github.com/idena-network/idena-go/releases/download/$idenanoderes/idena-node-win-$idenalastnode.exe
		echo 'Running...'
		cd $env:USERPROFILE
		start $env:USERPROFILE\AppData\Local\Programs\idena-desktop\Idena.exe
		echo 'Node updated to version "'
		$idenalastnode
	}elseif(-NOT ($idenanowclient -eq $idenalastclient)){
		echo 'Client update detected to version :'
		$idenalastclient
		echo 'Updating...'
		Stop-Process -Name "Idena"
		cd $env:USERPROFILE\Downloads
		Invoke-WebRequest -OutFile idena-latest-installer.exe https://github.com/idena-network/idena-desktop/releases/download/$idenaclientres/idena-client-win-$idenalastclient.exe
		Start-Process .\idena-latest-installer.exe /S -NoNewWindow -Wait -PassThru
		rm .\idena-latest-installer.exe
		echo 'Running...'
		cd $env:USERPROFILE
		start $env:USERPROFILE\AppData\Local\Programs\idena-desktop\Idena.exe
		echo 'Client updated to version :'
		$idenalastclient
	}else{
		echo 'Everything up to date, rechecking every ± 10 Minutes'
		Start-Sleep -s $randomtime
	} 
}