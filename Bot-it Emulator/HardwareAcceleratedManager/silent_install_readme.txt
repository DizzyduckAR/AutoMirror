overall:
  When this script is executed without Admin permission, a UAC window will pop up to ask for permission escalate.

Install:
	silent_install.bat [-log log_full_path] [-ld log_full_path]
    -log: the full path of the log file. if not specified, use default log path.
          default log path in Windows: ./haxm_silent_run.log. This log only prints the error message or succussful message.          
    -ld: the full path of the log file. 
          This log prints the detail log message. It is used for debug.
	In case of success:
		Windows will print "Intel HAXM installed successfully!"
		Return 0 to caller
	In case of fail:
		Print "Failed to install Intel HAXM. For details, please check the installation log: <log path>"
		Return 1 to caller
    In case of HAXM is already installed:
        HAXM will be upgraded automatically.
    In case the machines needs to reboot after install/update:
        Print "Please reboot your machine!"
        Return 2 to caller.        

Uninstall:
	silent_install.bat -u [-log log_full_path]
      -log: the full path of the log file. if not specified, use default log path.
          default log path in Windows: .\haxm_silent_run.log
	In case of success:
		Windows will print "Intel HAXM uninstalled successfull!".
		Return 0 to caller
	In case of fail:
		Print "Failed to uninstall Intel HAXM! For details, please check the installation log <log path>!"
		Return 1 to caller
	In case of haxm not installed:
		Print "Intel HAXM is not installed!"
		Return 0 to caller

Misc
   
    silent_install.bat -v
		If haxm is installed:
			Print haxm version.
			Return 0 to caller
		If haxm is not installed:
			print nothing
			Return 1 to caller
		
	silent_install.bat -c
		Check VT/NX capability of the platform
		Print following message:
			VT support -- yes|no
			NX support -- yes|no
		Return 0 to caller if both VT/NX are supported
		Return 1 to caller if either VT/NX is not supported.
	
	silent_install.bat -h
		Print usage
		Return 0 to caller
	
	Wrong parameters:
		Print "invalid_param for <intput>"
		Return 1 to caller
	
known issues:
  1. XD/VT check with "-c" option will only show the CPU capability. it cannot tell if XD/VT is disabled by BIOS	
