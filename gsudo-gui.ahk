/* eslint-disable */
#Requires AutoHotkey v2+
#SingleInstance
Persistent

#Include ./gsudo-gui.hotkeys.ahk
#Include ./gsudo-gui.isdev.ahk
#Include ./gsudo-gui.lang.ahk

LANG := "EN"

ITMAppName := "ITM - Application Control"
CheckTime := 1000
WAITTIMEAUT := 5000
WAITTIMEKEY := 2000

GUICOLS := 6
SHOW_DEV := false

NVM_PATH := "C:\Users\" A_UserName "\AppData\Roaming\nvm"

; Used to mark when ITM is being used by one of the predefined functions
ITMInUse := false

#Include ./gsudo-gui.config.ahk

if (!IsSet(DEFAULT_TEXT) or DEFAULT_TEXT == "") {
    DEFAULT_TEXT := %LANG%_STR_DEFAULT_TEXT
}
; Change TrayIcon
TraySetIcon(A_LineFile "\..\res\gsudo-gui.ico")

Apps := Array()
; Array with the name of the FUNC(tions) to execute
; The Hotkey will be HOTKEY_%Funcion% and the text translations %LANG%_STR_GUI_%Function%, %LANG%_STR_HELP_%Function%
; If %LANG%_STR_HELP_%Function% is empty, %LANG%_STR_GUI_%Function% will be used as help
Apps.Push("CMD")
Apps.Push("Powershell")
Apps.Push("Hosts")
Apps.Push("Environment")
Apps.Push("ControlPanel")
Apps.Push("Winget")
Apps.Push("Angular")
Apps.Push("Services")
Apps.Push("DiskManager")
Apps.Push("Firewall")
Apps.Push("Registry")
Apps.Push("DeleteFiles")
Apps.Push("Maintenance")
Apps.Push("Browser")
Apps.Push("TaskManager")
Apps.Push("SystemUpdate")
Apps.Push("MSStore")
Apps.Push("FreeSpace")
Apps.Push("TimeDate")
Apps.Push("JavaUpdate")
Apps.Push("OpenVPN")
Apps.Push("VPNUpdate")
Apps.Push("Bitlocker")

; Place buttons according to DPI of screen. Tested for DPI 100 to 150

ClickToWrite() {
    if WinExist(ITMAppName) {
        WinActivate
        WinGetClientPos &X, &Y, &W, &H
        CoordMode "Mouse", "Client"
        MouseClick "left", 0.16 * W, 0.44 * H
        ; MouseClick "left", 60, 160
    }
}

FillInDefaultText() {
    ClickToWrite()
    Send DEFAULT_TEXT
}

FillInFromClipboard() {
    ClickToWrite()
    ; Pastes the text into the clipboard if less than 100 characters. Else it will paste the default text
    if (StrLen(A_Clipboard) >= 0 and StrLen(A_Clipboard) < 100) {
        Send A_Clipboard
    } else {
        Send DEFAULT_TEXT
    }
}

ClickCancel() {
    if WinExist(ITMAppName) {
        WinActivate
        WinGetClientPos &X, &Y, &W, &H
        CoordMode "Mouse", "Client"
        MouseClick "left", 0.67 * W, 0.8677686 * H
        ; MouseClick "left", 330, 310
    }
}

ClickAccept() {
    if WinExist(ITMAppName) {
        WinActivate
        WinGetClientPos &X, &Y, &W, &H
        CoordMode "Mouse", "Client"
        MouseClick "left", 0.33 * W, 0.8677686 * H
        ; MouseClick "left", 160, 310
    }
}

; Do not launch automatically
if (IsSet(AUT_SYSTEM_ACTIVE) and AUT_SYSTEM_ACTIVE) {
    SetTimer CheckITMApp, CheckTime

    ; Win + C: cancel automatic system
    ;#c::SetTimer CheckITMApp, 0
    if HOTKEY_AUT_SYSTEM_ACTIVE_CANCEL != "" {
        ;Hotkey HOTKEY_AUT_SYSTEM_ACTIVE_CANCEL, SetTimer(CheckITMApp, 0)
        Hotkey HOTKEY_AUT_SYSTEM_ACTIVE_CANCEL, CheckITMAppCancelCallback
    }

    ; Win + S: use automatic system
    ; #s::SetTimer CheckITMApp, CheckTime
    if HOTKEY_AUT_SYSTEM_ACTIVE_RESTART != "" {
        Hotkey HOTKEY_AUT_SYSTEM_ACTIVE_RESTART, CheckITMAppRestartCallback
    }
    CheckITMAppCancelCallback(*) {
        SetTimer CheckITMApp, 0
    }

    CheckITMAppRestartCallback(*) {
        SetTimer CheckITMApp, CheckTime
    }

}

CheckITMApp() {
    if WinExist(ITMAppName) and Not ITMInUse {
        ; MsgBox "ITM - Application Control exists."
        WinActivate
        FillInFromClipboard()
        Sleep WAITTIMEAUT
        ClickAccept()
    }
}

LaunchGsudoApp(Cmd, Function, Text?) {
    ITMInUse := true
    Run "gsudo " . Cmd, , "Hide"
    WinWait ITMAppName
    WinActivate ITMAppName
    ClickToWrite()
    if Function != "" {
        Send %LANG%_STR_ITM_%Function%
    } else {
        Send Text
    }
    Sleep WAITTIMEKEY
    ClickAccept()
    ITMInUse := false
}

Hotkey HOTKEY_HELP, GSudoHelp

Hotkey HOTKEY_GUI, GSudoGui

GSudoHelp(*) {
    HelpText := HOTKEY_GUI ": " %LANG%_STR_HELP_GUI
    loop Apps.Length {
        if (%LANG%_STR_HELP_%Apps[A_Index]% = "") {
            if (IsSet(HOTKEY_%Apps[A_Index]%) And HOTKEY_%Apps[A_Index]% != "") {
                HelpText := HelpText . "`n" . HOTKEY_%Apps[A_Index]% . ": " . %LANG%_STR_GUI_%Apps[A_Index]%
            } else {
                HelpText := HelpText . "`n---: " . %LANG%_STR_GUI_%Apps[A_Index]%
            }
        } else {
            if (IsSet(HOTKEY_%Apps[A_Index]%) And HOTKEY_%Apps[A_Index]% != "") {
                HelpText := HelpText . "`n" . HOTKEY_%Apps[A_Index]% . ": " . %LANG%_STR_HELP_%Apps[A_Index]%
            } else {
                HelpText := HelpText . "`n---: " . %LANG%_STR_HELP_%Apps[A_Index]%
            }
        }
    }
    if (IsSet(AUT_SYSTEM_ACTIVE) and AUT_SYSTEM_ACTIVE) {
        if HOTKEY_AUT_SYSTEM_ACTIVE_CANCEL != "" {
            HelpText := HelpText . "`n`n" . HOTKEY_AUT_SYSTEM_ACTIVE_CANCEL . ": " . %LANG%_STR_HELP_AUT_SYSTEM_ACTIVE_CANCEL
        }
        if HOTKEY_AUT_SYSTEM_ACTIVE_RESTART != "" {
            HelpText := HelpText . "`n" . HOTKEY_AUT_SYSTEM_ACTIVE_RESTART . ": " . %LANG%_STR_HELP_AUT_SYSTEM_ACTIVE_RESTART
        }
    } else {
        if HOTKEY_FILL_WITH_DEFAULT_TEXT != "" {
            HelpText := HelpText . "`n`n" . HOTKEY_FILL_WITH_DEFAULT_TEXT . ": " . %LANG%_STR_HELP_FILL_WITH_DEFAULT_TEXT
        }
        if HOTKEY_FILL_WITH_CLIPBOARD != "" {
            HelpText := HelpText . "`n" . HOTKEY_FILL_WITH_CLIPBOARD . ": " . %LANG%_STR_HELP_FILL_WITH_CLIPBOARD
        }
    }

    HelpText := HelpText . "`n`n" . %LANG%_STR_ICONS_BY
    MsgBox HelpText, %LANG%_STR_HELP, "iconi"

}

GSudoGui(*) {
    GSudoGuiCancel(*) {
        GSudoGui.Visible := 0
        GSudoGui.Destroy()
    }

    GSudoGuiAction(ctrl, *) {
        ctrl.Visible := 0
        GSudoGui.GSudo%ctrl.Name%L.Visible := 1
        GSudo%ctrl.Name%()
        if GSudoGui.Visible {
            GSudoGui.GSudo%ctrl.Name%L.Visible := 0
            ctrl.Visible := 1
        }
    }

    GSudoGui := Gui(, STR_APP_NAME)
    GSudoGui.Visible := 1

    loop Apps.Length {
        PictureName := "./img/" StrLower(Apps[A_Index]) ".png"
        if Not FileExist(PictureName) {
            PictureName := "./img/genericscript.png"
        }
        HotKeyName := HOTKEY_%Apps[A_Index]% ":"
        if ( Not IsSet(HotKeyName) Or HotKeyName = ":") {
            HotKeyName := ""
        }
        GSudoGui.GSudo%Apps[A_Index]%L := GSudoGui.Add("Picture", "x" 40 + (Mod(A_Index - 1, GUICOLS) * 110) " y" 20 +
        (Floor((A_Index - 1) / GUICOLS) * 130) " w80 h80 +E0x200", PictureName)
        GSudoGui.GSudo%Apps[A_Index]%L.Visible := 0
        GSudoGui.Add("Picture", "x" 40 + (Mod(A_Index - 1, GUICOLS) * 110) " y" 20 + (Floor((A_Index - 1) / GUICOLS) *
        130) " w80 h80 +0x400000 v" Apps[A_Index], PictureName).OnEvent("Click", GSudoGuiAction)
        GSudoGui.Add("Text", "x" 20 + (Mod(A_Index - 1, GUICOLS) * 110) " y" 110 + (Floor((A_Index - 1) / GUICOLS) *
        130) " w110 h30 +Center", HotKeyName . " " . %LANG%_STR_GUI_%Apps[A_Index]%)
    }

    ; Accept
    ; GSudoGui.AddButton("x480 y450 w70 h30 +Center", "Aceptar").OnEvent("Click", GSudoGuiCancel)
    GSudoGui.AddButton("x" 60 + ((GUICOLS - 1) * 110) " y" (Ceil(Apps.Length / GUICOLS) * 130) + 10 " w70 h30 +Center", %LANG%_STR_GUI_OK).OnEvent(
        "Click", GSudoGuiCancel)

    GSudoGui.Show("w" 50 + (GUICOLS * 110) " h" 60 + (Ceil(Apps.Length / GUICOLS) * 130))
}

GSudoCMD(*) {
    LaunchGsudoApp("cmd", "CMD")
}

GSudoPowershell(*) {
    LaunchGsudoApp("powershell", "Powershell")
}

GSudoBitlocker(*) {
    LaunchGsudoApp("cmd /k manage-bde -protectors C: -get", "Bitlocker")
}

GSudoDiskManager(*) {
    LaunchGsudoApp("diskmgmt", "DiskManager")
}

GSudoServices(*) {
    LaunchGsudoApp("services.msc", "Services")
}

GSudoEnvironment(*) {
    LaunchGsudoApp("sysdm.cpl", "Environment")
}

GSudoFirewall(*) {
    LaunchGsudoApp("wf.msc", "Firewall")
}

GSudoHosts(*) {
    LaunchGsudoApp("notepad C:\Windows\System32\drivers\etc\hosts", "Hosts")
}

GSudoControlPanel(*) {
    LaunchGsudoApp("control", "ControlPanel")
}

GSudoRegistry(*) {
    LaunchGsudoApp("regedit", "Registry")
}

GSudoBrowser(*) {
    BrowserOK(*) {
        SelectedOption := BrowserGui.Submit()
        switch SelectedOption.BrowserOption {
            case 1: Cmd := "cmd /c start chrome"
            case 2: Cmd := "cmd /c start firefox"
            case 3: Cmd := "cmd /c start msedge"
        }
        BrowserGui.Destroy()
        LaunchGsudoApp(Cmd, "Browser")
    }

    BrowserCancel(*) {
        BrowserGui.Destroy()
    }

    BrowserGui := Gui(, %LANG%_STR_Browser_GUI_TITLE)
    BrowserGui.AddGroupBox("r3 w180 Section", %LANG%_STR_Browser_SELECT)
    BrowserGui.AddRadio("xp+15 yp+20 vBrowserOption checked", "Chrome")
    BrowserGui.AddRadio(, "Firefox")
    BrowserGui.AddRadio(, "Edge")
    BrowserGui.AddButton("Default xs w80", "OK").OnEvent("Click", BrowserOK)
    BrowserGui.AddButton("Default w80 xp95", "Cancel").OnEvent("Click", BrowserCancel)
    BrowserGui.Show()
}

GSudoMaintenance(*) {
    LimpiarOK(*) {
        SelectedOption := LimpiarGui.Submit()
        switch SelectedOption.LimpiaOption {
            case 1: Cmd := "cmd /k DISM.exe /Online /Cleanup-image /Scanhealth"
            case 2: Cmd := "cmd /k Dism.exe /Online /Cleanup-Image /CheckHealth"
            case 3: Cmd := "cmd /k DISM.exe /Online /Cleanup-image /Restorehealth"
            case 4: Cmd := "cmd /k Sfc /scannow"
        }
        LimpiarGui.Destroy()
        LaunchGsudoApp(Cmd, "Maintenance")
    }

    LimpiarCancel(*) {
        LimpiarGui.Destroy()
    }

    LimpiarGui := Gui(, %LANG%_STR_Maintenance_GUI_TITLE)
    LimpiarGui.AddGroupBox("r4 w180 Section", %LANG%_STR_Maintenance_SELECT)
    LimpiarGui.AddRadio("xp+15 yp+20 vLimpiaOption checked", "ScanHealth")
    LimpiarGui.AddRadio(, "CheckHealth")
    LimpiarGui.AddRadio(, "Restorehealth")
    LimpiarGui.AddRadio(, "ScanNow")
    LimpiarGui.AddButton("Default xs w80", "OK").OnEvent("Click", LimpiarOK)
    LimpiarGui.AddButton("Default w80 xp95", "Cancel").OnEvent("Click", LimpiarCancel)
    LimpiarGui.Show()
}

GSudoTaskManager(*) {
    LaunchGsudoApp("taskmgr", "TaskManager")
}

GSudoDeleteFiles(*) {
    FilesToDelete := FileSelect("M35", "c:\Users\Public\Desktop", %LANG%_STR_DeleteFiles_GUI_TITLE)
    if FilesToDelete.Length = 0 {
        MsgBox %LANG%_STR_DeleteFiles_NO_FILE
    } else {
        for FileName in FilesToDelete {
            Result := MsgBox(%LANG%_STR_DeleteFiles_FILE_DELETE " #" A_Index %LANG%_STR_DeleteFiles_FILE_OF FilesToDelete
                .Length ":`n" FileName "`n`n" %LANG%_STR_DeleteFiles_FILE_CONTINUE, ,
                "YN")
            if Result = "Yes" {
                LaunchGsudoApp('cmd /c DEL /f \"' . FileName . '\"', "DeleteFiles")
            }
        }
    }
}

GSudoWinget(*) {
    WingetOK(*) {
        SelectedOptions := WingetGui.Submit()
        for Name, Value in SelectedOptions.OwnProps() {
            if (Value = "1") {
                AppIndex := SubStr(Name, 5)
                if AppIndex = "All" {
                    LaunchGsudoApp("winget upgrade --include-unknown --all",
                        "Winget")
                } else {
                    LaunchGsudoApp("winget upgrade " AppsToUpgrade[AppIndex][2], "", %LANG%_STR_Winget_UPDATE AppsToUpgrade[
                        AppIndex][1] %LANG%_STR_Winget_WITH)
                }
            }
        }
        WingetGui.Destroy()
    }

    WingetCancel(*) {
        WingetGui.Destroy()
    }

    WingetClearOpts(*) {
        loop AppsToUpgrade.Length {
            WingetGui["App_" A_Index].Value := 0
        }
    }

    WingetClearAll(*) {
        WingetGui["App_All"].Value := 0
    }

    /* MsgBox RunWaitOne("winget upgrade --include-unknown"), "Winget upgrade" */

    vTempFolder := EnvGet("Temp")
    RunWait A_ComSpec ' /c winget upgrade --include-unknown > ' vTempFolder '\\AHK_WinGet_Upgrade.txt', , "Hide"
    ProcessLine := false
    AppsToUpgrade := Array()
    Start_Id := 46
    Start_Version_From := 83
    Start_Version_To := 98
    Start_Origin := 113
    loop read, vTempFolder "\\AHK_WinGet_Upgrade.txt" {
        ; End line
        ; Potential problem is O.S. user's interface is not in spanish
        if InStr(A_LoopReadLine, %LANG%_STR_Winget_UPDATES_AVAILABLE) {
            ProcessLine := false
        }
        ; Read applications and place them in the list
        if ProcessLine {
            AppData := Array()
            ; Name := Trim(SubStr(A_LoopReadLine,1,46))
            ; Package := Trim(SubStr(A_LoopReadLine,47,37))
            ; VersionInstalled := Trim(SubStr(A_LoopReadLine,84,15))
            ; VersionUpgrade := Trim(SubStr(A_LoopReadLine,99,15))
            Name := Trim(SubStr(A_LoopReadLine, 1, Start_Id - 1))
            Package := Trim(SubStr(A_LoopReadLine, Start_Id, Start_Version_From - Start_Id))
            VersionInstalled := Trim(SubStr(A_LoopReadLine, Start_Version_From, Start_Version_To - Start_Version_From))
            VersionUpgrade := Trim(SubStr(A_LoopReadLine, Start_Version_To, Start_Origin - Start_Version_To))
            AppData.Push Name
            AppData.Push Package
            AppData.Push VersionInstalled
            AppData.Push VersionUpgrade
            AppsToUpgrade.Push AppData
        }
        ; Get length of fields
        ; Potential problem is O.S. user's interface is not in spanish ("Name")
        if InStr(A_LoopReadLine, %LANG%_STR_Winget_NAME) {
            Start_Id := InStr(A_LoopReadLine, %LANG%_STR_Winget_ID)
            ; As Versión has a tilde, it counts as 2 bytes and the position is moved by one place
            Start_Version_From := InStr(A_LoopReadLine, %LANG%_STR_Winget_VERSI)
            Start_Version_To := InStr(A_LoopReadLine, %LANG%_STR_Winget_AVAILABLE) - 1
            Start_Origin := InStr(A_LoopReadLine, %LANG%_STR_Winget_ORIGIN) - 1
        }
        ; Separator to init the process
        if InStr(A_LoopReadLine, "-------------") {
            ProcessLine := true
        }
    }
    FileDelete vTempFolder "\\AHK_WinGet_Upgrade.txt"

    WingetGui := Gui(, %LANG%_STR_Winget_GUI_TITLE)
    loop AppsToUpgrade.Length {
        WingetGui.AddCheckBox("vApp_" A_Index, AppsToUpgrade[A_Index][1] " (" AppsToUpgrade[A_Index][3] ") - (" AppsToUpgrade[
            A_Index][4] ")").OnEvent("Click", WingetClearAll)
    }

    if (AppsToUpgrade.Length > 0) {
        WingetGui.AddCheckBox("vApp_All", %LANG%_STR_Winget_UPDATE_ALL).OnEvent("Click",
            WingetClearOpts)
    } else {
        WingetGui.AddText("", %LANG%_STR_Winget_NO_UPDATE)
    }

    WingetGui.AddButton("Default w80", "OK").OnEvent("Click", WingetOK)
    if (AppsToUpgrade.Length > 0) {
        WingetGui.AddButton("Default w80 xp95", "Cancel").OnEvent("Click", WingetCancel)
    }
    WingetGui.Show()
}

GSudoAngular(*) {
    AngularOK(*) {
        SelectedOption := AngularGui.Submit()
        Cmd := "cmd /c nvm use " NodeVersions[SelectedOption.AngularOption]
        AngularGui.Destroy()
        LaunchGsudoApp(Cmd, "", %LANG%_STR_Angular_USE NodeVersions[SelectedOption.AngularOption] %LANG%_STR_Angular_NODE)
        ; LaunchGsudoApp(Cmd, "Angular")
    }

    AngularCancel(*) {
        AngularGui.Destroy()
    }

    NodeVersions := Array()
    loop files, NVM_PATH "\*", "D" {
        ; NodeVersions.Push Trim(A_LoopFileName,"v")
        NodeVersions.Push A_LoopFileName
    }

    NodeVersions := SortVersionsAndRemoveV(NodeVersions)

    AngularGui := Gui(, %LANG%_STR_Angular_GUI_TITLE)
    AngularGui.AddGroupBox("r" NodeVersions.Length " w180 Section", %LANG%_STR_Angular_SELECT)
    loop NodeVersions.Length {
        if (A_Index = 1) {
            AngularGui.AddRadio("xp+15 yp+20 vAngularOption checked", NodeVersions[A_Index])
        } else {
            AngularGui.AddRadio(, NodeVersions[A_Index])
        }
    }
    AngularGui.AddButton("Default xs w80", "OK").OnEvent("Click", AngularOK)
    AngularGui.AddButton("Default w80 xp95", "Cancel").OnEvent("Click", AngularCancel)
    AngularGui.Show()

}

GSudoSystemUpdate(*) {
    LaunchGsudoApp("wuauclt /detectnow /updatenow", "SystemUpdate")
}

GSudoMSStore(*) {
    LaunchGsudoApp("cmd /c start ms-windows-store:", "MSStore")
}

GSudoFreeSpace(*) {
    LaunchGsudoApp("cleanmgr", "FreeSpace")
}

GSudoTimeDate(*) {
    LaunchGsudoApp("timedate.cpl", "TimeDate")
}

GSudoJavaUpdate(*) {
    LaunchGsudoApp('"C:\Program Files (x86)\Java\jre-1.8\bin\javacpl.exe"', "JavaUpdate")
}

GSudoOpenVPN(*) {
    LaunchGsudoApp('"C:\Program Files\OpenVPN\bin\openvpn-gui.exe"', "OpenVPN")
}

GSudoVPNUpdate(*) {
    Result := MsgBox( %LANG%_STR_VPNUpdate_GUI_TITLE, ,
        "YN")
    if Result = "Yes" {
        LaunchGsudoApp('"C:\Windows\Downloaded Program Files\f5instd.exe" –ap', "VPNUpdate")
    }
}

FilterDevApps(Apps) {
    AppsFiltered := Array()
    ; Remove DEV
    loop Apps.Length {
        if (SHOW_DEV And IS_DEV_%Apps[A_Index]%) {
            AppsFiltered.Push(Apps[A_Index])
        } else if ( Not IS_DEV_%Apps[A_Index]%) {
            AppsFiltered.Push(Apps[A_Index])
        }
    }
    return AppsFiltered
}

FilterApps(Apps) {
    AppsFiltered := Array()
    ; Remove HIDDEN
    loop Apps.Length {
        if ( Not IsSet(HIDE_%Apps[A_Index]%) Or Not HIDE_%Apps[A_Index]%) {
            AppsFiltered.Push(Apps[A_Index])
        }
    }
    return AppsFiltered
}

Apps := FilterDevApps(Apps)
Apps := FilterApps(Apps)

loop Apps.Length {
    if (IsSet(HOTKEY_%Apps[A_Index]%) And HOTKEY_%Apps[A_Index]% != "") {
        Hotkey HOTKEY_%Apps[A_Index]%, GSudo%Apps[A_Index]%
    }
}

HotIfWinExist ITMAppName
if (HOTKEY_FILL_WITH_DEFAULT_TEXT != "") {
    Hotkey HOTKEY_FILL_WITH_DEFAULT_TEXT, ITMFillInDefaultText
}
if (HOTKEY_FILL_WITH_CLIPBOARD != "") {
    Hotkey HOTKEY_FILL_WITH_CLIPBOARD, ITMFillInFromClipboard
}

ITMFillInDefaultText(*) {
    ; Fills up the text field with an standard text and presses the OK button
    WinActivate ITMAppName
    FillInDefaultText()
    Sleep WaitTimeAut
    ClickAccept()
}

ITMFillInFromClipboard(*) {
    ; Fills up the text field with the clipboard content and presses the OK button
    WinActivate ITMAppName
    FillInFromClipboard()
    Sleep WaitTimeAut
    ClickAccept()
}

RunWaitOne(command) {
    shell := ComObject("WScript.Shell")
    exec := shell.Exec(A_ComSpec " /C " command)
    return exec.StdOut.ReadAll()
}

SortVersionsAndRemoveV(Versions) {
    Sorted := []
    for x, y in Versions {
        for k, l in StrSplit(SubStr(y, 2), [".", "-"])              ;splits each element w/o the initial v; delimiter is . or -
        {
            m .= SubStr("00" l, -2) (k > 2 ? "-" : ".")             ;pads with 0 and recombine; 1st and 2nd delimiter is .; 3rd delimiter is -
        }
        n .= "v" rtrim(m, "-.") "`n", m := ""                       ;trim off last . or - and reinitialize m
    }
    n := rtrim(n, "`n")							     		        ;trim off last `n
    n := sort(n, "P2")                                              ;sort starting on strings w/o first character (v)
    for a, b in StrSplit(n, "`n")						  		    ;splits again on `n
        Sorted.push(StrReplace(StrReplace(StrReplace(StrReplace(b, "v0", "v"), ".0", "."), "-0", "-"), "v", ""))    ; push to array after replacing leading zeros and remove "v"
    return Sorted
}
