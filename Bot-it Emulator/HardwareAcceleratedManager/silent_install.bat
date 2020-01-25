:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: Copyright(c) 2013 Intel Corporation.
: All rights reserved.
: Redistribution. Redistribution and use in binary form, without modification,
: are permitted provided that the following conditions are met:
: 1. Redistributions must reproduce the above copyright notice and the
: following disclaimer in the documentation and/or other materials provided
: with the distribution.
: 2. Neither the name of Intel Corporation nor the names of its suppliers may
: be used to endorse or promote products derived from this software without
: specific prior written permission.
: 3. No reverse engineering, de-compilation, or disassembly of this software
: is permitted. Limited patent license. Intel Corporation grants a world-wide,
: royalty-free, non-exclusive license under patents it now or hereafter owns
: or controls to make, have made, use, import, offer to sell and sell
: ("Utilize") this software, but solely to the extent that any such patent
: is necessary to Utilize the software alone. The patent license shall not
: apply to any combinations which include this software. No hardware per se
: is licensed hereunder.
: DISCLAIMER.
: THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
: AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
: IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
: ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
: LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
: CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
: SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
: INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
: CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
: ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
: POSSIBILITY OF SUCH DAMAGE.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


@echo off

set reg_location=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products
set extract_folder=%TEMP%\intel\HAXM\7.3.0\silent
set base_dir=%~dp0
set install_log=haxm_silent_run.log

set mem_type=1
set mem_size=0
set action=install
set installed_haxm_version=na
set installed_product_id=na
set haxm_install=0
set haxm_reg_location=na
set log_parameter=e
set reg_memory_loc=HKLM\Software\HAXM\HAXM

reg query "%reg_location%" > nul 2>&1
if errorlevel 1 goto get_haxm_version

for /f "tokens=*" %%a in ('reg query "%reg_location%" ') do (
  reg query %%a /s /v DisplayName | findstr /c:"Hardware Accelerated Execution Manager" > nul && set haxm_reg_location=%%a && set haxm_install=1
)

:get_haxm_version
if [%haxm_install%]==[1] (
   for /f "skip=1 tokens=3 delims= " %%b in ('reg query "%haxm_reg_location%" /s /v DisplayVersion ' ) do (
      set installed_haxm_version=%%b
      goto find_product_id
   )

:find_product_id
   for /f "skip=1 tokens=4 delims= " %%c in ('reg query "%haxm_reg_location%" /s /v UninstallString ') do (
      set installed_product_id=%%c
      goto exit_product_id
   )
)
:exit_product_id

if [%HAXM_install%]==[1] (
  set installed_product_id=%installed_product_id:~3,36%
)

:parse_input
    if [%1]==[] goto %action%
    if [%1]==[-m] (
        if [%2]==[] goto need_more_param
        set action=install
        set mem_type=2
        set mem_size=%2
        shift
        shift
        goto parse_input)
    if [%1]==[-log] (
        if [%2]==[] goto need_more_param
        set install_log=%2
        shift
        shift
        goto parse_input)
    if [%1]==[-ld] (
        if [%2]==[] goto need_more_param
        set install_log=%2
        set log_parameter=*vx
        shift
        shift
        goto parse_input)
    if [%1]==[-u] (
        set action=uninstall
        shift
        goto parse_input)
    if [%1]==[-c] (
        set action=check
        shift
        goto parse_input)
    if [%1]==[-v] (
        set action=version
        shift
        goto parse_input)
    if [%1]==[-h] (
        set action=help
        shift
        goto parse_input)
    goto invalid_param

:install

    call :check_log
    if errorlevel 1 exit /b 1

    call :clean_extract_folder
    if errorlevel 1 exit /b 1

    if %PROCESSOR_ARCHITECTURE%==AMD64 (
        set msi_name=hax64.msi
    )  else (
        set msi_name=hax.msi
    )

    if exist %TEMP%\silent_reboot_flag del %TEMP%\silent_reboot_flag

    for %%a in ("%install_log%") do (
        set full_name=%%~fa
    )
    set install_log=%full_name%

    intelhaxm-android.exe -f %extract_folder% -a /qn /l%log_parameter% "%install_log%" MEMSIZETYPE=%mem_type% CUSTOMMEMSIZE=%mem_size% NOTCHECKVTENABLE=1

    if errorlevel 1 (
        if not %installed_haxm_version%==na (
            echo Failed to update Intel HAXM. For details, please check the installation log: "%install_log%"
            if %errorlevel%==5 (
              echo Failed to update Intel HAXM, because user selected NO in UAC window. >> "%install_log%"
            )
        ) else (
            echo Failed to install Intel HAXM. For details, please check the installation log: "%install_log%"
            if %errorlevel%==5 (
              echo Failed to install Intel HAXM, because user selected NO in UAC window. >> "%install_log%"
            )
        )
        exit /b 1
    )   else (
        if not %installed_haxm_version%==na (
            echo Intel HAXM updated successfully!
            echo Intel HAXM updated successfully! >> "%install_log%"
        )  else (
            echo Intel HAXM installed successfully!
            echo Intel HAXM installed successfully! >> "%install_log%"
        )
        if exist %TEMP%\silent_reboot_flag  (
                echo Please reboot your machine!
                echo Please reboot your machine!  >> "%install_log%"
                del %TEMP%\silent_reboot_flag
                exit /b 2
        )
        exit /b 0
    )

:uninstall
    if %installed_haxm_version%==na (
        echo Intel HAXM is not installed!
        exit /b 0
    )

    call :check_log
    if errorlevel 1 exit /b 1

    for %%a in ("%install_log%") do (
        set full_name=%%~fa
    )
    set install_log=%full_name%

    intelhaxm-android.exe -a /x  /q /l%log_parameter% "%install_log%"

    if errorlevel 1 (
        echo Failed to uninstall Intel HAXM! For details, please check the installation log "%install_log%"!
        if %errorlevel%==5 (
          echo Failed to uninstall Intel HAXM, because user selected NO in UAC window. >> "%install_log%"
        )
        exit /b 1
    )

    call :clean_extract_folder
    if errorlevel 1 exit /b 1

    echo Intel HAXM uninstalled successfully!
    echo Intel HAXM uninstalled successfully! >> "%install_log%"
    exit /b 0

:check

    if not exist haxm_check.exe (
        echo Failed to find haxm_check.exe
        exit /b 1
    )

    haxm_check.exe
    set ret=%errorlevel%

    exit /b %ret%

:version
    if %installed_haxm_version%==na (
        exit /b 1
    )
    echo %installed_haxm_version%
    exit /b 0

:help
    echo Usage:
    echo silent_install.bat -v: print out Intel HAXM version
    echo silent_install.bat -h: print out help information
    echo silent_install.bat -c: check the platform's VT capability
    echo silent_install.bat -log logfile: install Intel HAXM with log file output
    echo silent_install.bat: install Intel HAXM
    echo silent_install.bat -u: uninstall Intel HAXM
    exit /b 0
:invalid_param
    echo invalid_param for %1
    exit /b 1
:need_more_param
    echo need more param for %1
    exit /b 1

:clean_extract_folder
    if exist %extract_folder% rd /s /q %extract_folder% > nul 2>&1

    if exist %extract_folder% (
        echo Failed to cleanup temporary folder %extract_folder%
        exit /b 1
    )

    if not exist intelhaxm-android.exe (
        echo intelhaxm-android.exe is missing.
        exit /b 1
    )

    goto :eof

:check_log
    if exist "%install_log%" del "%install_log%"
    if exist "%install_log%" (
        echo Cannot write to: "%install_log%"
        echo Is it read-only?
        exit /b 1
    )
    echo HAXM installer log started > "%install_log%"
    if not exist "%install_log%" (
        echo Invalid log path: "%install_log%"
        exit /b 1
    )
    exit /b 0
