param (
    [switch]$noInstall = $false,
    [switch]$forceADBDownload = $false
    )

"
 ______     ______     ______     ______     __  __    
/\  __ \   /\  == \   /\  __ \   /\___  \   /\ \/\ \   
\ \  __ \  \ \  __<   \ \  __ \  \/_/  /__  \ \ \_\ \  
 \ \_\ \_\  \ \_\ \_\  \ \_\ \_\   /\_____\  \ \_____\ 
  \/_/\/_/   \/_/ /_/   \/_/\/_/   \/_____/   \/_____/
                                                       
 
         *                 *                  *              *
               https://discord.gg/CUgnVpk  DISCORD     *             *
     *            *             *                          *
            https://github.com/DizzyduckAR/AutoMirror/
                        *            *                             ___
  *               *                                          |     | |
        *              _________##                 *        / \    | |
                      @\\\\\\\\\##    *     |              |--I|===|-|
  *                  @@@\\\\\\\\##\       \|/|/            |---|   |A|
                    @@ @@\\\\\\\\\\\    \|\\|//|/     *   /     \  |D|
             *     @@@@@@@\\\\\\\\\\\    \|\|/|/         | blame | |B|aby
                  @@@@@@@@@----------|    \\|//          |  it   |=| |
       __         @@ @@@ @@__________|     \|/           |  on   | | |
  ____|_@|_       @@@@@@@@@__________|     \|/           |__my___| |_|
=|__ _____ |=     @@@@ .@@@__________|      |             |@| |@|  | |
____0_____0__\|/__@@@@__@@@__________|_\|/__|___\|/__\|/___________|_|_

"



function Get-Platform-Tools {
    Invoke-WebRequest https://github.com/Genymobile/scrcpy/releases/download/v1.10/scrcpy-win32-v1.10.zip -OutFile "Files\scrcpy32.zip" | out-null
    Expand-Archive Files\scrcpy32.zip -DestinationPath Files\scrcpy32
    Remove-Item –path Files/scrcpy32.zip
}



function Detect-ADB-Location {
    $adbloc = 'adb.exe'
    if ((Get-Command "adb.exe" -ErrorAction SilentlyContinue) -eq $null)
    {
        $adbloc = 'Files/scrcpy32/adb.exe'
        if( -not (Test-Path 'Files/scrcpy32/adb.exe') )
        {
            "No ADB installation detected, downloading"
            Get-Platform-Tools
        } 
        
    }
    $adbloc
}



function Install {

	$adblocation
	if($forceADBDownload)
	{
		"Forcing ADB download"
		Get-Platform-Tools
		$adblocation = 'Files/scrcpy32/adb.exe'
	}else
	{
		"Detecting ADB"
		$adblocation = Detect-ADB-Location
	}

timeout 3

	if(-not $noInstall)
	{
$sn = Files/scrcpy32/adb.exe -d get-serialno
echo $sn
$adblocation = Detect-ADB-Location

		"Waiting for Phone"
        & $adblocation kill-server
		& $adblocation wait-for-device
        & timeout 3
        & $adblocation -s $sn tcpip 5555
        & timeout 3
		& start-process Files/ip.bat
		& Exit-PSSession

	} else 
	{
		"No Installation..."
		"ADBlocation is $adblocation" 
	}
}

Install
Exit-PSSession