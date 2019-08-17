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
    Invoke-WebRequest https://github.com/Genymobile/scrcpy/releases/download/v1.10/scrcpy-win32-v1.10.zip -OutFile ".\scrcpy.zip" | out-null
    Expand-Archive .\scrcpy.zip -DestinationPath .\scrcpy
}



function Detect-ADB-Location {
    $adbloc = 'adb.exe'
    if ((Get-Command "adb.exe" -ErrorAction SilentlyContinue) -eq $null)
    {
        $adbloc = './scrcpy/adb.exe'
        if( -not (Test-Path './scrcpy/adb.exe') )
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
		$adblocation = './scrcpy/adb.exe'
	}else
	{
		"Detecting ADB"
		$adblocation = Detect-ADB-Location
	}

timeout 3

	if(-not $noInstall)
	{
$sn = ./scrcpy/adb.exe -d get-serialno
echo $sn
$adblocation = Detect-ADB-Location

		"Waiting for Phone"
        & $adblocation kill-server
		& $adblocation wait-for-device
        & timeout 3
        & $adblocation -s $sn tcpip 5555
        & timeout 3
		& start-process ip.bat
		& Exit-PSSession

	} else 
	{
		"No Installation..."
		"ADBlocation is $adblocation" 
	}
}

Install
Exit-PSSession