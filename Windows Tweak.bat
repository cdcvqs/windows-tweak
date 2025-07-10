@echo off
title Tweak - Windows Optimization Tool
setlocal enabledelayedexpansion
mode con: cols=120 lines=25

:MENU
cls
echo.
echo                               =====================[ MAIN MENU ]=====================
echo                            [1] Performance                            [2] Privacy/Security   
echo                            [3] Network                                [4] Programs 
echo                            [5] Customization                          [6] System
echo                            [7] Tools                                  [8] Exit
echo.
echo                               ========================================================

set /p choice="Enter your choice (1-8): "
if "%choice%"=="1" goto Performance_Menu
if "%choice%"=="2" goto Privacy_and_security_Menu
if "%choice%"=="3" goto Network_Menu
if "%choice%"=="4" goto Programs_Menu
if "%choice%"=="5" goto Customization_Menu
if "%choice%"=="6" goto System_Menu
if "%choice%"=="7" goto Tools_Menu
if "%choice%"=="8" goto exit

echo Invalid selection, please try again.
pause
goto MENU

:Performance_Menu
cls
echo =================[ PERFORMANCE SETTINGS ]=================
echo.
echo   [1] Services tweaks
echo   [2] Scheduler task tweaks
echo   [3] Clean up
echo   [4] Speed up boot
echo   [5] Disable visual effects
echo   [6] Power plan
echo   [7] Back 
echo.

set /p choice="Select an option (1-7): "

if "%choice%"=="1" goto Perf_Services_Tweaks
if "%choice%"=="2" goto Perf_Scheduler_Tweaks
if "%choice%"=="3" goto Perf_Clean
if "%choice%"=="4" goto Perf_SpeedUp_Boot
if "%choice%"=="5" goto Perf_Disable_Visual_Effects
if "%choice%"=="6" goto Perf_PowerPlan
if "%choice%"=="7" goto MENU

echo.
echo Invalid selection, please try again.
pause
goto Performance_Menu

:: ================================
::  Services tweaks Menu
:: ================================
:Perf_Services_tweaks
cls
echo ===============[  Services tweaks ]===============
echo.
echo   [1] Apply Tweaks
echo   [2] Restore Defaults
echo   [3] Back
echo.
echo ===================================================
set /p svcChoice="Select an option (1-3): "

if "%svcChoice%"=="1" goto Apply_Service_Tweaks
if "%svcChoice%"=="2" goto Restore_Services
if "%svcChoice%"=="3" goto Performance_Menu

echo Invalid selection, please try again.
pause
goto Perf_Services_tweaks

:: ================================
:: Apply Tweaks to Services
:: ================================
:Apply_Service_Tweaks
cls
echo Applying services tweaks...
echo.

:: Manual and Disabled service lists
set "ManualServices=AppIDSvc AppReadiness AppVClient Appinfo AssignedAccessManagerSvc AxInstSV BDESVC BFE BITS BTAGService BcastDVRUserService BluetoothUserService BrokerInfrastructure Browser BthAvctpSvc BthHFSrv CDPUserSvc COMSysApp CaptureService CertPropSvc ConsentUxUserSvc CoreMessagingRegistrar CredentialEnrollmentManagerUserSvc CryptSvc DPS DcomLaunch DcpSvc DevQueryBroker DeviceAssociationBrokerSvc DeviceAssociationService DeviceInstall DevicePickerUserSvc DevicesFlowUserSvc DialogBlockingService DispBrokerDesktopSvc DisplayEnhancementService DmEnrollmentSvc DsSvc DsmSvc EapHost EventLog EventSystem FontCache FrameServer FrameServerMonitor GraphicsPerfSvc HvHost IEEtwCollectorService IKEEXT InstallService InventorySvc IpxlatCfgSvc KeyIso KtmRm LSM LanmanServer LanmanWorkstation LicenseManager LxpSvc MSDTC MSiSCSI McpManagementService MpsSvc MsKeyboardFilter NPSMSvc NcaSvc NcbService NcdAutoSetup NetSetupSvc NetTcpPortSharing Netlogon Netman NgcCtnrSvc NgcSvc NlaSvc OneSyncSvc P9RdrService PNRPAutoReg PNRPsvc PenService PerfHost PimIndexMaintenanceSvc PolicyAgent Power PrintWorkflowUserSvc ProfSvc PushToInstall RasAuto RasMan RemoteAccess SDRSVC SENS SNMPTRAP SSDPSRV SamSs Schedule SecurityHealthService Sense SgrmBroker SharedAccess SharedRealitySvc ShellHWDetection SstpSvc StateRepository StiSvc StorSvc SystemEventsBroker TermService TextInputManagementService Themes TimeBroker TimeBrokerSvc TokenBroker TroubleshootingSvc TrustedInstaller UI0Detect UdkUserSvc UnistoreSvc UserDataSvc UserManager UsoSvc VGAuthService VMTools VSS VacSvc autotimesvc camsvc cbdhsvc cloudidsvc dcsvc defragsvc diagnosticshub.standardcollector.service dot3svc edgeupdate edgeupdatem embeddedmode gpsvc hidserv icssvc iphlpsvc lltdsvc lmhosts mpssvc msiserver netprofm nsi p2pimsvc p2psvc perceptionsimulation seclogon smphost spectrum sppsvc ssh-agent svsvc swprv tiledatamodelsvc uhssvc upnphost vds vm3dservice vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss webthreatdefsvc webthreatdefusersvc wercplsupport wisvc wlidsvc wlpasvc wmiApSrv workfolderssvc wscsvc wuauserv wudfsvc"
set "DisabledServices=AJRouter ALG AppMgmt AppXSvc bthserv CDPSvc ClipSVC CscService diagsvc DiagTrack dmwappushservice DoSvc MapsBroker DusmSvc EFS EntAppSvc Fax fdPHost FDResPub fhsvc HomeGroupListener HomeGroupProvider lfsvc NaturalAuthentication PcaSvc PeerDistSvc PhoneSvc pla PrintNotify QWAVE RemoteRegistry RetailDemo RmSvc RpcLocator ScDeviceEnum SCPolicySvc SEMgrSvc SensorDataService SensorService SensrSvc SessionEnv shpamsvc SCardSvr SmsRouter Spooler SysMain TabletInputService TapiSrv TieringEngineService TrkWks tzautoupdate UmRdpService UevAgentService VaultSvc W32Time WalletService wbengine WbioSrvc WebClient Wecsvc WEPHOSTSVC WerSvc WFDSConMgrSvc wcncsvc WdiServiceHost WdiSystemHost WMPNetworkSvc WPDBusEnum WpnService WSearch WwanSvc xbgm XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc"

:: Initialize counters
set "initial_auto=0"
set "initial_manual=0"
set "successfully_configured=0"
set "failed_to_configure=0"
set "services_not_found=0"
set "changed_from_auto=0"
set "initial_disabled=0"
set "disabled_successfully=0"
set "disabled_failed=0"
set "disabled_not_found=0"

echo Counting current service states...

:: Count current states (manual group)
for %%S in (%ManualServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do (
            if "%%T"=="2" set /a initial_auto+=1
            if "%%T"=="3" set /a initial_manual+=1
        )
    )
)

:: Count current disabled
for %%S in (%DisabledServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do (
            if "%%T"=="4" set /a initial_disabled+=1
        )
    )
)

echo Initial counts: Auto=!initial_auto!, Manual=!initial_manual!, Disabled=!initial_disabled!
echo.
echo Setting services to manual...

:: Set services to manual
for %%S in (%ManualServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        set "oldType="
        for /f "tokens=3" %%T in ('sc qc "%%S" ^| findstr "START_TYPE"') do set "oldType=%%T"
        sc config "%%S" start= demand >nul 2>&1 && (
            echo [SUCCESS] %%S
            set /a successfully_configured+=1
            if "!oldType!"=="2" set /a changed_from_auto+=1
        ) || (
            echo [FAILED ] %%S
            set /a failed_to_configure+=1
        )
    ) || (
        echo [NOTFOUND] %%S
        set /a services_not_found+=1
    )
)

echo.
echo Disabling services...

:: Disable services
for %%S in (%DisabledServices%) do (
    sc qc "%%S" >nul 2>&1 && (
        sc config "%%S" start= disabled >nul 2>&1 && (
            echo [DISABLED] %%S
            set /a disabled_successfully+=1
        ) || (
            echo [FAILED  ] %%S
            set /a disabled_failed+=1
        )
    ) || (
        echo [NOTFOUND] %%S
        set /a disabled_not_found+=1
    )
)

:: Calculate final counts
set /a final_auto=initial_auto - changed_from_auto
set /a final_manual=initial_manual + changed_from_auto
set /a final_disabled=initial_disabled + disabled_successfully

:: Show results
echo.
echo ========================
echo        FINAL REPORT
echo ========================
echo Auto services:     !initial_auto! to !final_auto!
echo Manual services:   !initial_manual! to !final_manual!
echo Disabled services: !initial_disabled! to !final_disabled!
echo.
echo Manual Set:  Success=!successfully_configured!, Fail=!failed_to_configure!, Missing=!services_not_found!
echo Disabled:    Success=!disabled_successfully!, Fail=!disabled_failed!, Missing=!disabled_not_found!
echo.
pause
goto Perf_Services_tweaks

:: ================================
:: Restore Default Service Settings
:: ================================
:Restore_Services
cls
echo Restoring default service startup types...
echo.
echo Starting services configuration process...
echo.

:: Initialize counters
set /a auto_success=0
set /a auto_failed=0
set /a manual_success=0
set /a manual_failed=0
set /a disabled_success=0
set /a disabled_failed=0

:: List of services to be set to AUTOMATIC startup
set "auto_services=AppHostSvc AudioEndpointBuilder Audiosrv BFE BITS BrokerInfrastructure CoreMessagingRegistrar CryptSvc DcomLaunch Dhcp DiagTrack Dnscache DoSvc DPS EventLog EventSystem FontCache ftpsvc gpsvc HomeGroupListener HomeGroupProvider HvHost iphlpsvc iprip LanmanServer LanmanWorkstation LPDSVC LSM MapsBroker MpsSvc MSMQ MSMQTriggers Netlogon NetMsmqActivator NetPipeActivator NetTcpActivator NlaSvc nsi PcaSvc Power ProfSvc RpcEptMapper RpcSs SamSs Schedule SENS ShellHWDetection simptcp SNMP Spooler sppsvc SysMain SystemEventsBroker TabletInputService TermService Themes tiledatamodelsvc TrkWks UserManager vmms W32Time W3SVC Wcmsvc WinDefend Winmgmt WlanSvc WMPNetworkSvc Wms WmsRepair wscsvc WSearch WwanSvc"

:: List of services to be set to MANUAL startup
set "manual_services=AJRouter ALG AppIDSvc Appinfo AppMgmt AppReadiness AppXSvc aspnet_state AxInstSV BDESVC Browser BthHFSrv bthserv c2wts CDPSvc CertPropSvc ClipSVC COMSysApp CscService DcpSvc defragsvc DeviceInstall DevQueryBroker diagnosticshub.standardcollector.service dot3svc DsmSvc DsRoleSvc DsSvc Eaphost EFS embeddedmode EntAppSvc Fax fdPHost FDResPub fhsvc FontCache3.0.0.0 hidserv icssvc IEEtwCollectorService IKEEXT KeyIso KtmRm lfsvc LicenseManager lltdsvc lmhosts MSDTC MSiSCSI msiserver NcaSvc NcbService NcdAutoSetup Netman netprofm NetSetupSvc NetTcpPortSharing NgcCtnrSvc NgcSvc p2pimsvc p2psvc PeerDistSvc PerfHost pla PlugPlay PNRPAutoReg PNRPsvc PolicyAgent PrintNotify QWAVE RasAuto RasMan RetailDemo RpcLocator SCPolicySvc SDRSVC seclogon SensorDataService SensorService SensrSvc SessionEnv SharedAccess smphost SmsRouter SNMPTRAP sppsvc SSDPSRV SstpSvc StateRepository stisvc StorSvc svsvc swprv TapiSrv TimeBroker TrustedInstaller UI0Detect UmRdpService upnphost UsoSvc VaultSvc vds vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss VSS w3logsvc WalletService WAS wbengine WbioSrv wcncsvc WcsPlugInService WdiServiceHost WdiSystemHost WdNisSvc WebClient Wecsvc WEPHOSTSVC wercplsupport WerSvc WiaRpc WinHttpAutoProxySvc WinRM wlidsvc wmiApSrv WMSVC workfolderssvc WPDBusEnum WpnService WSService wuauserv wudfsvc XblAuthManager XblGameSave XboxNetApiSvc"

:: List of services to be DISABLED
set "disabled_services=RemoteAccess RemoteRegistry SCardSvr"

echo ==========================================
echo        Setting Services to AUTOMATIC
echo ==========================================
echo.

:: Configure services to AUTOMATIC startup
for %%s in (%auto_services%) do (
    echo [PROCESSING] Setting service %%s to AUTOMATIC startup...
    
    :: Check if service exists
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc config "%%s" start=auto >nul 2>&1
        if !errorlevel! equ 0 (
            echo [SUCCESS] %%s set to AUTOMATIC startup
            set /a auto_success+=1
        ) else (
            echo [FAILED] %%s failed to set to AUTOMATIC startup
            set /a auto_failed+=1
        )
    ) else (
        echo [WARNING] %%s service not found in system
        set /a auto_failed+=1
    )
)

echo.
echo ==========================================
echo        Setting Services to MANUAL
echo ==========================================
echo.

:: Configure services to MANUAL startup
for %%s in (%manual_services%) do (
    echo [PROCESSING] Setting service %%s to MANUAL startup...
    
    :: Check if service exists
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        sc config "%%s" start=demand >nul 2>&1
        if !errorlevel! equ 0 (
            echo [SUCCESS] %%s set to MANUAL startup
            set /a manual_success+=1
        ) else (
            echo [FAILED] %%s failed to set to MANUAL startup
            set /a manual_failed+=1
        )
    ) else (
        echo [WARNING] %%s service not found in system
        set /a manual_failed+=1
    )
)

echo.
echo ==========================================
echo        DISABLING Services
echo ==========================================
echo.

:: Disable specified services
for %%s in (%disabled_services%) do (
    echo [PROCESSING] Disabling service %%s...
    
    :: Check if service exists
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        :: Stop the service first
        sc stop "%%s" >nul 2>&1
        :: Disable the service
        sc config "%%s" start=disabled >nul 2>&1
        if !errorlevel! equ 0 (
            echo [SUCCESS] %%s has been DISABLED
            set /a disabled_success+=1
        ) else (
            echo [FAILED] %%s failed to DISABLE
            set /a disabled_failed+=1
        )
    ) else (
        echo [WARNING] %%s service not found in system
        set /a disabled_failed+=1
    )
)

echo.
echo ==========================================
echo              OPERATION REPORT
echo ==========================================
echo.
echo Services set to AUTOMATIC startup:
echo   - Success: %auto_success% services
echo   - Failed: %auto_failed% services
echo.
echo Services set to MANUAL startup:
echo   - Success: %manual_success% services
echo   - Failed: %manual_failed% services
echo.
echo Services DISABLED:
echo   - Success: %disabled_success% services
echo   - Failed: %disabled_failed% services
echo.
set /a total_success=%auto_success% + %manual_success% + %disabled_success%
set /a total_failed=%auto_failed% + %manual_failed% + %disabled_failed%
set /a total_processed=%total_success% + %total_failed%

echo SUMMARY:
echo   - Total processed: %total_processed% services
echo   - Total success: %total_success% services
echo   - Total failed: %total_failed% services
echo.

if %total_failed% gtr 0 (
    echo [WARNING] Some services failed to configure
    echo Possible reasons: Service not found or protected from modification
) else (
    echo [COMPLETE] All services configured successfully!
)

echo.
echo Operation completed.
pause
goto Perf_Services_tweaks

:Perf_Scheduler_Tweaks

echo Disabling unnecessary Windows Scheduled Tasks...
echo.
:: ==========================================
:: TELEMETRY, TRACKING, AND DATA COLLECTION
:: ==========================================
echo [1/8] Disabling Telemetry and Data Collection Tasks...

schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable
schtasks /Change /TN "Microsoft\Windows\AppCompat\PT" /Disable

schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Disable

schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable

:: ==========================================
:: FEEDBACK AND EXPERIMENTATION
:: ==========================================
echo [2/8] Disabling Feedback and Experimentation Tasks...

schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable

schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable

:: ==========================================
:: DEVICE INFORMATION AND DIAGNOSTICS
:: ==========================================
echo [3/8] Disabling Device Information and Diagnostics Tasks...

schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device User" /Disable

schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\EnergyEstimation" /Disable
schtasks /Change /TN "Microsoft\Windows\WDI\ResolutionHost" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Disable

:: ==========================================
:: NETWORK TRACKING AND MONITORING
:: ==========================================
echo [4/8] Disabling Network Tracking and Monitoring Tasks...

schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable
schtasks /Change /TN "Microsoft\Windows\NlaSvc\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WCM\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WLANReport\WLANReportTask" /Disable

:: ==========================================
:: LOCATION AND MAPS SERVICES
:: ==========================================
echo [5/8] Disabling Location and Maps Services Tasks...

schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\Notifications" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\WindowsActionDialog" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\LocationNotification" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\SensorOverAcl" /Disable

:: ==========================================
:: INPUT DEVICES AND SYNCHRONIZATION
:: ==========================================
echo [6/8] Disabling Input Devices and Synchronization Tasks...

schtasks /Change /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\PenSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\InputSettingsRestoreDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\syncpensettings" /Disable

:: ==========================================
:: CLOUD, ENTERPRISE, AND MANAGEMENT
:: ==========================================
echo [7/8] Disabling Cloud, Enterprise, and Management Tasks...

schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\OOBE\BackgroundUserTask" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\Schedule" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\SyncML" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Cellular" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Logon" /Disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\Registration" /Disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\LoginCheck" /Disable
schtasks /Change /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Disable
schtasks /Change /TN "Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable

:: ==========================================
:: MISCELLANEOUS SERVICES AND FEATURES
:: ==========================================
echo [8/8] Disabling Miscellaneous Services and Features Tasks...

:: Language and Localization
schtasks /Change /TN "Microsoft\Windows\International\Synchronize Language Settings" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable
schtasks /Change /TN "Microsoft\Windows\MUI\LPRemove" /Disable

:: System Maintenance and Cleanup
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable
schtasks /Change /TN "Microsoft\Windows\Servicing\StartComponentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\Setup\SetupCleanupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Setup\SnapshotCleanupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Management" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable

:: Hardware and Sensors
schtasks /Change /TN "Microsoft\Windows\Camera\CameraAcquireSensorData" /Disable
schtasks /Change /TN "Microsoft\Windows\Camera\CameraFirstSensor" /Disable
schtasks /Change /TN "Microsoft\Windows\Camera\CameraBackgroundTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Sensor\SensorDataServiceStartupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Sensor\SensorServiceStartupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-Maintenance" /Disable

:: Gaming and Xbox
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /Disable

:: Printing Services
schtasks /Change /TN "Microsoft\Windows\Printing\EduPrintProv" /Disable
schtasks /Change /TN "Microsoft\Windows\Printing\PrinterCleanupTask" /Disable

:: Audio and Voice
schtasks /Change /TN "Microsoft\Windows\Shell\SoundRec" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\VoiceActivation" /Disable
schtasks /Change /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" /Disable

:: Family Safety and Parental Controls
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable

:: Mobile and Connectivity
schtasks /Change /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Disable
schtasks /Change /TN "Microsoft\Windows\Mobile Hotspot\HotspotTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Ras\MobilityManager" /Disable

:: Content and App Management
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\ContentDeliveryManager" /Disable
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\FeatureManager" /Disable
schtasks /Change /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" /Disable

:: Storage and Space Management
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Disable

:: Licensing and Updates
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\sih" /Disable

:: Other Services
schtasks /Change /TN "Microsoft\Windows\Task Manager\Interactive" /Disable
schtasks /Change /TN "Microsoft\Windows\UPnP\UPnPHostConfig" /Disable
schtasks /Change /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable

echo.
echo All scheduled tasks have been disabled successfully.
pause
goto Performance_Menu     
:: ================================
:: Clean Temporary & System Files
:: ================================
:Perf_Clean
cls
echo ================================
echo      SYSTEM CLEANUP START
echo ================================
echo.

:: --- Phase 1: Stop Services ---
echo.
echo Stopping Windows services for cleanup...
echo.

:: Stop Windows Update services
echo Stopping Windows Update services
net stop wuauserv   >nul 2>&1
net stop bits       >nul 2>&1
net stop cryptsvc   >nul 2>&1
net stop msiserver  >nul 2>&1

:: Wait for services to stop completely
timeout /t 3 /nobreak >nul 2>&1

:: --- Phase 2: Basic Cleanup ---
echo.
echo Basic System Cleanup...
echo.

:: Clean user temp files
echo Clean user temp files
if exist "%TEMP%" (
    del /q /f /s "%TEMP%\*.*"       >nul 2>&1
    for /d %%d in ("%TEMP%\*") do rd /s /q "%%d"  >nul 2>&1
)

:: Clean system temp files
echo Clean system temp files
if exist "%WINDIR%\Temp" (
    del /q /f /s "%WINDIR%\Temp\*.*" >nul 2>&1
    for /d %%d in ("%WINDIR%\Temp\*") do rd /s /q "%%d" >nul 2>&1
)

:: Clean prefetch files
echo Clean prefetch files
if exist "%WINDIR%\Prefetch" (
    del /q /f "%WINDIR%\Prefetch\*.pf"  >nul 2>&1
)

:: Clean recent files list
echo Clean recent files list
if exist "%APPDATA%\Microsoft\Windows\Recent" (
    del /q /f "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
)

:: --- Phase 3: Deep System Cleanup ---
echo.
echo Deep System Cleanup...
echo.

:: Clean Windows Update cache
echo Clean Windows Update cache
if exist "%WINDIR%\SoftwareDistribution\Download" (
    rd /s /q "%WINDIR%\SoftwareDistribution\Download" >nul 2>&1
    mkdir "%WINDIR%\SoftwareDistribution\Download"   >nul 2>&1
)

:: Remove Windows installation leftovers
echo Remove Windows installation leftovers
for %%X in ($GetCurrent $SysReset $Windows.~BT $Windows.~WS $WinREAgent) do (
    if exist "%SystemDrive%\%%X" rd /s /q "%SystemDrive%\%%X" >nul 2>&1
)

:: Remove Windows.old folder
echo Remove Windows.old folder
if exist "%SystemDrive%\Windows.old" (
    takeown /f "%SystemDrive%\Windows.old" /r /d y >nul 2>&1
    icacls "%SystemDrive%\Windows.old" /grant administrators:F /t >nul 2>&1
    rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
)

:: --- Phase 4: Browser Cache Cleanup ---
echo.
echo Browser Cache Cleanup...
echo.

:: Chrome cache & crash reports
echo Chrome cache
for %%P in (
    "Google\Chrome\User Data\Default\Cache"
    "Google\Chrome\User Data\Default\Cache2"
    "Google\Chrome\User Data\Default\Media Cache"
) do if exist "%LOCALAPPDATA%\%%P" rd /s /q "%LOCALAPPDATA%\%%P" >nul 2>&1

if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" (
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad\reports" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Google\CrashReports" (
    rd /s /q "%LOCALAPPDATA%\Google\CrashReports" >nul 2>&1
)

:: Brave cache
echo Brave cache
for %%P in (
    "BraveSoftware\Brave-Browser\User Data\Default\Cache"
    "BraveSoftware\Brave-Browser\User Data\Default\Cache2"
) do if exist "%LOCALAPPDATA%\%%P" rd /s /q "%LOCALAPPDATA%\%%P" >nul 2>&1

:: --- Phase 5: System Logs & Reports ---
echo.
echo System Logs and Error Reports...
echo.

:: Windows Error Reports
echo Windows Error Reports
for %%P in (
    "%LOCALAPPDATA%\Microsoft\Windows\WER"
    "%PROGRAMDATA%\Microsoft\Windows\WER"
) do if exist %%P del /q /f /s "%%P\*.*" >nul 2>&1

:: System and CBS logs
echo System and CBS logs
if exist "%WINDIR%\Logs\CBS" del /q /f /s "%WINDIR%\Logs\CBS\*.*"       >nul 2>&1
if exist "%WINDIR%\Panther" del /q /f /s "%WINDIR%\Panther\*.*"        >nul 2>&1
if exist "%WINDIR%\Installer" del /q /f /s "%WINDIR%\Installer\*.tmp"    >nul 2>&1
if exist "%SystemRoot%\Performance\WinSAT" del /q /f /s "%SystemRoot%\Performance\WinSAT\*.*" >nul 2>&1

:: Crash dumps and SleepStudy
echo Crash dumps and SleepStudy
if exist "%SystemRoot%\Minidump" rd /s /q "%SystemRoot%\Minidump"     >nul 2>&1
if exist "%SystemRoot%\System32\SleepStudy" rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1

:: Clear Windows Event Logs
echo Clear Windows Event Logs
for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G" >nul 2>&1

:: --- Phase 6: Enhanced Cleanup (New Features) ---
echo.
echo Enhanced System Cleanup...
echo.

:: Clean recently installed programs cache
echo Clean recently installed programs cache
if exist "%LOCALAPPDATA%\Microsoft\Windows\INetCache" (
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*.*" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Microsoft\Windows\INetCookies" (
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCookies\*.*" >nul 2>&1
)

:: Clean Windows Defender logs and old quarantine files
echo Clean Windows Defender logs and quarantine files
if exist "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History" (
    forfiles /p "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History" /s /c "cmd /c if @isdir==TRUE rd /s /q @path" >nul 2>&1
)
if exist "%PROGRAMDATA%\Microsoft\Windows Defender\Quarantine" (
    forfiles /p "%PROGRAMDATA%\Microsoft\Windows Defender\Quarantine" /m *.* /d -30 /c "cmd /c del /q @path" >nul 2>&1
)

:: Clean failed and pending updates
echo Clean failed and pending updates
if exist "%WINDIR%\SoftwareDistribution\DataStore" (
    del /q /f /s "%WINDIR%\SoftwareDistribution\DataStore\*.*" >nul 2>&1
)
if exist "%WINDIR%\WindowsUpdate.log" (
    del /q /f "%WINDIR%\WindowsUpdate.log" >nul 2>&1
)

:: Clean old SuperFetch/Prefetch files (older than 30 days)
echo Clean old SuperFetch/Prefetch files
if exist "%WINDIR%\Prefetch" (
    forfiles /p "%WINDIR%\Prefetch" /m *.pf /d -30 /c "cmd /c del /q @path" >nul 2>&1
)

:: Clean ReadyBoost temporary files
echo Clean ReadyBoost temporary files
if exist "%SystemRoot%\System32\ReadyBoost" (
    del /q /f /s "%SystemRoot%\System32\ReadyBoost\*.*" >nul 2>&1
)

:: Clean services cache
echo Clean services cache
if exist "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache" (
    del /q /f /s "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\*.*" >nul 2>&1
)

:: Clean indexing temporary files
echo Clean indexing temporary files
if exist "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows" (
    del /q /f /s "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\*.log" >nul 2>&1
)

:: Clean Windows Store Cache
echo Clean Windows Store Cache
if exist "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache" (
    del /q /f /s "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*.*" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\TempState" (
    del /q /f /s "%LOCALAPPDATA%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\TempState\*.*" >nul 2>&1
)

:: Clean additional Windows Store app caches
echo Clean Windows Store app caches
for /d %%d in ("%LOCALAPPDATA%\Packages\*") do (
    if exist "%%d\LocalCache" del /q /f /s "%%d\LocalCache\*.*" >nul 2>&1
    if exist "%%d\TempState" del /q /f /s "%%d\TempState\*.*" >nul 2>&1
)

:: Clean thumbnail cache
echo Clean thumbnail cache
if exist "%LOCALAPPDATA%\Microsoft\Windows\Explorer" (
    del /q /f "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1
)

:: Clean font cache
echo Clean font cache
if exist "%WINDIR%\System32\FNTCACHE.DAT" (
    del /q /f "%WINDIR%\System32\FNTCACHE.DAT" >nul 2>&1
)

:: Clean Windows Media Player cache
echo Clean Windows Media Player cache
if exist "%LOCALAPPDATA%\Microsoft\Media Player" (
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Media Player\*.*" >nul 2>&1
)

:: Clean Office cache files
echo Clean Office cache files
if exist "%LOCALAPPDATA%\Microsoft\Office" (
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Office\*.tmp" >nul 2>&1
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Office\*Cache*" >nul 2>&1
)

:: --- Phase 6: Final Cleanup ---
echo.
echo Final Cleanup...
echo.

:: Empty Recycle Bin
echo Empty Recycle Bin
powershell -command "Clear-RecycleBin -Force -Confirm:$false" >nul 2>&1

:: Restart services
echo.
echo Restarting services...
net start wuauserv   >nul 2>&1
net start bits       >nul 2>&1
net start cryptsvc   >nul 2>&1
net start msiserver  >nul 2>&1

:: Prompt for Disk Cleanup
:PromptCleanup
set /p runCleanup="Run Disk Cleanup? (Y/N): "
if /i "%runCleanup%"=="Y" (
    echo.
    cleanmgr /sagerun:1
    goto Performance_Menu
) else if /i "%runCleanup%"=="N" (
    goto Performance_Menu
) else (
    echo Invalid choice.
    goto PromptCleanup
)

:: Cleanup complete
echo.
echo Cleanup completed successfully.
pause
goto Performance_Menu

:: ================================
:: Speed Up Boot & Disable Startup
:: ================================
:Perf_SpeedUp_Boot
echo ================================
echo   BOOT OPTIMIZATION SCRIPT
echo ================================
echo.

:: Disable startup entries (Local Machine) by renaming values
echo [INFO] Processing startup entries...
for /f "tokens=1,2*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /i "REG_"') do (
    if "%%A" neq "" (
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%A_DISABLED" /t REG_SZ /d "%%C" /f >nul 2>&1
        reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%A" /f >nul 2>&1
    )
)

:: Ignore boot failures
bcdedit /set {current} bootstatuspolicy ignoreallfailures >nul 2>&1

:: Remove startup entries via PowerShell
powershell -Command "try { Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -ErrorAction SilentlyContinue | ForEach-Object { $_.PSObject.Properties | Where-Object { $_.Name -ne 'PSPath' -and $_.Name -ne 'PSParentPath' -and $_.Name -ne 'PSChildName' -and $_.Name -ne 'PSDrive' -and $_.Name -ne 'PSProvider' } | ForEach-Object { Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name $_.Name -ErrorAction SilentlyContinue } } } catch { Write-Host 'PowerShell cleanup completed' }" >nul 2>&1

:: Initialize counters
set "total=0"
set "success=0"
set "fail=0"

:: Function to apply an optimization
goto :start_optimizations

:apply_opt
set /a total+=1
echo [%total%] %~2
%~1 >nul 2>&1
if !errorLevel! equ 0 (
    echo    [SUCCESS]
    set /a success+=1
) else (
    echo    [FAILED]
    set /a fail+=1
)
echo.
goto :eof

:start_optimizations
:: --- Boot Menu & Timeout ---
call :apply_opt "bcdedit /timeout 3" "Set boot menu timeout to 3s"
call :apply_opt "bcdedit /set {current} bootmenupolicy legacy" "Enable legacy boot menu"

:: --- Startup Delay & Responsiveness ---
call :apply_opt "reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize\" /v StartupDelayInMSec /t REG_DWORD /d 0 /f" "Remove login delay"
call :apply_opt "reg add \"HKCU\Control Panel\Desktop\" /v MenuShowDelay /t REG_SZ /d 0 /f" "Speed up context menus"
call :apply_opt "reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" /v ExtendedUIHoverTime /t REG_DWORD /d 100 /f" "Improve hover response"

:: --- Quick Access Cleanup ---
call :apply_opt "reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\" /v ShowRecent /t REG_DWORD /d 0 /f" "Disable recent files"
call :apply_opt "reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\" /v ShowFrequent /t REG_DWORD /d 0 /f" "Disable frequent folders"

:: --- Windows Suggestions ---
call :apply_opt "reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\" /v SoftLandingEnabled /t REG_DWORD /d 0 /f" "Disable Windows tips"
call :apply_opt "reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f" "Disable pane suggestions"

:: --- Advanced Optimizations ---
call :apply_opt "powercfg -h off" "Disable hibernation & fast startup"
call :apply_opt "reg add \"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\" /v DisableAutomaticRestartSignOn /t REG_DWORD /d 1 /f" "Disable auto restart on update"

:: --- Results ---
cls
echo ================================
echo   BOOT OPTIMIZATION RESULTS
echo ================================
echo Total attempts:   %total%
echo Successful:      %success%
echo Failed:          %fail%
echo.
if %fail% equ 0 (
    echo [*] All optimizations applied successfully
) else (
    echo [!] Completed with %fail% failures
)
echo.
pause
goto Performance_Menu

:: ================================
:: Disable Visual Effects
:: ================================
:Perf_Disable_Visual_Effects
cls
echo ================================
echo    DISABLE VISUAL EFFECTS
echo ================================
echo.

:: Turn off all visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

:: Speed up menus and windows
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ     /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f

:: Disable transitions and peek
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek           /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f

:: Disable taskbar animations and shadows
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow      /t REG_DWORD /d 0 /f

:: Disable window animations
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarGlomLevel /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics"                      /v MinAnimate       /t REG_SZ    /d 0 /f

:: Disable transparency and shadows
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop"                                       /v DropShadows       /t REG_SZ    /d 0 /f

:: Disable mouse trails
reg add "HKCU\Control Panel\Mouse" /v MouseTrails      /t REG_SZ /d 0  /f
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f

:: Keep ClearType enabled
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing           /t REG_SZ    /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v FontSmoothingType       /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v FontSmoothingGamma      /t REG_DWORD /d 578 /f
reg add "HKCU\Control Panel\Desktop" /v FontSmoothingOrientation /t REG_DWORD /d 1   /f

:: Additional Explorer tweaks
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly           /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowInfoTip         /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowPreviewHandlers  /t REG_DWORD /d 0 /f

:: Disable Aero Shake
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f

:: Disable game DVR features
reg add "HKCU\System\GameConfigStore"                         /v GameDVR_Enabled       /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled     /t REG_DWORD /d 0 /f


echo.
echo Visual effects disabled; font smoothing remains enabled
pause
goto Performance_Menu

:: ================================
:: Power Plan Settings Menu
:: ================================
:Perf_PowerPlan
cls
echo ================================
echo     POWER PLAN OPTIONS
echo ================================
echo [1] High Performance
echo [2] Power Saver
echo [3] Ultimate Performance
echo [4] Balanced
echo [5] Back 
echo.
set /p choice="Select an option [1-5]: "

if /I "%choice%"=="1" goto Plan_High
if /I "%choice%"=="2" goto Plan_Saver
if /I "%choice%"=="3" goto Plan_Ultimate
if /I "%choice%"=="4" goto Plan_Balanced
if /I "%choice%"=="5" goto Performance_Menu

echo Invalid choice.
pause
goto Perf_PowerPlan

:: ================================
:: Activate High Performance Plan
:: ================================
:Plan_High
powercfg /setactive SCHEME_MIN
echo [+] High Performance activated.
pause
goto Performance_Menu

:: ================================
:: Activate Power Saver Plan
:: ================================
:Plan_Saver
powercfg /setactive SCHEME_MAX
echo [+] Power Saver activated.
pause
goto Performance_Menu

:: ================================
:: Activate Ultimate Performance Plan
:: ================================
:Plan_Ultimate
:: create Ultimate if missing
powercfg -query e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1 || powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo [+] Ultimate Performance activated.
pause
goto Performance_Menu

:: ================================
:: Activate Balanced Plan
:: ================================
:Plan_Balanced
powercfg /setactive SCHEME_BALANCED
echo [+] Balanced activated.
pause
goto Performance_Menu

:: ================================
:: Privacy & Security Settings
:: ================================
:Privacy_and_security_Menu
cls
echo =================[ PRIVACY / SECURITY ]================
echo.
echo   [1] Disable Telemetry
echo   [2] Disable Windows Updates
echo   [3] Block Apps Access to Files
echo   [4] Disable Windows Defender
echo   [5] Improve Network Security
echo   [6] Privacy clean up
echo   [7] Back 
echo.
echo =========================================================
set /p prChoice="Select an option (1-7): "

if "%prChoice%"=="1" goto Disable_Telemetry
if "%prChoice%"=="2" goto Disable_Updates
if "%prChoice%"=="3" goto Block_App_Access
if "%prChoice%"=="4" goto Disable_Defender
if "%prChoice%"=="5" goto Network_Security
if "%prChoice%"=="6" goto Privacy_cleanup
if "%prChoice%"=="7" goto MENU

echo Invalid selection.
pause
goto Privacy_and_security_Menu

:: ================================
:: Disable Telemetry
:: ================================
:Disable_Telemetry
cls
echo Disabling Telemetry...
echo.

echo Disabling specific Windows settings...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: Stop and disable DiagTrack service
sc stop DiagTrack      >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1

:: Stop and disable dmwappushservice
sc stop dmwappushservice      >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1

:: Disable Autologger for DiagTrack
set "regExport=%TEMP%\Diagtrack.reg"
set "regModified=%TEMP%\DiagtrackMod.reg"
reg export "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" "%regExport%" /y >nul 2>&1
powershell -Command ^
  "(Get-Content '%regExport%') -replace '\"Enabled\"=dword:00000001','\"Enabled\"=dword:00000000' | ^
   Set-Content '%regModified%'" >nul 2>&1
reg import "%regModified%" >nul 2>&1
del "%regExport%" "%regModified%" >nul 2>&1

:: Clear existing ETL logs
if exist "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\" del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\*.etl" >nul 2>&1
if exist "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\" del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\*.etl" >nul 2>&1

:: Disable Diagnostics Hub service
sc config diagnosticshub.standardcollector.service start= disabled >nul 2>&1

:: ================================
:: Disable Telemetry - Continued
:: ================================
:DisableTelemetryTasks
cls
echo Disabling scheduled telemetry tasks...
echo.

:: Disable telemetry-related scheduled tasks
for %%T in (Compat ProgramDataUpdater Consolidator KernelCeipTask UsbCeip) do (
    for /f "tokens=1,* delims=," %%A in ('schtasks /Query /FO CSV /NH ^| findstr /I "%%~T"') do (
        schtasks /Change /TN "%%~A" /Disable >nul 2>&1
    )
)

:: Remove Microsoft Compatibility Appraiser
if exist "%WINDIR%\System32\CompatTelRunner.exe" (
    takeown /F "%WINDIR%\System32\CompatTelRunner.exe" >nul 2>&1
    icacls "%WINDIR%\System32\CompatTelRunner.exe" /grant "%USERNAME%:F" >nul 2>&1
    del /f "%WINDIR%\System32\CompatTelRunner.exe" >nul 2>&1
)

:: Update registry to disable telemetry features
reg add "HKCU\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0"                          /v NoExplicitFeedback   /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                        /v AllowTelemetry       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\DataCollection"                                        /v AllowTelemetry       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v DontRetryOnError   /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v IsCensusDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v TaskEnableRun      /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"         /v AllowTelemetry       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat"                              /v AITEnable            /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                        /v AllowTelemetry       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger"                 /v Start                /t REG_DWORD /d 0 /f >nul 2>&1


schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device User" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\PenSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\International\Synchronize Language Settings" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Cellular" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Logon" /Disable
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Disable
schtasks /Change /TN "Microsoft\Windows\MUI\LPRemove" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\Registration" /Disable
schtasks /Change /TN "Microsoft\Windows\Ras\MobilityManager" /Disable
schtasks /Change /TN "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable
schtasks /Change /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" /Disable
schtasks /Change /TN "Microsoft\Windows\Servicing\StartComponentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Setup\SetupCleanupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Setup\SnapshotCleanupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Task Manager\Interactive" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-Maintenance" /Disable
schtasks /Change /TN "Microsoft\Windows\UPnP\UPnPHostConfig" /Disable
schtasks /Change /TN "Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WDI\ResolutionHost" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Management" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable
schtasks /Change /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\SoundRec" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\VoiceActivation" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\Notifications" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\WindowsActionDialog" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\EnergyEstimation" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\LocationNotification" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\SensorOverAcl" /Disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\OOBE\BackgroundUserTask" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\Schedule" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\SyncML" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\sih" /Disable
schtasks /Change /TN "Microsoft\Windows\WLANReport\WLANReportTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Camera\CameraAcquireSensorData" /Disable
schtasks /Change /TN "Microsoft\Windows\Camera\CameraFirstSensor" /Disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /Disable
schtasks /Change /TN "Microsoft\Windows\AppCompat\PT" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Sensor\SensorDataServiceStartupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Sensor\SensorServiceStartupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Camera\CameraBackgroundTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Mobile Hotspot\HotspotTask" /Disable
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\ContentDeliveryManager" /Disable
schtasks /Change /TN "Microsoft\Windows\ContentDeliveryManager\FeatureManager" /Disable
:: تجسس، تتبع، تليمتري
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Disable
:: تتبع الشبكة / الإنترنت
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable
schtasks /Change /TN "Microsoft\Windows\NlaSvc\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WCM\WiFiTask" /Disable


:: خرائط، موقع، جغرافيا
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\Notifications" /Disable
schtasks /Change /TN "Microsoft\Windows\Location\WindowsActionDialog" /Disable

:: Disable NVIDIA telemetry
sc stop NvTelemetryContainer                                                       >nul 2>&1
sc config NvTelemetryContainer start= disabled                                    >nul 2>&1
for %%T in (NvTmMon NvTmRep NvTmRepOnLogon NvProfileUpdaterDaily NvProfileUpdaterOnLogon) do (
    for /f "tokens=1 delims=," %%A in ('schtasks /Query /FO CSV ^| findstr "%%~T"') do (
        schtasks /Change /TN "%%~A" /Disable >nul 2>&1
    )
)
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable MS Office telemetry
for %%T in (
    "\Microsoft\Office\OfficeTelemetryAgentFallBack"
    "\Microsoft\Office\OfficeTelemetryAgentLogOn"
    "\Microsoft\Office\OfficeTelemetryAgentFallBack2016"
    "\Microsoft\Office\OfficeTelemetryAgentLogOn2016"
    "\Microsoft\Office\Office 15 Subscription Heartbeat"
    "\Microsoft\Office\Office 16 Subscription Heartbeat"
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1

reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" /v EnableLogging       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options"           /v EnableLogging       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" /v EnableLogging       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options"           /v EnableLogging       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry"      /v DisableTelemetry    /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry"      /v VerboseLogging      /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common"                 /v QMEnable            /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback"        /v Enabled             /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common"                 /v QMEnable            /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback"        /v Enabled             /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" /v EnableCalendarLogging /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" /v EnableCalendarLogging /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM"            /v EnableLogging       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM"            /v EnableUpload        /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM"            /v EnableLogging       /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM"            /v EnableUpload        /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowFullControl /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Windows Media Player usage tracking
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v UsageTracking /t REG_DWORD /d 0 /f >nul 2>&1
:: ================================
:: Block Telemetry Domains via Hosts File
:: ================================
set "hostsFile=%SystemRoot%\System32\drivers\etc\hosts"
set "marker=# Blocked by privacy script"

:: --- List of telemetry and tracking domains ---
set domains=^
oca.telemetry.microsoft.com ^
oca.microsoft.com ^
kmwatsonc.events.data.microsoft.com ^
watson.telemetry.microsoft.com ^
umwatsonc.events.data.microsoft.com ^
ceuswatcab01.blob.core.windows.net ^
ceuswatcab02.blob.core.windows.net ^
eaus2watcab01.blob.core.windows.net ^
eaus2watcab02.blob.core.windows.net ^
weus2watcab01.blob.core.windows.net ^
weus2watcab02.blob.core.windows.net ^
co4.telecommand.telemetry.microsoft.com ^
cs11.wpc.v0cdn.net ^
cs1137.wpc.gammacdn.net ^
modern.watson.data.microsoft.com ^
functional.events.data.microsoft.com ^
browser.events.data.msn.com ^
self.events.data.microsoft.com ^
v10.events.data.microsoft.com ^
v10c.events.data.microsoft.com ^
usv10c.events.data.microsoft.com ^
euv10c.events.data.microsoft.com ^
v10.vortexwin.data.microsoft.com ^
vortexwin.data.microsoft.com ^
telecommand.telemetry.microsoft.com ^
www.telecommandsvc.microsoft.com ^
umwatson.events.data.microsoft.com ^
watsonc.events.data.microsoft.com ^
euwatsonc.events.data.microsoft.com ^
settingswin.data.microsoft.com ^
settings.data.microsoft.com ^
inference.location.live.net ^
locationinferencewestus.cloudapp.net ^
maps.windows.com ^
ecn.dev.virtualearth.net ^
ecnus.dev.virtualearth.net ^
weathermapdata.blob.core.windows.net ^
arc.msn.com ^
ris.api.iris.microsoft.com ^
api.msn.com ^
assets.msn.com ^
c.msn.com ^
g.msn.com ^
ntp.msn.com ^
srtb.msn.com ^
www.msn.com ^
fd.api.iris.microsoft.com ^
staticview.msn.com ^
mucp.api.account.microsoft.com ^
query.prod.cms.rt.microsoft.com ^
business.bing.com ^
c.bing.com ^
th.bing.com ^
edgeassetservice.azureedge.net ^
cring.msedge.net ^
fp.msedge.net ^
Iring.msedge.net ^
sring.msedge.net ^
dualsring.msedge.net ^
creativecdn.com ^
aringfallback.msedge.net ^
fpafdnocacheccp.azureedge.net ^
prodazurecdnakamaiiris.azureedge.net ^
widgetcdn.azureedge.net ^
widgetservice.azurefd.net ^
fpvs.azureedge.net ^
lnring.msedge.net ^
tring.msedge.net ^
tringfdv2.msedge.net ^
tse1.mm.bing.net ^
config.edge.skype.com ^
evokewindowsservicestas.msedge.net ^
cdn.onenote.net ^
tileservice.weather.microsoft.com

echo.
echo Updating hosts file with blocked domains...
echo.

:: --- Add entries to hosts file if not already present ---
for %%D in (%domains%) do (
    findstr /i /c:"%%D" "%hostsFile%" >nul
    if errorlevel 1 (
        echo 0.0.0.0 %%D %marker%>>"%hostsFile%"
        echo [+] Blocked: %%D
    ) else (
        echo [=] Already exists: %%D
    )
)

echo.
echo [*] Done. Domains have been added to: %hostsFile%
pause
goto Privacy_and_security_Menu

:: ================================
:: Disable or Restore Windows Updates
:: ================================
:Disable_Updates
cls
echo ================================
echo        DISABLE WINDOWS UPDATES
echo ================================
echo   [1] Disable updates permanently
echo   [2] Restore updates (re-enable)
echo   [3] Back to Privacy Menu
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" goto DisableUpdates_Full
if "%choice%"=="2" goto RestoreUpdates
if "%choice%"=="3" goto Privacy_and_security_Menu

echo Invalid selection.
pause
goto Disable_Updates

:: ================================
:: Fully Disable Windows Update Services, Tasks & Registry
:: ================================
:DisableUpdates_Full
cls
echo [*] Disabling Windows Update services...

:: Stop and disable services
for %%S in (
    wuauserv
    UsoSvc
    bits
    dosvc
    uhssvc
    WaaSMedicSvc
) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    if /I "%%S"=="WaaSMedicSvc" (
        sc failure %%S reset= 0 actions= "" >nul 2>&1
    )
)

:: Disable update-related scheduled tasks
echo [*] Disabling scheduled tasks...
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\UpdateOrchestrator\*"
    "\Microsoft\Windows\UpdateAssistant\*"
    "\Microsoft\Windows\WaaSMedic\*"
) do (
    schtasks /Change /TN %%T /Disable >nul 2>&1
)

:: Set registry policies to block updates
echo [*] Setting Group Policy registry keys...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul

:: Clean update-related folders and temp data
echo [*] Cleaning update and temp files...
rd /s /q "%WinDir%\SoftwareDistribution\Download" >nul 2>&1
md "%WinDir%\SoftwareDistribution\Download" >nul 2>&1

for %%D in (Temp, Prefetch) do (
    rd /s /q "%WinDir%\%%D" >nul 2>&1
    md "%WinDir%\%%D" >nul 2>&1
)

rd /s /q "%Temp%" >nul 2>&1
md "%Temp%" >nul 2>&1

echo.
echo [*] Windows Updates have been fully disabled.
echo [!] A system restart is recommended to apply all changes.
pause
goto Privacy_and_security_Menu

:: ================================
:: Restore Windows Update Functionality
:: ================================
:RestoreUpdates
cls
echo [*] Restoring Windows Update services...

for %%S in (
    wuauserv
    UsoSvc
    bits
    dosvc
    uhssvc
    WaaSMedicSvc
) do (
    sc config %%S start= demand >nul 2>&1
    sc start %%S >nul 2>&1
)

echo [*] Enabling scheduled update tasks...
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\UpdateOrchestrator\*"
    "\Microsoft\Windows\UpdateAssistant\*"
    "\Microsoft\Windows\WaaSMedic\*"
) do (
    schtasks /Change /TN %%T /Enable >nul 2>&1
)

:: Restore registry settings to default
echo [*] Resetting registry policies...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /f >nul 2>&1

echo.
echo [*] Windows Update has been restored to default behavior.
pause
goto Privacy_and_security_Menu
:: ================================
:: Restore Windows Update Services and Tasks
:: ================================
:RESTORE
cls
echo ================================
echo      RESTORE WINDOWS UPDATES
echo ================================
echo.

:: Start and set services to automatic
echo [*] Restoring update services...
for %%S in (
    wuauserv
    UsoSvc
    bits
    dosvc
    uhssvc
    WaaSMedicSvc
) do (
    sc config %%S start= auto >nul 2>&1
    sc start %%S >nul 2>&1
)

:: Enable update-related scheduled tasks
echo [*] Enabling scheduled tasks...
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\UpdateOrchestrator\*"
    "\Microsoft\Windows\UpdateAssistant\*"
    "\Microsoft\Windows\WaaSMedic\*"
) do (
    schtasks /Change /TN %%T /Enable >nul 2>&1
)

:: Remove update-related group policy registry keys
echo [*] Removing Group Policy registry keys...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /f >nul 2>&1

echo.
echo [*] Restore complete. A system restart is recommended.
pause
goto MAIN_MENU

:: ================================
:: Block App Access to Personal Domains
:: ================================
:Block_App_Access
cls
set "HOSTS_FILE=%windir%\System32\drivers\etc\hosts"
echo.
echo Blocking IDM & CCleaner update/license domains in:
echo %HOSTS_FILE%
echo.

:: --- Function to add a host entry if not already present ---
:ADD_ENTRY
:: %~1 = domain name
set "DOMAIN=%~1"
findstr /i /c:"127.0.0.1 %DOMAIN%" "%HOSTS_FILE%" >nul 2>&1
if errorlevel 1 (
    echo 127.0.0.1 %DOMAIN% >> "%HOSTS_FILE%"
    echo [+] Added: %DOMAIN%
) else (
    echo [=] Already blocked: %DOMAIN%
)
goto :eof

:: --- Block IDM Domains ---
echo --- Blocking Internet Download Manager domains ---
for %%D in (
    tonec.com
    www.tonec.com
    internetdownloadmanager.com
    registeridm.com
    secure.internetdownloadmanager.com
    mirror.internetdownloadmanager.com
    mirror2.internetdownloadmanager.com
) do (
    call :ADD_ENTRY %%D
)

echo.

:: --- Block CCleaner Domains ---
echo --- Blocking CCleaner domains ---
for %%D in (
    piriform.com
    www.piriform.com
    license.piriform.com
    activate.piriform.com
    ipm-provider.piriform.com
    secure.piriform.com
    updates.piriform.com
    download.ccleaner.com
    www.ccleaner.com
) do (
    call :ADD_ENTRY %%D
)

echo.
echo All specified domains have been processed.
pause
goto Privacy

:: ====================================
:: Disable or Restore Windows Defender
:: ====================================
:Disable_Defender
cls
echo ====================================
echo         WINDOWS DEFENDER MENU
echo ====================================
echo.
echo   [1] Disable Defender and related services
echo   [2] Restore Defender
echo   [3] Back
echo.
set /p d_choice=Select an option [1-3]: 

if "%d_choice%"=="1" goto DISABLE_DEFENDER
if "%d_choice%"=="2" goto RESTORE_DEFENDER
if "%d_choice%"=="3" goto Privacy_and_security_Menu 
echo Invalid selection, please try again.
pause
goto Disable_Defender

:: ------------------------------------
:DISABLE_DEFENDER
cls
echo Disabling Windows Defender...
echo.

:: Kill core Defender processes
echo [*] Terminating Defender processes...
taskkill /f /im MsMpEng.exe >nul 2>&1
taskkill /f /im NisSrv.exe >nul 2>&1
taskkill /f /im SecurityHealthService.exe >nul 2>&1

:: Disable Defender services
echo [*] Disabling Defender services...
sc config WinDefend start= disabled >nul
sc config WdNisSvc start= disabled >nul
sc config SecurityHealthService start= disabled >nul
sc stop WinDefend >nul 2>&1
sc stop WdNisSvc >nul 2>&1
sc stop SecurityHealthService >nul 2>&1

:: Disable via Group Policy
echo [*] Applying Group Policy settings...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v DisableBlockAtFirstSeen /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Policy Manager" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f >nul

:: Prevent auto-start
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v Start /t REG_DWORD /d 4 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v Start /t REG_DWORD /d 4 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v Start /t REG_DWORD /d 4 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 0 /f >nul

:: Disable Tamper Protection
echo [*] Disabling Tamper Protection...
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul

:: Force Group Policy refresh
gpupdate /force >nul

:: Final message
echo.
echo --------------------------------------------------------
echo [SUCCESS] Windows Defender has been disabled
echo.
echo   - Tamper Protection is OFF
echo   - Real-time protection is disabled
echo   - System is now unprotected (as intended)
echo   - A reboot is recommended
pause
goto Disable_Defender

:: ------------------------------------
:RESTORE_DEFENDER
cls
echo Restoring Windows Defender...
echo.

:: Enable services
sc config WinDefend start= auto >nul
sc config WdNisSvc start= auto >nul
sc config SecurityHealthService start= auto >nul
sc start WinDefend >nul 2>&1
sc start WdNisSvc >nul 2>&1
sc start SecurityHealthService >nul 2>&1

:: Remove registry restrictions
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /f >nul 2>&1

:: Force Group Policy refresh
gpupdate /force >nul

echo.
echo [SUCCESS] Windows Defender has been restored.
pause
goto Disable_Defender
:: ================================
:: Restore Windows Defender Settings
:: ================================
:RESTORE_DEFENDER
cls
echo [*] Restoring Windows Defender configuration...
echo.

:: --- Restore core services ---
echo [*] Restoring Defender-related services...
sc config WinDefend start= auto >nul
sc config WdNisSvc start= auto >nul
sc config SecurityHealthService start= auto >nul
sc config Sense start= auto >nul
sc config WdBoot start= system >nul
sc config WdFilter start= system >nul

:: --- Remove Group Policy blocks ---
echo [*] Removing blocking Group Policy keys...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v DisableBlockAtFirstSeen /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Policy Manager" /v DisableRoutinelyTakingAction /f >nul 2>&1

:: --- Restore service startup registry ---
echo [*] Restoring service start settings...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v Start /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v Start /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v Start /t REG_DWORD /d 2 /f >nul

:: --- Enable Tamper Protection ---
echo [*] Enabling Tamper Protection...
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 5 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1

:: --- Enable real-time protection ---
echo [*] Enabling real-time protection...
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f >nul

:: --- Refresh Group Policy ---
echo [*] Refreshing Group Policy...
gpupdate /force >nul

:: --- Check final status ---
echo [*] Checking Defender service status...
sc query WinDefend | find "STATE"
sc query WdNisSvc | find "STATE"
sc query SecurityHealthService | find "STATE"

echo.
echo [✓] Windows Defender has been successfully restored!
pause
goto Privacy
:: ============================================
:: Improve Network Security and System Hardening
:: ============================================
:Network_Security
cls
echo ============================================
echo         NETWORK SECURITY HARDENING
echo ============================================

:: Step 1: Check Current Security Status
echo.
echo [1/10] Checking current security status...

:: Firewall Status
echo --- Firewall Status ---
netsh advfirewall show allprofiles | findstr "State"
echo.

:: Windows Defender Status
echo --- Windows Defender Status ---
sc query WinDefend | findstr "STATE"
echo.

:: Step 2: Open Ports & Connections
echo [2/10] Checking open ports and connections...

echo --- Listening Ports ---
netstat -an | findstr LISTENING
echo.

echo --- Established Connections ---
netstat -an | findstr ESTABLISHED
echo.

echo --- Network Configuration ---
ipconfig /all | findstr /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway" /C:"DNS Servers"
echo.

echo --- Routing Table ---
route print | findstr "0.0.0.0"
echo.

echo --- Connectivity Test ---
ping -n 2 8.8.8.8 | findstr "Reply"
echo.

:: Step 3: User Accounts & Groups
echo [3/10] Checking user accounts and groups...

echo --- Local Users ---
net user
echo.

echo --- Local Groups ---
net localgroup
echo.

echo --- Administrators Group ---
net localgroup administrators
echo.

:: Step 4: Enable Windows Firewall
echo [4/10] Enabling Windows Firewall...
netsh advfirewall set allprofiles state on
if %errorlevel% equ 0 (
    echo [SUCCESS] Windows Firewall enabled for all profiles
) else (
    echo [ERROR] Failed to enable Windows Firewall
)
echo.

:: Step 5: Block Commonly Exploited Ports
echo [5/10] Blocking unused network ports...
netsh advfirewall firewall add rule name="Block Telnet" protocol=TCP dir=in localport=23 action=block
netsh advfirewall firewall add rule name="Block FTP" protocol=TCP dir=in localport=21 action=block
netsh advfirewall firewall add rule name="Block TFTP" protocol=UDP dir=in localport=69 action=block
netsh advfirewall firewall add rule name="Block SNMP" protocol=UDP dir=in localport=161 action=block
netsh advfirewall firewall add rule name="Block NetBIOS UDP 137" protocol=UDP dir=in localport=137 action=block
netsh advfirewall firewall add rule name="Block NetBIOS UDP 138" protocol=UDP dir=in localport=138 action=block
netsh advfirewall firewall add rule name="Block NetBIOS TCP 139" protocol=TCP dir=in localport=139 action=block
echo [SUCCESS] Blocked common vulnerable ports
echo.

:: Step 6: Disable Remote Access Tools
echo [6/10] Disabling Windows remote tools...

:: Disable Remote Desktop
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul
echo [SUCCESS] Remote Desktop disabled

:: Disable Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul
echo [SUCCESS] Remote Assistance disabled

:: Disable Remote Registry Service
sc config "RemoteRegistry" start= disabled >nul
sc stop "RemoteRegistry" >nul 2>&1
echo [SUCCESS] Remote Registry service disabled
echo.

:: Step 7: Disable SMBv1 Protocol
echo [7/10] Disabling SMBv1 protocol...
dism /online /disable-feature /featurename:SMB1Protocol /NoRestart
if %errorlevel% equ 0 (
    echo [SUCCESS] SMBv1 protocol disabled
) else (
    echo [WARNING] SMBv1 may already be disabled or requires manual intervention
)

:: Disable via registry as backup
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f >nul
echo [SUCCESS] SMBv1 disabled via registry
echo.

:: Step 8: Disable Guest Account (optional)
echo [8/10] Disabling Guest account...
net user Guest /active:no >nul 2>&1
if %errorlevel% equ 0 (
    echo [SUCCESS] Guest account disabled
) else (
    echo [WARNING] Could not disable Guest account (may already be disabled)
)
echo.

:: Step 9: Configure Account Lockout Policy
echo [9/10] Setting account lockout policy...
net accounts /lockoutthreshold:5
net accounts /lockoutduration:30
net accounts /lockoutwindow:30
echo [SUCCESS] Lockout policy applied
echo.

:: Step 10: Disable Unused Services
echo [10/10] Disabling unnecessary services...

:: Telnet
sc config "TlntSvr" start= disabled >nul
sc stop "TlntSvr" >nul 2>&1
echo [SUCCESS] Telnet service disabled

:: FTP
sc config "FTPSVC" start= disabled >nul
sc stop "FTPSVC" >nul 2>&1
echo [SUCCESS] FTP service disabled

:: Computer Browser
sc config "Browser" start= disabled >nul
sc stop "Browser" >nul 2>&1
echo [SUCCESS] Computer Browser service disabled
echo.

echo ============================================
echo   Network security hardening completed!
echo ============================================
pause
goto Privacy

:: ================================
:: Clean Browser History and Cache
:: ================================
:Privacycleanup
cls
echo =====================================
echo         BROWSER DATA CLEANUP
echo =====================================
echo.

:: Clear Chrome History and Cache
set "chrome_dir=%LOCALAPPDATA%\Google\Chrome\User Data"
if exist "%chrome_dir%" (
    echo [*] Closing Chrome...
    taskkill /f /im chrome.exe >nul 2>&1
    timeout /t 2 /nobreak >nul

    echo [*] Cleaning Chrome data...
    set "chrome_default=%chrome_dir%\Default"
    if exist "%chrome_default%" (
        rd /s /q "%chrome_default%\Cache" >nul 2>&1
        del /q /f "%chrome_default%\History" >nul 2>&1
        del /q /f "%chrome_default%\Cookies" >nul 2>&1
        del /q /f "%chrome_default%\Top Sites" >nul 2>&1
        del /q /f "%chrome_default%\Favicons" >nul 2>&1
        del /q /f "%chrome_default%\Visited Links" >nul 2>&1
        echo [SUCCESS] Chrome history cleared.
    ) else (
        echo [WARNING] Chrome Default profile not found.
    )
) else (
    echo [INFO] Chrome is not installed or user data missing.
)

:: Clear Brave History and Cache
set "brave_dir=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data"
if exist "%brave_dir%" (
    echo.
    echo [*] Closing Brave...
    taskkill /f /im brave.exe >nul 2>&1
    timeout /t 2 /nobreak >nul

    echo [*] Cleaning Brave data...
    set "brave_default=%brave_dir%\Default"
    if exist "%brave_default%" (
        rd /s /q "%brave_default%\Cache" >nul 2>&1
        del /q /f "%brave_default%\History" >nul 2>&1
        del /q /f "%brave_default%\Cookies" >nul 2>&1
        del /q /f "%brave_default%\Top Sites" >nul 2>&1
        del /q /f "%brave_default%\Favicons" >nul 2>&1
        del /q /f "%brave_default%\Visited Links" >nul 2>&1
        echo [SUCCESS] Brave history cleared.
    ) else (
        echo [WARNING] Brave Default profile not found.
    )
) else (
    echo [INFO] Brave is not installed or user data missing.
)

echo.
echo [*] Browser data cleanup complete.
pause
goto Privacy_and_security_Menu 
:: ================================
:: UI & UX Customization Options
:: ================================
:Customization
cls
echo =================[ CUSTOMIZATION ]================
echo.
echo   [1] Disable Quick Access in File Explorer
echo   [2] Disable Lock Screen
echo   [3] Disable Recent Files
echo   [4] Show "This PC" in File Explorer
echo   [5] Restore Windows Photo Viewer
echo   [6] Enable Dark Mode
echo   [7] Enable File Extensions
echo   [8] Customize Right-Click Menu
echo   [9] Back to Main Menu
echo.
echo ================================================
set /p custchoice="Select an option (1-9): "

if "%custchoice%"=="1" goto Cust_DisableQuickAccess
if "%custchoice%"=="2" goto Cust_DisableLockScreen
if "%custchoice%"=="3" goto Cust_DisableRecentFiles
if "%custchoice%"=="4" goto Cust_ShowThisPC
if "%custchoice%"=="5" goto Cust_RestorePhotoViewer
if "%custchoice%"=="6" goto Cust_EnableDarkMode
if "%custchoice%"=="7" goto Cust_EnableFileExtensions
if "%custchoice%"=="8" goto Cust_CustomizeRightClick
if "%custchoice%"=="9" goto MENU

echo Invalid selection, please try again.
pause
goto Customization

:: ============================================
:: Disable Quick Access from File Explorer View
:: ============================================
:Cust_DisableQuickAccess
cls
echo Disabling Quick Access in File Explorer...

:: 1) Hide Quick Access in File Explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HubMode /t REG_DWORD /d 1 /f

:: 2) Make File Explorer open to "This PC" instead of Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: 3) Clear out all stored Quick Access entries
del /f /q "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*"
del /f /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*"

:: 4) Restart Explorer to apply changes immediately
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo [SUCCESS] Quick Access disabled.
pause
goto Customization

:: ============================
:: Disable Lock Screen Display
:: ============================
:Cust_DisableLockScreen
cls
echo Disabling Lock Screen...

:: Create policy key if it doesn't exist
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f >nul

:: Set policy to disable lock screen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Lock Screen disabled.
pause
goto Customization


:Cust_DisableRecentFiles
cls
echo Disable Recent Files...

:: Disable tracking of recently opened programs in Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f

:: Clear out the existing Recent Items list
del /f /q "%AppData%\Microsoft\Windows\Recent\*.*"

:: Hide Quick Access (disable its folder entry)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HubMode /t REG_DWORD /d 1 /f

:: Make File Explorer open to “This PC” instead of Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: Restart Explorer to apply all changes immediately
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo Recent Items, Recent Programs and Quick Access have been disabled.
echo File Explorer will now open to This PC by default.
pause
goto Customization
:: ===============================
:: Restore Windows Photo Viewer
:: ===============================
:Cust_RestorePhotoViewer
cls
echo Restoring Windows Photo Viewer...
echo.

:: Add Photo Viewer application capabilities
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationName" /d "Windows Photo Viewer" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationDescription" /d "View images using Windows Photo Viewer" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /f >nul

:: Associate common image formats
set extensions=.bmp .cr2 .crw .dib .dng .gif .jfif .jpe .jpeg .jpg .png .tif .tiff .wdp
for %%e in (%extensions%) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v "%%e" /d "PhotoViewer.FileAssoc.Tiff" /f >nul
    reg add "HKCR\%%e\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul
)

:: Set default association handler
for %%e in (%extensions%) do (
    reg add "HKCR\%%e" /ve /d "PhotoViewer.FileAssoc.Tiff" /f >nul
)

:: Add to "Open With" dialog
reg add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /d "\"%ProgramFiles%\Windows Photo Viewer\photoviewer.dll\" \"%%1\"" /f >nul
reg add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4375608A}" /f >nul

echo.
echo [✓] Windows Photo Viewer restored successfully.
pause
goto Customization

:: ==============================
:: Show File Extensions in Explorer
:: ==============================
:Cust_EnableFileExtensions
cls
echo [*] Enabling file extensions in File Explorer...

:: Enable file extensions in Explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

:: Restart Explorer to apply changes
echo Applying changes to Windows Explorer...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul

echo.
echo [+] File extensions are now visible.
pause
goto Customization

:Cust_CustomizeRightClick
cls
echo =============================
echo     Right Click Tweaks
echo =============================
echo [1] Add "Open PowerShell as Admin" for folders
echo [2] Add "Open CMD Here" for folders
echo [3] Add "Restart Explorer" on Desktop right-click
echo [4] Back to Customization Menu
echo =============================
set /p rcchoice="Select an option (1-4): "

if "%rcchoice%"=="1" goto RClick_PSAdmin
if "%rcchoice%"=="2" goto RClick_OpenCMD
if "%rcchoice%"=="3" goto RClick_RestartExplorer
if "%rcchoice%"=="4" goto Customization

echo Invalid selection.
pause
goto Cust_CustomizeRightClick

:RClick_PSAdmin
cls
echo Adding "Open PowerShell as Administrator"...

reg add "HKCR\Directory\shell\PowershellAsAdmin" /ve /d "Open PowerShell as Admin" /f
reg add "HKCR\Directory\shell\PowershellAsAdmin" /v "Icon" /d "powershell.exe" /f
reg add "HKCR\Directory\shell\PowershellAsAdmin\command" /ve /d "powershell.exe -NoExit -Command Start-Process powershell -Verb runAs -ArgumentList '-NoExit','-Command','Set-Location -LiteralPath ''%%V'''" /f

echo [SUCCESS] Added PowerShell as Admin to folder right-click menu.
pause
goto RightClickMenu

:RClick_OpenCMD
cls
echo Adding "Open CMD Here"...

reg add "HKCR\Directory\shell\OpenCmdHere" /ve /d "Open CMD Here" /f
reg add "HKCR\Directory\shell\OpenCmdHere" /v "Icon" /d "cmd.exe" /f
reg add "HKCR\Directory\shell\OpenCmdHere\command" /ve /d "cmd.exe /s /k pushd \"%%V\"" /f

echo [SUCCESS] Added CMD to folder right-click menu.
pause
goto Cust_CustomizeRightClick

:RClick_RestartExplorer
cls
echo Adding "Restart Explorer" to Desktop context menu...

reg add "HKCR\DesktopBackground\Shell\RestartExplorer" /ve /d "Restart Explorer" /f
reg add "HKCR\DesktopBackground\Shell\RestartExplorer" /v "Icon" /d "explorer.exe" /f
reg add "HKCR\DesktopBackground\Shell\RestartExplorer\command" /ve /d "cmd.exe /c taskkill /f /im explorer.exe && start explorer.exe" /f

echo [SUCCESS] Added Restart Explorer to desktop right-click menu.
pause
goto Cust_CustomizeRightClick

:Programs_Menu
cls
echo =================[ PROGRAMS ]================
echo.
echo   [1] Download Programs
echo   [2] Update Programs
echo   [3] Back
echo.
echo =========================================================
set /p prgchoice="Select an option (1-3): "
if "%prgchoice%"=="3" goto MENU
if "%prgchoice%"=="1" goto Programs_Download
if "%prgchoice%"=="2" goto Programs_Update

echo Invalid selection, please try again.
pause
goto Programs_Menu

:Programs_Download

:: Check if Chocolatey is already installed
echo Checking for existing Chocolatey installation...
where choco >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo Chocolatey is already installed!
    echo Current version:
    choco --version
    echo.
    echo Checking for available updates...
    
    :: Check if an update is available
    choco outdated chocolatey --limit-output >nul 2>&1
    if %errorlevel% equ 0 (
        echo Update available! Upgrading Chocolatey automatically...
        choco upgrade chocolatey -y
        if %errorlevel% equ 0 (
            echo.
            echo ✓ Chocolatey has been upgraded successfully!
            echo New version:
            choco --version
        ) else (
            echo.
            echo ✗ Failed to upgrade Chocolatey. Please try manually.
        )
    ) else (
        echo ✓ Chocolatey is already up to date!
    )
    goto :end
)

:: Chocolatey not found, proceed with installation
echo Chocolatey not found. Starting installation...
echo.

:: Set PowerShell execution policy
echo Configuring execution policy...
powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force" >nul 2>&1

:: Install Chocolatey
echo Installing Chocolatey. Please wait...
powershell -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" >nul 2>&1

:: Verify installation
echo Verifying installation...
where choco >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo ✓ Chocolatey installed successfully!
    echo.
    echo Installed version:
    choco --version
   
) else (
    echo.
    echo ✗ Chocolatey installation failed!
    echo Please try manual installation from:
    echo https://chocolatey.org/install
    echo.
)

:: Add Chocolatey to system PATH (in case it's not already there)
echo Adding Chocolatey to system PATH...
setx PATH "%PATH%;%ALLUSERSPROFILE%\chocolatey\bin" /M >nul 2>&1

:end
echo.
echo Press any key to exit...
pause >nul
cls
echo =============================
echo      Download Programs
echo =============================
echo [1] Download Google Chrome
echo [2] Download Brave Browser
echo [3] Download VLC Media Player
echo [4] Download Sumatra PDF
echo [5] Download WinRAR
echo [6] Download All Programs
echo [7] Back to Programs Menu
echo =============================
set /p dlchoice="Select an option (1-7): "

if "%dlchoice%"=="1" goto DL_Chrome
if "%dlchoice%"=="2" goto DL_Brave
if "%dlchoice%"=="3" goto DL_VLC
if "%dlchoice%"=="4" goto DL_Sumatra
if "%dlchoice%"=="5" goto DL_WinRAR
if "%dlchoice%"=="6" goto DL_All
if "%dlchoice%"=="7" goto Programs

echo Invalid selection.
pause
goto Programs_Download


:Install_Chrome
echo Installing Google Chrome...
choco install googlechrome -y
goto Programs_Download

:Install_Brave
echo Installing Brave Browser...
choco install brave -y
goto Programs_Download

:DL_VLC
echo Installing VLC Media Player...
choco install vlc -y
goto Programs_Download

:Install_Sumatra
echo Installing Sumatra PDF Reader...
choco install sumatrapdf.install -y
goto Programs_Download

:Install_WinRAR
echo Installing WinRAR...
choco install winrar -y
goto Programs_Download

:Install_All
echo Installing all selected programs...
choco install googlechrome brave vlc sumatrapdf.install winrar -y
pause
goto Programs_Download

:Programs_Update
cls
echo Update Programs...
choco outdated
pause
choco upgrade all -y
pause
goto Programs_Menu

:Network_Menu
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

echo Invalid selection, please try again.
pause
goto Network_Menu

:Network_TestSpeed
cls
echo Test Internet Speed

echo ======================================
echo        Internet Speed Test 
echo ======================================
echo.

:: Batch file to automatically download and run Speedtest
:: Created for Windows 10/11 systems with PowerShell

:: Set download URLs and paths
set "download_url=https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip"
set "zip_file=%TEMP%\speedtest.zip"
set "extract_dir=%TEMP%\speedtest"
set "exe_path=%extract_dir%\speedtest.exe"

:: Check if speedtest.exe already exists in temp
if exist "%exe_path%" (
    echo Found speedtest.exe
    goto run_test
)

:: Create extraction directory
if not exist "%extract_dir%" mkdir "%extract_dir%"

:: Download using PowerShell
echo Downloading Speedtest tool...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%download_url%' -OutFile '%zip_file%'"

:: Check if download succeeded
if not exist "%zip_file%" (
    echo Download failed. Please check your internet connection.
    pause
    exit /b 1
)

:: Extract the zip file
echo Extracting files...
powershell -Command "Expand-Archive -Path '%zip_file%' -DestinationPath '%extract_dir%' -Force"

:: Verify extraction
if not exist "%exe_path%" (
    echo Extraction failed. Please verify manually.
    pause
    goto Network_Menu
)

:: Cleanup zip file
del /f /q "%zip_file%"

:run_test
echo.
echo Measuring internet speed... Please wait
echo.

:: Run speedtest and show results
"%exe_path%" --accept-license --accept-gdpr

echo.
echo Test completed. Results are shown above.
echo.
pause
goto Network_Menu

:Network_Reset
cls
echo Reset Network Settings...

echo ==============================
echo     NETWORK RESET WARNING
echo ==============================
echo.
echo [!] This will reset ALL network settings to default
echo.
set /p confirm="Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto Network_Menu

cls
echo ==============================
echo     NETWORK RESET IN PROGRESS
echo ==============================
echo.
echo [*] Starting comprehensive network reset...
echo.
echo [*] Please wait, this may take several minutes...
echo.

REM Create function for executing commands with error handling
call :init_network_functions

echo [*] Phase 1: Stopping network services...
call :execute_network_command "net stop dnscache" "Stopping DNS Client service"
call :execute_network_command "net stop dhcp" "Stopping DHCP Client service"
call :execute_network_command "net stop lanmanserver" "Stopping Server service"
call :execute_network_command "net stop lanmanworkstation" "Stopping Workstation service"

echo [*] Phase 2: Resetting network components...
call :execute_network_command "ipconfig /release" "Releasing IP configuration"
call :execute_network_command "ipconfig /flushdns" "Flushing DNS cache"
call :execute_network_command "netsh winsock reset" "Resetting Winsock catalog"
call :execute_network_command "netsh int ip reset" "Resetting TCP/IP stack"
call :execute_network_command "netsh int tcp reset" "Resetting TCP settings"
call :execute_network_command "netsh int ipv4 reset" "Resetting IPv4 configuration"
call :execute_network_command "netsh int ipv6 reset" "Resetting IPv6 configuration"
call :execute_network_command "netsh winhttp reset proxy" "Removing proxy settings"
call :execute_network_command "netsh advfirewall reset" "Resetting Windows Firewall"

echo [*] Phase 3: Clearing network caches and tables...
call :execute_network_command "arp -d *" "Clearing ARP table"
call :execute_network_command "nbtstat -R" "Reloading NetBIOS name cache"
call :execute_network_command "nbtstat -RR" "Releasing and refreshing NetBIOS names"
call :execute_network_command "netsh int ip delete arpcache" "Clearing IP ARP cache"

echo [*] Phase 4: Resetting network adapters...
for /f "tokens=3*" %%a in ('netsh interface show interface ^| findstr /i "connected"') do (
    call :execute_network_command "netsh interface set interface \"%%b\" disable" "Disabling adapter: %%b"
    timeout /t 2 >nul
    call :execute_network_command "netsh interface set interface \"%%b\" enable" "Enabling adapter: %%b"
)

echo [*] Phase 5: Restarting network services...
call :execute_network_command "net start lanmanworkstation" "Starting Workstation service"
call :execute_network_command "net start lanmanserver" "Starting Server service"
call :execute_network_command "net start dhcp" "Starting DHCP Client service"
call :execute_network_command "net start dnscache" "Starting DNS Client service"

echo [*] Phase 6: Renewing IP configuration...
call :execute_network_command "ipconfig /renew" "Renewing IP configuration"

echo.
echo ==============================
echo    NETWORK RESET COMPLETED
echo ==============================
echo [*] Network reset completed successfully!
echo [*] Please restart your computer to apply all changes.
echo.
echo [*] After restart, you may need to:
echo     - Reconnect to WiFi networks
echo     - Reconfigure VPN settings
echo     - Reset custom DNS servers
echo.
pause
goto Network_Menu

:System_Menu
cls
echo =================[ SYSTEM ]================
echo.
echo   [1] Create Restore Point
echo   [2] Full Registry Backup
echo   [3] System File Check (sfc)
echo   [4] DISM Health Check
echo   [5] Disk Check (chkdsk)
echo   [6] Memory Diagnostic
echo   [7] System Information
echo   [8] Back
echo.
echo ============================================
set /p syschoice="Select an option (1-8): "
if "%syschoice%"=="8" goto MENU
if "%syschoice%"=="1" goto System_CreateRestore
if "%syschoice%"=="2" goto System_RegistryBackup
if "%syschoice%"=="3" goto System_SFC
if "%syschoice%"=="4" goto System_DISM
if "%syschoice%"=="5" goto System_Chkdsk
if "%syschoice%"=="6" goto System_MemoryTest
if "%syschoice%"=="7" goto System_Info

echo Invalid selection, please try again.
pause
goto System_Menu

:System_CreateRestore
cls
echo Create Restore Point...

echo ==============================
echo   SYSTEM RESTORE POINT
echo ==============================
echo.

:: Check if System Restore is available
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" >nul 2>&1 || (
    echo [!] System Restore is not available or disabled on this system.
    pause
    goto MENU
)

:: Create temporary PowerShell script
set "ps_script=%temp%\CreateRestore.ps1"

(
    echo $restorePointName = "Hello world"
    echo try {
    echo     Checkpoint-Computer -Description $restorePointName -RestorePointType "MODIFY_SETTINGS"
    echo     Write-Host "SUCCESS: Restore point '$restorePointName' created" -ForegroundColor Green
    echo     exit 0
    echo } catch {
    echo     Write-Host "ERROR: $_" -ForegroundColor Red
    echo     exit 1
    echo }
) > "%ps_script%"

:: Execute PowerShell script
powershell -ExecutionPolicy Bypass -NoProfile -File "%ps_script%"
if %errorlevel% equ 0 (
    echo  Restore point created successfully.
) else (
    echo  Failed to create restore point.
)

:: Clean up
del "%ps_script%" >nul 2>&1
echo.
pause
goto System_Menu

:System_RegistryBackup
cls
echo Full Registry Backup...

:: Setup paths and information
set "BackupPath=C:\ProgramData\RegistryBackup"
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "DateTime=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%-%dt:~12,2%"
set "BackupFolder=%BackupPath%\Registry_Backup_%DateTime%"

:: Create backup folder
if not exist "%BackupPath%" (
    mkdir "%BackupPath%"
    echo Created main folder: %BackupPath%
)

mkdir "%BackupFolder%"
if %errorLevel% neq 0 (
    echo Error creating backup folder!
    pause
    exit /b
)
echo Created backup folder: %BackupFolder%

echo.
echo Starting registry backup process...
echo.

:: Backup HKEY_LOCAL_MACHINE
echo Backing up HKEY_LOCAL_MACHINE...
reg export "HKEY_LOCAL_MACHINE" "%BackupFolder%\HKLM.reg" /y >nul 2>&1
if %errorLevel% equ 0 (
    echo [32m✓ Successfully backed up HKEY_LOCAL_MACHINE[0m
) else (
    echo [31m✗ Failed to backup HKEY_LOCAL_MACHINE[0m
)

:: Backup HKEY_CURRENT_USER
echo Backing up HKEY_CURRENT_USER...
reg export "HKEY_CURRENT_USER" "%BackupFolder%\HKCU.reg" /y >nul 2>&1
if %errorLevel% equ 0 (
    echo [32m✓ Successfully backed up HKEY_CURRENT_USER[0m
) else (
    echo [31m✗ Failed to backup HKEY_CURRENT_USER[0m
)

:: Backup HKEY_USERS
echo Backing up HKEY_USERS...
reg export "HKEY_USERS" "%BackupFolder%\HKU.reg" /y >nul 2>&1
if %errorLevel% equ 0 (
    echo [32m✓ Successfully backed up HKEY_USERS[0m
) else (
    echo [31m✗ Failed to backup HKEY_USERS[0m
)

:: Backup HKEY_CLASSES_ROOT
echo Backing up HKEY_CLASSES_ROOT...
reg export "HKEY_CLASSES_ROOT" "%BackupFolder%\HKCR.reg" /y >nul 2>&1
if %errorLevel% equ 0 (
    echo [32m✓ Successfully backed up HKEY_CLASSES_ROOT[0m
) else (
    echo [31m✗ Failed to backup HKEY_CLASSES_ROOT[0m
)

:: Backup HKEY_CURRENT_CONFIG
echo Backing up HKEY_CURRENT_CONFIG...
reg export "HKEY_CURRENT_CONFIG" "%BackupFolder%\HKCC.reg" /y >nul 2>&1
if %errorLevel% equ 0 (
    echo [32m✓ Successfully backed up HKEY_CURRENT_CONFIG[0m
) else (
    echo [31m✗ Failed to backup HKEY_CURRENT_CONFIG[0m
)

echo.
echo ==================================================
echo Backup completed successfully!
echo Path: %BackupFolder%
echo ==================================================
echo.

:: Open backup folder (optional)
set /p OpenFolder="Do you want to open the backup folder? (y/n): "
if /i "%OpenFolder%"=="y" (
    start explorer "%BackupFolder%"
)

echo.
pause
goto System_Menu

:System_SFC
cls
echo System File Check (sfc)...
sfc /scannow
pause
goto System_Menu

:System_DISM
cls
echo DISM Health Check...
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto System_Menu

:System_Chkdsk
cls
echo Disk Check (chkdsk)...
echo Available drives:
wmic logicaldisk get size,freespace,caption
echo.
set /p drive="Enter drive letter to check (e.g., C): "
echo.
echo Checking disk %drive%: for errors...
chkdsk %drive%: /f /r /x
pause
goto System_Menu

:System_MemoryTest
cls
echo Memory Diagnostic...
echo This will schedule a memory test on next restart.
echo Your computer will restart automatically.
echo.
set /p confirm="Continue? (Y/N): "
if /i "%confirm%"=="Y" (
    echo Scheduling memory diagnostic...
    mdsched.exe
	) else (
    echo Memory diagnostic cancelled.
)
pause
goto System_Menu

:System_Info
cls
echo System Information 

REM ===== Basic Info =====
echo Date and Time:
echo Current Date: %date%
echo Current Time: %time%
echo.

echo Computer Name: %COMPUTERNAME%
echo Current User: %USERNAME%
echo.
REM ===== System Info =====
echo System information:
powershell -Command "systeminfo | findstr /C:'OS Name' /C:'OS Version' /C:'System Type' /C:'Total Physical Memory' /C:'Available Physical Memory' /C:'System Manufacturer' /C:'System Boot Time' /C:'System Locale' | ForEach-Object {Write-Host \$_ -ForegroundColor Green}"
echo.


REM ===== Administrator Users =====
echo Administrator Users:
powershell -Command "try { Get-LocalGroupMember -Group 'Administrators' | Format-Table -AutoSize } catch { net localgroup administrators }"
echo.

REM ===== Login History =====
echo System Login History:
echo.

echo Recent Login Events:
powershell -Command "try { Get-EventLog -LogName Security -InstanceId 4624 -Newest 10 -ErrorAction Stop | Where-Object { $_.ReplacementStrings[5] -notlike '*$' -and $_.ReplacementStrings[5] -ne 'SYSTEM' -and $_.ReplacementStrings[5] -ne 'ANONYMOUS LOGON' } | ForEach-Object { 'Login: ' + $_.ReplacementStrings[5] + ' on ' + $_.TimeGenerated + ' (Logon Type: ' + $_.ReplacementStrings[8] + ')' } } catch { 'Login history not accessible or empty' }"

echo Failed Login Attempts:
powershell -Command "try { Get-EventLog -LogName Security -InstanceId 4625 -Newest 5 -ErrorAction Stop | ForEach-Object { 'Failed Login: ' + $_.ReplacementStrings[5] + ' on ' + $_.TimeGenerated + ' from ' + $_.ReplacementStrings[19] } } catch { 'No recent failed login attempts found' }"

echo Currently Logged In Users:
powershell -Command "try { Get-WmiObject -Class Win32_LoggedOnUser | ForEach-Object { $user = ([wmi]$_.Dependent).Name; $domain = ([wmi]$_.Dependent).Domain; if ($user -ne 'SYSTEM' -and $user -ne 'LOCAL SERVICE' -and $user -ne 'NETWORK SERVICE') { 'Active User: ' + $domain + '\' + $user } } } catch { query user }"
echo.

REM ===== Uptime =====
powershell -Command "$uptime = (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime; 'System Uptime: ' + $uptime.Days + ' days, ' + $uptime.Hours + ' hours, ' + $uptime.Minutes + ' minutes'"
echo.

REM ===== Security Status =====
echo Security Status:
echo.

echo Firewall Status:
powershell -Command "$firewall = Get-NetFirewallProfile | Where-Object {$_.Enabled -eq $true}; if ($firewall) { 'Windows Firewall: ENABLED - PROTECTED' } else { 'Windows Firewall: DISABLED - VULNERABLE' }"
echo.

echo Windows Defender Status:
powershell -Command "try { $defender = Get-MpComputerStatus -ErrorAction Stop; if ($defender.AntivirusEnabled) { 'Windows Defender: ENABLED - PROTECTED' } else { 'Windows Defender: DISABLED - VULNERABLE' } } catch { 'Windows Defender: STATUS UNKNOWN' }"
echo.

echo Windows Update Status:
powershell -Command "try { $updates = Get-WindowsUpdate -ErrorAction Stop | Measure-Object; if ($updates.Count -eq 0) { 'Windows Updates: UP TO DATE' } else { 'Windows Updates: ' + $updates.Count + ' UPDATES AVAILABLE' } } catch { $lastUpdate = (Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn; 'Last Update Installed: ' + $lastUpdate }"
echo.

REM ===== Performance Info =====
echo System Performance:
echo.

echo Disk Usage:
powershell -Command "Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | ForEach-Object { $total = [math]::Round($_.Size/1GB, 2); $free = [math]::Round($_.FreeSpace/1GB, 2); $used = $total - $free; $percent = [math]::Round(($used/$total)*100, 2); 'Drive ' + $_.DeviceID + ' - Total: ' + $total + ' GB | Used: ' + $used + ' GB (' + $percent + '%) | Free: ' + $free + ' GB' }"
echo.

REM ===== Disk Type and Health =====
echo Disk Type and Health:
echo.

powershell -Command "try { Get-PhysicalDisk | ForEach-Object { $disk = $_; $health = $disk.HealthStatus; $mediaType = $disk.MediaType; $diskType = switch ($mediaType) { 'SSD' { 'SSD' } 'HDD' { 'HDD' } default { if ($disk.SpindleSpeed -eq 0) { 'SSD' } elseif ($disk.SpindleSpeed -gt 0) { 'HDD' } else { 'Unknown' } } }; 'Disk: ' + $disk.FriendlyName + ' | Type: ' + $diskType + ' | Health: ' + $health } } catch { 'Disk information not available' }"
echo.

REM ===== Pagefile and Virtualization =====
echo Pagefile:
echo.
powershell -Command "try { Get-WmiObject -Class Win32_PageFileUsage | ForEach-Object { 'Pagefile Size: ' + [math]::Round($_.AllocatedBaseSize/1024, 2) + ' GB | Used: ' + [math]::Round($_.CurrentUsage/1024, 2) + ' GB' } } catch { 'Pagefile information not available' }"
echo.

echo Virtualization Status:
echo.
powershell -Command "$cpu = Get-WmiObject -Class Win32_Processor; if ($cpu.VirtualizationFirmwareEnabled -eq $true) { 'Virtualization: ENABLED' } else { 'Virtualization: DISABLED' }"
echo.

REM ===== Hardware Info =====
echo Hardware Information:
echo.

echo CPU Information:
wmic cpu get name /format:list | findstr /r /v "^$"
echo.

echo Graphics Card (GPU) Information:
wmic path win32_VideoController get name /format:list | findstr /r /v "^$"
echo.

echo Battery Status:
powershell -Command "try { $battery = Get-WmiObject -Class Win32_Battery; if ($battery) { 'Battery Level: ' + $battery.EstimatedChargeRemaining + '% | Status: ' + $(if ($battery.BatteryStatus -eq 2) {'Charging'} else {'Not Charging'}) } else { 'No battery detected (Desktop PC)' } } catch { 'Battery information not available' }"
echo.

echo Screen Resolution:
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Size; 'Screen Resolution: ' + $screen.Width + 'x' + $screen.Height"
echo.

REM ===== Hardware Temperatures =====
echo Hardware Temperatures:
echo.

echo CPU Temperature:
powershell -Command "try { $temp = Get-WmiObject -Namespace 'root\wmi' -Class MSAcpi_ThermalZoneTemperature | Select-Object -First 1; if ($temp) { $celsius = [math]::Round(($temp.CurrentTemperature / 10) - 273.15, 1); 'CPU Temperature: ' + $celsius + '°C' } else { 'CPU Temperature: Not available via WMI' } } catch { 'CPU Temperature: Sensor not accessible' }"

echo Alternative CPU Temperature Check:
powershell -Command "try { $cpu = Get-Counter '\Thermal Zone Information(*)\Temperature' -ErrorAction Stop; $temp = ($cpu.CounterSamples | Measure-Object CookedValue -Average).Average; if ($temp -gt 0) { $celsius = [math]::Round($temp - 273.15, 1); 'CPU Temperature: ' + $celsius + '°C' } else { 'CPU Temperature: Not available' } } catch { 'CPU Temperature: Performance counter not available' }"

echo System Temperature Sensors:
powershell -Command "try { Get-WmiObject -Namespace 'root\wmi' -Class MSAcpi_ThermalZoneTemperature | ForEach-Object { $celsius = [math]::Round(($_.CurrentTemperature / 10) - 273.15, 1); 'Thermal Zone: ' + $celsius + '°C' } } catch { 'Thermal sensors: Not accessible via WMI' }"
echo.

REM ===== Network Testing =====
echo Network Information:
echo.

echo Internet Connection Status:
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% equ 0 (
    echo Status: CONNECTED TO INTERNET
) else (
    echo Status: NO INTERNET CONNECTION
)
echo.

echo Network Adapter Information:
echo.
wmic path Win32_NetworkAdapter where "NetConnectionStatus=2" get Name,NetConnectionID,Speed /format:list | findstr /r /v "^$"
echo.

REM ===== Wi-Fi Networks =====
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

REM ===== System Applications =====
echo Startup Applications:
echo.
powershell -Command "Get-CimInstance Win32_StartupCommand | Select Name,Command,Location | Format-Table -AutoSize"
echo.
echo All Installed Programs:
powershell -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName} | Sort-Object InstallDate -Descending | Select-Object DisplayName, InstallDate, Publisher | Format-Table -AutoSize"
echo.
pause 


echo ================================================
echo                 REPORT COMPLETE
echo ================================================
echo.
echo Press any key to continue...
pause >nul
goto SAVE_MENU

:SAVE_MENU
cls
echo ================================================
echo                 SAVE OPTIONS
echo ================================================
echo.
echo [1] Save Report to Documents
echo [2] Back
echo.
set /p save_choice="Select option (1-2): "

if "%save_choice%"=="1" goto SAVE_REPORT
if "%save_choice%"=="2" goto System
goto SAVE_MENU

:SAVE_REPORT
set "timestamp=%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "filename=SystemInfo_Report_%timestamp%.txt"
set "documents_path=%USERPROFILE%\Documents"
set "full_path=%documents_path%\%filename%"

echo ================================================
echo         GENERATING REPORT FILE
echo ================================================
echo.
echo Saving system report...
echo Location: %documents_path%
echo Filename: %filename%
echo.

REM Generate complete report
(
    echo ================================================
    echo    COMPLETE SYSTEM INFORMATION REPORT
    echo    Generated on: %date% at %time%
    echo    Computer: %COMPUTERNAME%
    echo    User: %USERNAME%
    echo ================================================
    echo.
    call :FULL_REPORT_DATA
) > "%full_path%" 2>&1

echo ================================================
echo       REPORT SAVED SUCCESSFULLY!
echo ================================================
echo.
echo File: %filename%
echo Size: 
for %%i in ("%full_path%") do echo %%~zi bytes
echo Location: %documents_path%
echo.
echo Opening Documents folder...
timeout /t 2 /nobreak >nul
explorer "%documents_path%"
echo.
pause
goto SAVE_MENU

:FULL_REPORT_DATA
REM This generates the data for file output
echo BASIC INFORMATION:
echo Date and Time: %date% %time%
echo Computer Name: %COMPUTERNAME%
echo Current User: %USERNAME%
echo.

echo SYSTEM INFORMATION:
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"System Manufacturer" /C:"System Boot Time"
echo.

echo BOOT AND UPTIME:
powershell -Command "try { Get-WinEvent -FilterHashtable @{LogName='System'; ID=100} -MaxEvents 1 | ForEach-Object { 'Last Boot Duration: ' + [math]::Round($_.Properties[1].Value / 1000, 2) + ' seconds' } } catch { 'Boot duration information not available' }"
powershell -Command "$uptime = (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime; 'System Uptime: ' + $uptime.Days + ' days, ' + $uptime.Hours + ' hours, ' + $uptime.Minutes + ' minutes'"
echo.

echo SECURITY STATUS:
echo.
echo Firewall Status:
echo.
powershell -Command "$firewall = Get-NetFirewallProfile | Where-Object {$_.Enabled -eq $true}; if ($firewall) { 'Windows Firewall: ENABLED - PROTECTED' } else { 'Windows Firewall: DISABLED - VULNERABLE' }"
echo.
echo Windows Defender Status:
powershell -Command "try { $defender = Get-MpComputerStatus -ErrorAction Stop; if ($defender.AntivirusEnabled) { 'Windows Defender: ENABLED - PROTECTED' } else { 'Windows Defender: DISABLED - VULNERABLE' } } catch { 'Windows Defender: STATUS UNKNOWN' }"
echo Windows Update Status:
powershell -Command "try { $updates = Get-WindowsUpdate -ErrorAction Stop | Measure-Object; if ($updates.Count -eq 0) { 'Windows Updates: UP TO DATE' } else { 'Windows Updates: ' + $updates.Count + ' UPDATES AVAILABLE' } } catch { $lastUpdate = (Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn; 'Last Update Installed: ' + $lastUpdate }"
echo.

echo PERFORMANCE INFORMATION:
powershell -Command "$mem = Get-CimInstance -ClassName Win32_OperatingSystem; $total = [math]::Round($mem.TotalVisibleMemorySize/1MB, 2); $free = [math]::Round($mem.FreePhysicalMemory/1MB, 2); $used = $total - $free; $percent = [math]::Round(($used/$total)*100, 2); 'Memory Usage: ' + $used + '/' + $total + ' GB (' + $percent + '%)'"
powershell -Command "Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | ForEach-Object { $total = [math]::Round($_.Size/1GB, 2); $free = [math]::Round($_.FreeSpace/1GB, 2); $used = $total - $free; $percent = [math]::Round(($used/$total)*100, 2); 'Drive ' + $_.DeviceID + ' Usage: ' + $used + '/' + $total + ' GB (' + $percent + '%)' }"
echo.

echo HARDWARE INFORMATION:
wmic cpu get name /format:list | findstr /r /v "^$"
wmic path win32_VideoController get name /format:list | findstr /r /v "^$"
echo.

echo NETWORK INFORMATION:
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% equ 0 (echo Internet Status: CONNECTED) else (echo Internet Status: DISCONNECTED)
powershell -Command "$start = Get-Date; try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $web = New-Object System.Net.WebClient; $web.Headers.Add('User-Agent', 'Mozilla/5.0'); $data = $web.DownloadData('http://speedtest.ftp.otenet.gr/files/test1Mb.db'); $end = Get-Date; $duration = ($end - $start).TotalSeconds; if ($duration -gt 0) { $speed = [math]::Round((1 * 8) / $duration, 2); 'Download Speed: ' + $speed + ' Mbps' } else { 'Download Speed: Very Fast (>100 Mbps)' } } catch { 'Speed test: Failed or blocked' }"
echo.

echo APPLICATIONS AND USERS:
powershell -Command "try { Get-LocalGroupMember -Group 'Administrators' | Format-Table -AutoSize } catch { net localgroup administrators }"
echo.
pause
goto System_Menu

:Tools_Menu
cls
echo =================[ TOOLS ]================
echo.
echo   [1] Activate Windows
echo   [2] Launch Chris Titus Tool
echo   [3] Back
echo.
echo ============================================
set /p toolschoice="Select an option (1-3): "
if "%toolschoice%"=="3" goto MENU
if "%toolschoice%"=="1" goto Tools_ActivateWindows
if "%toolschoice%"=="2" goto Tools_LaunchTitus

echo Invalid selection, please try again.
pause
goto Tools_Menu

:Tools_ActivateWindows
cls
echo Activate Windows
echo.
echo 1. Activate Windows
echo 2. Check Activation Status
echo 3. Back 
echo.

choice /c 123 /n /m "Select an option: "

if errorlevel 1 goto RUN_ACTIVATION
if errorlevel 2 goto CHECK_ACTIVATION
if errorlevel 3 goto MENU

goto MENU

:RUN_ACTIVATION
cls
echo.
echo ==============================
echo     ACTIVATING WINDOWS
echo ==============================
echo.
echo Connecting to activation servers...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
echo [*] Activation script executed.
echo Please check the system activation status manually.
pause
goto Tools_ActivateWindows


:CHECK_ACTIVATION
cls
echo.
echo ==============================
echo   CHECK WINDOWS ACTIVATION
echo ==============================
echo.
echo Running activation status check...
cscript //nologo "%SystemRoot%\System32\slmgr.vbs" /xpr
echo.
pause
goto Tools_ActivateWindows

:Tools_LaunchTitus
cls
echo Launch Chris Titus Tool...

echo [*] Downloading and launching optimization tool...
echo.

:: Launch Chris Titus PowerShell GUI
start "" powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://christitus.com/win | iex"

echo.
echo [*] The Chris Titus tool should now be running.
pause
goto Tools_Menu
