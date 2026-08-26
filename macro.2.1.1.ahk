#Requires AutoHotkey v2.0
#Include userconfig.ahk

SendMode "Event"
CoordMode("Pixel", "Window")

version := "2.1.1"
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

if !IsSet(f2p_mode)
    f2p_mode := false

ToolTip("F1 to start, F2 to pause/unpause, and ESC to exit. Press F5 to test roblox relaunching")
SetTimer(CheckRobloxClosed, 500)

FreeToPlayMode(){
    SetMouseDelay(10)
    global scalex, scaley, seconds
    Click(scalex * 1845, scaley * 474)
    Click(scalex * 1273, scaley * 760)
    Sleep(800)
    Click(scalex * 781, scaley * 655)
    Sleep(1000)
    Click(scalex * 685, scaley * 17)
    Click(scalex * 1100, scaley * 225)
    MouseMove(scalex * 1247, scaley * 321)
    SendInput "{LButton down}"
    MouseMove(scalex * 1247, scaley * 489)
    SendInput "{LButton up}"
    Click(scalex * 918, scaley * 515)
    Click(scalex * 807, scaley * 637)
    Click(scalex * 918, scaley * 515)
    Click(scalex * 807, scaley * 637)
    Click(scalex * 918, scaley * 515)
    Click(scalex * 1278, scaley * 154)
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
    global seconds, fullseconds, running, updatespeed, totalruntime
    if running = true {
        seconds := seconds + (updatespeed/1000)
        fullseconds := fullseconds + (updatespeed/1000)
        totalruntime := Round(totalruntime + (updatespeed/1000), 3)
        ToolTip(Round(seconds) ", " Round(fullseconds))
    }
}

Comma(num) {
    return RegExReplace(num, "(?<=\d)(?=(\d{3})+$)", ",")
}

SendWebhook(type := "ascension", message := "") {
    global webhook_msg, version
    global fullseconds, totalruntime, sessionascensions, totalasc
    global breaks, goal, seconds, estimatedtime

    if webhook_msg = "" || webhook_msg = "PUT_YOUR_WEBHOOK_HERE"
        return

    if sessionascensions > 0 {
        averageTime := fullseconds / sessionascensions
        if averageTime > 0 {
            dailyPace := Round(86400 / averageTime)
        }
        else {
            dailyPace := "ERR"
        }
        if sessionascensions > 0 {
            uptime := (sessionascensions / (breaks + sessionascensions)) * 100
        }
        else {
            uptime := "ERR"
        }
        timeRemaining := Floor((goal - totalasc) * averageTime)
    }
    else {
        averageTime := 0
        dailyPace := 0
        uptime := 100
        timeRemaining := 0
    }

    remaining := goal - totalasc

    if remaining < 0
        remaining := 0

    progressPercent := 0

    if goal > 0
        progressPercent := (totalasc / goal) * 100

    if progressPercent > 100
        progressPercent := 100

    barLength := 20
    filled := Round((progressPercent / 100) * barLength)

    if filled > barLength
        filled := barLength

    empty := barLength - filled
    progressBar := ""

    Loop filled
        progressBar .= "█"

    Loop empty
        progressBar .= "░"

    currentTime := FormatTime(
        A_Now,
        "MM/dd/yyyy h:mm:ss tt"
    )

    switch type {
        case "ascension":
            authorName := "🟢 Ascension successful"
            embedColor := 3066993

        case "start":
            authorName := "🔵 Macro started"
            embedColor := 3447003

        case "break":
            authorName := "🔴 Break detected"
            embedColor := 15158332

        case "warning":
            authorName := "🟡 Macro warning"
            embedColor := 16776960

        case "error":
            authorName := "🔴 Macro error"
            embedColor := 15158332

        case "success":
            authorName := "🔵 Macro status"
            embedColor := 3447003
        
        case "pause":
            authorName := "⏸️ Macro paused"
            embedColor := 16776960
        
        case "resume":
            authorName := "▶️ Macro resumed"
            embedColor := 3066993

        default:
            authorName := "⚪ Macro"
            embedColor := 9807270
    }

    JsonEscape(value) {
        value := StrReplace(value, "\", "\\")
        value := StrReplace(value, '"', '\"')
        value := StrReplace(value, "`r`n", "\n")
        value := StrReplace(value, "`n", "\n")
        value := StrReplace(value, "`r", "\n")
        return value
    }

    if type = "ascension" {

        json := (
            '{'
            '"embeds":['
                '{'
                    '"color":' embedColor ','
                    '"author":{"name":"' JsonEscape(authorName) '"},'
                    '"fields":['

                        '{'
                            '"name":"Performance:",'
                            '"value":"'
                                'Time per Ascension: ' Round(averageTime, 2) 's\n'
                                'Time this Ascension: ' Round(seconds, 1) 's\n\n'
                                'Uptime: ' Format("{:.2f}", uptime) '%\n'
                                'Daily pace: ' Comma(dailyPace) '/day\n'
                            '"'
                        '},'

                        '{'
                            '"name":"Progress:",'
                            '"value":"'
                                Comma(totalasc) ' / ' Comma(goal) ' (' Format("{:.2f}", progressPercent) '%)\n'
                                progressBar '\n'
                                Comma(remaining) ' remaining\n'
                            '"'
                        '},'

                        '{'
                            '"name":"Runtime",'
                            '"value":"'
                                'Session: ' SecondsToDHMS(fullseconds) '\n'
                                'Total: ' SecondsToDHMS(totalruntime) '\n'
                            '"'
                        '},'

                        '{'
                            '"name":"ETA",'
                            '"value":"'
                                JsonEscape(estimatedtime) '\n'
                                SecondsToDHMS(timeRemaining) ' remaining\n'
                            '"'
                        '}'

                    '],'
                    '"footer":{"text":"' JsonEscape("V" version ", " currentTime) '"}'
                '}'
            ']}'
        )

    }
    else {

        json := (
            '{'
            '"embeds":['
                '{'
                    '"color":' embedColor ','
                    '"author":{"name":"' JsonEscape(authorName) '"},'
                    '"description":"' JsonEscape(message) '",'
                    '"fields":['

                        '{'
                            '"name":"Progress:",'
                            '"value":"'
                                Comma(totalasc) ' / ' Comma(goal) '\n'
                                progressBar '\n'
                                Format("{:.2f}", progressPercent) '%\n'
                                Comma(remaining) ' remaining'
                            '"'
                        '},'

                        '{'
                            '"name":"Runtime",'
                            '"value":"'
                                'Session: ' SecondsToDHMS(fullseconds) '\n'
                                'Total: ' SecondsToDHMS(totalruntime)
                            '"'
                        '}'

                    '],'
                    '"footer":{"text":"' JsonEscape("V" version ", " currentTime) '"}'
                '}'
            ']}'
        )
    }

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
    if sessionascensions > 0 {
        averagetime := fullseconds / sessionascensions
    }
    else {
        averagetime := 0
    }

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

        SendWebhook(
            "warning",
            "Roblox closed/crashed. Rejoining server..."
        )

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

    SendWebhook(
        "warning",
        "Consqbreaks hit 10. Force restarting Roblox...`nError code: 6"
    )

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

        SendWebhook(
            "success",
            "Roblox restarted successfully."
        )
    }
    else
    {
        RestartingRoblox := false
        SendWebhook(
            "error",
            "Roblox failed to restart after 20 seconds."
        )
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
    global okay_x, okay_y, totalruntime, f2p_mode

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
                ascensionWaitStart := A_TickCount

                while PixelSearch(&x, &y, corrected_x_asc, corrected_y_asc, corrected_x_asc, corrected_y_asc, 0xFFFFFF, 15) {
                    Click(Round(scalex * 846), Round(scaley * 651))
                    if A_TickCount - ascensionWaitStart >= 10000 {
                        SendWebhook(
                            "warning",
                            "Ascension screen timeout after 10 seconds. Breaking loop.`nError code: 7"
                        )
                        break
                    }

                }

                sessionascensions++
                totalasc++
                SaveForeverPurchases(totalasc - 399)
                SaveTotalRuntime(totalruntime)
                restartattempts := 0

                CalculateThis()

                SendWebhook("ascension")

                if consqbreaks >= 1 {
                    consqbreaks--
                    SendWebhook("warning", "Consqbreaks decreased. Current consqbreaks: " consqbreaks)
                }

                seconds := 0
                startTime := 0

                if f2p_mode = true {
                    Sleep(800)
                    FreeToPlayMode()
                }
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
                SendWebhook(
                    "warning",
                    "<@" your_discord_user_id "> Consqbreaks hit the limit of 10. Restarting Roblox...`nError code: 4"
                )

                consqbreaks := 0
                seconds := 0
                startTime := 0
                seconds := -20

                restartattempts++

                if restartattempts >= 4 {
                    SendWebhook(
                        "error",
                        "<@" your_discord_user_id "> Roblox failed to recover after 3 restart attempts. Emergency shutdown.`nExit code: 3"
                    )
                    ExitApp()
                }

                RestartRoblox()
                continue
            }
            else if reconnectoption = false {
                SendWebhook(
                    "error",
                    "<@" your_discord_user_id "> Consqbreaks hit the limit of 30. Exiting...`nExit code: 2"
                )
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

            SendWebhook(
                "break",
                "Consqbreaks: " consqbreaks "`nError code: 5"
            )
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

SaveTotalRuntime(value) {
    configFile := A_ScriptDir "\userconfig.ahk"
    content := FileRead(configFile)

    content := RegExReplace(
        content,
        "m)^totalruntime\s*:=.*$",
        "totalruntime := " value
    )

    FileDelete(configFile)
    FileAppend(content, configFile)
}

F1::
{
    global seconds, breaks, consqbreaks, sessionascensions, totalasc, startTime, fullseconds, goal, estimatedtime, your_discord_user_id
    global new_x_upgrade, new_y_upgrade, new_x_complete, new_y_complete, scalex, scaley, running
    global AutoRejoin, RobloxWasRunning, RobloxClosed, reconnectoption, updatespeed, version, f2p_mode

    ToolTip("Starting macro...`nChecking configuration and Roblox...")

    if (screen_width * 9 != screen_height * 16)
    {
        ToolTip()
        MsgBox "This macro requires a 16:9 display. Make sure you put in the correct coordinates!"
        ExitApp()
    }

    if reconnectoption && ServerLink = ""
    {
        ToolTip()
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
        ToolTip()
        MsgBox "Roblox could not be detected. Please open Roblox and join the server before pressing F1."
        SetTimer(Update, 0)
        return
    }

    WinWait("ahk_exe " RobloxProcess, , 20)

    hwnd := WinExist("ahk_exe " RobloxProcess)

    if !hwnd
    {
        ToolTip()
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
        ToolTip()
        MsgBox "Failed to activate the Roblox window."
        SetTimer(Update, 0)
        return
    }

    FullscreenRoblox()

    UIFix()

    ToolTip("Macro started!`nVersion: " version "`nReconnect: " (reconnectoption ? "Enabled" : "Disabled"))

    running := true
    seconds := 0
    startTime := A_TickCount

    SendWebhook(
            "start",
            "Version: " version
            "`nReconnect: " (reconnectoption ? "Enabled" : "Disabled")
            "`nF2P mode: " (f2p_mode ? "Enabled" : "Disabled")
        )

    if f2p_mode = true {
        FreeToPlayMode()
    }

    Macro()
}

F2::{
    global running, updatespeed

    if running = true {
        running := false
        SetTimer(Update, 0)

        SendWebhook(
            "pause",
            "Macro paused.`n`nPress F2 to resume."
        )

        Pause(-1)

        ; Script has been resumed
        running := true
        SetTimer(Update, updatespeed)

        SendWebhook(
            "resume",
            "Macro resumed."
        )
    }
    else {
        running := true
        SetTimer(Update, updatespeed)

        SendWebhook(
            "resume",
            "Macro resumed."
        )

        Pause(-1)

        ; Script has been paused again
        running := false
        SetTimer(Update, 0)
    }
}

F5::{
    global AutoRejoin, RobloxWasRunning, RobloxClosed

    if !reconnectoption
    {
        ToolTip("F5 test failed:`nReconnect is disabled in userconfig.ahk")
        Sleep(3000)
        ToolTip()
        return
    }

    AutoRejoin := true
    RobloxWasRunning := true
    RobloxClosed := false

    ToolTip("F5 test: Restarting Roblox...`nClosing Roblox and relaunching configured server...")
    SendWebhook(
            "warning",
            "🧪 F5 test: manually testing Roblox relaunch..."
        )

    RestartRoblox()

    ToolTip("F5 test complete.")
    Sleep(3000)
    ToolTip()
}

Esc::{
    SendWebhook(
            "success",
            "Macro exited.`nExit code: 1"
        )
    ExitApp()
}
