#Requires AutoHotkey v2.0
#Include userconfig.ahk

SendMode "Event"
CoordMode("Pixel", "Window")

version := "2.0 GITHUB"
seconds := 0
breaks := 0
consqbreaks := 0
sessionascensions := 0
startTime := 0
fullseconds := 0
estimatedtime := 0
new_x_upgrade := 0
new_y_upgrade := 0
new_x_complete := 0
new_y_complete := 0
totalasc := foreverpurchases + 399
scalex := screen_width / 1920
scaley := screen_height / 1080
running := false
corrected_x_asc := 0
corrected_y_asc := 0
AutoRejoin := false
RobloxWasRunning := false
RobloxClosed := false
RestartingRoblox := false
restartattempts := 0
consqbreakslimit := 0
ServerLink := ConvertServerLink(ServerLink)
reconnect_x := 0
reconnect_y := 0
okay_x := 0
okay_y := 0
f2p_mode := false ; Currently does NOTHING

SetTimer(CheckRobloxClosed, 500)

FreeToPlayMode(){
    ; Currently does NOTHING
}

ConvertServerLink(link) {
    if RegExMatch(link, "code=([^&]+)", &match)
        return "roblox://navigation/share_links?code=" match[1] "&type=Server"

    return ""
}

UIFix(){
    global ui_variation, new_x_complete, new_x_upgrade, new_y_complete, new_y_upgrade, scalex, scaley, corrected_x_asc, corrected_y_asc, seconds_delay, consqbreakslimit, reconnectoption, reconnect_x, reconnect_y, okay_x, okay_y
    if ui_variation = 1 {
        if screen_width = 2560 && screen_height = 1440 {
            new_x_upgrade := 1183 * scalex
            new_y_upgrade := 969 * scaley
            new_x_complete := 1288 * scalex
            new_y_complete := 984 * scaley
            reconnect_x := 1386
            reconnect_y := 810
            okay_x := 1028
            okay_y := 881
        }
        else {
        new_x_upgrade := 1183 * scalex
        new_y_upgrade := 969 * scaley
        new_x_complete := 1288 * scalex
        new_y_complete := 984 * scaley 
        reconnect_x := scalex * 1054
        reconnect_y := scaley * 623
        okay_x := scalex * 754
        okay_y := scaley * 699
        }
    }
    if ui_variation = 2 {
        if screen_width = 2560 && screen_height = 1440 {
            new_x_upgrade := 1067 * scalex
            new_y_upgrade := 866 * scaley
            new_x_complete := 1619
            new_y_complete := 1180
            reconnect_x := 1386
            reconnect_y := 810
            okay_x := 1028
            okay_y := 881
        }
        else {
            new_x_upgrade := 1067 * scalex
            new_y_upgrade := 866 * scaley
            new_x_complete := 1214 * scalex
            new_y_complete := 876 * scaley
            reconnect_x := scalex * 1054
            reconnect_y := scaley * 623
            okay_x := scalex * 754
            okay_y := scaley * 699
        }
    }
    if ui_variation = 3 {
        if screen_width = 2560 && screen_height = 1440 {
            new_x_upgrade := 1129 * scalex
            new_y_upgrade := 922 * scaley
            new_x_complete := 1273 * scalex
            new_y_complete := 929 * scaley
            reconnect_x := 1386
            reconnect_y := 810
            okay_x := scalex * 754
            okay_y := scaley * 699
        }
        else {
            new_x_upgrade := 1129 * scalex
            new_y_upgrade := 922 * scaley
            new_x_complete := 1273 * scalex
            new_y_complete := 929 * scaley
            reconnect_x := 1386
            reconnect_y := 810
            okay_x := scalex * 754
            okay_y := scaley * 699
        }
    }
    if screen_width = 2560 && screen_height = 1440 {
        corrected_x_asc := 1709
        corrected_y_asc := 517
    }
    else {
        corrected_x_asc := Round(scalex * 1301)
        corrected_y_asc := Round(scaley * 382)
    }
    if seconds_delay < 25 { 
        seconds_delay := 25
    }
    if reconnectoption = false {
        consqbreakslimit := 30
    }
    else if reconnectoption = true {
        consqbreakslimit := 10
    }
}

Update(){
    global seconds, fullseconds, running, updatespeed
    if running = true {
        seconds := seconds + (updatespeed/1000)
        fullseconds := fullseconds + (updatespeed/1000)
        ToolTip(Round(seconds) ", " Round(fullseconds))
    }
}

Comma(num) {
    return RegExReplace(num, "(?<=\d)(?=(\d{3})+$)", ",")
}

SendWebhook(msg) {
    global webhook_msg

    if webhook_msg = "" || webhook_msg = "PUT_YOUR_WEBHOOK_HERE" {
        return
    }

    ; Escape JSON
    msg := StrReplace(msg, "\", "\\")
    msg := StrReplace(msg, '"', '\"')
    msg := StrReplace(msg, "`r`n", "\n")
    msg := StrReplace(msg, "`n", "\n")
    msg := StrReplace(msg, "`r", "\n")

    json := '{"content":"' msg '"}'

    try {
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("POST", webhook_msg, false)
        http.SetRequestHeader("Content-Type", "application/json")
        http.Send(json)
    }
    catch {
    }
}

SecondsToDHMS(totalSeconds) {
    totalSeconds := Round(totalSeconds)

    days := totalSeconds // 86400
    rem  := Mod(totalSeconds, 86400)

    hours := rem // 3600
    rem   := Mod(rem, 3600)

    minutes := rem // 60
    seconds := Mod(rem, 60)

    return Format("{1}d {2:02}h {3:02}m {4:02}s", days, hours, minutes, seconds)
}

CalculateThis() {
    global goal, totalasc, fullseconds, sessionascensions, estimatedtime

    ascensionsgoalprogress := goal - totalasc

    averagetime := fullseconds / sessionascensions

    timeleft := ascensionsgoalprogress * averagetime

    if timeleft <= 1
        timeleft := 0

    estimatedtime := FormatTime(
        DateAdd(A_Now, Round(timeleft), "Seconds"),
        "MM/dd/yyyy h:mm tt"
    )
}

OptimizePC()
{
    SetPriority("Discord.exe", "Low")
    SetPriority("OBS.exe", "Low")
    SetPriority("Brave.exe", "Low")
    SetPriority("OneDrive.exe", "Low")

    RobloxProcess := GetRobloxProcess()

    if RobloxProcess
        SetPriority(RobloxProcess, "High")
}

SetPriority(ProcessName, Priority)
{
    try
    {
        for Process in ComObjGet("winmgmts:").ExecQuery(
            "SELECT ProcessId FROM Win32_Process WHERE Name='" ProcessName "'"
        )
        {
            ProcessSetPriority(Process.ProcessId, Priority)
        }
    }
}

GetRobloxProcess()
{
    ; Prefer normal Roblox
    if ProcessExist("RobloxPlayerBeta.exe")
        return "RobloxPlayerBeta.exe"

    ; Fall back to Microsoft Store Roblox
    if ProcessExist("Windows10Universal.exe")
        return "Windows10Universal.exe"

    return ""
}

OptimizeRoblox()
{
    RobloxProcess := GetRobloxProcess()

    if !RobloxProcess
        return

    RegWrite(
        RobloxProcess,
        "REG_SZ",
        "HKEY_CURRENT_USER\Software\Microsoft\Direct3D\MostRecentApplication",
        "Name"
    )

    RegWrite(
        1,
        "REG_DWORD",
        "HKEY_CURRENT_USER\Software\Microsoft\Direct3D\MostRecentApplication",
        "PerfFlag"
    )

    RegWrite(
        1,
        "REG_DWORD",
        "HKEY_CURRENT_USER\Software\Roblox\RobloxStudio",
        "EditQualityLevel"
    )

    RegWrite(
        1,
        "REG_DWORD",
        "HKEY_CURRENT_USER\Software\Roblox\RobloxStudio",
        "RenderQualityLevel"
    )
}

LaunchServer()
{
    global ServerLink
    global AutoRejoin
    global seconds, startTime
    startTime := 0

    if !AutoRejoin
        return

    A_Clipboard := ServerLink

    try
        Run(ServerLink)

    SetTimer(WaitForRoblox, 500)
}

WaitForRoblox()
{
    global AutoRejoin, seconds, startTime

    if !AutoRejoin
    {
        SetTimer(WaitForRoblox, 0)
        return
    }

    RobloxProcess := GetRobloxProcess()

    if RobloxProcess
    {
        SetTimer(WaitForRoblox, 0)

        ; Reset break timer when Roblox launches

        ; Optimize whichever Roblox version actually launched
        OptimizeRoblox()
        OptimizePC()

        Sleep(3000)

        FullscreenRoblox()
    }
}

CheckRobloxClosed()
{
    global RobloxWasRunning
    global RobloxClosed
    global AutoRejoin
    global RestartingRoblox

    if !AutoRejoin
        return

    RobloxProcess := GetRobloxProcess()

    ; Roblox is running
    if RobloxProcess
    {
        RobloxWasRunning := true
        RobloxClosed := false
        return
    }

    ; Roblox was running, then disappeared
    if RobloxWasRunning && !RobloxClosed
    {
        RobloxClosed := true

        if RestartingRoblox
            return

        SendWebhook("🔵 Roblox closed/crashed. Rejoining server...")

        SetTimer(RejoinServer, -2000)
    }
}

RejoinServer()
{
    global AutoRejoin
    global RobloxWasRunning
    global RobloxClosed

    if !AutoRejoin
        return

    RobloxWasRunning := false
    RobloxClosed := false

    LaunchServer()
}

RestartRoblox()
{
    global AutoRejoin
    global RestartingRoblox
    global RobloxWasRunning
    global RobloxClosed

    if !AutoRejoin
        return

    RestartingRoblox := true

    RobloxWasRunning := false
    RobloxClosed := false

    SetTimer(WaitForRoblox, 0)
    SetTimer(FullscreenRoblox, 0)
    SetTimer(RejoinServer, 0)

    SendWebhook("🔄 Consqbreaks hit 10. Force restarting Roblox... Error code: 6")

    CloseRoblox()

    ; Wait up to 5 seconds for either Roblox client to disappear
    Loop 20
    {
        if !GetRobloxProcess()
            break

        Sleep(250)
    }

    Sleep(1500)

    ; Launch server again
    LaunchServer()

    ; Wait up to 20 seconds for either Roblox client
    Loop 80
    {
        RobloxProcess := GetRobloxProcess()

        if RobloxProcess
            break

        Sleep(250)
    }

    if RobloxProcess
    {
        Sleep(3000)
        FullscreenRoblox()

        RobloxWasRunning := true
        RobloxClosed := false
        RestartingRoblox := false

        SendWebhook("🔵 Roblox restarted successfully.")
    }
    else
    {
        RestartingRoblox := false
        SendWebhook("🔴 Roblox failed to restart after 20 seconds.")
    }
}

CloseRoblox()
{
    ; Normal Roblox
    if ProcessExist("RobloxPlayerBeta.exe")
    {
        try
            WinClose("ahk_exe RobloxPlayerBeta.exe")

        Sleep(1000)

        if ProcessExist("RobloxPlayerBeta.exe")
        {
            try
                ProcessClose("RobloxPlayerBeta.exe")
        }
    }

    ; Microsoft Store Roblox
    if ProcessExist("Windows10Universal.exe")
    {
        try
            WinClose("ahk_exe Windows10Universal.exe")

        Sleep(1000)

        if ProcessExist("Windows10Universal.exe")
        {
            try
                ProcessClose("Windows10Universal.exe")
        }
    }
}

FullscreenRoblox()
{
    RobloxProcess := GetRobloxProcess()

    if !RobloxProcess
        return false

    hwnd := WinExist("ahk_exe " RobloxProcess)

    if !hwnd
        return false

    ; Roblox can replace its window while launching.
    ; Protect against WinActivate failing.
    try
    {
        if !WinExist("ahk_id " hwnd)
            return false

        WinActivate("ahk_id " hwnd)
        Sleep(500)

        if !WinExist("ahk_id " hwnd)
            return false

        WinGetPos(&x, &y, &width, &height, hwnd)
        MonitorGet(1, &monLeft, &monTop, &monRight, &monBottom)
    }
    catch
    {
        return false
    }

    monitorWidth := monRight - monLeft
    monitorHeight := monBottom - monTop

    ; If Roblox isn't already approximately fullscreen
    if (width < monitorWidth - 20 || height < monitorHeight - 20)
    {
        try
            Send("{F11}")

        Sleep(1000)
    }

    return true
}

Macro() {
    global seconds, breaks, consqbreaks, sessionascensions, totalasc, startTime, fullseconds, goal, estimatedtime, your_discord_user_id, consqbreakslimit, reconnectoption
    global new_x_upgrade, new_y_upgrade, new_x_complete, new_y_complete, scalex, scaley, corrected_x_asc, corrected_y_asc, seconds_delay, restartattempts, reconnect_x, reconnect_y
    global okay_x, okay_y

    Loop {
        RobloxProcess := GetRobloxProcess()

        if RobloxProcess && !WinActive("ahk_exe " RobloxProcess)
        {
            try
            {
                hwnd := WinExist("ahk_exe " RobloxProcess)

                if hwnd
                {
                    WinActivate("ahk_id " hwnd)
                    Sleep(100)
                    FullscreenRoblox()
                }
            }
            catch
            {
            }
        }

        detected := PixelSearch(&x, &y, Round(new_x_complete), Round(new_y_complete), Round(new_x_complete), Round(new_y_complete), 0xCCCCCC, 15)
            || PixelSearch(&x, &y, Round(scalex * 1469), Round(scaley * 760), Round(scalex * 1469), Round(scaley * 760), 0x00DCFF, 15)

        if detected {
            if !startTime
                startTime := A_TickCount

            if A_TickCount - startTime >= 50 {
                Click(okay_x, okay_y)
                Click(Round(scalex * 662), Round(scaley * 685))
                SetMouseDelay(10)
                Click(Round(scalex * 1878), Round(scaley * 755))
                Click(Round(scalex * 1256), Round(scaley * 774))
                Sleep(400)
                SetMouseDelay(-1)

                while PixelSearch(&x, &y, corrected_x_asc, corrected_y_asc, corrected_x_asc, corrected_y_asc, 0xFFFFFF, 15) {
                    Click(Round(scalex * 846), Round(scaley * 651))
                }

                sessionascensions++
                totalasc++
                SaveForeverPurchases(totalasc - 399)
                restartattempts := 0

                CalculateThis()

                SendWebhook("-# 🟢 T/A: " Round((fullseconds/sessionascensions), 2) "s Session: " Comma(sessionascensions) " Total: " Comma(totalasc) "`n"
                "-# Current session time: " SecondsToDHMS(fullseconds) "`n"
                "-# Uptime: " Format("{:.2f}", (sessionascensions / (breaks + sessionascensions)) * 100) "% EST Daily pace: " Comma(Round(86400 / (fullseconds/sessionascensions))) "`n"
                "-# " Comma(totalasc) "/" Comma(goal) " (" Comma((goal - totalasc)) " left) " "T/R: " Round(seconds, 1) "s`n"
                "-# ETA: " estimatedtime ", " SecondsToDHMS(Floor((goal - totalasc) * (fullseconds/sessionascensions))) "`n"
                "-# Current time: " FormatTime(A_Now, "MM/dd/yyyy h:mm:ss tt"))

                if consqbreaks >= 1 {
                    consqbreaks--
                    SendWebhook("🟡 Consqbreaks going down. Current consqbreaks: " consqbreaks)
                }

                seconds := 0
                startTime := 0
            }
        }
        else {
            startTime := 0
        }

        if PixelSearch(&x, &y, Round(scalex * 947), Round(scaley * 1015), Round(scalex * 947), Round(scaley * 1015), 0x2E2E00, 5) {
            SetMouseDelay(10)
            Click(Round(scalex * 957), Round(scaley * 994))
            MouseMove(Round(scalex * 1183), Round(scaley * 969))
        }

        if consqbreaks >= consqbreakslimit {
            if reconnectoption = true {
                SendWebhook("⚠️ <@" your_discord_user_id "> Consqbreaks hit limit of 10, restarting roblox... Error code: 4")

                consqbreaks := 0
                seconds := 0
                startTime := 0
                seconds := -20

                restartattempts++

                if restartattempts >= 4 {
                    SendWebhook("<@" your_discord_user_id "> 🛑 Roblox failed to recover after 3 restart attempts. Emergency shutdown. Exit code: 3")
                    ExitApp()
                }

                RestartRoblox()
                continue
            }
            else if reconnectoption = false {
                SendWebhook("<@" your_discord_user_id "> 🔴 Consqbreaks hit limit of 30, exiting... Exit code: 2")
                ExitApp()
            }
        }

        if seconds >= seconds_delay {
            SetMouseDelay(10)

            Click(Round(scalex * 983), Round(scaley * 938))
            Click(Round(scalex * 1654), Round(scaley * 222))
            Click(reconnect_x, reconnect_y)
            Click(Round(scalex * 744), Round(scaley * 681))

            seconds := 0
            consqbreaks := consqbreaks + 2
            breaks++

            SendWebhook("🔴 Break detected. Consqbreaks: " consqbreaks ". Error code: 5")
        }

        SetMouseDelay(-1)

        Click(new_x_upgrade, new_y_upgrade)
    }
}

SaveForeverPurchases(value) {
    configFile := A_ScriptDir "\userconfig.ahk"
    content := FileRead(configFile)

    content := RegExReplace(
        content,
        "m)^foreverpurchases\s*:=.*$",
        "foreverpurchases := " value
    )

    FileDelete(configFile)
    FileAppend(content, configFile)
}

F1::
{
    global seconds, breaks, consqbreaks, sessionascensions, totalasc, startTime, fullseconds, goal, estimatedtime, your_discord_user_id
    global new_x_upgrade, new_y_upgrade, new_x_complete, new_y_complete, scalex, scaley, running
    global AutoRejoin, RobloxWasRunning, RobloxClosed, reconnectoption, updatespeed, version

    if (screen_width * 9 != screen_height * 16)
    {
        MsgBox "This macro requires a 16:9 display. Make sure you put in the correct coordinates!"
        ExitApp()
    }

    if reconnectoption && ServerLink = ""
    {
        MsgBox "Reconnect is enabled, but ServerLink is blank.`n`nPlease either disable Reconnect or enter a private server link in ServerLink."
        ExitApp()
    }

    AutoRejoin := reconnectoption
    RobloxWasRunning := false
    RobloxClosed := false

    running := false
    seconds := 0
    startTime := 0

    SetTimer(Update, updatespeed)

    RobloxProcess := GetRobloxProcess()

    if !RobloxProcess
    {
        MsgBox "Roblox could not be detected. Please open Roblox and join the server before pressing F1."
        SetTimer(Update, 0)
        return
    }

    WinWait("ahk_exe " RobloxProcess, , 20)

    hwnd := WinExist("ahk_exe " RobloxProcess)

    if !hwnd
    {
        MsgBox "Roblox process was detected, but its window could not be found."
        SetTimer(Update, 0)
        return
    }

    try
    {
        WinActivate("ahk_id " hwnd)
        Sleep(500)
    }
    catch
    {
        MsgBox "Failed to activate the Roblox window."
        SetTimer(Update, 0)
        return
    }

    FullscreenRoblox()

    UIFix()

    running := true
    seconds := 0
    startTime := A_TickCount

    SendWebhook("Macro started. Version: " version " `nReconnectoption: " reconnectoption)

    Macro()
}

F2::{
    global running, updatespeed
    if running = true {
        running := false
        SetTimer(Update, 0)
        Pause(-1)
    }
    else if running = false {
        running := true
        SetTimer(Update, updatespeed)
        Pause(-1)
    }
}

Esc::{
    SendWebhook("Macro exited. Exit code: 1")
    ExitApp()
}
