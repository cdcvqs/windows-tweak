@echo off
:: ========================================================
:: Tweak - Windows Optimization Tool
:: Version: 1.0
:: Description: Batch script for Windows system optimization
:: ========================================================

:: Initialize script settings
setlocal enabledelayedexpansion
title Tweak - Windows Optimization Tool

:: ======================
:: Script main menu                         
:: ======================
:MENU
cls
echo.
echo                    ========================[ MENU ]=======================
echo                 [1] Performance                            [2] Privacy/Security   
echo                 [3] Network                                [4] Programs 
echo                 [5] Customization                          [6] System
echo                                          [7] Exit                     
echo                    ========================================================

:: Get user input
set /p choice="Select an option: " 

:: Process main menu selection 
if "%choice%"=="1" goto PERFORMANCE_MENU
if "%choice%"=="2" goto PRIVACY_SECRUTY_MENU
if "%choice%"=="3" goto NETWORK_MENU
if "%choice%"=="4" goto INSTALL_PROGRAMS
if "%choice%"=="5" goto CUSTOMIZATION_MENU
if "%choice%"=="6" goto SYSTEM_MENU
if "%choice%"=="7" goto EXIT_SCRIPT

:: Invalid selection handling
echo.
echo Invalid selection. Please choose a number between (1-7)
pause
goto MENU


:: =============================================================
:: SECTION: PERFORMANCE MENU
:: DESCRIPTION: This section helps improve the performance of Windows.
:: =============================================================
:PERFORMANCE_MENU
cls
echo.
echo               =================[ PERFORMANCE SETTINGS ]=================
echo             [1] Services tweaks                     [4] Speed up boot
echo             [2] Scheduler task tweaks               [5] visual effects
echo             [3] Clean up                            [6] Power plan
echo                                       [7] Back 
echo               ==========================================================

:: Get user input with validation
set /p perchoice="Select an option: " 

:: Process performance menu selection
if "%perchoice%"=="1" goto SERVICES_TWEAKS_MENU
if "%perchoice%"=="2" goto PERF_SCHEDULER_TWEAKS
if "%perchoice%"=="3" goto PERF_CLEAN
if "%perchoice%"=="4" goto BOOT_OPTIMIZE
if "%perchoice%"=="5" goto Perf_Disable_Visual_Effects
if "%perchoice%"=="6" goto Perf_PowerPlan
if "%perchoice%"=="7" goto MENU

:: Invalid selection handling
echo.
echo Invalid selection. Please choose a number between (1-7)
pause
goto PERFORMANCE_MENU

:: ======================
:: Configure Windows Services
:: ======================
:SERVICES_TWEAKS_MENU
cls
echo.
echo               ===============[ SERVICES TWEAKS ]===============
echo.
echo             [1] Service Tweaks
echo             [2] Default Service Settings
echo             [3] Back 
echo.
echo               =================================================

:: Get user input with validation
set /p svcChoice="Select an option:"

:: Process services menu selection
if "%svcChoice%"=="1" goto APPLY_SERVICE_TWEAKS
if "%svcChoice%"=="2" goto RESTORE_SERVICES
if "%svcChoice%"=="3" goto PERFORMANCE_MENU

:: Invalid selection handling
echo.
echo Invalid selection. Please choose a number between (1-3)
pause
goto SERVICES_TWEAKS_MENU


:: ========================================================
:: Set some Windows services to startup (manual/disable)
:: ========================================================
:APPLY_SERVICE_TWEAKS
cls
echo Applying Services Tweaks...            
echo.

:: Services lists for manual startup
set "ManualServices=AppIDSvc AppReadiness AppVClient Appinfo AssignedAccessManagerSvc AxInstSV BDESVC BFE BITS BcastDVRUserService BluetoothUserService BrokerInfrastructure Browser BthAvctpSvc BthHFSrv CDPUserSvc COMSysApp CaptureService CertPropSvc ConsentUxUserSvc CoreMessagingRegistrar CredentialEnrollmentManagerUserSvc CryptSvc DPS DcomLaunch DcpSvc DevQueryBroker DeviceAssociationBrokerSvc DeviceAssociationService DeviceInstall DevicePickerUserSvc DevicesFlowUserSvc DialogBlockingService DispBrokerDesktopSvc DmEnrollmentSvc DsSvc DsmSvc EapHost EventLog EventSystem FontCache FrameServer FrameServerMonitor GraphicsPerfSvc HvHost IEEtwCollectorService IKEEXT InventorySvc IpxlatCfgSvc KeyIso KtmRm LSM LanmanWorkstation LicenseManager LxpSvc MSDTC MSiSCSI McpManagementService MpsSvc MsKeyboardFilter NPSMSvc NcaSvc NcbService NcdAutoSetup NetSetupSvc NetTcpPortSharing Netlogon Netman NlaSvc OneSyncSvc P9RdrService PNRPAutoReg PNRPsvc PenService PerfHost PimIndexMaintenanceSvc PolicyAgent Power PrintWorkflowUserSvc ProfSvc PushToInstall RasAuto RasMan RemoteAccess SDRSVC SENS SNMPTRAP SamSs Schedule SecurityHealthService Sense SgrmBroker SharedAccess SharedRealitySvc ShellHWDetection SstpSvc StateRepository StiSvc SystemEventsBroker TermService TextInputManagementService Themes TimeBroker TimeBrokerSvc TroubleshootingSvc TrustedInstaller UI0Detect UdkUserSvc UnistoreSvc UserDataSvc UserManager UsoSvc VGAuthService VMTools VSS VacSvc autotimesvc cbdhsvc cloudidsvc dcsvc defragsvc diagnosticshub.standardcollector.service dot3svc edgeupdate edgeupdatem embeddedmode gpsvc hidserv icssvc iphlpsvc lltdsvc mpssvc msiserver netprofm nsi p2pimsvc p2psvc perceptionsimulation seclogon smphost spectrum sppsvc ssh-agent svsvc swprv tiledatamodelsvc uhssvc upnphost vds vm3dservice vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss webthreatdefsvc webthreatdefusersvc wercplsupport wisvc wlpasvc wmiApSrv workfolderssvc wscsvc wuauserv wudfsvc"

:: Services lists for disable startup
set "DisabledServices=AJRouter camsvc lmhosts NgcSvc NgcCtnrSvc ALG AppMgmt SSDPSRV StateRepository wlidsvc BTAGService AppXSVC InstallService WinHttpAutoProxySvc TokenBroker bthserv cbdhsvc_26c34 CDPSvc ClipSVC WpnUserService_26c34 LanmanServer CscService diagsvc DiagTrack dmwappushservice DoSvc MapsBroker DusmSvc EFS EntAppSvc Fax fdPHost FDResPub fhsvc HomeGroupListener HomeGroupProvider lfsvc NaturalAuthentication PcaSvc PeerDistSvc PhoneSvc pla PrintNotify QWAVE RemoteRegistry RetailDemo RmSvc RpcLocator ScDeviceEnum DisplayEnhancementService SCPolicySvc SEMgrSvc SensorDataService SensorService SensrSvc SessionEnv shpamsvc SCardSvr SmsRouter Spooler SysMain TabletInputService TapiSrv TieringEngineService TrkWks tzautoupdate UmRdpService UevAgentService VaultSvc W32Time WalletService wbengine WbioSrvc WebClient Wecsvc StorSvc WEPHOSTSVC WerSvc WFDSConMgrSvc wcncsvc WdiServiceHost WdiSystemHost WMPNetworkSvc WPDBusEnum WpnService WSearch WwanSvc xbgm XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc"

:: Combined list for state counting
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
set "final_auto=0"
set "final_manual=0"
set "final_disabled=0"


:: Count initial service states
for %%S in (%AllServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do (
            if "%%T"=="2" set /a initial_auto+=1
            if "%%T"=="3" set /a initial_manual+=1
            if "%%T"=="4" set /a initial_disabled+=1
        )
    )
)

:: Set services to manual startup
echo services to manual startup...
for %%S in (%ManualServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        sc config "%%S" start= demand >nul 2>&1 && (
            set /a success_manual+=1
        ) || (
            set /a failed_manual+=1
        )
    ) || (
        set /a not_found_manual+=1
    )
)

:: Disable specified services
echo.
echo Unnecessary services to disable startup...
for %%S in (%DisabledServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        sc config "%%S" start= disabled >nul 2>&1 && (
            set /a success_disabled+=1
        ) || (
            set /a failed_disabled+=1
        )
    ) || (
        set /a not_found_disabled+=1
    )
)

:: Count final service states
for %%S in (%AllServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do (
            if "%%T"=="2" set /a final_auto+=1
            if "%%T"=="3" set /a final_manual+=1
            if "%%T"=="4" set /a final_disabled+=1
        )
    )
)

:: Calculate totals
set /a total_success = success_manual + success_disabled
set /a total_failed = failed_manual + failed_disabled
set /a total_not_found = not_found_manual + not_found_disabled
set /a change_to_no_automatic = initial_auto - final_auto
set /a change_to_manual = initial_manual - final_manual
set /a change_to_disabled = final_disabled - initial_disabled
:: Final Report
cls
echo.
echo               ========================
echo                  FINAL REPORT
echo               ========================
echo  Service Type       Before    After    Changed
echo  -------------------------------------------------
echo Automatic:         %initial_auto%        %final_auto%        %change_to_no_automatic%     
echo Manual   :         %initial_manual%       %final_manual%       %change_to_manual%
echo Disabled :         %initial_disabled%        %final_disabled%        %change_to_disabled%
echo.
echo Configer :   %total_success%
echo Failed   :   %total_failed%
echo Not Found:   %total_not_found%
echo.
pause
goto SERVICES_TWEAKS_MENU

:: ========================================================
:: Set Windows services to default
:: ========================================================
:RESTORE_SERVICES
cls
echo Restoring Default Service Settings...
echo.

:: Services that should be set to automatic startup
set "auto_services=AppHostSvc AudioEndpointBuilder Audiosrv BFE BITS BrokerInfrastructure CoreMessagingRegistrar CryptSvc DcomLaunch Dhcp DiagTrack Dnscache DoSvc DPS EventLog EventSystem FontCache ftpsvc gpsvc HomeGroupListener HomeGroupProvider HvHost iphlpsvc iprip LanmanServer LanmanWorkstation LPDSVC LSM MapsBroker MpsSvc MSMQ MSMQTriggers Netlogon NetMsmqActivator NetPipeActivator NetTcpActivator NlaSvc nsi PcaSvc Power ProfSvc RpcEptMapper RpcSs SamSs Schedule SENS ShellHWDetection simptcp SNMP Spooler sppsvc SysMain SystemEventsBroker TabletInputService TermService Themes tiledatamodelsvc TrkWks UserManager vmms W32Time W3SVC Wcmsvc WinDefend Winmgmt WlanSvc WMPNetworkSvc Wms WmsRepair wscsvc WSearch WwanSvc"

:: Services that should be set to manual startup
set "manual_services=AJRouter ALG AppIDSvc Appinfo AppMgmt AppReadiness AppXSvc aspnet_state AxInstSV BDESVC Browser BthHFSrv bthserv c2wts CDPSvc CertPropSvc ClipSVC COMSysApp CscService DcpSvc defragsvc DeviceInstall DevQueryBroker diagnosticshub.standardcollector.service dot3svc DsmSvc DsRoleSvc DsSvc Eaphost EFS embeddedmode EntAppSvc Fax fdPHost FDResPub fhsvc FontCache3.0.0.0 hidserv icssvc IEEtwCollectorService IKEEXT KeyIso KtmRm lfsvc LicenseManager lltdsvc lmhosts MSDTC MSiSCSI msiserver NcaSvc NcbService NcdAutoSetup Netman netprofm NetSetupSvc NetTcpPortSharing NgcCtnrSvc NgcSvc p2pimsvc p2psvc PeerDistSvc PerfHost pla PlugPlay PNRPAutoReg PNRPsvc PolicyAgent PrintNotify QWAVE RasAuto RasMan RetailDemo RpcLocator SCPolicySvc SDRSVC seclogon SensorDataService SensorService SensrSvc SessionEnv SharedAccess smphost SmsRouter SNMPTRAP sppsvc SSDPSRV SstpSvc StateRepository stisvc StorSvc svsvc swprv TapiSrv TimeBroker TrustedInstaller UI0Detect UmRdpService upnphost UsoSvc VaultSvc vds vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss VSS w3logsvc WalletService WAS wbengine WbioSrv wcncsvc WcsPlugInService WdiServiceHost WdiSystemHost WdNisSvc WebClient Wecsvc WEPHOSTSVC wercplsupport WerSvc WiaRpc WinRM wlidsvc wmiApSrv WMSVC workfolderssvc WPDBusEnum WpnService WSService wuauserv wudfsvc XblAuthManager XblGameSave XboxNetApiSvc"

:: Services that should be disabled
set "disabled_services=RemoteAccess RemoteRegistry SCardSvr"

:: Initialize counters
set /a total_success=0
set /a total_failed=0
set /a total_not_found=0

:: Configure automatic services
for %%s in (%auto_services%) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc config "%%s" start= auto >nul 2>&1
        if !errorlevel! equ 0 (
            set /a total_success+=1
        ) else (
            set /a total_failed+=1
        )
    ) else (
        set /a total_not_found+=1
    )
)

:: Configure manual services
for %%s in (%manual_services%) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc config "%%s" start= demand >nul 2>&1
        if !errorlevel! equ 0 (
            set /a total_success+=1
        ) else (
            set /a total_failed+=1
        )
    ) else (
        set /a total_not_found+=1
    )
)

:: Configure disabled services
for %%s in (%disabled_services%) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc stop "%%s" >nul 2>&1
        timeout /t 2 >nul
        sc config "%%s" start= disabled >nul 2>&1
        if !errorlevel! equ 0 (
            set /a total_success+=1
        ) else (
            set /a total_failed+=1
        )
    ) else (
        set /a total_not_found+=1
    )
)

:: Final Summary Report
cls
echo.
echo ========================================================
echo             SERVICE CONFIGURATION REPORT
echo ========================================================
echo Configured: %total_success%
echo Failed    : %total_failed%
echo Not Found : %total_not_found%
echo ========================================================
echo.
pause
goto SERVICES_TWEAKS_MENU


:: ========================================================
:: Disable unnecessary scheduled tasks
:: ========================================================
:PERF_SCHEDULER_TWEAKS
cls
echo.
echo  Scheduled Tasks tweaks...
echo.

:: Initialize counters
set /a total_tasks=0
set /a disabled_success=0
set /a disabled_failed=0
set /a not_found=0

:: List of all tasks to disable
set "tasks="
set tasks=%tasks% "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
set tasks=%tasks% "Microsoft\Windows\Application Experience\PcaPatchDbTask"
set tasks=%tasks% "Microsoft\Windows\Application Experience\ProgramDataUpdater"
set tasks=%tasks% "Microsoft\Windows\Application Experience\StartupAppTask"
set tasks=%tasks% "Microsoft\Windows\Application Experience\AitAgent"
set tasks=%tasks% "Microsoft\Windows\AppCompat\PT"
set tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
set tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
set tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
set tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
set tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\Uploader"
set tasks=%tasks% "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask"
set tasks=%tasks% "Microsoft\Windows\PI\Sqm-Tasks"
set tasks=%tasks% "Microsoft\Windows\Feedback\Siuf\DmClient"
set tasks=%tasks% "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
set tasks=%tasks% "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures"
set tasks=%tasks% "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing"
set tasks=%tasks% "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting"
set tasks=%tasks% "Microsoft\Windows\Flighting\OneSettings\RefreshCache"
set tasks=%tasks% "Microsoft\Windows\Device Information\Device"
set tasks=%tasks% "Microsoft\Windows\Device Information\Device User"
set tasks=%tasks% "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
set tasks=%tasks% "Microsoft\Windows\DiskFootprint\Diagnostics"
set tasks=%tasks% "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
set tasks=%tasks% "Microsoft\Windows\Power Efficiency Diagnostics\EnergyEstimation"
set tasks=%tasks% "Microsoft\Windows\WDI\ResolutionHost"
set tasks=%tasks% "Microsoft\Windows\Diagnosis\Scheduled"
set tasks=%tasks% "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
set tasks=%tasks% "Microsoft\Windows\NetTrace\GatherNetworkInfo"
set tasks=%tasks% "Microsoft\Windows\WwanSvc\NotificationTask"
set tasks=%tasks% "Microsoft\Windows\WwanSvc\OobeDiscovery"
set tasks=%tasks% "Microsoft\Windows\NlaSvc\WiFiTask"
set tasks=%tasks% "Microsoft\Windows\WCM\WiFiTask"
set tasks=%tasks% "Microsoft\Windows\WLANReport\WLANReportTask"
set tasks=%tasks% "Microsoft\Windows\Maps\MapsToastTask"
set tasks=%tasks% "Microsoft\Windows\Maps\MapsUpdateTask"
set tasks=%tasks% "Microsoft\Windows\Location\Notifications"
set tasks=%tasks% "Microsoft\Windows\Location\WindowsActionDialog"
set tasks=%tasks% "Microsoft\Windows\Location\LocationNotification"
set tasks=%tasks% "Microsoft\Windows\Location\SensorOverAcl"
set tasks=%tasks% "Microsoft\Windows\Input\LocalUserSyncDataAvailable"
set tasks=%tasks% "Microsoft\Windows\Input\MouseSyncDataAvailable"
set tasks=%tasks% "Microsoft\Windows\Input\PenSyncDataAvailable"
set tasks=%tasks% "Microsoft\Windows\Input\TouchpadSyncDataAvailable"
set tasks=%tasks% "Microsoft\Windows\Input\InputSettingsRestoreDataAvailable"
set tasks=%tasks% "Microsoft\Windows\Input\syncpensettings"
set tasks=%tasks% "Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
set tasks=%tasks% "Microsoft\Windows\OOBE\BackgroundUserTask"
set tasks=%tasks% "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask"
set tasks=%tasks% "Microsoft\Windows\EnterpriseMgmt\Schedule"
set tasks=%tasks% "Microsoft\Windows\EnterpriseMgmt\SyncML"
set tasks=%tasks% "Microsoft\Windows\Management\Provisioning\Cellular"
set tasks=%tasks% "Microsoft\Windows\Management\Provisioning\Logon"
set tasks=%tasks% "Microsoft\Windows\PushToInstall\Registration"
set tasks=%tasks% "Microsoft\Windows\PushToInstall\LoginCheck"
set tasks=%tasks% "Microsoft\Windows\SettingSync\NetworkStateChangeTask"
set tasks=%tasks% "Microsoft\Windows\User Profile Service\HiveUploadTask"
set tasks=%tasks% "Microsoft\Windows\Workplace Join\Automatic-Device-Join"
set tasks=%tasks% "Microsoft\Windows\International\Synchronize Language Settings"
set tasks=%tasks% "Microsoft\Windows\LanguageComponentsInstaller\Installation"
set tasks=%tasks% "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
set tasks=%tasks% "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation"
set tasks=%tasks% "Microsoft\Windows\MUI\LPRemove"
set tasks=%tasks% "Microsoft\Windows\Autochk\Proxy"
set tasks=%tasks% "Microsoft\Windows\DiskCleanup\SilentCleanup"
set tasks=%tasks% "Microsoft\Windows\DUSM\dusmtask"
set tasks=%tasks% "Microsoft\Windows\Servicing\StartComponentCleanup"
set tasks=%tasks% "Microsoft\Windows\Setup\SetupCleanupTask"
set tasks=%tasks% "Microsoft\Windows\Setup\SnapshotCleanupTask"
set tasks=%tasks% "Microsoft\Windows\Sysmain\ResPriStaticDbSync"
set tasks=%tasks% "Microsoft\Windows\Sysmain\WsSwapAssessmentTask"
set tasks=%tasks% "Microsoft\Windows\WOF\WIM-Hash-Management"
set tasks=%tasks% "Microsoft\Windows\WOF\WIM-Hash-Validation"
set tasks=%tasks% "Microsoft\Windows\Camera\CameraAcquireSensorData"
set tasks=%tasks% "Microsoft\Windows\Camera\CameraFirstSensor"
set tasks=%tasks% "Microsoft\Windows\Camera\CameraBackgroundTask"
set tasks=%tasks% "Microsoft\Windows\Sensor\SensorDataServiceStartupTask"
set tasks=%tasks% "Microsoft\Windows\Sensor\SensorServiceStartupTask"
set tasks=%tasks% "Microsoft\Windows\TPM\Tpm-HASCertRetr"
set tasks=%tasks% "Microsoft\Windows\TPM\Tpm-Maintenance"
set tasks=%tasks% "Microsoft\XblGameSave\XblGameSaveTask"
set tasks=%tasks% "Microsoft\XblGameSave\XblGameSaveTaskLogon"
set tasks=%tasks% "Microsoft\Windows\Task Manager\Interactive"
set tasks=%tasks% "Microsoft\Windows\UPnP\UPnPHostConfig"
set tasks=%tasks% "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
set tasks=%tasks% "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE"
set tasks=%tasks% "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization"
set tasks=%tasks% "Microsoft\Windows\Work Folders\Work Folders Maintenance Work"
set tasks=%tasks% "Microsoft\Windows\Windows Error Reporting\QueueReporting"

:: Loop through and process each task
for %%T in (%tasks%) do (
    set /a total_tasks+=1
    schtasks /query /TN %%~T >nul 2>&1
    if !errorlevel! equ 0 (
        schtasks /change /tn %%~T /disable >nul 2>&1
        if !errorlevel! equ 0 (
            set /a disabled_success+=1
        ) else (
            set /a disabled_failed+=1
        )
    ) else (
        set /a not_found+=1
    )
)

:: Final report
echo.
echo ========================================================
echo               TASK OPTIMIZATION REPORT
echo ========================================================
echo Configured    : %disabled_success%
echo Failed        : %disabled_failed%
echo Not Found     : %not_found%
echo ========================================================
echo.
pause
goto PERFORMANCE_MENU

:: ========================================================
:: System cleanup utility
:: ========================================================
:PERF_CLEAN
cls
echo.
echo Cleaning temporary files              
echo.

:: User temp files cleanup
if exist "%TEMP%" (
    echo Cleaning User Temp Files...
    del /q /f /s "%TEMP%\*.*" >nul 2>&1
    for /d %%d in ("%TEMP%\*") do rd /s /q "%%d" >nul 2>&1
)

:: System temp files cleanup
if exist "%WINDIR%\Temp" (
    echo Cleaning System Temp Files...
    del /q /f /s "%WINDIR%\Temp\*.*" >nul 2>&1
    for /d %%d in ("%WINDIR%\Temp\*") do rd /s /q "%%d" >nul 2>&1
)

:: Prefetch files cleanup
if exist "%WINDIR%\Prefetch" (
    echo Cleaning Prefetch files...
    del /q /f "%WINDIR%\Prefetch\*.pf" >nul 2>&1
)

:: System logs cleanup
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

:: Clean Windows Installer temp files
if exist "%WINDIR%\Installer" (
    echo Cleaning Windows Installer temp files...
    del /q /f /s "%WINDIR%\Installer\*.tmp" >nul 2>&1
)

:: Crash dumps and SleepStudy cleanup
if exist "%SystemRoot%\Minidump" (
    echo Cleaning crash dumps...
    rd /s /q "%SystemRoot%\Minidump" >nul 2>&1
)

if exist "%SystemRoot%\System32\SleepStudy" (
    echo Cleaning SleepStudy data...
    rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
)

:: Recent files cleanup
if exist "%APPDATA%\Microsoft\Windows\Recent" (
    echo Cleaning Recent Files...
    del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
    for /d %%d in ("%APPDATA%\Microsoft\Windows\Recent\*") do rd /s /q "%%d" >nul 2>&1
)

:: SYSTEM CACHE CLEANUP
echo.
echo Cleaning system cache...

:: Windows Update cache cleanup
if exist "%WINDIR%\SoftwareDistribution\Download" (
    echo Cleaning Windows Update cache...
    rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
)

:: Windows installation leftovers cleanup
for %%X in ($GetCurrent $SysReset $Windows.~BT $Windows.~WS $WinREAgent) do (
    if exist "%SystemDrive%\%%X" (
        echo Removing Windows installation folder: %%X...
        rd /s /q "%SystemDrive%\%%X" >nul 2>&1
    )
)

:: Windows.old folder cleanup
if exist "%SystemDrive%\Windows.old" (
    echo Removing Windows.old folder...
    takeown /f "%SystemDrive%\Windows.old" /r /d y >nul 2>&1
    icacls "%SystemDrive%\Windows.old" /grant administrators:F /t >nul 2>&1
    rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
)

::  BROWSER DATA CLEANUP
echo.
echo Cleaning browser cache

:: Chrome cache cleanup
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

:: Chrome crash reports cleanup
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" (
    echo Cleaning Chrome Crash Reports...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Google\CrashReports" (
    echo Cleaning Google Crash Reports...
    rd /s /q "%LOCALAPPDATA%\Google\CrashReports" >nul 2>&1
)

:: Brave cache cleanup
if exist "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache" (
    echo Cleaning Brave Cache...
    rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache" >nul 2>&1
)

if exist "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache2" (
    echo Cleaning Brave Cache2...
    rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache2" >nul 2>&1
)

:: SYSTEM LOGS AND REPORTS
echo.
echo Cleaning system log...
echo.

:: Windows Error Reports cleanup
if exist "%LOCALAPPDATA%\Microsoft\Windows\WER" (
    echo Cleaning Windows Error Reports...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER" >nul 2>&1
)

if exist "%PROGRAMDATA%\Microsoft\Windows\WER" (
    echo Cleaning System Error Reports...
    rd /s /q "%PROGRAMDATA%\Microsoft\Windows\WER" >nul 2>&1
)

:: WinSAT performance logs cleanup
if exist "%SystemRoot%\Performance\WinSAT" (
    echo Cleaning WinSAT Logs...
    rd /s /q "%SystemRoot%\Performance\WinSAT" >nul 2>&1
)

:: Clear Windows Event Logs
echo Clearing Windows Event Logs...
for /f "tokens=*" %%G in ('wevtutil el') do (
    wevtutil cl "%%G" >nul 2>&1
)

:: PHASE 6: ENHANCED CLEANUP FEATURES
echo.
echo Advanced cleanup... 

:: Internet cache cleanup
if exist "%LOCALAPPDATA%\Microsoft\Windows\INetCache" (
    echo Cleaning Internet Cache...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\INetCache" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Microsoft\Windows\INetCookies" (
    echo Cleaning Internet Cookies...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\INetCookies" >nul 2>&1
)

:: Windows Defender cleanup
if exist "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History" (
    echo Cleaning Windows Defender logs...
    forfiles /p "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History" /s /c "cmd /c if @isdir==TRUE rd /s /q @path" >nul 2>&1
)

if exist "%PROGRAMDATA%\Microsoft\Windows Defender\Quarantine" (
    echo Cleaning old Defender quarantine files...
    forfiles /p "%PROGRAMDATA%\Microsoft\Windows Defender\Quarantine" /m *.* /d -30 /c "cmd /c del /q @path" >nul 2>&1
)

:: Windows Update data cleanup
if exist "%WINDIR%\SoftwareDistribution\DataStore" (
    echo Cleaning Windows Update data...
    del /q /f /s "%WINDIR%\SoftwareDistribution\DataStore\*.*" >nul 2>&1
)

if exist "%WINDIR%\WindowsUpdate.log" (
    echo Removing WindowsUpdate.log...
    del /q /f "%WINDIR%\WindowsUpdate.log" >nul 2>&1
)

:: Prefetch files cleanup (older than 30 days)
if exist "%WINDIR%\Prefetch" (
    echo Cleaning old Prefetch files...
    forfiles /p "%WINDIR%\Prefetch" /m *.pf /d -30 /c "cmd /c del /q @path" >nul 2>&1
)

:: ReadyBoost cleanup
if exist "%SystemRoot%\System32\ReadyBoost" (
    echo Cleaning ReadyBoost Cache...
    rd /s /q "%SystemRoot%\System32\ReadyBoost" >nul 2>&1
)

:: Services cache cleanup
if exist "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache" (
    echo Cleaning Services Cache...
    rd /s /q "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache" >nul 2>&1
)

:: Indexing temporary files cleanup
if exist "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows" (
    echo Cleaning indexing temp files...
    del /q /f /s "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\*.log" >nul 2>&1
)

:: Windows Store cache cleanup
if exist "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache" (
    echo Cleaning Windows Store cache...
    del /q /f /s "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*.*" >nul 2>&1
)

if exist "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\TempState" (
    echo Cleaning Windows Store temp files...
    del /q /f /s "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\TempState\*.*" >nul 2>&1
)

:: Clean other Store apps caches
for /d %%d in ("%LOCALAPPDATA%\Packages\*") do (
    if exist "%%d\LocalCache" (
        del /q /f /s "%%d\LocalCache\*.*" >nul 2>&1
    )
    if exist "%%d\TempState" (
        del /q /f /s "%%d\TempState\*.*" >nul 2>&1
    )
)

:: Thumbnail cache cleanup
if exist "%LOCALAPPDATA%\Microsoft\Windows\Explorer" (
    echo Cleaning thumbnail cache...
    del /q /f "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1
)

:: Font cache cleanup
if exist "%WINDIR%\System32\FNTCACHE.DAT" (
    echo Cleaning font cache...
    del /q /f "%WINDIR%\System32\FNTCACHE.DAT" >nul 2>&1
)

:: Media Player cache cleanup
if exist "%LOCALAPPDATA%\Microsoft\Media Player" (
    echo Cleaning Media Player Cache...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Media Player" >nul 2>&1
)

:: Office cache cleanup
if exist "%LOCALAPPDATA%\Microsoft\Office" (
    echo Cleaning Office cache...
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Office\*.tmp" >nul 2>&1
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Office\*Cache*" >nul 2>&1
)

echo.
echo Final cleanup...
:: Empty Recycle Bin
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force -Confirm:$false" >nul 2>&1

:: Prompt for Disk Cleanup
:PROMPT_CLEANUP
choice /C YN /N /M "Run Disk Cleanup? (Y/N): "
if %errorlevel% equ 1 (
    echo Running Disk Cleanup...
    cleanmgr /sagerun:1
)
if %errorlevel% equ 2 (
    goto PERFORMANCE_MENU
)

:BOOT_OPTIMIZE
cls
:: Set boot menu timeout to 0 seconds (instant boot)
bcdedit /timeout 0 >nul 2>&1

:: Enable legacy boot menu (useful for F8 safe mode)
bcdedit /set {current} bootmenupolicy legacy >nul 2>&1

:: Disable login startup delay (serialize startup apps)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul

:: Speed up context menu display
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul

:: Disable "Frequent folders" in Explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f >nul

:: Disable hibernation to save disk space (if not used)
powercfg -h off >nul

:: Disable auto-restart after updates
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableAutomaticRestartSignOn /t REG_DWORD /d 1 /f >nul

:: Safely clear startup entries without deleting the Run keys
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1

:: Delete startup shortcuts (if they exist)
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" (
    del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" >nul 2>&1
)

if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\" (
    del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" >nul 2>&1
)

echo.
echo All boot optimizations applied successfully.
pause
goto PERFORMANCE_MENU

:: ===========================================
:: Visual Effects Optimization Script
:: ===========================================

:Perf_Disable_Visual_Effects
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


:: ===========================================
:: Power Plan Configuration Menu
:: ===========================================
:Perf_PowerPlan
cls
echo ===========================================
echo      WINDOWS POWER PLAN MANAGER
echo ===========================================
echo.
echo [1] High Performance
echo [2] Power Saver
echo [3] Ultimate Performance
echo [4] Balanced
echo [5] Back
echo.
set /p powchoice="Select an option:"

:: Validate input and jump to selected option
if /I "%powchoice%"=="1" goto Plan_High
if /I "%powchoice%"=="2" goto Plan_Saver
if /I "%powchoice%"=="3" goto Plan_Ultimate
if /I "%powchoice%"=="4" goto Plan_Balanced
if /I "%powchoice%"=="5" goto PERFORMANCE_MENU

:: Handle invalid input
echo.
echo Invalid selection. Please choose a number between (1-5)
pause
goto Perf_PowerPlan

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



:: =============================================================
:: SECTION: PRIVACY & SECURITY MENU
:: DESCRIPTION: This section helps enhance privacy and secure Windows.
:: =============================================================
:PRIVACY_SECRUTY_MENU
cls
echo ===========================================
echo      PRIVACY AND SECURITY CENTER
echo ===========================================
echo.
echo [1] Disable Telemetry 
echo [2] Disable  Windows Updates
echo [3] Disable Some App Access to Internet
echo [4] Disable Windows Defender
echo [5] Enhance Network Security
echo [6] Privacy Cleanup Tool
echo [7] Back
echo.
echo ===========================================
set /p priChoice="Select an option:"

:: Validate input and jump to selected option
if "%priChoice%"=="1" goto Disable_Telemetry
if "%priChoice%"=="2" goto Disable_Updates
if "%priChoice%"=="3" goto Block_App_Access
if "%priChoice%"=="4" goto Defender_Manager
if "%priChoice%"=="5" goto Network_Security
if "%priChoice%"=="6" goto Privacycleanup
if "%priChoice%"=="7" goto MENU

:: Handle invalid input
echo.
echo Invalid selection. Please choose a number between
pause
goto PRIVACY_SECRUTY_MENU

:: ================================
:: Advanced Telemetry Disabler
:: ================================
:Disable_Telemetry
cls
echo ================================
echo    DISABLING TELEMETRY FEATURES
echo ================================
echo.

:: ----- Windows Settings -----
echo [Step 1/5] Configuring Windows Settings...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: ----- Core Services -----
echo [Step 2/5] Stopping Telemetry Services...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config diagnosticshub.standardcollector.service start= disabled >nul 2>&1

:: ----- Diagnostic Logs -----
echo [Step 3/5] Disabling Diagnostic Logging...
set "regExport=%TEMP%\Diagtrack.reg"
set "regModified=%TEMP%\DiagtrackMod.reg"
reg export "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" "%regExport%" /y >nul 2>&1
powershell -Command "(Get-Content '%regExport%') -replace '\"Enabled\"=dword:00000001','\"Enabled\"=dword:00000000' | Set-Content '%regModified%'" >nul 2>&1
reg import "%regModified%" >nul 2>&1
del "%regExport%" "%regModified%" >nul 2>&1

:: Clear ETL logs
if exist "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\" del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\*.etl" >nul 2>&1
if exist "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\" del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\*.etl" >nul 2>&1

:: ----- Scheduled Tasks -----
echo [Step 4/5] Disabling Telemetry Tasks...
for %%T in (Compat ProgramDataUpdater Consolidator KernelCeipTask UsbCeip) do (
    for /f "tokens=1,* delims=," %%A in ('schtasks /Query /FO CSV /NH ^| findstr /I "%%~T"') do (
        schtasks /Change /TN "%%~A" /Disable >nul 2>&1
    )
)

:: Remove Compatibility Appraiser
if exist "%WINDIR%\System32\CompatTelRunner.exe" (
    takeown /F "%WINDIR%\System32\CompatTelRunner.exe" >nul 2>&1
    icacls "%WINDIR%\System32\CompatTelRunner.exe" /grant "%USERNAME%:F" >nul 2>&1
    del /f "%WINDIR%\System32\CompatTelRunner.exe" >nul 2>&1
)

:: ----- Third-Party Telemetry -----
echo [Step 5/5] Disabling Third-Party Telemetry...

:: NVIDIA Telemetry
sc stop NvTelemetryContainer >nul 2>&1
sc config NvTelemetryContainer start= disabled >nul 2>&1
for %%T in (NvTmMon NvTmRep NvTmRepOnLogon NvProfileUpdaterDaily NvProfileUpdaterOnLogon) do (
    for /f "tokens=1 delims=," %%A in ('schtasks /Query /FO CSV ^| findstr "%%~T"') do (
        schtasks /Change /TN "%%~A" /Disable >nul 2>&1
    )
)
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul 2>&1

:: Office Telemetry
for %%T in (
    "\Microsoft\Office\OfficeTelemetryAgentFallBack"
    "\Microsoft\Office\OfficeTelemetryAgentLogOn"
    "\Microsoft\Office\OfficeTelemetryAgentFallBack2016"
    "\Microsoft\Office\OfficeTelemetryAgentLogOn2016"
    "\Microsoft\Office\Office 15 Subscription Heartbeat"
    "\Microsoft\Office\Office 16 Subscription Heartbeat"
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1

:: Office Registry Settings
for %%V in (15.0 16.0) do (
    reg add "HKCU\SOFTWARE\Microsoft\Office\%%V\Outlook\Options\Mail" /v EnableLogging /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Office\%%V\Word\Options" /v EnableLogging /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Office\%%V\Common" /v QMEnable /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Office\%%V\Common\Feedback" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Office\%%V\Outlook\Options\Calendar" /v EnableCalendarLogging /t REG_DWORD /d 0 /f >nul 2>&1
)

reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v DisableTelemetry /t REG_DWORD /d 1 /f >nul 2>&1

:: ----- Additional Privacy Settings -----
echo [Finalizing] Applying Additional Privacy Settings...

:: Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowFullControl /t REG_DWORD /d 0 /f >nul 2>&1

:: Media Player Tracking
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v UsageTracking /t REG_DWORD /d 0 /f >nul 2>&1

:: Core Telemetry Policies
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v Start /t REG_DWORD /d 0 /f >nul 2>&1

:: ----- Phase 1: Disable Scheduled Tasks -----
echo [PHASE 1/3] Disabling Telemetry Tasks...
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Location\Notifications" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Location\WindowsActionDialog" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\FeatureManagerEnabled" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\Subscription" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\Upload" /Disable >nul 2>&1


:: Special individual tasks
for %%T in (
    "\Microsoft\Windows\AppCompat\PT"
    "\Microsoft\Windows\Autochk\Proxy"
    "\Microsoft\Windows\DiskCleanup\SilentCleanup"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\XblGameSave\XblGameSaveTask"
) do (
    schtasks /Change /TN "%%~T" /Disable >nul 2>&1 && echo [Disabled] %%T
)

:: ----- Phase 2: Block Telemetry Domains -----
echo [PHASE 2/3] Blocking Telemetry Domains...
set "hostsFile=%SystemRoot%\System32\drivers\etc\hosts"
set "marker=:: BlockedByPrivacySuite"

:: Categorized domains
set "ms_telemetry=oca.telemetry.microsoft.com oca.microsoft.com watson.telemetry.microsoft.com"
set "data_collection=functional.events.data.microsoft.com browser.events.data.msn.com"
set "location_services=inference.location.live.net locationinferencewestus.cloudapp.net"
set "msn_services=arc.msn.com api.msn.com assets.msn.com c.msn.com"
set "other_tracking=weathermapdata.blob.core.windows.net tileservice.weather.microsoft.com"

:: Backup hosts file
if not exist "%hostsFile%.bak" copy "%hostsFile%" "%hostsFile%.bak" >nul

:: Add domain blocks
for %%D in (%ms_telemetry% %data_collection% %location_services% %msn_services% %other_tracking%) do (
    findstr /i /c:"%%D" "%hostsFile%" >nul || (
        echo 0.0.0.0 %%D %marker%>>"%hostsFile%"
        echo [Blocked] %%D
    )
)

:: ----- Phase 3: Final Configuration -----
echo [PHASE 3/3] Applying Final Settings...

:: Disable remaining services
for %%S in (
    DiagTrack
    dmwappushservice
    diagnosticshub.standardcollector.service
    NvTelemetryContainer
) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

:: Disable Location Tracking
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul

echo.
echo All telemetry components disabled
pause
goto PRIVACY_SECRUTY_MENU


:: =============================================
:: Windows Update Management Module
:: =============================================
:Disable_Updates
cls
echo =============================================
echo      WINDOWS UPDATE MANAGEMENT CENTER
echo =============================================
echo    [1] Disable Windows Updates
echo    [2] Restore Windows Updates
echo    [3] Back
echo.
set /p updchoice="Select an option:"

if "%updchoice%"=="1" goto DisableUpdates_Full
if "%updchoice%"=="2" goto RestoreWindowsUpdates
if "%updchoice%"=="3" goto PRIVACY_SECRUTY_MENU

echo.
echo Invalid selection. Please choose a number between (1-3)
pause
goto Disable_Updates


:: =============================================
:: FULL WINDOWS UPDATE DISABLE FUNCTION
:: =============================================
:DisableUpdates_Full
cls
echo Starting Windows Update disable process...
echo.

:: --------------------------
:: Service Configuration
:: --------------------------
echo [STEP 1/4] Stopping and disabling services...
for %%S in (
    wuauserv    # Windows Update Service
    UsoSvc      # Update Orchestrator Service
    bits        # Background Intelligent Transfer
    dosvc       # Delivery Optimization
    uhssvc      # Update Health Service
    WaaSMedicSvc # Windows Update Medic Service
) do (
    echo    - Processing service: %%S
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    
    :: Special handling for Medic Service
    if /I "%%S"=="WaaSMedicSvc" (
        sc failure %%S reset= 0 actions= "" >nul 2>&1
    )
)

:: --------------------------
:: Task Scheduler Configuration
:: --------------------------
echo [STEP 2/4] Disabling scheduled tasks...
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\UpdateOrchestrator\*"
    "\Microsoft\Windows\UpdateAssistant\*"
    "\Microsoft\Windows\WaaSMedic\*"
) do (
    echo    - Disabling task: %%T
    schtasks /Change /TN %%T /Disable >nul 2>&1
)

:: --------------------------
:: Registry Configuration
:: --------------------------
echo [STEP 3/4] Configuring registry policies...
(
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul && echo    - Set: NoAutoUpdate=1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul && echo    - Set: AUOptions=2
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul && echo    - Set: NoAutoReboot=1
)

:: --------------------------
:: Cleanup Operations
:: --------------------------
echo [STEP 4/4] Cleaning update files and temp data...
(
    rd /s /q "%WinDir%\SoftwareDistribution\Download" >nul 2>&1 && md "%WinDir%\SoftwareDistribution\Download" >nul 2>&1 && echo    - Reset SoftwareDistribution folder
    
    for %%D in (Temp, Prefetch) do (
        rd /s /q "%WinDir%\%%D" >nul 2>&1
        md "%WinDir%\%%D" >nul 2>&1
        echo    - Reset %%D folder
    )
    
    rd /s /q "%Temp%" >nul 2>&1
    md "%Temp%" >nul 2>&1
    echo    - Reset Temp folder
)

:: --------------------------
:: Completion Message
:: --------------------------
echo.
echo Windows Updates have been fully disabled!
echo.
pause
goto PRIVACY_SECRUTY_MENU


:: =============================================
:: RESTORE WINDOWS UPDATE FUNCTIONALITY
:: =============================================
:RestoreWindowsUpdates
cls
echo =============================================
echo      WINDOWS UPDATE RESTORATION CENTER
echo =============================================
echo Preparing to restore Windows Update functionality
echo.

:: --------------------------
:: Service Restoration
:: --------------------------
echo [STEP 1/3] Restoring Windows Update services...
for %%S in (
    wuauserv    # Windows Update Service
    UsoSvc      # Update Orchestrator Service 
    bits        # Background Intelligent Transfer
    dosvc       # Delivery Optimization
    uhssvc      # Update Health Service
    WaaSMedicSvc # Windows Update Medic Service
) do (
    echo    - Restoring service: %%S
    sc config %%S start= auto >nul 2>&1
    sc start %%S >nul 2>&1
    :: Verify service state
    sc query %%S | find "RUNNING" >nul && (
        echo    - Service %%S started successfully
    ) || (
        echo    - [WARNING] Could not start %%S
    )
)

:: --------------------------
:: Task Scheduler Restoration 
:: --------------------------
echo [STEP 2/3] Enabling scheduled tasks...
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot" 
    "\Microsoft\Windows\UpdateOrchestrator\*"
    "\Microsoft\Windows\UpdateAssistant\*"
    "\Microsoft\Windows\WaaSMedic\*"
) do (
    echo    - Enabling task: %%T
    schtasks /Change /TN %%T /Enable >nul 2>&1
    :: Verify task state
    schtasks /Query /TN %%T 2>&1 | find "Disabled" >nul || (
        echo    - Task %%T enabled successfully
    )
)

:: --------------------------
:: Registry Restoration
:: --------------------------
echo [STEP 3/3] Resetting registry policies...
(
    echo    - Removing WindowsUpdate policies
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
    
    echo    - Resetting Auto Update settings
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /f >nul 2>&1
    
    echo    - Recreating default registry structure
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /f >nul 2>&1
)

:: --------------------------
:: Completion Message
:: --------------------------
echo.
echo Windows Update functionality fully restored!
echo.
pause
goto MENU


:: =============================================
:: This module blocks specified application domains
:: by adding them to the system hosts file
:: =============================================
:Block_App_Access
cls
echo =============================================
echo    APPLICATION DOMAIN BLOCKING UTILITY
echo =============================================
echo.

:: Domain list to block
set domains[0]=tonec.com
set domains[1]=www.tonec.com
set domains[2]=registeridm.com
set domains[3]=secure.internetdownloadmanager.com
set domains[4]=internetdownloadmanager.com
set domains[5]=mirror.internetdownloadmanager.com
set domains[6]=mirror2.internetdownloadmanager.com
set domains[7]=license.piriform.com
set domains[8]=activate.piriform.com
set domains[9]=www.piriform.com
set domains[10]=ipm-provider.piriform.com
set domains[11]=secure.piriform.com
set domains[12]=updates.piriform.com
set domains[13]=download.ccleaner.com

:: Backup hosts file
set "hosts=%SystemRoot%\System32\drivers\etc\hosts"
if not exist "%hosts%.bak" (
    copy "%hosts%" "%hosts%.bak" >nul
    echo Created hosts file backup: %hosts%.bak
)

:: Add block entries
echo Checking hosts file...
set added=0
echo. >> "%hosts%"
echo # IDM/Piriform Block Start >> "%hosts%"

for /l %%i in (0,1,13) do (
    set domain=!domains[%%i]!
    find /i "!domain!" < "%hosts%" >nul
    if errorlevel 1 (
        echo 127.0.0.1 !domain!>> "%hosts%"
        echo Blocked: !domain!
        set /a added+=1
    ) else (
        echo Already blocked: !domain!
    )
)

echo # IDM/Piriform Block End >> "%hosts%"
echo. >> "%hosts%"

:: Results summary
echo -----------------------------------------
echo Total domains processed: 14
echo Newly blocked domains: %added%
echo Hosts file modified successfully!
echo -----------------------------------------
echo Restart your browser to apply changes
pause

pause
goto PRIVACY_SECRUTY_MENU


:: =============================================
:: This module provides complete control over
:: Windows Defender components including:
:: - Core services
:: - Real-time protection
:: - Tamper protection
:: - Group Policy settings
:: =============================================

:Defender_Manager
cls
echo =============================================
echo       WINDOWS DEFENDER CONTROL CENTER
echo =============================================
echo    [1]  DISABLE Windows Defender
echo    [2]  RESTORE Windows Defender
echo    [3]  Back
echo.
set /p "defchoice="Select an option:"
:: Validate input using case statement

if "%defchoice%"=="1" goto Disable_Defender_Completely
if "%defchoice%"=="2" goto Restore_Defender_Fully
if "%defchoice%"=="3" goto PRIVACY_SECRUTY_MENU

echo.
echo Invalid selection. Please choose a number between (1-3)
pause
goto Defender_Manager


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
echo [PHASE 1/4] Terminating Defender processes...
for %%P in (
    MsMpEng.exe
    NisSrv.exe
    SecurityHealthService.exe
    SecurityHealthHost.exe
    MsSense.exe
) do (
    taskkill /f /im %%P >nul 2>&1 && (
        echo    - Killed: %%P
    ) || (
        echo    - [WARNING] Could not terminate %%P
    )
)

:: --------------------------
:: Service Configuration
:: --------------------------
echo [PHASE 2/4] Disabling Defender services...
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
    echo    - Disabled: %%S service
)

:: --------------------------
:: Registry Configuration
:: --------------------------
echo [PHASE 3/4] Applying registry modifications...

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

:: ==== Confirm completion ====
echo [INFO] SmartScreen protection has been completely disabled across the system.
pause

:: Disable Tamper Protection
(
    reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f >nul && echo    - Disabled Tamper Protection
    reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul && echo    - Added secondary AntiSpyware disable
)

:: --------------------------
:: Service Hardening
:: --------------------------
echo [PHASE 4/4] Applying service hardening...
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
goto Defender_Manager


:: =============================================
:: This module fully restores Windows Defender
:: functionality including all security features
:: =============================================
:Restore_Defender_Fully
cls
echo Starting Defender restoration process...
echo.

:: --------------------------
:: Service Restoration
:: --------------------------
echo [PHASE 1/4] Restoring Defender services...
for %%S in (
    WinDefend
    WdNisSvc
    SecurityHealthService
    Sense
    WdBoot
    WdFilter
) do (
    echo    - Configuring service: %%S
    if "%%S"=="WdBoot" (
        sc config %%S start= system >nul
    ) else if "%%S"=="WdFilter" (
        sc config %%S start= system >nul
    ) else (
        sc config %%S start= auto >nul
    )
    
    sc start %%S >nul 2>&1 && (
        echo    - Service %%S started successfully
    ) || (
        echo    - [WARNING] Could not start %%S
    )
)

:: --------------------------
:: Registry Cleanup
:: --------------------------
echo [PHASE 2/4] Cleaning registry configurations...

:: Remove all Defender policies
set "DEFENDER_REG=HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"
reg delete "%DEFENDER_REG%" /f >nul 2>&1 && (
    echo    - Removed all Group Policy restrictions
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
echo [PHASE 3/4] Repairing service startup...
for %%S in (
    WinDefend
    WdNisSvc
    SecurityHealthService
) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 2 /f >nul
    echo    - Restored startup type for %%S
)

:: --------------------------
:: Finalization
:: --------------------------
echo [PHASE 4/4] Finalizing restoration...
gpupdate /force >nul 2>&1

echo [VERIFICATION]
sc query WinDefend | find "STATE"
sc query WdNisSvc | find "STATE"
sc query SecurityHealthService | find "STATE"
echo.
echo Windows Defender has been fully restored!
echo.
pause
goto Defender_Manager


:: =============================================
:: This module performs comprehensive network
:: security hardening including:
:: - Firewall configuration
:: - Port blocking
:: - Service hardening
:: - Protocol security
:: - Account policies
:: =============================================

:Network_Security
cls
echo  Starting security hardening process...
echo.

:: --------------------------
:: Initial System Assessment
:: --------------------------
echo [PHASE 1/3] System Assessment...
echo.

:: Firewall Status
echo --- Firewall Status ---
netsh advfirewall show allprofiles state | findstr "State"
echo.

:: Network Configuration
echo --- Network Configuration ---
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr "IPv4"') do echo IP Address: %%A
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr "Subnet"') do echo Subnet Mask: %%A
echo.

:: Listening Ports (Top 20)
echo --- Listening Ports (Top 20) ---
netstat -ano | findstr LISTENING | head -20
echo.

:: User Accounts
echo --- Local Administrators ---
net localgroup administrators | findstr /v "Alias Comment Members"
echo.

:: --------------------------
:: Security Hardening
:: --------------------------
echo [PHASE 2/3] Applying Security Hardening...
echo.

:: 1. Firewall Configuration
echo [1/8] Configuring Windows Firewall...
(
    netsh advfirewall set allprofiles state on && echo    - Firewall enabled for all profiles
    netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound && echo    - Set default block inbound policy
) >nul

:: 2. Port Hardening
echo [2/8] Blocking vulnerable ports...
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

:: 3. Remote Access Hardening
echo [3/8] Hardening remote access...
(
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul && echo    - Remote Desktop disabled
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul && echo    - Remote Assistance disabled
    sc config RemoteRegistry start= disabled >nul && sc stop RemoteRegistry >nul && echo    - Remote Registry disabled
) >nul

:: 4. SMB Security
echo [4/8] Securing SMB protocol...
(
    dism /online /disable-feature /featurename:SMB1Protocol /NoRestart >nul && echo    - SMBv1 disabled via DISM
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f >nul && echo    - SMBv1 registry hardening
) >nul

:: 5. Account Policies
echo [5/8] Configuring account policies...
(
    net accounts /lockoutthreshold:5 >nul && echo    - Account lockout threshold: 5 attempts
    net accounts /lockoutduration:30 >nul && echo    - Lockout duration: 30 minutes
    net accounts /lockoutwindow:30 >nul && echo    - Lockout observation window: 30 minutes
    net user Guest /active:no >nul && echo    - Guest account disabled
) >nul

:: 6. Service Hardening
echo [6/8] Disabling vulnerable services...
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

:: 7. Network Protocol Security
echo [7/8] Configuring network protocols...
(
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v SMBDeviceEnabled /t REG_DWORD /d 0 /f >nul && echo    - Disabled SMB over NetBIOS
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f >nul && echo    - Disabled IPv6 (where possible)
) >nul

:: 8. Additional Hardening
echo [8/8] Applying additional hardening...
(
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /v AllowProtectedCreds /t REG_DWORD /d 1 /f >nul && echo    - Enabled Protected Credentials
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 0 /f >nul && echo    - Disabled local account token filtering
) >nul

:: --------------------------
:: Verification
:: --------------------------
echo [PHASE 3/3] Verifying changes...
echo.

:: Firewall Verification
netsh advfirewall show allprofiles state | findstr "State"
echo.

:: Critical Service Verification
for %%S in (RemoteRegistry,FTPSVC,TlntSvr) do (
    sc query %%S | findstr "STATE"
)


:: Final Message
echo.
echo Network security hardening complete!
echo.
echo Reboot system for all changes to take effect
pause
goto PRIVACY_SECRUTY_MENU

:: ================================
:: Clean Browser History and Cache
:: ================================
:Privacycleanup
cls
echo =====================================
echo         BROWSER DATA CLEANUP
echo =====================================
echo.

:: Function to clear registry keys
echo [1/10] Clearing Registry Activity Traces...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Search Assistant\ACMru" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Direct3D\MostRecentApplication" /f >nul 2>&1
echo   - Registry activity traces cleared

:: Clear application history
echo [2/10] Clearing Application History...
reg delete "HKCU\Software\Adobe\MediaBrowser\MRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Wordpad\Recent File List" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentFileList" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentURLList" /f >nul 2>&1
reg delete "HKCU\Software\Gabest\Media Player Classic\Recent File List" /f >nul 2>&1
echo   - Application history cleared

:: Clear recent files and Quick Access
echo [3/10] Clearing Recent Files and Quick Access...
if exist "%APPDATA%\Microsoft\Windows\Recent" (
    del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
)
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" (
    del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
)
if exist "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations" (
    del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1
)
echo   - Recent files and Quick Access cleared

:: Clear temporary files
echo [4/10] Clearing Temporary Files...
if exist "%TEMP%" (
    del /f /s /q "%TEMP%\*" >nul 2>&1
    for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1
)
if exist "%SYSTEMROOT%\Temp" (
    del /f /s /q "%SYSTEMROOT%\Temp\*" >nul 2>&1
    for /d %%i in ("%SYSTEMROOT%\Temp\*") do rd /s /q "%%i" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Temp" (
    del /f /s /q "%LOCALAPPDATA%\Temp\*" >nul 2>&1
    for /d %%i in ("%LOCALAPPDATA%\Temp\*") do rd /s /q "%%i" >nul 2>&1
)
echo   - Temporary files cleared

:: Clear system cache and prefetch
echo [5/10] Clearing System Cache and Prefetch...
if exist "%SYSTEMROOT%\Prefetch" (
    del /f /s /q "%SYSTEMROOT%\Prefetch\*.pf" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Microsoft\Windows\WebCache" (
    del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\WebCache\*" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Microsoft\Windows\Explorer" (
    del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db" >nul 2>&1
)
echo   - System cache and prefetch cleared

:: Clear Windows Update cache
echo [6/10] Clearing Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
if exist "%SYSTEMROOT%\SoftwareDistribution" (
    ren "%SYSTEMROOT%\SoftwareDistribution" "SoftwareDistribution.old" >nul 2>&1
    rd /s /q "%SYSTEMROOT%\SoftwareDistribution.old" >nul 2>&1
)
if exist "%SYSTEMROOT%\System32\catroot2" (
    ren "%SYSTEMROOT%\System32\catroot2" "catroot2.old" >nul 2>&1
    rd /s /q "%SYSTEMROOT%\System32\catroot2.old" >nul 2>&1
)
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
echo   - Windows Update cache cleared

:: Clear system logs
echo [7/10] Clearing System Logs...
for /f "tokens=*" %%i in ('wevtutil.exe el 2^>nul') do (
    wevtutil.exe cl "%%i" >nul 2>&1
)
if exist "%SYSTEMROOT%\Logs" (
    for /d %%i in ("%SYSTEMROOT%\Logs\*") do (
        del /f /s /q "%%i\*" >nul 2>&1
    )
)
:: Clear specific log files
del /f /q "%SYSTEMROOT%\setupact.log" >nul 2>&1
del /f /q "%SYSTEMROOT%\setuperr.log" >nul 2>&1
del /f /q "%SYSTEMROOT%\comsetup.log" >nul 2>&1
del /f /q "%SYSTEMROOT%\DtcInstall.log" >nul 2>&1
del /f /q "%SYSTEMROOT%\PFRO.log" >nul 2>&1
del /f /q "%SYSTEMROOT%\setupapi.log" >nul 2>&1
del /f /q "%SYSTEMROOT%\debug\PASSWD.LOG" >nul 2>&1
echo   - System logs cleared

:: Clear browser caches
echo [8/10] Clearing Browser Caches...
:: Chrome
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
    taskkill /f /im chrome.exe >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" (
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" >nul 2>&1
)
echo   - Browser caches cleared

:: Clear Windows Defender and security logs
echo [9/10] Clearing Security and Defender Logs...
if exist "%ProgramData%\Microsoft\Windows Defender\Scans\History" (
    takeown /f "%ProgramData%\Microsoft\Windows Defender\Scans\History" /r /d y >nul 2>&1
    icacls "%ProgramData%\Microsoft\Windows Defender\Scans\History" /grant administrators:F /t >nul 2>&1
    rd /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\History" >nul 2>&1
)
if exist "%PROGRAMDATA%\Microsoft\Windows\WER" (
    del /f /s /q "%PROGRAMDATA%\Microsoft\Windows\WER\*" >nul 2>&1
    for /d %%i in ("%PROGRAMDATA%\Microsoft\Windows\WER\*") do rd /s /q "%%i" >nul 2>&1
)
echo   - Security and Defender logs cleared

:: Final cleanup and system optimization
echo [10/10] Final System Cleanup...
:: Clear credentials
for /f "tokens=1,2 delims=: " %%a in ('cmdkey /list 2^>nul ^| findstr "Target"') do (
    if "%%b" neq "" cmdkey /delete:%%b >nul 2>&1
)
:: Empty recycle bin
rd /s /q "%USERPROFILE%\$Recycle.Bin" >nul 2>&1
rd /s /q "C:\$Recycle.Bin" >nul 2>&1
:: Clear DNS cache
ipconfig /flushdns >nul 2>&1
:: Remove default user account
net user defaultuser0 /delete >nul 2>&1
:: Clear SRUM database
takeown /f "%SYSTEMROOT%\System32\sru\SRUDB.dat" /a >nul 2>&1
icacls "%SYSTEMROOT%\System32\sru\SRUDB.dat" /grant administrators:F >nul 2>&1
del /f /q "%SYSTEMROOT%\System32\sru\SRUDB.dat" >nul 2>&1
:: Clear previous Windows installation
if exist "%SYSTEMDRIVE%\Windows.old" (
    takeown /f "%SYSTEMDRIVE%\Windows.old" /r /d y >nul 2>&1
    icacls "%SYSTEMDRIVE%\Windows.old" /grant administrators:F /t >nul 2>&1
    rd /s /q "%SYSTEMDRIVE%\Windows.old" >nul 2>&1
)
echo   - Final cleanup completed

echo.
echo ========================================
echo    System Cleanup Completed Successfully!
echo ========================================
echo.
pause
goto PRIVACY_SECRUTY_MENU 



:: =============================================
:: This module provides various Windows interface
:: customization options to improve user experience
:: =============================================
:CUSTOMIZATION_MENU
cls
echo =============================================
echo             CUSTOMIZATION
echo =============================================
echo    [1] File Explorer 
echo    [2] Disable Lock Screen
echo    [3] Disable News and Interests
echo    [4] Restore Classic Windows Photo Viewer
echo    [5] Enable Dark Mode
echo    [6] Customize Right-Click Context Menu
echo    [7] Power seeting
echo    [8] Back
echo.
echo =============================================
set /p "cus_choice="Select an option:"

:: Validate input using case statement
if "%cus_choice%"=="1" goto FileExplorer_Tweaks
if "%cus_choice%"=="2" goto Disable_Lock_Scree
if "%cus_choice%"=="3" goto NEW_AND_INTERESTS
if "%cus_choice%"=="4" goto Restore_PhotoViewer
if "%cus_choice%"=="5" goto DARK_MODE
if "%cus_choice%"=="6" goto Customize_Context_Menu
if "%cus_choice%"=="7" goto POWER_SEETING
if "%cus_choice%"=="8" goto MENU

echo.
echo Invalid selection. Please choose a number between (1-8)
pause
goto CUSTOMIZATION_MENU 

:: =============================================
:: This module provides various File Explorer
:: tweaks including showing file extensions and
:: customizing the right-click context menu
:: =============================================

:FileExplorer_Tweaks
cls
echo =============================================
echo       FILE EXPLORER CUSTOMIZATION CENTER
echo =============================================
echo    [1] Show File Extensions
echo    [2] Disable Quick Acces
echo    [3] Disable Resent File
echo    [4] Back
echo.
echo =============================================
set /p fil_choice="Select an option:"

if "%choice%"=="1" goto download_programs
if "%choice%"=="2" goto Disable_Quick_Access
if "%choice%"=="3" goto Disable_Recent_Files
if "%choice%"=="4" goto FileExplorer_Tweaks

echo.
echo Invalid selection. Please choose a number between
pause 

:: =============================================
:: ALWAYS SHOW FILE EXTENSIONS
:: =============================================
:Show_File_Extensions
cls
echo =============================================
echo      ENABLING FILE EXTENSIONS IN EXPLORER
echo =============================================
echo.

:: Set registry to show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul && (
    echo [SUCCESS] File extensions setting updated
)

echo.
echo [COMPLETE] File extensions are now visible
pause
goto FileExplorer_Tweaks

:: =============================================
:: DISABLE QUICK ACCESS IN FILE EXPLORER
:: =============================================
:Disable_Quick_Access
cls
echo =============================================
echo       DISABLING QUICK ACCESS FEATURE
echo =============================================
echo.

:: Set registry values to disable Quick Access
(
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HubMode /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Quick Access hidden
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Default set to "This PC"
)

:: Clear Quick Access history
(
    del /f /q "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
    del /f /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1
    echo [SUCCESS] Quick Access history cleared
)

echo [COMPLETE] Quick Access has been disabled
pause
goto CUSTOMIZATION_MENU

:: =============================================
:: DISABLE RECENT FILES AND ACTIVITY HISTORY
:: =============================================
:Disable_Recent_Files
cls
echo =============================================
echo    DISABLING RECENT FILES AND ACTIVITY HISTORY
echo =============================================
echo.

:: 1. Disable tracking in Start Menu and Jump Lists
(
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul && echo [SUCCESS] Disabled recent programs tracking
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul && echo [SUCCESS] Disabled recent documents tracking
)

:: 2. Clear existing history
(
    del /f /q "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
    del /f /q "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
    echo [SUCCESS] Cleared existing recent items
)

:: 3. Configure File Explorer defaults
(
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HubMode /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Disabled Quick Access
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Set default to This PC
)

echo.
echo [COMPLETE] Recent files and activity tracking disabled
pause
goto CUSTOMIZATION_MENU

:: =============================================
:: DISABLE WINDOWS LOCK SCREEN
:: =============================================
:Disable_Lock_Screen
cls
echo =============================================
echo        DISABLING WINDOWS LOCK SCREEN
echo =============================================
echo.

:: Configure registry to disable lock screen
(
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f >nul
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul && echo [SUCCESS] Lock screen disabled
)

echo.
echo [COMPLETE] Lock screen has been disabled
pause
goto CUSTOMIZATION_MENU

:NEW_AND_INTERESTS

:: Disable News and Interests from taskbar for all users (in English)

echo Disabling News and Interests for all users...

:: System-wide policy to disable feeds
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

:: Disable taskbar feeds for current user
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f

:: Disable taskbar feeds for default user profile (future users)
reg load HKU\DefaultUser "C:\Users\Default\NTUSER.DAT"
reg add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg unload HKU\DefaultUser

:: Restart Explorer to apply changes immediately (optional)
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo News and Interests have been disabled.
pause >nul

:: =============================================
:: RESTORE CLASSIC WINDOWS PHOTO VIEWER
:: =============================================
:Restore_PhotoViewer
cls
echo =============================================
echo      RESTORING CLASSIC WINDOWS PHOTO VIEWER
echo =============================================

REM إنشاء مفاتيح التسجيل لـ Applications\photoviewer.dll
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f

reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ PhotoViewer.FileAssoc.Bitmap
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-70" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ print
reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print" /v "NeverDefault" /t REG_SZ /d "" /f

reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f

:: إنشاء مفاتيح التسجيل لـ PhotoViewer.FileAssoc.JFIF
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ PhotoViewer.FileAssoc.Jpeg
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ PhotoViewer.FileAssoc.Gif
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-83" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ PhotoViewer.FileAssoc.Png
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\imageres.dll,-71" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ PhotoViewer.FileAssoc.Wdp
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp" /v "EditFlags" /t REG_DWORD /d "00010000" /f
reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp" /v "ImageOptionFlags" /t REG_DWORD /d "00000001" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f

:: إنشاء مفاتيح التسجيل لـ SystemFileAssociations
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\Image Preview\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f

reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\Image Preview\DropTarget" /v "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /t REG_SZ /d "" /f

:: إنشاء مفاتيح التسجيل لـ HKEY_LOCAL_MACHINE
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3069" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationName" /t REG_SZ /d "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3009" /f

:: إنشاء مفاتيح التسجيل لـ FileAssociations
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

echo Windows Photo Viewer has been successfully restored!
pause
goto CUSTOMIZATION_MENU

:: =============================================
:: CUSTOMIZE RIGHT-CLICK CONTEXT MENU
:: =============================================
:Customize_Context_Menu
cls
echo =============================================
echo      CONTEXT MENU CUSTOMIZATION CENTER
echo =============================================
echo    [1] Add "Open PowerShell as Admin" to folders
echo    [2] Add "Open Command Prompt Here" to folders
echo    [3] Add "Restart Explorer" to desktop
echo    [4] Return to File Explorer Tweaks
echo.
echo =============================================
set /p con_choice="Select an option:"

if "%con_choice%"=="1" goto download_programsAdd_PSAdmin_Context
if "%con_choice%"=="2" goto update_programsAdd_CMD_Context
if "%con_choice%"=="3" goto Add_ExplorerRestart_Context
if "%con_choice%"=="3" goto CUSTOMIZATION_MENU

echo.
echo Invalid selection. Please choose a number between
pause
goto Customize_Context_Menu


:: =============================================
:: ADD POWERSHELL AS ADMIN TO CONTEXT MENU
:: =============================================
:Add_PSAdmin_Context
cls
echo =============================================
echo    ADDING POWERSHELL ADMIN TO CONTEXT MENU
echo =============================================
echo [INFO] This will add:
echo    - "Open PowerShell as Administrator"
echo    - To folder context menus
echo.

(
    reg add "HKCR\Directory\shell\PowershellAsAdmin" /ve /d "Open PowerShell as Admin" /f >nul
    reg add "HKCR\Directory\shell\PowershellAsAdmin" /v "Icon" /d "powershell.exe" /f >nul
    reg add "HKCR\Directory\shell\PowershellAsAdmin\command" /ve /d "powershell.exe -NoExit -Command \"Start-Process powershell -Verb RunAs -ArgumentList '-NoExit','-Command','Set-Location -LiteralPath ''%%V'''\"" /f >nul
    echo [SUCCESS] PowerShell admin option added
)

echo.
echo [COMPLETE] Context menu item added
pause
goto Customize_Context_Menu

:: =============================================
:: ADD COMMAND PROMPT TO CONTEXT MENU
:: =============================================
:Add_CMD_Context
cls
echo =============================================
echo    ADDING COMMAND PROMPT TO CONTEXT MENU
echo =============================================
echo [INFO] This will add:
echo    - "Open Command Prompt Here"
echo    - To folder context menus
echo.

(
    reg add "HKCR\Directory\shell\OpenCmdHere" /ve /d "Open Command Prompt Here" /f >nul
    reg add "HKCR\Directory\shell\OpenCmdHere" /v "Icon" /d "cmd.exe" /f >nul
    reg add "HKCR\Directory\shell\OpenCmdHere\command" /ve /d "cmd.exe /s /k pushd \"%%V\"" /f >nul
    echo [SUCCESS] Command Prompt option added
)

echo.
echo [COMPLETE] Context menu item added
pause
goto Customize_Context_Menu

:: =============================================
:: ADD EXPLORER RESTART TO DESKTOP CONTEXT MENU
:: =============================================
:Add_ExplorerRestart_Context
cls
echo =============================================
echo    ADDING EXPLORER RESTART TO CONTEXT MENU
echo =============================================
echo [INFO] This will add:
echo    - "Restart Explorer"
echo    - To desktop right-click menu
echo.

(
    reg add "HKCR\DesktopBackground\Shell\RestartExplorer" /ve /d "Restart Explorer" /f >nul
    reg add "HKCR\DesktopBackground\Shell\RestartExplorer" /v "Icon" /d "explorer.exe" /f >nul
    reg add "HKCR\DesktopBackground\Shell\RestartExplorer\command" /ve /d "cmd.exe /c \"taskkill /f /im explorer.exe && start explorer.exe\"" /f >nul
    echo [SUCCESS] Explorer restart option added
)

echo.
echo [COMPLETE] Context menu item added
echo [NOTE] Right-click on desktop to use this option
pause
goto Customize_Context_Menu

:POWER_SEETING
:: Create  folder on Desktop 
set "folderName=power setting.{ED7BA470-8E54-465E-825C-99712043E01C}"
set "desktopPath=%USERPROFILE%\Desktop"

mkdir "%desktopPath%\%folderName%"

echo God Mode folder "power setting" created on your desktop.
pause
goto Customize_Context_Menu

:: =============================================
:: PROGRAM INSTALLATION MENU
:: =============================================
:INSTALL_PROGRAMS
cls
echo ==========================================
echo       Interactive Program Manager
echo ==========================================
echo.
echo [1] Download Programs
echo [2] Update Programs
echo [3] Back
echo.
echo ==========================================
set /p choice="Enter your choice: "

if "%choice%"=="1" goto download_programs
if "%choice%"=="2" goto update_programs
if "%choice%"=="3" goto Menu

echo Invalid choice! Please choose a number between
pause 
goto INSTALL_PROGRAMS

:download_programs
cls
echo ==========================================
echo           Download Programs
echo ==========================================
echo.
echo Installing Chocolatey package manager...
echo.

:: Check if Chocolatey is installed
where choco >nul 2>&1
if %errorlevel% equ 0 (
    echo Chocolatey is already installed
    :: Check for updates
    echo  Checking for Chocolatey updates...
    choco outdated chocolatey --limit-output >nul 2>&1
    if %errorlevel% equ 0 (
        echo [↑] Update available! Upgrading...
        choco upgrade chocolatey -y >nul && (
            echo [✓] Chocolatey upgraded successfully
        )
    ) else (
        echo  Chocolatey is up-to-date
    )
    goto PROGRAME_DOWNLOAD
)


:: Install Chocolatey
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
if %errorlevel% == 0 (
    echo.
    echo  Chocolatey installed successfully!
    goto PROGRAME_DOWNLOAD
) else (
    echo.
    echo  Failed to install Chocolatey!
    echo  Please install manually from:
    echo  https://chocolatey.org/install
    pause
    goto INSTALL_PROGRAMS
)

:PROGRAME_DOWNLOAD
cls
echo.
echo ==========================================
echo         Program Download Options
echo ==========================================
echo.
echo    [1] Install Google Chrome
echo    [2] Install Brave Browser
echo    [3] Install VLC Media Player
echo    [4] Install Sumatra PDF
echo    [5] Install WinRAR
echo    [6] Install Notpad plus plus
echo    [7] Install ALL 
echo    [8] VirtualBox
echo    [9] Back
echo.
echo ==========================================
set /p prog_choice="Select an option:"

if "%prog_choice%"=="1" goto install_chrome
if "%prog_choice%"=="2" goto install_brave
if "%prog_choice%"=="3" goto install_vlc
if "%prog_choice%"=="4" goto install_sumatra
if "%prog_choice%"=="5" goto install_winrar
if "%prog_choice%"=="6" goto install_notepad
if "%prog_choice%"=="7" goto install_all
if "%prog_choice%"=="8" goto install_virtualbox
if "%prog_choice%"=="9" goto MENU
echo.
echo Invalid selection. Please choose a number between
pause 
goto chocolatey_success
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
goto chocolatey_success

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
goto chocolatey_success

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
goto chocolatey_success

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
goto chocolatey_success

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
goto chocolatey_success

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
goto chocolatey_success

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
set /p ext_choice=Do you want to install the VirtualBox Extension Pack? (Y/N): 
if /i "%ext_choice%"=="Y" (
    echo.
    echo Installing VirtualBox Extension Pack...
    choco install virtualbox-extension-pack -y
) else (
    echo Skipping Extension Pack installation.
)

echo.
pause
goto chocolatey_success

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
goto chocolatey_success

:check_and_install
:: %1 = Program name (for display)
:: %2 = Executable full path
:: %3 = Chocolatey package name
echo Installing %1...
if exist "%~2" (
    echo  %1 is already installed.
) else (
    choco install %~3 -y
)
echo.
exit /b

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
    goto INSTALL_PROGRAMS
)
:: Get programs that need updates
choco outdated > "%temp%\outdated.txt"

:: Check if there are no updates
findstr /R "^$" "%temp%\outdated.txt" >nul && (
    echo All programs are up to date.
    pause
    goto :eof
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
    goto :eof
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
goto INSTALL_PROGRAMS

:: =============================================================
:: SECTION: NETWORK MENU
:: DESCRIPTION: This section measures internet speed and helps improve internet quality.
:: =============================================================

:NETWORK_MENU
cls
echo =================[ NETWORK ]================
echo.
echo   [1] Test Internet Speed
echo   [2] Reset Network Settings
echo   [3] Back
echo.
echo ============================================
set /p netchoice="Select an option (1-3): "
if "%netchoice%"=="3" goto MENU
if "%netchoice%"=="1" goto Network_TestSpeed
if "%netchoice%"=="2" goto Network_Reset

echo Invalid selection, Please choose a number between
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
echo =============================================
echo        INTERNET SPEED TEST UTILITY
echo =============================================
echo [INFO] This will:
echo    - Download official Speedtest CLI tool
echo    - Measure your connection speed
echo    - Display ping, download and upload results
echo.

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
echo [↓] Downloading Speedtest CLI tool...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%SPEEDTEST_URL%', '%TEMP_ZIP%')"

if not exist "%TEMP_ZIP%" (
    echo [✗] Download failed! Check your internet connection
    pause
    goto NETWORK_MENU
)

:: Extract the archive
echo [↦] Extracting files...
powershell -Command "Expand-Archive -Path '%TEMP_ZIP%' -DestinationPath '%EXTRACT_DIR%' -Force" >nul 2>&1

if not exist "%EXE_PATH%" (
    echo [✗] Extraction failed! File may be corrupted
    del "%TEMP_ZIP%" >nul 2>&1
    pause
    goto NETWORK_MENU
)

:: Cleanup
del "%TEMP_ZIP%" >nul 2>&1
echo [✓] Speedtest tool ready

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
echo =============================================
echo       NETWORK RESET IN PROGRESS
echo =============================================
echo [INFO] Starting network reset procedure...
echo        Please wait, this may take 2-3 minutes...
echo.

:: --------------------------
:: Phase 1: Service Management
:: --------------------------
echo [PHASE 1/6] Managing network services...
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
echo [PHASE 2/6] Resetting core network components...
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
echo [PHASE 3/6] Clearing network caches...
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
echo [PHASE 4/6] Resetting network adapters...
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
echo [PHASE 5/6] Restoring network services...
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
echo [PHASE 6/6] Finalizing network configuration...
echo    - Renewing IP addresses...
ipconfig /renew >nul 2>&1

echo.
echo =============================================
echo      NETWORK RESET COMPLETED
echo =============================================
echo [SUCCESS] Network components have been reset!
echo.
echo [ACTION REQUIRED]
echo 1. RESTART your computer to complete the reset
echo 2. After restart, you may need to:
echo    - Reconnect to WiFi networks
echo    - Reconfigure VPN connections
echo    - Set custom DNS servers if needed
echo    - Check firewall rules
echo.
pause
goto NETWORK_MENU

:: Main System Menu
:System_Menu
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      SYSTEM MAINTENANCE TOOLS - MAIN MENU
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo 1. System File Checker (SFC)
echo 2. DISM Health Check
echo 3. Disk Check (CHKDSK)
echo 4. Memory Diagnostic Tool
echo 5. System Information
echo 6. Defragment
echo 7. Activation
echo 8. Back
echo.
set /p choice="Enter your choice (1-6): "
if "%choice%"=="1" goto System_SFC
if "%choice%"=="2" goto System_DISM
if "%choice%"=="3" goto System_Chkdsk
if "%choice%"=="4" goto System_MemoryTest
if "%choice%"=="5" goto System_Info
if "%choice%"=="6" goto disk_defrag
if "%choice%"=="7" goto Tools_ActivateWindows
if "%choice%"=="8" goto Menu

echo Invalid selection. Please choose a number between
pause
goto System_Menu

:: =============================================
:: SYSTEM RESTORE POINT CREATION MODULE
:: =============================================
:: This module creates a Windows System Restore Point
:: with proper error handling and verification
:: =============================================
:System_Create_Restore_Point
cls
echo =============================================
echo       SYSTEM RESTORE POINT CREATION
echo =============================================
echo [INFO] Verifying System Restore availability...
echo.

:: Check if System Restore is enabled
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR ^| findstr /i "DisableSR"') do (
        if "%%A"=="0x1" (
            echo [ERROR] System Restore is disabled on this system
            echo         Please enable it in System Properties
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
    echo         Write-Host "[SUCCESS] Restore point created: $description" -ForegroundColor Green
    echo         exit 0
    echo     } else {
    echo         Write-Host "[ERROR] Failed to create restore point" -ForegroundColor Red
    echo         exit 1
    echo     }
    echo } catch {
    echo     Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    echo     exit 1
    echo }
) > "%ps_script%"

:: Execute with proper permissions
echo [STATUS] Creating restore point: %restore_point_name%
powershell -ExecutionPolicy Bypass -NoProfile -File "%ps_script%"

:: Verify result
if %errorlevel% equ 0 (
    echo [SUCCESS] Restore point created successfully
    echo            Name: %restore_point_name%
) else (
    echo [ERROR] Failed to create restore point
)

:: Cleanup
del "%ps_script%" >nul 2>&1

echo.
echo [NOTE] To manage restore points:
echo        1. Open System Properties
echo        2. Select System Protection tab
echo        3. Click System Restore button
echo.
pause
goto SYSTEM_MENU

:: =============================================
:: COMPLETE REGISTRY BACKUP UTILITY
:: =============================================
:: Creates full backup of all registry hives
:: Backup location: C:\RegistryBackups
:: =============================================

:System_Registry_Backup
cls
echo =============================================
echo        FULL REGISTRY BACKUP
echo =============================================

:: Set backup location with timestamp
set "BackupDir=C:\RegistryBackups\%DATE%_%TIME%"
set "BackupDir=%BackupDir:/=-%"
set "BackupDir=%BackupDir::=-%"

:: Create backup directory
mkdir "%BackupDir%" 2>nul || (
    echo ERROR: Could not create backup directory
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
        echo   ✓ Success
    ) || (
        echo   ✗ Failed
    )
)

echo.
echo [COMPLETE] Registry backup finished
echo Location: %BackupDir%
echo.

pause
goto SYSTEM_MENU



:: System File Checker (SFC) - Scans and repairs system files
:System_SFC
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      SYSTEM FILE CHECKER (SFC) - RUNNING
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo This will scan and repair protected system files.
echo Note: This process may take some time.
echo.
sfc /scannow
echo.
echo SFC scan completed. Check above for results.
pause
goto System_Menu

:: DISM Health Check - Repairs Windows image
:System_DISM
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      DISM HEALTH CHECK - RUNNING
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo This will repair the Windows component store.
echo Note: Internet connection required for full repair.
echo.
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo DISM operation completed. Check above for results.
pause
goto System_Menu
	
:disk_defrag
cls
echo --------------------------------------------------------------------------------
echo Disk Defragment
echo --------------------------------------------------------------------------------
echo.
echo Defragmenting hard disks...
timeout /t 3 >nul
defrag -c -v
if %errorlevel% neq 0 (
    echo Error during disk defragmentation.
    goto error
)
cls
echo --------------------------------------------------------------------------------
echo Disk Defragment
echo --------------------------------------------------------------------------------
echo.
echo Disk Defrag successful!
echo.
pause

:: Disk Check Utility - Checks and repairs disk errors
:System_Chkdsk
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      DISK CHECK (CHKDSK) - UTILITY
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Available drives on your system:
echo.
wmic logicaldisk get size,freespace,caption
echo.
:RetryDrive
set /p drive="Enter drive letter to check (e.g., C): "
:: Validate drive letter input
    if not exist %drive%:\ (
        echo Invalid drive letter. Please try again.
        goto RetryDrive
    )
echo.
echo WARNING: This will schedule a disk check for the next restart.
echo The system will restart automatically to perform this check.
echo.
set /p confirm="Are you sure you want to continue? (Y/N): "
    
if /i "!confirm!"=="Y" (
        echo Scheduling disk check for drive %drive%...
        chkdsk %drive%: /f /r /x
        echo.
        echo Disk check scheduled. Please restart your computer.
    ) else (
        echo Operation cancelled by user.
    )
pause
goto System_Menu

:: Windows Memory Diagnostic Tool
:System_MemoryTest
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      MEMORY DIAGNOSTIC TOOL
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
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
        echo Memory diagnostic cancelled by user.
    )
pause
goto System_Menu

:: System Information Utility
:: Version: 1.0
:: Description: Comprehensive system information gathering tool
:: Maintained by: [Your Name/Team]
:: Last Updated: [Date]

:System_Info
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      SYSTEM INFORMATION - COMPREHENSIVE REPORT
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
:: ================= BASIC SYSTEM INFO =================
echo [1] BASIC SYSTEM INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Date and Time:
echo    Current Date: %date%
echo    Current Time: %time%
echo.
echo Computer Name: %COMPUTERNAME%
echo Current User: %USERNAME%
echo.
:: Get core system information using PowerShell
echo OS Details:
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"System Manufacturer" /C:"System Boot Time" /C:"System Locale"
echo.
:: ================= USER ACCOUNT INFO =================
echo [2] USER ACCOUNT INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Administrator Users:
powershell -Command "try { Get-LocalGroupMember -Group 'Administrators' | Format-Table -AutoSize } catch { net localgroup administrators }"
echo.
:: ================= SECURITY LOGS =================
echo [3] SECURITY AND LOGIN HISTORY
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
echo [4] SYSTEM HEALTH STATUS
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

:: ===== Pagefile and Virtualization =====
echo Pagefile:
echo.
powershell -Command "try { Get-WmiObject -Class Win32_PageFileUsage | ForEach-Object { 'Pagefile Size: ' + [math]::Round($_.AllocatedBaseSize/1024, 2) + ' GB | Used: ' + [math]::Round($_.CurrentUsage/1024, 2) + ' GB' } } catch { 'Pagefile information not available' }"
echo.

echo Virtualization Status:
echo.
powershell -Command "$cpu = Get-WmiObject -Class Win32_Processor; if ($cpu.VirtualizationFirmwareEnabled -eq $true) { 'Virtualization: ENABLED' } else { 'Virtualization: DISABLED' }"
echo.
:: ================= HARDWARE INFO =================
echo [5] HARDWARE INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
echo [6] STORAGE INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Disk Type and Health:
echo.
powershell -Command "try { Get-PhysicalDisk | ForEach-Object { $disk = $_; $health = $disk.HealthStatus; $mediaType = $disk.MediaType; $diskType = switch ($mediaType) { 'SSD' { 'SSD' } 'HDD' { 'HDD' } default { if ($disk.SpindleSpeed -eq 0) { 'SSD' } elseif ($disk.SpindleSpeed -gt 0) { 'HDD' } else { 'Unknown' } } }; 'Disk: ' + $disk.FriendlyName + ' | Type: ' + $diskType + ' | Health: ' + $health } } catch { 'Disk information not available' }"
echo.
echo Disk Drive Information:
wmic logicaldisk get size,freespace,caption,filesystem,description
:: ================= NETWORK INFO =================
echo [7] NETWORK INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Network Status:
ping -n 1 8.8.8.8 >nul && echo    Internet: CONNECTED || echo    Internet: DISCONNECTED
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
:: If a password is not found (it might be an open or enterprise network)
if errorlevel 1 (
    echo     Password: [No password found or open network]
)
echo.
:: ================= SOFTWARE INFO =================
echo [8] SOFTWARE INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Startup Programs:
powershell -Command "Get-CimInstance Win32_StartupCommand | Select Name,Command,Location"
echo.
echo All Installed Programs:
powershell -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName} | Sort-Object InstallDate -Descending | Select-Object DisplayName, InstallDate, Publisher | Format-Table -AutoSize"
echo.
:: ================= REPORT OPTIONS =================
:SAVE_MENU
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo      REPORT GENERATION OPTIONS
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo [1] Save Report to Text File
echo [2] Back
echo.
set /p save_choice="Select option (1-2): "

    if "%save_choice%"=="1" (
        set "reportfile=%USERPROFILE%\Documents\System_Report_%date:/=_%_%time::=_%.txt"
        (
            echo ===== SYSTEM INFORMATION REPORT =====
            echo Generated on: %date% %time%
            echo.
            :: Repeat all information commands redirecting to file
            call :System_Info
        ) > "%reportfile%"
        echo Report saved to: %reportfile%
        pause
    )
 goto System_Menu


:Tools_ActivateWindows
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo         WINDOWS ACTIVATION UTILITIES
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo 1. Activate Windows
echo 2. Check Activation Status
echo 3. View License Information
echo 4. Return to Tools Menu
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set /p act_choice="Select an option:"
if "%act_choice%"=="1" goto RUN_ACTIVATION
if "%act_choice%"=="2" goto CHECK_ACTIVATION
if "%act_choice%"=="3" goto LICENSE_INFO
if "%act_choice%"=="4" goto System_Menu
echo.
echo Invalid selection. Please choose 1-4.
pause
goto Tools_ActivateWindows
:RUN_ACTIVATION
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo          WINDOWS ACTIVATION PROCESS
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo  Connecting to activation servers...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
pause
goto Tools_ActivateWindows
:CHECK_ACTIVATION
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo       WINDOWS ACTIVATION STATUS CHECK
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo [STATUS] Current activation status:
echo.
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /dli
echo.
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /xpr
echo.
pause
goto Tools_ActivateWindows
:LICENSE_INFO
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo         WINDOWS LICENSE INFORMATION
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo [STATUS] Current license details:
echo.
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /dlv
echo.
pause
goto Tools_ActivateWindows

:: ======================
:: SCRIPT EXIT
:: ======================
:EXIT_SCRIPT
cls
echo.
echo Thank you for using Tweak - Windows Optimization Tool
timeout /t 3 >nul
exit	
