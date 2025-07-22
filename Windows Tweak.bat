@echo off
setlocal enabledelayedexpansion
title Tweak - Windows Optimization Tool
color 06

:: ======================
:: MAIN MENU
:: ======================
:MENU
cls
echo.
echo.
echo                   ===================================[ MENU ]===================================
echo.
echo                      [1] Performance                                         [2] Privacy/Security
echo.   
echo                      [3] Network                                             [4] Programs 
echo.
echo                      [5] Customization                                       [6] System
echo.
echo                      [7] Tools                                               [0] Exit   
echo.     
echo                   ==============================================================================                   
echo.
set /p choice="Select an option: "

:: Process selection
if "%choice%"=="1" goto PERFORMANCE_MENU
if "%choice%"=="2" goto PRIVACY_SECURITY_MENU
if "%choice%"=="3" goto NETWORK_MENU
if "%choice%"=="4" goto PROGRAMS_MENU
if "%choice%"=="5" goto CUSTOMIZATION_MENU
if "%choice%"=="6" goto SYSTEM_MENU
if "%choice%"=="7" goto TOOLS_MENU
if "%choice%"=="0" goto EXIT_SCRIPT

:: Invalid selection handler
echo.
echo Invalid selection. Please choose a number between (0-7)
pause
goto MENU


:: ======================
:: PERFORMANCE MENU
:: ======================
:PERFORMANCE_MENU
cls
echo.
echo.
echo                   ===================================[ PERFORMANCE ]===================================
echo.
echo                     [1] Services                                                [4] Speed up boot
echo.
echo                     [2] Scheduler task                                          [5] Visual effects
echo.
echo                     [3] Clean up                                                [6] Power plan
echo.
echo                                                          [0] Back 
echo.
echo                   =====================================================================================
echo.
set /p per_choice="Select an option: "

:: Process selection
if "%per_choice%"=="1" goto SERVICES_TWEAKS_MENU
if "%per_choice%"=="2" goto SCHEDULER_TASKS
if "%per_choice%"=="3" goto CLEAN_UP
if "%per_choice%"=="4" goto SPEED_UP_BOOT
if "%per_choice%"=="5" goto VISUAL_EFFECTS
if "%per_choice%"=="6" goto POWER_PLAN
if "%per_choice%"=="0" goto MENU

:: Invalid input handler
echo.
echo Invalid selection. Please choose a number between (0-6)
pause
goto PERFORMANCE_MENU

:: ======================
:: SERVICES CONFIGURATION
:: ======================
:SERVICES_TWEAKS_MENU
cls
echo.
echo.
echo                   ===================================[ SERVICES ]===================================
echo.
echo                    [1] Service Tweaks                                       [2] Default Service
echo.
echo                                                        [0] Back 
echo.
echo                   ==================================================================================
echo.
set /p svc_choice="Select an option: "

:: Process selection
if "%svc_choice%"=="1" goto APPLY_SERVICE_TWEAKS
if "%svc_choice%"=="2" goto RESTORE_SERVICES
if "%svc_choice%"=="0" goto PERFORMANCE_MENU

:: Invalid input handler
echo.
echo Invalid selection. Please choose a number between (0-2)
pause
goto SERVICES_TWEAKS_MENU

::========================================================
:: APPLY SERVICE TWEAKS
:: Configures Windows services for manual/disabled startup
:: =======================================================
:APPLY_SERVICE_TWEAKS
cls
echo Applying Services Tweaks...
echo.

:: Define service configuration lists
set "ManualServices=AppReadiness AppVClient Appinfo AssignedAccessManagerSvc AxInstSV BDESVC BITS BcastDVRUserService BluetoothUserService Browser BthAvctpSvc BthHFSrv CDPUserSvc COMSysApp CaptureService CertPropSvc ConsentUxUserSvc CryptSvc DPS DcpSvc DevQueryBroker DeviceAssociationService DeviceInstall DevicePickerUserSvc DevicesFlowUserSvc DialogBlockingService DispBrokerDesktopSvc DmEnrollmentSvc DsSvc DsmSvc EapHost EventLog EventSystem FontCache FrameServer FrameServerMonitor GraphicsPerfSvc HvHost IEEtwCollectorService IKEEXT InventorySvc IpxlatCfgSvc KeyIso KtmRm LanmanWorkstation LicenseManager LxpSvc MSDTC MSiSCSI MsKeyboardFilter NPSMSvc NcaSvc NcbService NcdAutoSetup NetSetupSvc NetTcpPortSharing Netlogon Netman NlaSvc P9RdrService PNRPAutoReg PNRPsvc PenService PerfHost PimIndexMaintenanceSvc PolicyAgent Power ProfSvc PushToInstall RasAuto RasMan RemoteAccess SDRSVC SENS SNMPTRAP SamSs SecurityHealthService Sense SgrmBroker SharedAccess SharedRealitySvc ShellHWDetection SstpSvc StiSvc TermService TextInputManagementService Themes TimeBroker TroubleshootingSvc TrustedInstaller UI0Detect UserManager UsoSvc VSS VacSvc autotimesvc cloudidsvc dcsvc defragsvc diagnosticshub.standardcollector.service dot3svc hidserv icssvc iphlpsvc lltdsvc netprofm nsi p2pimsvc p2psvc perceptionsimulation seclogon smphost spectrum ssh-agent svsvc swprv tiledatamodelsvc uhssvc upnphost vds vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss webthreatdefsvc webthreatdefusersvc wercplsupport wlpasvc wmiApSrv workfolderssvc wscsvc wuauserv wudfsvc"
set "DisabledServices=AJRouter camsvc lmhosts ALG AppMgmt wisvc SSDPSRV wlidsvc BTAGService InstallService TokenBroker bthserv cbdhsvc CDPSvc LanmanServer CscService diagsvc DiagTrack dmwappushservice MapsBroker DusmSvc EFS Fax fdPHost FDResPub fhsvc HomeGroupListener HomeGroupProvider lfsvc NaturalAuthentication PcaSvc PeerDistSvc PhoneSvc pla PrintNotify QWAVE RemoteRegistry RmSvc RpcLocator ScDeviceEnum DisplayEnhancementService SCPolicySvc SEMgrSvc SensorDataService SensorService SensrSvc SessionEnv shpamsvc SCardSvr SmsRouter Spooler SysMain TabletInputService TapiSrv TieringEngineService TrkWks tzautoupdate UmRdpService UevAgentService VaultSvc W32Time WalletService wbengine WbioSrvc WebClient Wecsvc WEPHOSTSVC WerSvc WFDSConMgrSvc wcncsvc WdiServiceHost WdiSystemHost WMPNetworkSvc WPDBusEnum WSearch WwanSvc XblAuthManager XboxNetApiSvc XblGameSave XboxGipSvc XboxNetApiSvc"
set "AllServices=%ManualServices% %DisabledServices%"

:: Initialize counters
set "initial_auto=0"
set "initial_manual=0"
set "initial_disabled=0"
set "success_manual=0"
set "success_disabled=0"
set "failed_manual=0"
set "failed_disabled=0"
set "not_found_manual=0"
set "not_found_disabled=0"

:: Create log directory and file
set "LogDir=%USERPROFILE%\AppData\Local\Temp\By Windows Optimization Script"
if not exist "%LogDir%" mkdir "%LogDir%"
set "LogFile=%LogDir%\Final Service Report - %date:~-4%-%date:~4,2%-%date:~7,2% %time:~0,2%.%time:~3,2%.log"

:: Initialize log file
(
    echo Windows Services Configuration Log
    echo Date/Time: %date% %time%
    echo.
) > "%LogFile%"

:: ======================
:: PRE-CONFIGURATION AUDIT
:: ======================
for %%S in (%AllServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do (
            if "%%T"=="2" set /a initial_auto+=1
            if "%%T"=="3" set /a initial_manual+=1
            if "%%T"=="4" set /a initial_disabled+=1
        )
    )
)

:: ======================
:: MANUAL SERVICE CONFIGURATION
:: ======================
echo Configuring services for manual startup...
(
    echo    ===============================
    echo    MANUAL SERVICES CONFIGURATION:
    echo    ===============================
) >> "%LogFile%"

for %%S in (%ManualServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        sc config "%%S" start= demand >nul 2>&1 && (
            set /a success_manual+=1
            echo SUCCESS: %%S configured to manual startup
        ) || (
            set /a failed_manual+=1
            echo FAILED: %%S - Could not configure to manual startup
        )
    ) || (
        set /a not_found_manual+=1
        echo NOT FOUND: %%S - Service does not exist
    )
) >> "%LogFile%"

:: ======================
:: DISABLE SERVICES
:: ======================
echo.
echo Disabling unnecessary services...
(
    echo.
    echo    =================================
    echo    DISABLED SERVICES CONFIGURATION:
    echo    =================================
) >> "%LogFile%"

for %%S in (%DisabledServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        sc config "%%S" start= disabled >nul 2>&1 && (
            set /a success_disabled+=1
            echo SUCCESS: %%S disabled
        ) || (
            set /a failed_disabled+=1
            echo FAILED: %%S - Could not disable service
        )
    ) || (
        set /a not_found_disabled+=1
        echo NOT FOUND: %%S - Service does not exist
    )
) >> "%LogFile%"

:: ======================
:: POST-CONFIGURATION AUDIT
:: ======================
set "final_auto=0"
set "final_manual=0"
set "final_disabled=0"

for %%S in (%AllServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do (
            if "%%T"=="2" set /a final_auto+=1
            if "%%T"=="3" set /a final_manual+=1
            if "%%T"=="4" set /a final_disabled+=1
        )
    )
)

:: ======================
:: RESULTS SUMMARY
:: ======================
set /a total_success = success_manual + success_disabled
set /a total_failed = failed_manual + failed_disabled
set /a total_not_found = not_found_manual + not_found_disabled

:: لطباعة على الشاشة
call :DisplayReport

echo.
echo Log file saved to: %LogFile%

:: لطباعة إلى الملف
call :DisplayReport >> "%LogFile%"


pause
goto SERVICES_TWEAKS_MENU
:DisplayReport
echo.
echo ==================================================
echo            SERVICE CONFIGURATION REPORT
echo ==================================================
echo  Service Type       Before            After    
echo --------------------------------------------------
echo Automatic:         %initial_auto%        %final_auto%         
echo Manual   :         %initial_manual%       %final_manual%       
echo Disabled :         %initial_disabled%        %final_disabled%   
echo ==================================================     
echo.
echo.
echo ==================================================     
echo Configured:   %total_success%
echo Failed    :   %total_failed%
echo Not Found :   %total_not_found%
echo ==================================================     
echo.
goto :eof




:: ======================
:: RESTORE DEFAULT SERVICES
:: ======================
:RESTORE_SERVICES
cls
echo Restoring Default Service Settings...
echo.

:: Initialize logging
set "log_dir=%USERPROFILE%\AppData\Local\Temp\By Windows Optimization Script"
if not exist "%log_dir%" mkdir "%log_dir%" >nul 2>&1
set "log_file=%log_dir%\ServiceRestore_%date:~-4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.log"

:: Create log header
(
    echo ===== SERVICE RESTORE LOG =====
    echo Start Time: %date% %time%
    echo.
) > "%log_file%"

:: Service configuration lists
set "auto_services=AppHostSvc AudioEndpointBuilder Audiosrv BFE BITS BrokerInfrastructure CoreMessagingRegistrar CryptSvc DcomLaunch Dhcp DiagTrack Dnscache DoSvc DPS EventLog EventSystem FontCache ftpsvc gpsvc HomeGroupListener HomeGroupProvider HvHost iphlpsvc iprip LanmanServer LanmanWorkstation LPDSVC LSM MapsBroker MpsSvc MSMQ MSMQTriggers Netlogon NetMsmqActivator NetPipeActivator NetTcpActivator NlaSvc nsi PcaSvc Power ProfSvc RpcEptMapper RpcSs SamSs Schedule SENS ShellHWDetection simptcp SNMP Spooler sppsvc SysMain SystemEventsBroker TabletInputService TermService Themes tiledatamodelsvc TrkWks UserManager vmms W32Time W3SVC Wcmsvc WinDefend Winmgmt WlanSvc WMPNetworkSvc Wms WmsRepair wscsvc WSearch WwanSvc"
set "manual_services=AJRouter ALG AppIDSvc Appinfo AppMgmt AppReadiness AppXSvc aspnet_state AxInstSV BDESVC Browser BthHFSrv bthserv c2wts CDPSvc CertPropSvc ClipSVC COMSysApp CscService DcpSvc defragsvc DeviceInstall DevQueryBroker diagnosticshub.standardcollector.service dot3svc DsmSvc DsRoleSvc DsSvc Eaphost EFS embeddedmode EntAppSvc Fax fdPHost FDResPub fhsvc FontCache3.0.0.0 hidserv icssvc IEEtwCollectorService IKEEXT KeyIso KtmRm lfsvc LicenseManager lltdsvc lmhosts MSDTC MSiSCSI msiserver NcaSvc NcbService NcdAutoSetup Netman netprofm NetSetupSvc NetTcpPortSharing NgcCtnrSvc NgcSvc p2pimsvc p2psvc PeerDistSvc PerfHost pla PlugPlay PNRPAutoReg PNRPsvc PolicyAgent PrintNotify QWAVE RasAuto RasMan RetailDemo RpcLocator SCPolicySvc SDRSVC seclogon SensorDataService SensorService SensrSvc SessionEnv SharedAccess smphost SmsRouter SNMPTRAP sppsvc SSDPSRV SstpSvc StateRepository stisvc StorSvc svsvc swprv TapiSrv TimeBroker TrustedInstaller UI0Detect UmRdpService upnphost UsoSvc VaultSvc vds vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss VSS w3logsvc WalletService WAS wbengine WbioSrv wcncsvc WcsPlugInService WdiServiceHost WdiSystemHost WdNisSvc WebClient Wecsvc WEPHOSTSVC wercplsupport WerSvc WiaRpc WinRM wlidsvc wmiApSrv WMSVC workfolderssvc WPDBusEnum WpnService WSService wuauserv wudfsvc XblAuthManager XblGameSave XboxNetApiSvc"
set "disabled_services=RemoteAccess RemoteRegistry SCardSvr"

:: Initialize counters
set /a total_success=0
set /a total_failed=0
set /a total_not_found=0

:: ======================
:: CONFIGURE AUTOMATIC SERVICES
:: ======================
echo Configuring automatic services...
for %%s in (%auto_services%) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc config "%%s" start= auto >nul 2>&1
        if !errorlevel! equ 0 (
            set /a total_success+=1
            echo [%time%] SUCCESS: Configured "%%s" (Auto)
        ) else (
            set /a total_failed+=1
            echo [%time%] FAILED: Configuring "%%s" (Auto)
        )
    ) else (
        set /a total_not_found+=1
        echo [%time%] NOT FOUND: "%%s"
    )
) >> "%log_file%"

:: ======================
:: CONFIGURE MANUAL SERVICES
:: ======================
echo Configuring manual services...
for %%s in (%manual_services%) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc config "%%s" start= demand >nul 2>&1
        if !errorlevel! equ 0 (
            set /a total_success+=1
            echo [%time%] SUCCESS: Configured "%%s" (Manual)
        ) else (
            set /a total_failed+=1
            echo [%time%] FAILED: Configuring "%%s" (Manual)
        )
    ) else (
        set /a total_not_found+=1
        echo [%time%] NOT FOUND: "%%s"
    )
) >> "%log_file%"

:: ======================
:: DISABLE SERVICES
:: ======================
echo Disabling services...
for %%s in (%disabled_services%) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc stop "%%s" >nul 2>&1
        timeout /t 2 >nul
        sc config "%%s" start= disabled >nul 2>&1
        if !errorlevel! equ 0 (
            set /a total_success+=1
            echo [%time%] SUCCESS: Configured "%%s" (Disabled)
        ) else (
            set /a total_failed+=1
            echo [%time%] FAILED: Configuring "%%s" (Disabled)
        )
    ) else (
        set /a total_not_found+=1
        echo [%time%] NOT FOUND: "%%s"
    )
) >> "%log_file%"

:: ======================
:: FINAL REPORT
:: ======================
(
    echo.
    echo ===== SUMMARY =====
    echo Success: %total_success%
    echo Failed: %total_failed%
    echo Not Found: %total_not_found%
    echo.
    echo ===== END OF LOG =====
) >> "%log_file%"

:: Display results
cls
echo.
echo ========================================================
echo             SERVICE CONFIGURATION REPORT
echo ========================================================
echo Configured: %total_success%
echo Failed    : %total_failed%
echo Not Found : %total_not_found%
echo.
echo Log saved to: %log_file%
echo ========================================================
echo.
pause
goto PERFORMANCE_MENU


:: ======================
:: SCHEDULED TASK OPTIMIZATION
:: ======================


:SCHEDULER_TASKS
cls
echo.
echo  Scheduled Tasks Tweaks...
echo.

:: Initialize logging
set "log_dir=%USERPROFILE%\AppData\Local\Temp\By Windows Optimization Script"
if not exist "%log_dir%" mkdir "%log_dir%"
set "log_file=%log_dir%\TaskOptimization_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.log"

:: Create log header
(
    echo ===== SCHEDULED TASK OPTIMIZATION LOG =====
    echo Start Time: %date% %time%
    echo.
) > "%log_file%"

:: Initialize counters
set /a total_tasks=0
set /a disabled_success=0
set /a disabled_failed=0
set /a not_found=0

:: Task list to disable
set "tasks="
set "tasks=%tasks% "Microsoft\Windows\AppCompat\PT""
set "tasks=%tasks% "Microsoft\Windows\Application Experience\AitAgent""
set "tasks=%tasks% "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser""
set "tasks=%tasks% "Microsoft\Windows\Application Experience\PcaPatchDbTask""
set "tasks=%tasks% "Microsoft\Windows\Application Experience\ProgramDataUpdater""
set "tasks=%tasks% "Microsoft\Windows\Application Experience\StartupAppTask""
set "tasks=%tasks% "Microsoft\Windows\Autochk\Proxy""
set "tasks=%tasks% "Microsoft\Windows\Camera\CameraAcquireSensorData""
set "tasks=%tasks% "Microsoft\Windows\Camera\CameraBackgroundTask""
set "tasks=%tasks% "Microsoft\Windows\Camera\CameraFirstSensor""
set "tasks=%tasks% "Microsoft\Windows\CloudExperienceHost\CreateObjectTask""
set "tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\BthSQM""
set "tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\Consolidator""
set "tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask""
set "tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask""
set "tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\Uploader""
set "tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip""
set "tasks=%tasks% "Microsoft\Windows\DUSM\dusmtask""
set "tasks=%tasks% "Microsoft\Windows\Device Information\Device User""
set "tasks=%tasks% "Microsoft\Windows\Device Information\Device""
set "tasks=%tasks% "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner""
set "tasks=%tasks% "Microsoft\Windows\Diagnosis\Scheduled""
set "tasks=%tasks% "Microsoft\Windows\DiskCleanup\SilentCleanup""
set "tasks=%tasks% "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector""
set "tasks=%tasks% "Microsoft\Windows\DiskFootprint\Diagnostics""
set "tasks=%tasks% "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask""
set "tasks=%tasks% "Microsoft\Windows\EnterpriseMgmt\Schedule""
set "tasks=%tasks% "Microsoft\Windows\EnterpriseMgmt\SyncML""
set "tasks=%tasks% "Microsoft\Windows\Feedback\Siuf\DmClient""
set "tasks=%tasks% "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload""
set "tasks=%tasks% "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures""
set "tasks=%tasks% "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing""
set "tasks=%tasks% "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting""
set "tasks=%tasks% "Microsoft\Windows\Flighting\OneSettings\RefreshCache""
set "tasks=%tasks% "Microsoft\Windows\Input\InputSettingsRestoreDataAvailable""
set "tasks=%tasks% "Microsoft\Windows\Input\LocalUserSyncDataAvailable""
set "tasks=%tasks% "Microsoft\Windows\Input\MouseSyncDataAvailable""
set "tasks=%tasks% "Microsoft\Windows\Input\PenSyncDataAvailable""
set "tasks=%tasks% "Microsoft\Windows\Input\TouchpadSyncDataAvailable""
set "tasks=%tasks% "Microsoft\Windows\Input\syncpensettings""
set "tasks=%tasks% "Microsoft\Windows\International\Synchronize Language Settings""
set "tasks=%tasks% "Microsoft\Windows\LanguageComponentsInstaller\Installation""
set "tasks=%tasks% "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources""
set "tasks=%tasks% "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation""
set "tasks=%tasks% "Microsoft\Windows\Location\LocationNotification""
set "tasks=%tasks% "Microsoft\Windows\Location\Notifications""
set "tasks=%tasks% "Microsoft\Windows\Location\SensorOverAcl""
set "tasks=%tasks% "Microsoft\Windows\Location\WindowsActionDialog""
set "tasks=%tasks% "Microsoft\Windows\MUI\LPRemove""
set "tasks=%tasks% "Microsoft\Windows\Management\Provisioning\Cellular""
set "tasks=%tasks% "Microsoft\Windows\Management\Provisioning\Logon""
set "tasks=%tasks% "Microsoft\Windows\Maps\MapsToastTask""
set "tasks=%tasks% "Microsoft\Windows\Maps\MapsUpdateTask""
set "tasks=%tasks% "Microsoft\Windows\NetTrace\GatherNetworkInfo""
set "tasks=%tasks% "Microsoft\Windows\NlaSvc\WiFiTask""
set "tasks=%tasks% "Microsoft\Windows\OOBE\BackgroundUserTask""
set "tasks=%tasks% "Microsoft\Windows\PI\Sqm-Tasks""
set "tasks=%tasks% "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem""
set "tasks=%tasks% "Microsoft\Windows\Power Efficiency Diagnostics\EnergyEstimation""
set "tasks=%tasks% "Microsoft\Windows\PushToInstall\LoginCheck""
set "tasks=%tasks% "Microsoft\Windows\PushToInstall\Registration""
set "tasks=%tasks% "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE""
set "tasks=%tasks% "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask""
set "tasks=%tasks% "Microsoft\Windows\Sensor\SensorDataServiceStartupTask""
set "tasks=%tasks% "Microsoft\Windows\Sensor\SensorServiceStartupTask""
set "tasks=%tasks% "Microsoft\Windows\Servicing\StartComponentCleanup""
set "tasks=%tasks% "Microsoft\Windows\SettingSync\NetworkStateChangeTask""
set "tasks=%tasks% "Microsoft\Windows\Setup\SetupCleanupTask""
set "tasks=%tasks% "Microsoft\Windows\Setup\SnapshotCleanupTask""
set "tasks=%tasks% "Microsoft\Windows\Sysmain\ResPriStaticDbSync""
set "tasks=%tasks% "Microsoft\Windows\Sysmain\WsSwapAssessmentTask""
set "tasks=%tasks% "Microsoft\Windows\TPM\Tpm-HASCertRetr""
set "tasks=%tasks% "Microsoft\Windows\TPM\Tpm-Maintenance""
set "tasks=%tasks% "Microsoft\Windows\Task Manager\Interactive""
set "tasks=%tasks% "Microsoft\Windows\UPnP\UPnPHostConfig""
set "tasks=%tasks% "Microsoft\Windows\User Profile Service\HiveUploadTask""
set "tasks=%tasks% "Microsoft\Windows\WCM\WiFiTask""
set "tasks=%tasks% "Microsoft\Windows\WDI\ResolutionHost""
set "tasks=%tasks% "Microsoft\Windows\WLANReport\WLANReportTask""
set "tasks=%tasks% "Microsoft\Windows\WOF\WIM-Hash-Management""
set "tasks=%tasks% "Microsoft\Windows\WOF\WIM-Hash-Validation""
set "tasks=%tasks% "Microsoft\Windows\Windows Error Reporting\QueueReporting""
set "tasks=%tasks% "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization""
set "tasks=%tasks% "Microsoft\Windows\Work Folders\Work Folders Maintenance Work""
set "tasks=%tasks% "Microsoft\Windows\Workplace Join\Automatic-Device-Join""
set "tasks=%tasks% "Microsoft\Windows\WwanSvc\NotificationTask""
set "tasks=%tasks% "Microsoft\Windows\WwanSvc\OobeDiscovery""
set "tasks=%tasks% "Microsoft\XblGameSave\XblGameSaveTask""
set "tasks=%tasks% "Microsoft\XblGameSave\XblGameSaveTaskLogon""

:: ======================
:: PROCESS TASKS
:: ======================
echo Processing %tasks: =" and "% tasks...
for %%T in (%tasks%) do (
    set /a total_tasks+=1
    (
        echo Processing: %%T
        schtasks /query /TN %%T >nul 2>&1
        if !errorlevel! equ 0 (
            schtasks /change /tn %%T /disable >nul 2>&1
            if !errorlevel! equ 0 (
                set /a disabled_success+=1
                echo   SUCCESS: Task disabled
            ) else (
                set /a disabled_failed+=1
                echo   ERROR: Failed to disable task
            )
        ) else (
            set /a not_found+=1
            echo   WARNING: Task not found
        )
    ) >> "%log_file%"
)

:: ======================
:: FINAL REPORT
:: ======================
(
    echo.
    echo ===== SUMMARY =====
    echo Total Tasks : %total_tasks%
    echo Disabled    : %disabled_success%
    echo Failed      : %disabled_failed%
    echo Not Found   : %not_found%
    echo.
    echo Log saved to: "%log_file%"
    echo ===== END OF LOG =====
) >> "%log_file%"

:: Display results
cls
echo.
echo ========================================================
echo               TASK OPTIMIZATION REPORT
echo ========================================================
echo Total Tasks : %total_tasks%
echo Disabled    : %disabled_success%
echo Failed      : %disabled_failed%
echo Not Found   : %not_found%
echo.
echo Log saved to: "%log_file%"
echo ========================================================
echo.
pause
goto PERFORMANCE_MENU



:CLEAN_UP
cls
echo.
echo Cleaning temporary files              
echo.

if exist "%TEMP%" (
    echo Cleaning User Temp Files...
    del /q /f /s "%TEMP%\*.*" >nul 2>&1
    for /d %%d in ("%TEMP%\*") do rd /s /q "%%d" >nul 2>&1
)

if exist "%WINDIR%\Temp" (
    echo Cleaning System Temp Files...
    del /q /f /s "%WINDIR%\Temp\*.*" >nul 2>&1
    for /d %%d in ("%WINDIR%\Temp\*") do rd /s /q "%%d" >nul 2>&1
)

if exist "%WINDIR%\Prefetch" (
    echo Cleaning Prefetch files...
    del /q /f "%WINDIR%\Prefetch\*.pf" >nul 2>&1
)

if exist "%WINDIR%\Logs\CBS" (
    echo Cleaning CBS Logs...
    del /q /f /s "%WINDIR%\Logs\CBS\*.*" >nul 2>&1
    for /d %%d in ("%WINDIR%\Logs\CBS\*") do rd /s /q "%%d" >nul 2>&1
)

if exist "%WINDIR%\Panther" (
    echo Cleaning Panther Logs...
    del /q /f /s "%WINDIR%\Panther\*.*" >nul 2>&1
    for /d %%d in ("%WINDIR%\Panther\*") do rd /s /q "%%d" >nul 2>&1
)

if exist "%WINDIR%\Installer" (
    echo Cleaning Windows Installer temp files...
    del /q /f /s "%WINDIR%\Installer\*.tmp" >nul 2>&1
)

if exist "%SystemRoot%\Minidump" (
    echo Cleaning crash dumps...
    rd /s /q "%SystemRoot%\Minidump" >nul 2>&1
)

if exist "%SystemRoot%\System32\SleepStudy" (
    echo Cleaning SleepStudy data...
    rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
)

if exist "%APPDATA%\Microsoft\Windows\Recent" (
    echo Cleaning Recent Files...
    del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
    for /d %%d in ("%APPDATA%\Microsoft\Windows\Recent\*") do rd /s /q "%%d" >nul 2>&1
)

echo.
echo Cleaning system cache...

if exist "%WINDIR%\SoftwareDistribution\Download" (
    echo Cleaning Windows Update cache...
    rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
)

for %%X in ($GetCurrent $SysReset $Windows.~BT $Windows.~WS $WinREAgent) do (
    if exist "%SystemDrive%\%%X" (
        echo Removing Windows installation folder: %%X...
        rd /s /q "%SystemDrive%\%%X" >nul 2>&1
    )
)

if exist "%SystemDrive%\Windows.old" (
    echo Removing Windows.old folder...
    takeown /f "%SystemDrive%\Windows.old" /r /d y >nul 2>&1
    icacls "%SystemDrive%\Windows.old" /grant administrators:F /t >nul 2>&1
    rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
)

echo.
echo Cleaning browser cache

if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
    echo Cleaning Chrome Cache...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache2" (
    echo Cleaning Chrome Cache2...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache2" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Media Cache" (
    echo Cleaning Chrome Media Cache...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Media Cache" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" (
    echo Cleaning Chrome Crash Reports...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Google\CrashReports" (
    echo Cleaning Google Crash Reports...
    rd /s /q "%LOCALAPPDATA%\Google\CrashReports" >nul 2>&1
)

if exist "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache" (
    echo Cleaning Brave Cache...
    rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache" >nul 2>&1
)

if exist "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache2" (
    echo Cleaning Brave Cache2...
    rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache2" >nul 2>&1
)

echo.
echo Cleaning system log...
echo.

if exist "%LOCALAPPDATA%\Microsoft\Windows\WER" (
    echo Cleaning Windows Error Reports...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER" >nul 2>&1
)

if exist "%PROGRAMDATA%\Microsoft\Windows\WER" (
    echo Cleaning System Error Reports...
    rd /s /q "%PROGRAMDATA%\Microsoft\Windows\WER" >nul 2>&1
)

if exist "%SystemRoot%\Performance\WinSAT" (
    echo Cleaning WinSAT Logs...
    rd /s /q "%SystemRoot%\Performance\WinSAT" >nul 2>&1
)

echo Clearing Windows Event Logs...
for /f "tokens=*" %%G in ('wevtutil el') do (
    wevtutil cl "%%G" >nul 2>&1
)

echo.
echo Advanced cleanup... 

if exist "%LOCALAPPDATA%\Microsoft\Windows\INetCache" (
    echo Cleaning Internet Cache...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\INetCache" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Microsoft\Windows\INetCookies" (
    echo Cleaning Internet Cookies...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\INetCookies" >nul 2>&1
)

if exist "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History" (
    echo Cleaning Windows Defender logs...
    forfiles /p "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History" /s /c "cmd /c if @isdir==TRUE rd /s /q @path" >nul 2>&1
)

if exist "%PROGRAMDATA%\Microsoft\Windows Defender\Quarantine" (
    echo Cleaning old Defender quarantine files...
    forfiles /p "%PROGRAMDATA%\Microsoft\Windows Defender\Quarantine" /m *.* /d -30 /c "cmd /c del /q @path" >nul 2>&1
)

if exist "%WINDIR%\SoftwareDistribution\DataStore" (
    echo Cleaning Windows Update data...
    del /q /f /s "%WINDIR%\SoftwareDistribution\DataStore\*.*" >nul 2>&1
)

if exist "%WINDIR%\WindowsUpdate.log" (
    echo Removing WindowsUpdate.log...
    del /q /f "%WINDIR%\WindowsUpdate.log" >nul 2>&1
)

if exist "%WINDIR%\Prefetch" (
    echo Cleaning old Prefetch files...
    forfiles /p "%WINDIR%\Prefetch" /m *.pf /d -30 /c "cmd /c del /q @path" >nul 2>&1
)

if exist "%SystemRoot%\System32\ReadyBoost" (
    echo Cleaning ReadyBoost Cache...
    rd /s /q "%SystemRoot%\System32\ReadyBoost" >nul 2>&1
)

if exist "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache" (
    echo Cleaning Services Cache...
    rd /s /q "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache" >nul 2>&1
)

if exist "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows" (
    echo Cleaning indexing temp files...
    del /q /f /s "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\*.log" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache" (
    echo Cleaning Windows Store cache...
    del /q /f /s "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*.*" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\TempState" (
    echo Cleaning Windows Store temp files...
    del /q /f /s "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\TempState\*.*" >nul 2>&1
)

for /d %%d in ("%LOCALAPPDATA%\Packages\*") do (
    if exist "%%d\LocalCache" (
        del /q /f /s "%%d\LocalCache\*.*" >nul 2>&1
    )
    if exist "%%d\TempState" (
        del /q /f /s "%%d\TempState\*.*" >nul 2>&1
    )
)

if exist "%LOCALAPPDATA%\Microsoft\Windows\Explorer" (
    echo Cleaning thumbnail cache...
    del /q /f "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1
)

if exist "%WINDIR%\System32\FNTCACHE.DAT" (
    echo Cleaning font cache...
    del /q /f "%WINDIR%\System32\FNTCACHE.DAT" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Microsoft\Media Player" (
    echo Cleaning Media Player Cache...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Media Player" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Microsoft\Office" (
    echo Cleaning Office cache...
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Office\*.tmp" >nul 2>&1
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Office\*Cache*" >nul 2>&1
)
:: .NET Framework
if exist "%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files\" (
    rd /s /q "%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files" 2>nul
)

:: SQL Server
if exist "%ProgramData%\Microsoft\Microsoft SQL Server Local DB\" (
    rd /s /q "%ProgramData%\Microsoft\Microsoft SQL Server Local DB" 2>nul
)
:: سجلات DNS
ipconfig /flushdns >nul

:: سجلات البرامج المثبتة
if exist "%SystemRoot%\AppCompat\Programs\" (
    del /f /q "%SystemRoot%\AppCompat\Programs\*.sdb" 2>nul
)
echo.
echo Final cleanup...
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force -Confirm:$false" >nul 2>&1

:PROMPT_CLEANUP
choice /C YN /N /M "Run Disk Cleanup? (Y/N): "
if %errorlevel% equ 1 (
    echo Running Disk Cleanup...
    cleanmgr /sagerun:1
)
if %errorlevel% equ 2 goto PERFORMANCE_MENU

pause
goto PERFORMANCE_MENU


:SPEED_UP_BOOT
cls

:: Set boot menu timeout to 0 seconds (instant boot)
bcdedit /timeout 0 >nul 2>&1

:: Enable legacy boot menu (useful for F8 safe mode)
bcdedit /set {current} bootmenupolicy legacy >nul 2>&1

:: Disable login startup delay
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul

:: Speed up context menu display
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul

:: Disable "Frequent folders" in Explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f >nul

:: Disable hibernation to save disk space
powercfg -h off >nul

:: Disable auto-restart after updates
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableAutomaticRestartSignOn /t REG_DWORD /d 1 /f >nul

:: Clear startup entries without deleting the Run keys
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1

:: Delete startup shortcuts if they exist
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" (
    del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" >nul 2>&1
)

if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" (
    del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" >nul 2>&1
)


echo.
echo All boot optimizations applied successfully.
pause
goto PERFORMANCE_MENU


:: ===========================================
:: Power Plan Configuration Menu
:: ===========================================
:POWER_PLAN
cls
echo.
echo.
echo                   ===================================[ POWER PLAN ]===================================
echo.
echo                     [1] High Performance                                      [2] Balanced
echo.
echo                     [3] Power Saver                                           [4] Ultimate Performance
echo. 
echo                                                        [0] Back
echo.
echo                   ====================================================================================
echo.
set /p powchoice="Select an option: "

:: Validate input and jump to selected option
if /I "%powchoice%"=="1" goto Plan_High
if /I "%powchoice%"=="2" goto Plan_Balanced
if /I "%powchoice%"=="3" goto Plan_Saver
if /I "%powchoice%"=="4" goto Plan_Ultimate
if /I "%powchoice%"=="0" goto PERFORMANCE_MENU

:: Handle invalid input
echo.
echo Invalid selection. Please choose a number between (0-4)
pause
goto POWER_PLAN

:: ===========================================
:: HIGH PERFORMANCE POWER PLAN
:: ===========================================
:Plan_High
cls
powercfg /setactive SCHEME_MIN
echo.
echo High Performance power plan activated
pause
goto PERFORMANCE_MENU

:: ===========================================
:: BALANCED POWER PLAN
:: ===========================================
:Plan_Balanced
cls
powercfg /setactive SCHEME_BALANCED
echo.
echo Balanced power plan activated
pause
goto PERFORMANCE_MENU

:: ===========================================
:: POWER SAVER PLAN
:: ===========================================
:Plan_Saver
cls
powercfg /setactive SCHEME_MAX
echo.
echo Power Saver plan activated
pause
goto PERFORMANCE_MENU

:: ===========================================
:: ULTIMATE PERFORMANCE PLAN
:: ===========================================
:Plan_Ultimate
cls
powercfg -query e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1 || (
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
)
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo Ultimate Performance plan activated
pause
goto PERFORMANCE_MENU


:VISUAL_EFFECTS
cls

:: Disable all visual effects (sets to best performance)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

:: Speed up menu animations
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f

:: Disable window animations and effects
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f

:: Disable Aero Peek and thumbnails
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f

:: Disable taskbar animations
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f

:: Disable all shadow effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v DropShadows /t REG_SZ /d 0 /f

:: Disable transparency effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f

:: Keep ClearType enabled (for readability)
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v FontSmoothingType /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v FontSmoothingGamma /t REG_DWORD /d 578 /f

:: Disable Aero Shake feature
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f

:: Disable Game DVR features
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

echo.
echo  Visual effects disabled.
pause
goto PERFORMANCE_MENU


:: =============================================================
:: SECTION: PRIVACY & SECURITY MENU
:: DESCRIPTION: This section helps enhance privacy and secure Windows.
:: =============================================================
:PRIVACY_SECURITY_MENU
cls
echo.
echo.
echo                   ===================================[ PRIVACY AND SECURITY ]===================================
echo.
echo                     [1] Disable Telemetry                                         [2] Disable App Access
echo. 
echo                     [3] Windows Updates                                           [4] Windows Defender
echo. 
echo                     [5] Enhance Network Security                                  [0] Back
echo.
echo                   =============================================================================================
echo.
set /p priChoice="Select an option: "

:: Validate input and jump to selected option
if "%priChoice%"=="1" goto DISABLE_TELEMETRY
if "%priChoice%"=="2" goto Block_App_Access
if "%priChoice%"=="3" goto MANAGE_UPDATES
if "%priChoice%"=="4" goto DEFENDER_MANAGER
if "%priChoice%"=="5" goto NETWORK_SECURITY
if "%priChoice%"=="0" goto MENU

:: Handle invalid input
echo.
echo Invalid selection. Please choose a number between (0-5)
pause
goto PRIVACY_SECURITY_MENU

:: ================================
:: Advanced Telemetry Disabler
:: ================================
:DISABLE_TELEMETRY
cls
echo ================================
echo    DISABLING TELEMETRY FEATURES
echo ================================
echo.

echo Disabling Services...
sc config DiagTrack start= disabled >nul 2>&1
sc config diagnosticshub.standardcollector.service start= disabled >nul 2>&1
sc config diagsvc start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config wercplsupport start= disabled >nul 2>&1
sc config wersvc start= disabled >nul 2>&1
echo.
echo Terminating Processes & Blocking Executables...
taskkill /f /im CompatTelRunner.exe >nul 2>&1
taskkill /f /im DeviceCensus.exe >nul 2>&1
taskkill /f /im AitAgent.exe >nul 2>&1
taskkill /f /im diagsvc.exe >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v DisallowRun /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v Debugger /t REG_SZ /d "cmd.exe /c" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v Debugger /t REG_SZ /d "cmd.exe /c" /f >nul
echo.
echo Disabling Tasks & Features...
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
echo.
echo Applying Registry Tweaks...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1
:: تعطيل سجل النشاط
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f


:: File renaming operations
for %%d in ("%ProgramFiles%" "%ProgramFiles(x86)%") do (
    for /f "delims=" %%f in ('dir /b /s "%%~d\NVIDIA Corporation\NvTelemetry\*" 2^>nul') do (
        if not "%%~xf"==".OLD" ren "%%f" "%%~nxf.OLD" 1>nul 2>&1
    )
)
for /f "delims=" %%f in ('dir /b /s "%SystemRoot%\System32\DriverStore\FileRepository\NvTelemetry*.dll" 2^>nul') do (
    if not "%%~xf"==".OLD" ren "%%f" "%%~nxf.OLD" 1>nul 2>&1
)

:: Registry modifications
set regs[1]="HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v UsageTracking /t REG_DWORD /d 0 /f
set regs[2]="HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v PreventCDDVDMetadataRetrieval /t REG_DWORD /d 1 /f
set regs[3]="HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v PreventMusicFileMetadataRetrieval /t REG_DWORD /d 1 /f
set regs[4]="HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v PreventRadioPresetsRetrieval /t REG_DWORD /d 1 /f
set regs[5]="HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v EnableRID44231 /t REG_DWORD /d 0 /f
set regs[6]="HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v EnableRID64640 /t REG_DWORD /d 0 /f
set regs[7]="HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v EnableRID66610 /t REG_DWORD /d 0 /f
set regs[8]="HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f
set regs[9]="HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v DisableOnline /t REG_DWORD /d 1 /f
set regs[10]="HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v SendTelemetryData /t REG_DWORD /d 0 /f

for /l %%i in (1,1,10) do reg add !regs[%%i]! >nul 2>&1

:: Service management
for %%s in ("NvTelemetryContainer" "WMPNetworkSvc") do (
    sc query "%%~s" >nul 2>&1 && (
        sc stop "%%~s" >nul 2>&1
        sc config "%%~s" start= disabled >nul 2>&1
    )
)

:: Scheduled tasks
for %%t in (
    "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
    "NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
    "NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
) do (
    schtasks /Change /TN "\%%~t" /DISABLE >nul 2>&1
)

:: منع تجميع بيانات التشخيص
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: تعطيل ميزة "الحصول على تلميحات"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f

echo [5/6] Blocking Telemetry Hosts...
set hosts=%SystemRoot%\System32\drivers\etc\hosts
(
    echo.
    echo # [Privacy Blocklist - Added %date%]
    echo 0.0.0.0 Iring.msedge.net
    echo 0.0.0.0 aringfallback.msedge.net
    echo 0.0.0.0 api.msn.com
    echo 0.0.0.0 arc.msn.com
    echo 0.0.0.0 assets.msn.com
    echo 0.0.0.0 browser.events.data.msn.com
    echo 0.0.0.0 business.bing.com
    echo 0.0.0.0 cring.msedge.net
    echo 0.0.0.0 c.bing.com
    echo 0.0.0.0 c.msn.com
    echo 0.0.0.0 ceuswatcab01.blob.core.windows.net
    echo 0.0.0.0 ceuswatcab02.blob.core.windows.net
    echo 0.0.0.0 co4.telecommand.telemetry.microsoft.com
    echo 0.0.0.0 creativecdn.com
    echo 0.0.0.0 cs11.wpc.v0cdn.net
    echo 0.0.0.0 cs1137.wpc.gammacdn.net
    echo 0.0.0.0 dualsring.msedge.net
    echo 0.0.0.0 eaus2watcab01.blob.core.windows.net
    echo 0.0.0.0 eaus2watcab02.blob.core.windows.net
    echo 0.0.0.0 edgeassetservice.azureedge.net
    echo 0.0.0.0 euv10c.events.data.microsoft.com
    echo 0.0.0.0 euwatsonc.events.data.microsoft.com
    echo 0.0.0.0 fd.api.iris.microsoft.com
    echo 0.0.0.0 fpafdnocacheccp.azureedge.net
    echo 0.0.0.0 fpvs.azureedge.net
    echo 0.0.0.0 fp.msedge.net
    echo 0.0.0.0 functional.events.data.microsoft.com
    echo 0.0.0.0 g.msn.com
    echo 0.0.0.0 kmwatsonc.events.data.microsoft.com
    echo 0.0.0.0 lnring.msedge.net
    echo 0.0.0.0 modern.watson.data.microsoft.com
    echo 0.0.0.0 mucp.api.account.microsoft.com
    echo 0.0.0.0 ntp.msn.com
    echo 0.0.0.0 oca.microsoft.com
    echo 0.0.0.0 oca.telemetry.microsoft.com
    echo 0.0.0.0 prodazurecdnakamaiiris.azureedge.net
    echo 0.0.0.0 query.prod.cms.rt.microsoft.com
    echo 0.0.0.0 ris.api.iris.microsoft.com
    echo 0.0.0.0 sring.msedge.net
    echo 0.0.0.0 self.events.data.microsoft.com
    echo 0.0.0.0 srtb.msn.com
    echo 0.0.0.0 staticview.msn.com
    echo 0.0.0.0 tringfdv2.msedge.net
    echo 0.0.0.0 tring.msedge.net
    echo 0.0.0.0 telecommand.telemetry.microsoft.com
    echo 0.0.0.0 th.bing.com
    echo 0.0.0.0 tse1.mm.bing.net
    echo 0.0.0.0 umwatson.events.data.microsoft.com
    echo 0.0.0.0 umwatsonc.events.data.microsoft.com
    echo 0.0.0.0 usv10c.events.data.microsoft.com
    echo 0.0.0.0 v10.events.data.microsoft.com
    echo 0.0.0.0 v10.vortexwin.data.microsoft.com
    echo 0.0.0.0 v10c.events.data.microsoft.com
    echo 0.0.0.0 vortexwin.data.microsoft.com
    echo 0.0.0.0 watson.telemetry.microsoft.com
    echo 0.0.0.0 watsonc.events.data.microsoft.com
    echo 0.0.0.0 weus2watcab01.blob.core.windows.net
    echo 0.0.0.0 weus2watcab02.blob.core.windows.net
    echo 0.0.0.0 widgetcdn.azureedge.net
    echo 0.0.0.0 widgetservice.azurefd.net
    echo 0.0.0.0 www.msn.com
    echo 0.0.0.0 www.telecommandsvc.microsoft.com
    echo # [End of Privacy Blocklist]
) >> %hosts%

echo [6/6] Finalizing Settings...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCortanaButton /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v VoiceActivationEnableAboveLockscreen /t REG_DWORD /d 0 /f >nul

pause
echo.
echo All telemetry components disabled
pause
goto PRIVACY_SECURITY_MENU


:: =============================================
:: Windows Update Management Module
:: =============================================
:MANAGE_UPDATES
cls
echo.
echo    [1] Disable
echo    [2] Enable
echo    [0] Back
echo.
set /p updchoice="Select an option: "

if "%updchoice%"=="1" goto DISABLE_UPDATES
if "%updchoice%"=="2" goto ENABLE_UPDATES
if "%updchoice%"=="0" goto PRIVACY_SECURITY_MENU

echo.
echo Invalid selection. Please choose a number between (0-2)
pause
goto MANAGE_UPDATES


:: =============================================
:: FULL WINDOWS UPDATE DISABLE FUNCTION
:: =============================================
:DISABLE_UPDATES
cls
echo Starting Windows Update disable process...
echo.

sc stop wuauserv >nul 2>&1
sc stop UsoSvc >nul 2>&1
sc stop WaaSMedicSvc >nul 2>&1
sc config wuauserv start=disabled >nul
sc config UsoSvc start=disabled >nul
sc config WaaSMedicSvc start=disabled >nul
echo [+] Core update services terminated!

set "tasks="
set "tasks=!tasks! "\Microsoft\Windows\InstallService\RestoreDevice""
set "tasks=!tasks! "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\Report policies""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\ScanForUpdates""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\Scheduled Start""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\PerformRemediation""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work""
set "tasks=!tasks! "\Microsoft\Windows\WindowsUpdate\AUScheduledInstall""
set "tasks=!tasks! "\Microsoft\Windows\WaaSMedic\PerformRemediation""

for %%t in (!tasks!) do (
    schtasks /Change /TN "%%~t" /DISABLE >nul 2>&1
)


reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v DontSearchWindowsUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v DriverUpdateWizardWuSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableDualScan /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesEndTime /t REG_SZ /d "2099-12-31" /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallDay /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallTime /f >nul 2>&1
echo [+] Registry modifications applied!

taskkill /f /im WaaSMedicAgent.exe >nul 2>&1
taskkill /f /im upfc.exe >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v DisallowRun /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v 1 /t REG_SZ /d "WaaSMedicAgent.exe" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v 2 /t REG_SZ /d "upfc.exe" /f >nul
echo 127.0.0.1 update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 4 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v RequireDeferUpgrade /t REG_DWORD /d 1 /f >nul
echo [+] System hardened against forced updates!


:: --------------------------
:: Completion Message
:: --------------------------
echo.
echo Windows Updates have been fully disabled!
echo.
pause
goto PRIVACY_SECURITY_MENU



:: =============================================
:: RESTORE WINDOWS UPDATE FUNCTIONALITY
:: =============================================
:ENABLE_UPDATES
cls
echo Preparing to restore Windows Update functionality
echo.


sc config wuauserv start=auto >nul
sc config UsoSvc start=auto >nul
sc config WaaSMedicSvc start=auto >nul
sc start wuauserv >nul
sc start UsoSvc >nul
sc start WaaSMedicSvc >nul



set "tasks="
set "tasks=!tasks! "\Microsoft\Windows\InstallService\RestoreDevice""
set "tasks=!tasks! "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\Report policies""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\ScanForUpdates""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\Scheduled Start""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\PerformRemediation""
set "tasks=!tasks! "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work""
set "tasks=!tasks! "\Microsoft\Windows\WindowsUpdate\AUScheduledInstall""
set "tasks=!tasks! "\Microsoft\Windows\WaaSMedic\PerformRemediation""

for %%t in (!tasks!) do (
    schtasks /Change /TN "%%~t" /ENABLE >nul 2>&1
)



reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v DontSearchWindowsUpdate /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v DriverUpdateWizardWuSearchEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableDualScan /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesEndTime /f >nul 2>&1

:: استعادة إعدادات التثبيت المجدول
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallDay /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallTime /t REG_DWORD /d 3 /f >nul
echo [+] إعدادات الريجستري مُستعادة!


reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v 1 /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v DisallowRun /t REG_DWORD /d 0 /f >nul



set "hosts=%SystemRoot%\System32\drivers\etc\hosts"
findstr /v /c:"update.microsoft.com" "%hosts%" > "%hosts%.tmp"
move /y "%hosts%.tmp" "%hosts%" >nul


reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 2 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v RequireDeferUpgrade /f >nul 2>&1

:: --------------------------
:: Completion Message
:: --------------------------
echo.
echo Windows Update functionality fully restored!
echo.
pause
goto MENU


:Block_App_Access
cls
echo =============================================
echo    APPLICATION  BLOCKING UTILITY
echo =============================================
echo.

:: Set registry values
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v Value /t REG_SZ /d Deny /f >nul
pause
goto PRIVACY_SECURITY_MENU


:: =============================================
:: This module provides complete control over
:: Windows Defender components including:
:: - Core services
:: - Real-time protection
:: - Tamper protection
:: - Group Policy settings
:: =============================================

:DEFENDER_MANAGER
cls
echo.
echo    [1]  Disable
echo    [2]  Enable
echo    [0]  Back
echo.
set /p "defchoice="Select an option: "
:: Validate input using case statement

if "%defchoice%"=="1" goto Disable_Defender_Completely
if "%defchoice%"=="2" goto Restore_Defender_Fully
if "%defchoice%"=="0" goto PRIVACY_SECURITY_MENU

echo.
echo Invalid selection. Please choose a number between (0-2)
pause
goto DEFENDER_MANAGER


:: =============================================
:: COMPLETE DEFENDER DISABLE FUNCTION
:: =============================================
:Disable_Defender_Completely
cls
echo Initializing Windows Defender disable procedure...
echo.

:: --------------------------
:: Process Termination
:: --------------------------
for %%P in (
    MsMpEng.exe
    NisSrv.exe
    SecurityHealthService.exe
    SecurityHealthHost.exe
    MsSense.exe
) do (
    taskkill /f /im %%P >nul 2>&1
)

:: --------------------------
:: Service Configuration
:: --------------------------
for %%S in (
    WinDefend
    WdNisSvc
    SecurityHealthService
    Sense
    WdBoot
    WdFilter
) do (
    sc config %%S start= disabled >nul
    sc stop %%S >nul 2>&1
)

:: --------------------------
:: Registry Configuration
:: --------------------------

:: Disable via Group Policy
set "DEFENDER_REG=HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"
(
    reg add "%DEFENDER_REG%" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul && echo    - Disabled AntiSpyware
    reg add "%DEFENDER_REG%" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul && echo    - Disabled AntiVirus
    reg add "%DEFENDER_REG%\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul && echo    - Disabled Realtime Monitoring
    reg add "%DEFENDER_REG%\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul && echo    - Disabled Behavior Monitoring
    reg add "%DEFENDER_REG%\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul && echo    - Disabled On-Access Protection
    reg add "%DEFENDER_REG%\Spynet" /v DisableBlockAtFirstSeen /t REG_DWORD /d 1 /f >nul && echo    - Disabled Block at First Seen
    reg add "%DEFENDER_REG%\Policy Manager" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f >nul && echo    - Disabled Routine Actions
)
:: ==== Disable SmartScreen for File Explorer (EXE, MSI launch blocking) ====
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d Off /f

:: ==== Prevent "Downloaded from Internet" file tagging ====
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 1 /f

:: ==== Disable SmartScreen for Microsoft Edge (old and new versions) ====
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SmartScreenEnabled /t REG_DWORD /d 0 /f

:: ==== Disable SmartScreen for Windows Store apps (AppHost) ====
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f

:: ==== Optional: Disable Windows Defender PUA protection (Potentially Unwanted Apps) ====
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v PUATProtection /t REG_DWORD /d 0 /f

:: Disable Tamper Protection
(
    reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f >nul && echo    - Disabled Tamper Protection
    reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul && echo    - Added secondary AntiSpyware disable
)

:: --------------------------
:: Service Hardening
:: --------------------------
for %%S in (
    WinDefend
    WdNisSvc
    SecurityHealthService
) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul
    echo    - Hardened: %%S service startup
)

:: Refresh policies and return
gpupdate /force >nul 2>&1

:: --------------------------
:: Finalization
:: --------------------------
echo.
echo Windows Defender has been completely disabled
pause
goto DEFENDER_MANAGER


:Restore_Defender_Fully
cls
echo Starting Defender restoration process...
echo.

:: --------------------------
:: Service Restoration
:: --------------------------
for %%S in (
    WinDefend
    WdNisSvc
    SecurityHealthService
    Sense
    WdBoot
    WdFilter
) do (
    if "%%S"=="WdBoot" (
        sc config %%S start= system >nul
    ) else if "%%S"=="WdFilter" (
        sc config %%S start= system >nul
    ) else (
        sc config %%S start= auto >nul
    )
    
    sc start %%S >nul 2>&1 && 
)

:: --------------------------
:: Registry Cleanup
:: --------------------------

:: Remove all Defender policies
set "DEFENDER_REG=HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"
reg delete "%DEFENDER_REG%" /f >nul 2>&1 && (
)

:: Restore Tamper Protection
(
    reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 5 /f >nul && echo    - Enabled Tamper Protection
    reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1 && echo    - Removed AntiSpyware disable
    reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1 && echo    - Removed AntiVirus disable
)

:: --------------------------
:: Service Startup Repair
:: --------------------------
for %%S in (
    WinDefend
    WdNisSvc
    SecurityHealthService
) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 2 /f >nul
)

:: --------------------------
:: Finalization
:: --------------------------
gpupdate /force >nul 2>&1

echo Windows Defender has been fully restored!
echo.
pause
goto DEFENDER_MANAGER



:NETWORK_SECURITY
cls
echo  Starting security hardening process...
echo.

echo Starting network hardening...

:: === [1] Disable legacy and insecure protocols ===

:: Disable SMBv1 (legacy file sharing protocol)
dism /online /norestart /disable-feature /featurename:SMB1Protocol >nul

:: Disable NetBIOS over TCP/IP on all active adapters
for /f "tokens=*" %%i in ('wmic nicconfig where (IPEnabled=TRUE) get SettingID ^| findstr /r /v "^$"') do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\Tcpip_%%i" /v NetbiosOptions /t REG_DWORD /d 2 /f >nul
)

:: Set NodeType = P-node to fully disable NetBIOS name resolution
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v NodeType /t REG_DWORD /d 2 /f >nul

:: Disable LLMNR (Link-Local Multicast Name Resolution)
reg add "HKLM\Software\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 0 /f >nul

:: Disable WPAD (Web Proxy Auto Discovery)
reg add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v EnableAutoproxyResultCache /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DisableWpad /t REG_DWORD /d 1 /f >nul
sc config WinHttpAutoProxySvc start= disabled >nul

:: Enforce TLS 1.2 only (disable TLS 1.0 and 1.1)
for %%V in (1.0 1.1) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS %%V\Client" /v Enabled /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS %%V\Server" /v Enabled /t REG_DWORD /d 0 /f >nul
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /v Enabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f >nul

:: === [2] Harden SMB settings ===

:: Require SMB signing
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 1 /f >nul

:: Enforce SMB hardening flags
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB2_Hardening /t REG_DWORD /d 8 /f >nul

:: Disable NTLM over SMB (require integrity)
reg add "HKLM\SYSTEM\CurrentControlSet\services\mrxsmb10\Parameters" /v RequireIntegrity /t REG_DWORD /d 1 /f >nul

:: Set SMB authentication retry timeout
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v MaxAuthRetryTimeout /t REG_DWORD /d 2 /f >nul

:: === [3] Disable remote attack surfaces ===

:: Disable Remote Desktop (TermService)
sc config TermService start= disabled >nul

:: Network Protocol Security
(
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v SMBDeviceEnabled /t REG_DWORD /d 0 /f >nul && echo    - Disabled SMB over NetBIOS
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f >nul && echo    - Disabled IPv6 (where possible)
) >nul

:: Additional Hardening
(
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /v AllowProtectedCreds /t REG_DWORD /d 1 /f >nul && echo    - Enabled Protected Credentials
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 0 /f >nul && echo    - Disabled local account token filtering
) >nul

:: Disable WinRM (Remote PowerShell)
sc config WinRM start= disabled >nul

:: Disable Remote Registry service
sc config RemoteRegistry start= disabled >nul

sc config Remote Assistance start= disabled >nul   Remote Desktop

sc config Remote Desktop start= disabled >nul

:: Service Hardening
for %%S in (
    "TlntSvr,Telnet"
    "FTPSVC,FTP"
    "Browser,Computer Browser"
    "SSDPSRV,SSDP Discovery"
    "upnphost,UPnP Host"
) do (
    for /f "tokens=1-2 delims=," %%A in ("%%~S") do (
        sc config %%A start= disabled >nul && sc stop %%A >nul && echo    - Disabled service: %%B
    )
)
:: Disable WDigest use of plaintext credentials
reg add "HKLM\System\CurrentControlSet\Control\SecurityProviders\WDigest" /v UseLogonCredential /t REG_DWORD /d 0 /f >nul

:: === [4] Firewall and discovery protection ===

:: Block ICMP Echo requests (ping)
netsh advfirewall firewall add rule name="Block ICMPv4-In" protocol=icmpv4:8,any dir=in action=block profile=any >nul

:: Disable network discovery (LLTD)
netsh advfirewall firewall set rule group="Network Discovery" new enable=No >nul

:: Network Configuration
echo --- Network Configuration ---
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr "IPv4"') do echo IP Address: %%A
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr "Subnet"') do echo Subnet Mask: %%A


:: Port Hardening
for %%P in (
    "Telnet,23,TCP"
    "FTP,21,TCP" 
    "TFTP,69,UDP"
    "SNMP,161,UDP"
    "NetBIOS-137,137,UDP"
    "NetBIOS-138,138,UDP"
    "NetBIOS-139,139,TCP"
) do (
    for /f "tokens=1-3 delims=," %%A in ("%%~P") do (
        netsh advfirewall firewall add rule name="Block %%A" protocol=%%C dir=in localport=%%B action=block >nul && echo    - Blocked port %%B (%%A)
    )
)

:: Enable Windows Firewall for all profiles
netsh advfirewall set allprofiles state on >nul
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound >nul

netsh advfirewall show allprofiles state
ipconfig
netstat -ano | findstr LISTENING | more +0


:: Final Message
echo.
echo Network security hardening complete!
pause
goto PRIVACY_SECURITY_MENU


:CUSTOMIZATION_MENU
cls
echo.
echo.
echo                   ===================================[ CUSTOMIZATION ]===================================
echo.
echo                    [1] File Explorer                                        [2] Lock Screen                              
echo.
echo                    [3] News and Interests                                   [4] Dark Mode
echo.
echo                    [5] Power seeting                                        [6] Customize Right-Click 
echo.
echo                    [7] Classic Windows Photo Viewer                         [8] Back
echo.
echo                  ========================================================================================
echo.
set /p "cus_choice="Select an option: "

:: Validate input using case statement
if "%cus_choice%"=="1" goto FileExplorer_Tweaks
if "%cus_choice%"=="2" goto DISABLE_LOCK_SCREEN
if "%cus_choice%"=="3" goto NEW_AND_INTERESTS
if "%cus_choice%"=="4" goto DARK_MODE
if "%cus_choice%"=="5" goto POWER_SEETING
if "%cus_choice%"=="6" goto CONTEXT_MENU
if "%cus_choice%"=="7" goto Restore_PhotoViewer
if "%cus_choice%"=="0" goto MENU

echo.
echo Invalid selection. Please choose a number between (0-7)
pause
goto CUSTOMIZATION_MENU 

:: =============================================
:: This module provides various File Explorer
:: tweaks including showing file extensions and
:: customizing the right-click context menu
:: =============================================

:FileExplorer_Tweaks
cls
echo.
echo.
echo                   ===================================[ FILE EXPLORER ]===================================
echo.
echo                    [1] Show File Extensions                                [2] Disable Quick Access
echo.
echo                    [3] Disable Recent Files                                [4] Show Full Path in Title Bar
echo.    
echo                    [5] Show Protected System Files                         [6] Enable One-Click to Open Items
echo.    
echo                    [7] Folder as default                                   [8] remove_shortcut
echo.   
echo                                                          [0] Back
echo.
echo                  ========================================================================================
echo.
set /p fil_choice="Select an option: "

if "%fil_choice%"=="1" goto SHOW_FILE_EXTENTION
if "%fil_choice%"=="2" goto DISABLE_QUIK_ACCESS
if "%fil_choice%"=="3" goto DISABLE_RECENT_FILES
if "%fil_choice%"=="4" goto FULL_PATH 
if "%fil_choice%"=="5" goto HIDEN_FILE
if "%fil_choice%"=="6" goto ONE_CLICK
if "%fil_choice%"=="7" goto FOLDER_DEFAULT
if "%fil_choice%"=="8" goto REMOVE_SHORTCUT
if "%fil_choice%"=="0" goto CUSTOMIZATION_MENU

echo.
echo Invalid selection. Please choose a number between (1-7)
pause 



:: =============================================
:: ALWAYS SHOW FILE EXTENSIONS
:: =============================================
:SHOW_FILE_EXTENTION
cls
echo.
echo          [1] Enable
echo          [2] Disable
echo          [0] Back
echo.

choice /c 012 /n /m "Select an option: "

if errorlevel 1 goto ENABLE_FILE_EXTENSIONS
if errorlevel 2 goto DISABLE_FILE_EXTENSIONS
if errorlevel 0 goto FileExplorer_Tweaks
:ENABLE_FILE_EXTENSIONS
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul
echo.
echo File extensions are now visible.
pause
goto FileExplorer_Tweaks
:DISABLE_FILE_EXTENSIONS
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f >nul
echo.
echo File extensions are now hidden.
pause
goto FileExplorer_Tweaks

:: =============================================
:: DISABLE QUICK ACCESS IN FILE EXPLORER
:: =============================================
:DISABLE_QUIK_ACCESS
cls
echo.
echo          [1] Enable Quick Access
echo          [2] Disable Quick Access
echo          [0] Back
echo.

choice /c 012 /n /m "Select an option: "

if errorlevel 1 goto ENABLE_QUICK_ACCESS
if errorlevel 2 goto DISABLE_QUICK_ACCESS
if errorlevel 0 goto FileExplorer_Tweaks
:ENABLE_QUICK_ACCESS
:: Enable Quick Access and set Explorer to open Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HubMode /t REG_DWORD /d 0 /f >nul && echo [SUCCESS] Quick Access shown
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 0 /f >nul && echo [SUCCESS] Default set to 'Quick Access'
echo Quick Access are now enable
pause
goto FileExplorer_Tweaks
:DISABLE_QUICK_ACCESS
:: Clear Quick Access history
del /f /q "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
del /f /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1
:: Disable Quick Access and set Explorer to open "This PC"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HubMode /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Quick Access hidden
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Default set to 'This PC'
echo Quick Access are now disable.
pause
goto FileExplorer_Tweaks

:: =============================================
:: DISABLE RECENT FILES AND ACTIVITY HISTORY
:: =============================================
:DISABLE_RECENT_FILES
cls
echo.
echo [1] Enable recent file 
echo [2] Disable recent file
echo [0] Back
echo.
choice /c 012 /n /m "Select an option: "

if errorlevel 1 goto ENABLE_RECENT_FILE
if errorlevel 2 goto DISABLE_RECENT_FILE
if errorlevel 0 goto FileExplorer_Tweaks

:ENABLE_RECENT_FILE
cls
echo Enabling recent file...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 1 /f >nul

:DISABLE_RECENT_FILE
cls
echo Disabling recent file...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul
del /f /q "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
del /f /q "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1

:FULL_PATH
cls
title Enable Show Full Path in Title Bar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f
echo [SUCCESS] Enabled full path in Explorer title bar.
pause
goto CUSTOMIZATION_MENU

:HIDEN_FILE
cls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f >nul
echo [SUCCESS] Hidden and protected system files are now visible.
pause
goto CUSTOMIZATION_MENU

:ONE_CLICK
cls
echo [INFO] Enabling one-click to open items...

:: تفعيل الفتح بنقرة واحدة
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v IconUnderline /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShellState /t REG_BINARY /d 2400000030000000B0110000A0000000000000000000000060000000000000000000000000000000 /f >nul

echo [SUCCESS] One-click behavior enabled!
pause
goto CUSTOMIZATION_MENU

:FOLDER_DEFAULT

echo [INFO] Resetting File Explorer settings to default...
timeout /t 2 >nul

:: 1. إعادة ضبط إعدادات عرض المستكشف (View Settings)
reg delete "HKCU\Software\Microsoft\Windows\Shell\Bags" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\Shell\BagMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\ShellNoRoam\Bags" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\ShellNoRoam\BagMRU" /f >nul 2>&1

:: 2. إعادة تفعيل الإعدادات الافتراضية للمستكشف
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CIDOpen" /f >nul 2>&1

:: 3. إعادة خيارات عرض الملفات المخفية والامتدادات إلى الافتراضي
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f

:: 4. إعادة ضبط شريط العنوان والإشارات الحديثة
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1

:: 5. إعادة تشغيل Explorer لتطبيق التغييرات
echo.
echo [INFO] Restarting Explorer...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo [DONE] File Explorer settings have been reset.
pause
goto CUSTOMIZATION_MENU



:DARK_MODE
:: تمكين الوضع المظلم للتطبيقات
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul

:: تمكين الوضع المظلم للنظام (شريط المهام، قائمة Start...)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
pause
goto CUSTOMIZATION_MENU

:REMOVE_SHORTCUT
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "C:\Windows\System32\imageres.dll,197" /f
pause
goto CUSTOMIZATION_MENU
:: =============================================
:: DISABLE WINDOWS LOCK SCREEN
:: =============================================
:DISABLE_LOCK_SCREEN
cls
echo.
echo [1] Enable Lock Screen
echo [2] Disable Lock Screen
echo [0] Back
echo.

choice /c 012 /n /m "Select an option: "

if errorlevel 1 goto ENABLE_LOCK_SCREEN
if errorlevel 2 goto DISABLE_LOCK_SCREEN
if errorlevel 0 goto CUSTOMIZATION_MENU

:ENABLE_LOCK_SCREEN
cls
echo Enabling Windows Lock Screen...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /f >nul 2>&1
pause
goto CUSTOMIZATION_MENU

:DISABLE_LOCK_SCREEN
cls
echo Disabling Windows Lock Screen...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul
pause
goto CUSTOMIZATION_MENU

	
:NEW_AND_INTERESTS
cls
echo [1] Enable
echo [2] Disable
echo [0] Back
choice /c 012 /n /m "Select an option: "

if errorlevel 1 goto ENABLE_NEW_AND_INTERESTS
if errorlevel 2 goto DISABLE_NEW_AND_INTERESTS
if errorlevel 3 goto CUSTOMIZATION_MENU

:ENABLE_NEW_AND_INTERESTS
cls
echo Enabling News and Interests...
:: Enable feeds system-wide
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /f >nul 2>&1
:: Enable for current user
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 0 /f >nul
:: Enable for Default User (future accounts)
reg load HKU\DefaultUser "C:\Users\Default\NTUSER.DAT" >nul 2>&1
reg add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 0 /f >nul
reg unload HKU\DefaultUser >nul
pause
goto CUSTOMIZATION_MENU
	
:DISABLE_NEW_AND_INTERESTS
cls
echo Disabling News and Interests ...
:: Disable feeds system-wide
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
:: Disable for current user
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
:: Disable for Default User (future accounts)
reg load HKU\DefaultUser "C:\Users\Default\NTUSER.DAT" >nul 2>&1
reg add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
reg unload HKU\DefaultUser >nul
pause
goto CUSTOMIZATION_MENU

::==================================================
:: RESTORE CLASSIC WINDOWS PHOTO VIEWER
:: Re‑enables the legacy Photo Viewer for various image types
::==================================================
:Restore_PhotoViewer
cls
echo =======================[ PHOTO VIEWER ]======================
echo [1] Enable Photo Viewer    [2] Disable Photo Viewer    [0] Back
echo ============================================================
echo.
choice /c 012 /n /m "Select an option: "

if errorlevel 1 goto ENABLE_PHOTO_VIEWER
if errorlevel 2 goto DISABLE_PHOTO_VIEWER
if errorlevel 3 goto CUSTOMIZATION_MENU

:ENABLE_PHOTO_VIEWER
cls
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-70" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print" /v "NeverDefault" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-83" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-71" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3058" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-122" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\Image Preview\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\Image Preview\DropTarget" /v "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /t REG_SZ /d "" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3069" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationName" /t REG_SZ /d "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3009" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".cr2" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.JFIF" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Png" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Gif" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\RegisteredApplications" /v "Windows Photo Viewer" /t REG_SZ /d "SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /f
echo.
echo Windows Photo Viewer has been successfully restored!
echo.
pause
goto Restore_PhotoViewer


:DISABLE_PHOTO_VIEWER
cls
reg delete "HKEY_CLASSES_ROOT\Applications\photoviewer.dll" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\Image Preview" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\RegisteredApplications" /v "Windows Photo Viewer" /f >nul 2>&1
echo.
echo Windows Photo Viewer has been successfully disabled!
echo.
pause
goto Restore_PhotoViewer

:: =============================================
:: CUSTOMIZE RIGHT-CLICK CONTEXT MENU
:: =============================================
:CONTEXT_MENU
cls
echo.
echo.
echo                   ===================================[ CONTEXT MENU ]===================================
echo.
echo                    [1] Add Open Command Prompt                               [2]Add Open PowerShell
echo. 
echo                    [3] Add Kill Frozen Processes                             [4] Add Restart Explorer
echo.    
echo                                                          [0] Back
echo.
echo                   ======================================================================================
echo.
set /p con_choice="Select an option: "

if "%con_choice%"=="1" goto Add_CMD_Context
if "%con_choice%"=="2" goto Add_PSAdmin_Context
if "%con_choice%"=="3" goto KILL_PROCESSES
if "%con_choice%"=="4" goto Explorer_Restart
if "%con_choice%"=="0" goto CUSTOMIZATION_MENU

echo.
echo Invalid selection. Please choose a number between (0-4)
pause
goto CONTEXT_MENU


:: =============================================
:: ADD POWERSHELL AS ADMIN TO CONTEXT MENU
:: =============================================
:Add_PSAdmin_Context
cls

(
    reg add "HKCR\Directory\shell\PowershellAsAdmin" /ve /d "Open PowerShell as Admin" /f >nul
    reg add "HKCR\Directory\shell\PowershellAsAdmin" /v "Icon" /d "powershell.exe" /f >nul
    reg add "HKCR\Directory\shell\PowershellAsAdmin\command" /ve /d "powershell.exe -NoExit -Command \"Start-Process powershell -Verb RunAs -ArgumentList '-NoExit','-Command','Set-Location -LiteralPath ''%%V'''\"" /f >nul
    echo [SUCCESS] PowerShell admin option added
)

echo.
echo Context menu item added
pause
goto CONTEXT_MENU

:: =============================================
:: ADD COMMAND PROMPT TO CONTEXT MENU
:: =============================================
:Add_CMD_Context
cls
(
    reg add "HKCR\Directory\shell\OpenCmdHere" /ve /d "Open Command Prompt Here" /f >nul
    reg add "HKCR\Directory\shell\OpenCmdHere" /v "Icon" /d "cmd.exe" /f >nul
    reg add "HKCR\Directory\shell\OpenCmdHere\command" /ve /d "cmd.exe /s /k pushd \"%%V\"" /f >nul
    echo [SUCCESS] Command Prompt option added
)

echo.
echo Context menu item added
pause
goto CONTEXT_MENU


::==================================================
:: ADD POWERSHELL AS ADMIN
::==================================================
:ADD_PSADMIN_CONTEXT
cls
echo Adding 'Open PowerShell as Admin' to context menu...
reg add "HKCR\Directory\shell\PowershellAsAdmin" /ve /d "Open PowerShell as Admin" /f >nul
reg add "HKCR\Directory\shell\PowershellAsAdmin" /v Icon /d "powershell.exe" /f >nul
reg add "HKCR\Directory\shell\PowershellAsAdmin\command" /ve /d "powershell.exe -NoExit -Command \"Start-Process powershell -Verb RunAs -ArgumentList '-NoExit','-Command','Set-Location -LiteralPath ''%%V'''\"" /f >nul
echo [SUCCESS] 'Open PowerShell as Admin' added.
pause
goto CONTEXT_MENU



:: =============================================
:: ADD EXPLORER RESTART TO DESKTOP CONTEXT MENU
:: =============================================
:Explorer_Restart
cls
(
    reg add "HKCR\DesktopBackground\Shell\RestartExplorer" /ve /d "Restart Explorer" /f >nul
    reg add "HKCR\DesktopBackground\Shell\RestartExplorer" /v "Icon" /d "explorer.exe" /f >nul
    reg add "HKCR\DesktopBackground\Shell\RestartExplorer\command" /ve /d "cmd.exe /c \"taskkill /f /im explorer.exe && start explorer.exe\"" /f >nul
    echo [SUCCESS] Explorer restart option added
)

echo.
echo Context menu item added
pause
goto CONTEXT_MENU

:KILL_PROCESSES
cls
echo.
echo ==========================================
echo     Kill Frozen Processes Context Menu
echo ==========================================
echo.
echo [1] Add to Context Menu
echo [2] Remove from Context Menu
echo [3] Exit
echo ==========================================
choice /c 123 /n /m "Select an option: "

if errorlevel 3 goto CONTEXT_MENU
if errorlevel 2 goto REMOVE_CONTEXT
if errorlevel 1 goto ADD_CONTEXT

:ADD_CONTEXT
cls
echo Adding "Kill Frozen Processes" to context menu...
echo.



REM Create the PowerShell script for killing frozen processes
set "scriptPath=%TEMP%\KillFrozenProcesses.ps1"
echo # Kill Frozen Processes PowerShell Script > "%scriptPath%"
echo Add-Type -AssemblyName System.Windows.Forms >> "%scriptPath%"
echo. >> "%scriptPath%"
echo $frozenProcesses = Get-Process ^| Where-Object { >> "%scriptPath%"
echo     $_.Responding -eq $false -and >> "%scriptPath%"
echo     $_.ProcessName -ne "System" -and >> "%scriptPath%"
echo     $_.ProcessName -ne "Idle" -and >> "%scriptPath%"
echo     $_.ProcessName -ne "csrss" -and >> "%scriptPath%"
echo     $_.ProcessName -ne "winlogon" -and >> "%scriptPath%"
echo     $_.ProcessName -ne "services" -and >> "%scriptPath%"
echo     $_.ProcessName -ne "lsass" -and >> "%scriptPath%"
echo     $_.ProcessName -ne "svchost" >> "%scriptPath%"
echo } >> "%scriptPath%"
echo. >> "%scriptPath%"
echo if ($frozenProcesses.Count -eq 0) { >> "%scriptPath%"
echo     [System.Windows.Forms.MessageBox]::Show("No frozen processes found!", "Kill Frozen Processes", "OK", "Information") >> "%scriptPath%"
echo } else { >> "%scriptPath%"
echo     $processNames = ($frozenProcesses ^| ForEach-Object { $_.ProcessName }) -join ", " >> "%scriptPath%"
echo     $result = [System.Windows.Forms.MessageBox]::Show("Found " + $frozenProcesses.Count + " frozen process(es):`n`n" + $processNames + "`n`nDo you want to kill them?", "Kill Frozen Processes", "YesNo", "Question") >> "%scriptPath%"
echo     if ($result -eq "Yes") { >> "%scriptPath%"
echo         $killedCount = 0 >> "%scriptPath%"
echo         foreach ($process in $frozenProcesses) { >> "%scriptPath%"
echo             try { >> "%scriptPath%"
echo                 $process.Kill() >> "%scriptPath%"
echo                 $killedCount++ >> "%scriptPath%"
echo             } catch { >> "%scriptPath%"
echo                 Write-Host "Failed to kill process: " $process.ProcessName >> "%scriptPath%"
echo             } >> "%scriptPath%"
echo         } >> "%scriptPath%"
echo         [System.Windows.Forms.MessageBox]::Show("Successfully killed " + $killedCount + " frozen process(es)!", "Kill Frozen Processes", "OK", "Information") >> "%scriptPath%"
echo     } >> "%scriptPath%"
echo } >> "%scriptPath%"

REM Add registry entries for desktop context menu
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\KillFrozenProcesses" /v "" /t REG_SZ /d "Kill Frozen Processes" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\KillFrozenProcesses" /v "Icon" /t REG_SZ /d "taskmgr.exe,0" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\KillFrozenProcesses\command" /ve /t REG_SZ /d "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%TEMP%\KillFrozenProcesses.ps1\"" /f >nul 2>&1

REM Add registry entries for Computer/This PC context menu
reg add "HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\KillFrozenProcesses" /v "" /t REG_SZ /d "Kill Frozen Processes" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\KillFrozenProcesses" /v "Icon" /t REG_SZ /d "taskmgr.exe,0" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\KillFrozenProcesses\command" /ve /t REG_SZ /d "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%TEMP%\KillFrozenProcesses.ps1\"" /f >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo  Successfully added "Kill Frozen Processes" to context menu
) else (
    echo  Failed to add context menu option!
)
echo.
pause
goto CONTEXT_MENU

:REMOVE_CONTEXT
cls
echo Removing "Kill Frozen Processes" from context menu...
echo.

REM Remove registry entries
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\KillFrozenProcesses" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\KillFrozenProcesses" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\KillFrozenProcesses" /f >nul 2>&1

REM Remove PowerShell script
if exist "%TEMP%\KillFrozenProcesses.ps1" del "%TEMP%\KillFrozenProcesses.ps1" >nul 2>&1

echo  Successfully removed "Kill Frozen Processes" from context menu
echo.
pause
goto CONTEXT_MENU


:POWER_SEETING
:: Create  folder on Desktop 
set "folderName=power setting.{ED7BA470-8E54-465E-825C-99712043E01C}"
set "desktopPath=%USERPROFILE%\Desktop"

mkdir "%desktopPath%\%folderName%"

echo God Mode folder "power setting" created on your desktop.
pause
goto CUSTOMIZATION_MENU


:: =============================================================
:: SECTION: NETWORK MENU
:: DESCRIPTION: This section measures internet speed and helps improve internet quality.
:: =============================================================
:NETWORK_MENU
cls
echo.
echo.
echo                   ===================================[ TOOLS ]===================================
echo.
echo                    [1] Internet Speed                                  [2] Reset Network Settings
echo. 
echo                                                      [0] Back
echo.
echo                  ================================================================================

set /p netchoice="Select an option: "

if "%netchoice%"=="1" goto Network_Speed_Test
if "%netchoice%"=="2" goto Network_Reset
if "%netchoice%"=="0" goto MENU

echo Invalid selection, Please choose a number between (0-2)
pause
goto NETWORK_MENU

:: =============================================
:: NETWORK SPEED TEST MODULE
:: =============================================
:: This module downloads and runs the official
:: Ookla Speedtest CLI tool to measure internet
:: connection speed and latency
:: =============================================

:Network_Speed_Test
cls
:: Configuration
set "SPEEDTEST_URL=https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip"
set "TEMP_ZIP=%TEMP%\speedtest_cli.zip"
set "EXTRACT_DIR=%TEMP%\speedtest_cli"
set "EXE_PATH=%EXTRACT_DIR%\speedtest.exe"

:: Check for existing installation
if exist "%EXE_PATH%" (
    goto RUN_SPEEDTEST
)

:: Create extraction directory if needed
if not exist "%EXTRACT_DIR%" (
    mkdir "%EXTRACT_DIR%" >nul 2>&1
    if not exist "%EXTRACT_DIR%" (
        echo  Failed to create temporary directory
        pause
        goto NETWORK_MENU
    )
)

:: Download Speedtest CLI
echo Downloading Speedtest...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%SPEEDTEST_URL%', '%TEMP_ZIP%')"

if not exist "%TEMP_ZIP%" (
    echo Download failed. Check your internet connection
    pause
    goto NETWORK_MENU
)

:: Extract the archive
echo Extracting files...
powershell -Command "Expand-Archive -Path '%TEMP_ZIP%' -DestinationPath '%EXTRACT_DIR%' -Force" >nul 2>&1

if not exist "%EXE_PATH%" (
    echo Extraction failed. File may be corrupted
    del "%TEMP_ZIP%" >nul 2>&1
    pause
    goto NETWORK_MENU
)

:: Cleanup
del "%TEMP_ZIP%" >nul 2>&1

:RUN_SPEEDTEST
echo.
echo [*] Measuring your internet speed...
echo.

:: Run speedtest with GDPR acceptance
"%EXE_PATH%" --accept-license --accept-gdpr

pause
goto NETWORK_MENU

:: =============================================
:: NETWORK RESET MODULE
:: =============================================
:: This module performs a comprehensive reset of
:: all network components including:
:: - TCP/IP stack
:: - Winsock catalog
:: - Firewall settings
:: - Network adapters
:: - DNS and DHCP configurations
:: =============================================

:Network_Reset
cls
echo =============================================
echo       NETWORK RESET UTILITY
echo =============================================
echo [WARNING] This will:
echo    - Reset ALL network settings to defaults
echo    - Clear all network caches and tables
echo    - Require network reconfiguration
echo    - Need a system restart to complete
echo.
choice /c YN /n /m "Are you sure you want to continue (Y/N)? "
if errorlevel 2 goto NETWORK_MENU

cls
echo Starting network reset procedure...
echo        Please wait, this may take 2-3 minutes...
echo.

:: --------------------------
:: Phase 1: Service Management
:: --------------------------
echo  Managing network services...
for %%S in (
    "dnscache,DNS Client"
    "dhcp,DHCP Client"
    "lanmanserver,Server"
    "lanmanworkstation,Workstation"
) do (
    for /f "tokens=1,2 delims=," %%A in ("%%~S") do (
        echo    - Stopping %%B service...
        net stop %%A >nul 2>&1
    )
)

:: --------------------------
:: Phase 2: Core Components Reset
:: --------------------------
echo [*] Resetting core network components...
for %%C in (
    "ipconfig /release,Releasing IP addresses"
    "ipconfig /flushdns,Flushing DNS resolver cache"
    "netsh winsock reset,Resetting Winsock catalog"
    "netsh int ip reset,Resetting TCP/IP stack"
    "netsh int tcp reset,Resetting TCP settings"
    "netsh int ipv4 reset,Resetting IPv4 configuration"
    "netsh int ipv6 reset,Resetting IPv6 configuration"
    "netsh winhttp reset proxy,Clearing proxy settings"
    "netsh advfirewall reset,Resetting firewall to defaults"
) do (
    for /f "tokens=1* delims=," %%A in ("%%~C") do (
        echo    - %%B...
        %%A >nul 2>&1
    )
)

:: --------------------------
:: Phase 3: Cache Clearing
:: --------------------------
echo [*] Clearing network caches...
for %%C in (
    "arp -d *,Clearing ARP cache"
    "nbtstat -R,Reloading NetBIOS name cache"
    "nbtstat -RR,Refreshing NetBIOS names"
    "netsh int ip delete arpcache,Clearing IP ARP cache"
) do (
    for /f "tokens=1* delims=," %%A in ("%%~C") do (
        echo    - %%B...
        %%A >nul 2>&1
    )
)

:: --------------------------
:: Phase 4: Adapter Reset
:: --------------------------
echo [*] Resetting network adapters...
setlocal enabledelayedexpansion
for /f "tokens=3*" %%A in ('netsh interface show interface ^| findstr /i "connected"') do (
    set "adapter=%%B"
    echo    - Resetting adapter: !adapter!
    netsh interface set interface "!adapter!" disable >nul 2>&1
    timeout /t 3 >nul
    netsh interface set interface "!adapter!" enable >nul 2>&1
)
endlocal

:: --------------------------
:: Phase 5: Service Restoration
:: --------------------------
echo [*] Restoring network services...
for %%S in (
    "lanmanworkstation,Workstation"
    "lanmanserver,Server" 
    "dhcp,DHCP Client"
    "dnscache,DNS Client"
) do (
    for /f "tokens=1,2 delims=," %%A in ("%%~S") do (
        echo    - Starting %%B service...
        net start %%A >nul 2>&1
    )
)

:: --------------------------
:: Phase 6: Final Configuration
:: --------------------------
echo [*] Finalizing network configuration...
echo    - Renewing IP addresses...
ipconfig /renew >nul 2>&1

echo.
echo Network components have been reset.
echo.
pause
goto NETWORK_MENU


:: =============================================
:: PROGRAM INSTALLATION MENU
:: =============================================
:PROGRAMS_MENU
cls
echo.
echo                   ===================================[ PROGRAM MANAGER ]===================================
echo.
echo                    [1] Download Programs                                              [2] Update Programs
echo.
echo                                                          [0] Back
echo.
echo                  ==========================================================================================
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto download_programs
if "%choice%"=="2" goto update_programs
if "%choice%"=="0" goto MENU

echo Invalid choice! Please choose a number between
pause 
goto PROGRAMS_MENU

:download_programs
:: Check if Chocolatey is installed
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Chocolatey...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

    :: Refresh environment variables
    if defined ChocolateyInstall (
        if exist "%ChocolateyInstall%\bin\refreshenv.cmd" (
            call "%ChocolateyInstall%\bin\refreshenv.cmd"
        )
    )

    :: Check installation success
    where choco >nul 2>&1
    if %errorlevel% equ 0 (
        echo.
        echo Chocolatey installed successfully.
        goto PROGRAME_DOWNLOAD
    ) else ( 
        echo.
        echo Failed to install Chocolatey!
        echo Please install manually from: https://chocolatey.org/install
        pause
        goto MENU
    )
) else (
    echo Chocolatey is already installed.
    goto PROGRAME_DOWNLOAD
)

:PROGRAME_DOWNLOAD
cls
echo.
echo.
echo                   ===================================[ PROGRAME ]===================================
echo.
echo                   [1] Install Google Chrome                            [2] Install Brave Browser
echo.    
echo                   [3] Install VLC Media Player                         [4] Install Sumatra PDF
echo.    
echo                   [5] Install WinRAR                                   [6] Install Notpad plus plus
echo.    
echo                   [7] Install ALL                                      [8] VirtualBox
echo.
echo                                                        [0] Back
echo.
echo               ======================================================================================
echo.
set /p prog_choice="Select an option: "

if "%prog_choice%"=="1" goto install_chrome
if "%prog_choice%"=="2" goto install_brave
if "%prog_choice%"=="3" goto install_vlc
if "%prog_choice%"=="4" goto install_sumatra
if "%prog_choice%"=="5" goto install_winrar
if "%prog_choice%"=="6" goto install_notepad
if "%prog_choice%"=="7" goto install_all
if "%prog_choice%"=="8" goto install_virtualbox
if "%prog_choice%"=="0" goto MENU
echo.
echo Invalid selection. Please choose a number between (0-8)
pause 
goto PROGRAME_DOWNLOAD

:install_chrome
cls
echo Install Google Chrome...
echo.

:: Check if Google Chrome is installed (regardless of Chocolatey)
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    echo  Google Chrome is already installed!
) else (
    choco install googlechrome -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_brave
cls
echo Install Brave Browser...
echo.

:: Check if Brave Browser is installed
if exist "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" (
    echo  Brave Browser is already installed!
) else (
    choco install brave -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_vlc
cls
echo Install VLC Media Player...
echo.

:: Check if VLC is installed
if exist "C:\Program Files\VideoLAN\VLC\vlc.exe" (
    echo  VLC Media Player is already installed!
) else (
    choco install vlc -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_sumatra
cls
echo Install Sumatra PDF...
echo.

:: Check if Sumatra PDF is installed
if exist "C:\Program Files\SumatraPDF\SumatraPDF.exe" (
    echo  Sumatra PDF is already installed!
) else (
    choco install sumatrapdf -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_winrar
cls
echo Install WinRAR...
echo.

:: Check if WinRAR is installed
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
    echo  WinRAR is already installed!
) else (
    choco install winrar -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_notepad
cls
echo Install Notepad plus plus...
echo.

:: Check if Notepad++ is installed
if exist "C:\Program Files\Notepad++\notepad++.exe" (
    echo  Notepad plus plus is already installed!
) else (
    choco install notepadplusplus -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_virtualbox
cls
echo Install VirtualBox...
echo.

:: Check if VirtualBox is installed
if exist "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe" (
    echo  VirtualBox is already installed!
) else (
    choco install virtualbox -y
)
echo.
pause
goto PROGRAME_DOWNLOAD

:install_all
cls
echo Installing all selected programs...
echo.
call :check_and_install "Google Chrome" "C:\Program Files\Google\Chrome\Application\chrome.exe" "googlechrome"
call :check_and_install "Brave Browser" "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "brave"
call :check_and_install "VLC Media Player" "C:\Program Files\VideoLAN\VLC\vlc.exe" "vlc"
call :check_and_install "Sumatra PDF" "C:\Program Files\SumatraPDF\SumatraPDF.exe" "sumatrapdf"
call :check_and_install "WinRAR" "C:\Program Files\WinRAR\WinRAR.exe" "winrar"
call :check_and_install "Notepad++" "C:\Program Files\Notepad++\notepad++.exe" "notepadplusplus"
call :check_and_install "VirtualBox" "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe" "virtualbox"
echo.
pause
goto PROGRAME_DOWNLOAD

:check_and_install
echo Installing %1...
if exist "%~2" (
    echo  %1 is already installed.
) else (
    choco install %~3 -y
)
echo.
goto :eof

:update_programs
cls
echo Checking if Chocolatey is installed...
where choco >nul 2>&1

if %errorlevel%==0 (
    echo Update Programs...
) else (
    echo.
    echo  Chocolatey is NOT installed
	echo  Try updating your software in other ways.
    timeout /t 2 > nul
    goto PROGRAMS_MENU
)
:: Get programs that need updates
choco outdated > "%temp%\outdated.txt"

:: Check if there are no updates
findstr /R "^$" "%temp%\outdated.txt" >nul && (
    echo All programs are up to date.
    pause
    goto PROGRAMS_MENU
)

:: Display program list
set i=0
for /f "skip=1 tokens=1" %%A in (%temp%\outdated.txt) do (
    set /a i+=1
    set "prog!i!=%%A"
    echo !i!. %%A
)

echo.
set /p choice=Enter the number of the program to update (or press Enter to cancel): 

if not defined choice (
    echo Cancelled.
    pause
    goto PROGRAMS_MENU
)

:: Validate selection
set "selected=!prog%choice%!"
if not defined selected (
    echo Invalid choice.
    pause
    goto :eof
)

:: Update selected program
echo.
echo Updating %selected% ...
choco upgrade %selected% -y
echo.
pause
goto PROGRAMS_MENU


:: Main System Menu
:SYSTEM_MENU
cls
echo.      
echo.            
echo                   ===================================[ TOOLS ]===================================
echo.
echo                    [1] Restore point                                       [2] Registry Backup
echo.
echo                    [3] System Information                                  [4]  Activation 
echo.
echo                                                       [5] Back
echo.  
echo                   ===============================================================================
echo.
set /p choice="Enter your choice (1-6): "
if "%choice%"=="1" goto RESTORE_POINT
if "%choice%"=="2" goto REGISTRY_BACKUP
if "%choice%"=="3" goto SYSTEM_INFO
if "%choice%"=="4" goto ACTIVATE_WINDOWS
if "%choice%"=="5" goto MENU

echo Invalid selection. Please choose a number between (1-5)
pause
goto SYSTEM_MENU

:: =============================================
:: SYSTEM RESTORE POINT CREATION MODULE
:: =============================================
:: This module creates a Windows System Restore Point
:: with proper error handling and verification
:: =============================================
:RESTORE_POINT
cls
echo [*] Verifying System Restore availability...
echo.

:: Check if System Restore is enabled
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR ^| findstr /i "DisableSR"') do (
        if "%%A"=="0x1" (
            echo [*] System Restore is disabled on this system
            echo [*] Please enable it in System Properties 
            pause
            goto SYSTEM_MENU
        )
    )
)

:: Get current date/time for restore point name
for /f "tokens=1-3 delims=/ " %%A in ('date /t') do set "current_date=%%A-%%B-%%C"
for /f "tokens=1-2 delims=: " %%A in ('time /t') do set "current_time=%%A-%%B"
set "restore_point_name=ManualRestore_%current_date%_%current_time%"

:: Create PowerShell script
set "ps_script=%temp%\CreateRestorePoint_%random%.ps1"
(
    echo $ErrorActionPreference = "Stop"
    echo try {
    echo     $description = "%restore_point_name%"
    echo     $result = Checkpoint-Computer -Description $description -RestorePointType "MODIFY_SETTINGS"
    echo     if ($result -ne $null) {
    echo         Write-Host "[*] Restore point created: $description" 
    echo         exit 0
    echo     } else {
    echo         Write-Host "[*] Failed to create restore point" 
    echo         exit 1
    echo     }
    echo } catch {
    echo     Write-Host "[*] $($_.Exception.Message)" 
    echo     exit 1
    echo }
) > "%ps_script%"

:: Execute with proper permissions
echo [*] Creating restore point: %restore_point_name%
powershell -ExecutionPolicy Bypass -NoProfile -File "%ps_script%"

:: Verify result
if %errorlevel% equ 0 (
    echo [*] Restore point created successfully
    echo            Name: %restore_point_name%
) else (
    echo [*] Failed to create restore point
)

:: Cleanup
del "%ps_script%" >nul 2>&1

pause
goto SYSTEM_MENU

:: =============================================
:: COMPLETE REGISTRY BACKUP UTILITY
:: =============================================
:: Creates full backup of all registry hives
:: Backup location: C:\RegistryBackups
:: =============================================

:REGISTRY_BACKUP
cls
echo FULL REGISTRY BACKUP...
echo.
:: Set backup location with timestamp
set "BackupDir=C:\RegistryBackups\%DATE%_%TIME%"
set "BackupDir=%BackupDir:/=-%"
set "BackupDir=%BackupDir::=-%"

:: Create backup directory
mkdir "%BackupDir%" 2>nul || (
    echo [*] Could not create backup directory
    pause
    goto SYSTEM_MENU
)

echo Backing up registry to: %BackupDir%
echo.

:: List of registry hives to backup
set "Hives=HKLM HKCU HKU HKCR HKCC"

:: Backup each hive
for %%H in (%Hives%) do (
    echo - Backing up %%H...
    reg export "%%H" "%BackupDir%\%%H.reg" /y >nul && (
        echo [*] Success
    ) || (
        echo [*] Failed
    )
)

echo.
echo Registry backup finished
echo Location: %BackupDir%
echo.

pause
goto SYSTEM_MENU

:: SECTION: System Information Utility
:: Description: Comprehensive system information gathering tool
:SYSTEM_INFO
cls
echo                    ============================================================
echo                                         SYSTEM INFORMATION 
echo                    ============================================================
echo.
:: ================= BASIC SYSTEM INFO =================
echo Date and Time:
echo           Current Date: %date%
echo           Current Time: %time%
echo.
echo           Computer Name: %COMPUTERNAME%
echo           Current User: %USERNAME%
echo.
:: Get core system information using PowerShell
echo OS Details:
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"System Manufacturer" /C:"System Boot Time" /C:"System Locale"
echo.
:: ================= USER ACCOUNT INFO =================
echo [*] USER ACCOUNT INFORMATION
echo.
echo Administrator Users:
powershell -Command "try { Get-LocalGroupMember -Group 'Administrators' | Format-Table -AutoSize } catch { net localgroup administrators }"
echo.
:: ================= SECURITY LOGS =================
echo [*] SECURITY AND LOGIN HISTORY
echo.
echo Recent Successful Logins:
powershell -Command "try { Get-EventLog -LogName Security -InstanceId 4624 -Newest 10 -ErrorAction Stop | Where-Object { $_.ReplacementStrings[5] -notlike '*$' -and $_.ReplacementStrings[5] -ne 'SYSTEM' -and $_.ReplacementStrings[5] -ne 'ANONYMOUS LOGON' } | ForEach-Object { 'Login: ' + $_.ReplacementStrings[5] + ' on ' + $_.TimeGenerated + ' (Logon Type: ' + $_.ReplacementStrings[8] + ')' } } catch { 'Login history not accessible or empty' }"
echo.
echo Recent Failed Login Attempts:
powershell -Command "try { Get-EventLog -LogName Security -InstanceId 4625 -Newest 5 -ErrorAction Stop | ForEach-Object { 'Failed Login: ' + $_.ReplacementStrings[5] + ' on ' + $_.TimeGenerated + ' from ' + $_.ReplacementStrings[19] } } catch { 'No recent failed login attempts found' }"
echo.
echo Current Active Sessions:
powershell -Command "try { Get-WmiObject -Class Win32_LoggedOnUser | ForEach-Object { $user = ([wmi]$_.Dependent).Name; $domain = ([wmi]$_.Dependent).Domain; if ($user -ne 'SYSTEM' -and $user -ne 'LOCAL SERVICE' -and $user -ne 'NETWORK SERVICE') { 'Active User: ' + $domain + '\' + $user } } } catch { query user }"
echo.
:: ================= SYSTEM HEALTH =================
echo [*] SYSTEM HEALTH STATUS
echo.
echo Uptime:
powershell -Command "$uptime = (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime; 'System Uptime: ' + $uptime.Days + ' days, ' + $uptime.Hours + ' hours, ' + $uptime.Minutes + ' minutes'"
echo.
echo Security Status:
echo Firewall Status:
powershell -Command "$firewall = Get-NetFirewallProfile | Where-Object {$_.Enabled -eq $true}; if ($firewall) { 'Windows Firewall: ENABLED - PROTECTED' } else { 'Windows Firewall: DISABLED - VULNERABLE' }"
echo.
echo Windows Defender Status:
powershell -Command "try { $defender = Get-MpComputerStatus -ErrorAction Stop; if ($defender.AntivirusEnabled) { 'Windows Defender: ENABLED - PROTECTED' } else { 'Windows Defender: DISABLED - VULNERABLE' } } catch { 'Windows Defender: STATUS UNKNOWN' }"
echo.
echo Windows Update Status:
powershell -Command "try { $updates = Get-WindowsUpdate -ErrorAction Stop | Measure-Object; if ($updates.Count -eq 0) { 'Windows Updates: UP TO DATE' } else { 'Windows Updates: ' + $updates.Count + ' UPDATES AVAILABLE' } } catch { $lastUpdate = (Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn; 'Last Update Installed: ' + $lastUpdate }"
echo.
echo Pagefile:
echo.
powershell -Command "try { Get-WmiObject -Class Win32_PageFileUsage | ForEach-Object { 'Pagefile Size: ' + [math]::Round($_.AllocatedBaseSize/1024, 2) + ' GB | Used: ' + [math]::Round($_.CurrentUsage/1024, 2) + ' GB' } } catch { 'Pagefile information not available' }"
echo.
echo Virtualization Status:
echo.
powershell -Command "$cpu = Get-WmiObject -Class Win32_Processor; if ($cpu.VirtualizationFirmwareEnabled -eq $true) { 'Virtualization: ENABLED' } else { 'Virtualization: DISABLED' }"
echo.
:: ================= HARDWARE INFO =================
echo [*] HARDWARE INFORMATION
echo.
echo CPU:
wmic cpu get name
echo.
echo GPU:
wmic path win32_VideoController get name
echo.
echo Memory:
powershell -Command "\$mem = Get-CimInstance Win32_PhysicalMemory; \$totalGB = [math]::Round((\$mem | Measure-Object -Property Capacity -Sum).Sum/1GB, 2); '   Total RAM: ' + \$totalGB + ' GB'"
echo.
echo Battery Status:
powershell -Command "try { $battery = Get-WmiObject -Class Win32_Battery; if ($battery) { 'Battery Level: ' + $battery.EstimatedChargeRemaining + '% | Status: ' + $(if ($battery.BatteryStatus -eq 2) {'Charging'} else {'Not Charging'}) } else { 'No battery detected (Desktop PC)' } } catch { 'Battery information not available' }"
echo.
echo Screen Resolution:
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Size; 'Screen Resolution: ' + $screen.Width + 'x' + $screen.Height"
echo.

:: ===== Hardware Temperatures =====
echo Hardware Temperatures:
echo.

echo CPU Temperature:
powershell -Command "try { $temp = Get-WmiObject -Namespace 'root\wmi' -Class MSAcpi_ThermalZoneTemperature | Select-Object -First 1; if ($temp) { $celsius = [math]::Round(($temp.CurrentTemperature / 10) - 273.15, 1); 'CPU Temperature: ' + $celsius + '°C' } else { 'CPU Temperature: Not available via WMI' } } catch { 'CPU Temperature: Sensor not accessible' }"

echo Alternative CPU Temperature Check:
powershell -Command "try { $cpu = Get-Counter '\Thermal Zone Information(*)\Temperature' -ErrorAction Stop; $temp = ($cpu.CounterSamples | Measure-Object CookedValue -Average).Average; if ($temp -gt 0) { $celsius = [math]::Round($temp - 273.15, 1); 'CPU Temperature: ' + $celsius + '°C' } else { 'CPU Temperature: Not available' } } catch { 'CPU Temperature: Performance counter not available' }"

echo System Temperature Sensors:
powershell -Command "try { Get-WmiObject -Namespace 'root\wmi' -Class MSAcpi_ThermalZoneTemperature | ForEach-Object { $celsius = [math]::Round(($_.CurrentTemperature / 10) - 273.15, 1); 'Thermal Zone: ' + $celsius + '°C' } } catch { 'Thermal sensors: Not accessible via WMI' }"
echo.

:: ================= STORAGE INFO =================
echo [*] STORAGE INFORMATION
echo.
echo Disk Type and Health:
echo.
powershell -Command "try { Get-PhysicalDisk | ForEach-Object { $disk = $_; $health = $disk.HealthStatus; $mediaType = $disk.MediaType; $diskType = switch ($mediaType) { 'SSD' { 'SSD' } 'HDD' { 'HDD' } default { if ($disk.SpindleSpeed -eq 0) { 'SSD' } elseif ($disk.SpindleSpeed -gt 0) { 'HDD' } else { 'Unknown' } } }; 'Disk: ' + $disk.FriendlyName + ' | Type: ' + $diskType + ' | Health: ' + $health } } catch { 'Disk information not available' }"
echo.
echo Disk Drive Information:
wmic logicaldisk get size,freespace,caption,filesystem,description
:: ================= NETWORK INFO =================
echo [*] NETWORK INFORMATION
echo.
echo Network Status:
ping 8.8.8.8 >nul && echo    Internet: CONNECTED || echo    Internet: DISCONNECTED
echo.
echo Network Adapters:
wmic path Win32_NetworkAdapter where "NetConnectionStatus=2" get Name,NetConnectionID,Speed /format:list | findstr /r /v "^$"
echo.
echo Wi-Fi Profiles and Passwords
echo.
:: Loop through each saved Wi-Fi profile
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| find "All User Profile"') do (
call :process_profile "%%i"
)
:process_profile

:: Trim the leading space from the profile name
set "ssid=%~1"
set "ssid=%ssid:~1%"
echo  Profile Name: %ssid%
:: Find the password (Key Content) for the current profile
for /f "tokens=2 delims=:" %%j in ('netsh wlan show profile name^="%ssid%" key^=clear ^| find /I "Key Content"') do (
    echo     Password: %%j
)
:: If a password is not found
if errorlevel 1 (
    echo     Password: No password found or open network
)
echo.
:: ================= SOFTWARE INFO =================
echo [*] SOFTWARE INFORMATION
echo.
echo Startup Programs:
powershell -Command "Get-CimInstance Win32_StartupCommand | Select Name,Command,Location"
echo.
echo All Installed Programs:
powershell -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName} | Sort-Object InstallDate -Descending | Select-Object DisplayName, InstallDate, Publisher | Format-Table -AutoSize"
echo.
:: ================= REPORT OPTIONS =================
:SAVE_MENU
echo.
choice /c YN /n /m "Save report? (Y/N): "

if errorlevel 2 (
    goto SYSTEM_MENU
)
set "reportfile=%USERPROFILE%\Documents\System_Report_%date:/=_%_%time::=_%.log"
(
    :: Repeat all information commands redirecting to file
    call :SYSTEM_INFO
) > "%reportfile%"
echo Report saved to: %reportfile%
pause
goto SYSTEM_MENU


:ACTIVATE_WINDOWS
cls
echo.
echo.
echo                   ===================================[ ACTIVATION ]===================================
echo.
echo                    [1] Activate Windows                                     [2] Activation Status
echo. 
echo                                                         [0]Back
echo.
echo                  =====================================================================================
echo.
set /p act_choice="Select an option: "
if "%act_choice%"=="1" goto RUN_ACTIVATION
if "%act_choice%"=="2" goto CHECK_ACTIVATION
if "%act_choice%"=="0" goto SYSTEM_MENU 

:: Invalid input handler
echo.
echo Invalid selection. Please choose (0-2)
pause
goto ACTIVATE_WINDOWS
:RUN_ACTIVATION
cls
echo Connecting to activation servers...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
pause
goto ACTIVATE_WINDOWS
:CHECK_ACTIVATION
cls
echo Current activation status:
echo.
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /dli
echo.
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /xpr
echo.
echo Current license details:
echo.
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /dlv
echo.
pause
goto ACTIVATE_WINDOWS

:TOOLS_MENU
cls
echo.
echo.                                                              
echo                   ===================================[ TOOLS ]===================================
echo.
echo                    [1] System File Check                                   [2] DISM Tools
echo.  
echo                    [3] Defragment Drive                                    [4] Check Disk 
echo. 
echo                    [5] Memory Diagnostic                                   [6] Run Disk Cleanup
echo.
echo                                                      [0] Back 
echo.
echo                  ================================================================================
echo.
set /p TOOL_CHOICE="Select an option: "

if "%TOOL_CHOICE%"=="1" goto SFC
if "%TOOL_CHOICE%"=="2" goto DISM_MENU
if "%TOOL_CHOICE%"=="3" goto DEFRAG
if "%TOOL_CHOICE%"=="4" goto CHKDSK
if "%TOOL_CHOICE%"=="5" goto MEMORY_DIAG
if "%TOOL_CHOICE%"=="6" goto CLEAN_MGR
if "%TOOL_CHOICE%"=="0" goto MENU

:: Invalid input handler
echo.
echo Invalid selection. Please choose a number between (0-4)
pause
goto TOOLS_MENU


:: System File Checker (SFC) - Scans and repairs system files
:SFC
cls
echo SYSTEM FILE CHECKER (SFC)...
echo.
sfc /scannow
echo.
echo SFC scan completed. Check above for results.
echo.
pause
goto TOOLS_MENU

:DISM_MENU
cls
echo.
echo.
echo                   ===================================[ DISM Tools ]===================================
echo.
echo                    [1] Fix system corruption                              [2] Full Component Cleanup
echo.                    
echo                    [3] Deep check for corruption                          [4] Check Health
echo.
echo                                                      [0] Back
echo.
echo                   ====================================================================================
echo.
set /p DISM_CHOICE="Select an option: " 

if "%DISM_CHOICE%"=="1" goto DISM_RESTORE_HEALTH
if "%DISM_CHOICE%"=="2" goto DISM_CLEANUP
if "%DISM_CHOICE%"=="3" goto DISM_SCANN_HEALTH
if "%DISM_CHOICE%"=="4" goto DISM_CHECK_HEALTH
if "%DISM_CHOICE%"=="0" goto TOOLS_MENU


:: Invalid input handler
echo.
echo Invalid selection. Please choose a number between (0-4)
pause
goto DISM_MENU

:DISM_RESTORE_HEALTH
cls
echo Running: DISM /Online /Cleanup-Image /RestoreHealth
dism /Online /Cleanup-Image /RestoreHealth
echo.
pause
goto DISM_MENU

:DISM_CLEANUP
cls
echo Running: DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo.
pause
goto DISM_MENU

:DISM_SCANN_HEALTH
cls
echo Running: DISM /Online /Cleanup-Image /ScanHealth
dism /Online /Cleanup-Image /ScanHealth
echo.
pause
goto DISM_MENU

:DISM_CHECK_HEALTH
cls
echo Running: DISM /Online /Cleanup-Image /CheckHealth
dism /Online /Cleanup-Image /CheckHealth
echo.
pause
goto DISM_MENU


:DEFRAG
cls
echo Defragmenting hard disks...
echo.
timeout /t 3 >nul
defrag -c -v
if %errorlevel% neq 0 (
    echo Error during disk defragmentation.

)
echo Disk Defrag successful!
echo.
pause
goto TOOLS_MENU

:: Disk Check Utility - Checks and repairs disk errors
:CHKDSK
cls
echo Available drives on your system:
echo.
wmic logicaldisk get size,freespace,caption
echo.


:CHOOSE_DRIVE
set /p drive="Enter drive letter to check (e.g., C): "
:: Validate drive letter input
    if not exist %drive%:\ (
        echo Invalid drive letter. Please try again.
        goto CHOOSE_DRIVE
    )
echo.
echo This will schedule a disk check for the next restart.
echo The system will restart automatically to perform this check.
echo.
set /p confirm="Are you sure you want to continue? (Y/N): "
    
if /i "!confirm!"=="Y" (
        echo Scheduling disk check for drive %drive%...
        chkdsk %drive%: /f /r /x
        echo.
        echo Disk check scheduled. Please restart your computer.
    ) else (
        goto TOOLS_MENU
    )
pause
goto TOOLS_MENU

:: Windows Memory Diagnostic Tool
:MEMORY_DIAG
cls
echo This will schedule a memory test on next restart.
echo Your computer will restart automatically.
echo.
set /p confirm="Are you sure you want to continue? (Y/N): "
    
    if /i "!confirm!"=="Y" (
        echo Scheduling memory diagnostic...
        mdsched.exe
        echo.
        echo Memory diagnostic scheduled. Please restart your computer.
    ) else (
        goto TOOLS_MENU
    )
pause
goto TOOLS_MENU

:CLEAN_MGR
cls
echo Launching Disk Cleanup Utility...
cleanmgr
pause
goto TOOLS_MENU

:OpenEventViewer
cls
echo Opening Event Viewer...
eventvwr
goto TOOLS_MENU


:: ======================
:: SCRIPT EXIT
:: ======================
:EXIT_SCRIPT
cls
echo.
echo Thank you for using Tweak - Windows Optimization Tool
timeout /t 3 >nul
exit
