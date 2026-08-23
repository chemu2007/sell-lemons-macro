# How to use

1. Go to the [Releases](https://github.com/chemu2007/sell-lemons-macro/releases) page and download the latest release. Extract the ZIP file to your desired location.

2. If you do not have AutoHotkey already installed, I have included the setup for the version that I edit.

3. Open `userconfig.ahk` in Notepad, here you can change the variables if needed.

   * **UI variation** = What variation of the UI that pops up when you press the up arrow to reveal the remote buy purchases.

     * **Variation 1** = 5/5 UI icons are present.
     * **Variation 2** = 3/5 UI icons are present.
     * **Variation 3** = 4/5 UI icons are present.

     (If you are F2P, which there currently isn't support for, you would pick the variation AFTER buying remote buy.)

   * **seconds_delay:** Amount of seconds before macro believes a problem has happened and will start auto-fixing.

     Default is 25 seconds, minimum is 25 seconds. Unless you are laggy, you should be able to stay on 25s.

   * **Screen_width and screen_height:**

     Based on your screen's resolution. If you're running on 2560x1440, put screen_width to 2560 and screen_height to 1440.

     If you're running on 1920x1080, put screen_width to 1920 and screen_height to 1080. Currently only 16:9 displays are supported.

   * **Updatespeed:** The rate in which the seconds are updated. Lower values mean more precise inputs at a cost of potentially lagging your computer.

     Default is 100ms, if you are lagging, switch it to 1000ms. Recommended to stay between 100ms and 1000ms.

   * **reconnectoption & serverlink:** If you wish to have Roblox automatically relaunch in the event of an error it cannot fix without relaunching, set this to true.

     If reconnectoption is set to true, you must have a valid Roblox private server link in serverlink.

   * **Optional settings, foreverpurchases, goal, totalruntime, webhook_msg, your_discord_user_id:** These are optional settings and only known if you have a webhook in webhook_msg.

     * **Foreverpurchases:** Put your foreverpurchase amount here and it will automatically go up in the stats to show your ascension count.

     * **Goal:** Put an ascension goal here and you will be able to see an ETA until you hit said goal in the webhook.

     * **Totalruntime:** Put your previous total runtime here if you are continuing from another installation or configuration. This is based off the total number of seconds the macro has been running and is automatically updated while the macro is running.

     * **Webhook_msg:** Put a valid Discord webhook in here to see your stats directly in your own channel!

     * **your_discord_user_id:** Put a valid Discord user ID in here to get pinged if the macro fails.

4. **Controls:**

   * **F1** to start
   * **F2** to pause/unpause
   * **ESC** to exit

## Error/Exit codes:

**Exit code 1:** User exited macro themselves.

**Exit code 2:** Roblox got into a state where the auto-fix was not fixing the problem. This could've been an issue of Roblox going into another instance (such as ascension lounge) or reconnect failing. Message chemu with a screenshot of your macro at the error code and I can help.

**Exit code 3:** Roblox failed to relaunch multiple times and automatically closed to stop further failures from happening. Could likely be a network issue with relaunching Roblox or unable to contact Roblox's servers.

**Error code 4:** Consqbreaks hit the limit of 10 while reconnectoption was enabled, it will now force restart Roblox.

**Error code 5:** The macro has not had an ascension since seconds_delay and will now attempt to auto-fix itself. If this is happening multiple times while you're just regularly ascending, try making seconds_delay longer.

**Error code 6:** Roblox is being force-restarted as part of Error 4's recovery process. The macro will close Roblox, reopen the configured private server, wait for Roblox to launch, and then resume the macro.

If the macro becomes stuck at this error, verify the following:

* You can access roblox.com normally on a web browser.
* Your serverLink is a valid Roblox private server link.

If both are correct and the macro is still stuck, message ".chemu." on Discord with your `userconfig.ahk` and error code. 

**Error code 7:** The macro detected the ascension screen but the ascension confirmation pixel remained detected for 10 seconds. The macro broke out of the ascension detection loop and continued running.

## How to interpret the webhook

### Example webhook: (webhook taken from version 2.0.3)

```text
-# 🟢 T/A: 10.24s Session: 11 Total: 131,722
-# **---------------------------------**
-# Current session time: 0d 00h 01m 53s
-# Total runtime: 0d 01h 35m 17s
-# Uptime: 100.00% EST Daily pace: 8,440
-# **---------------------------------**
-# 131,722/250,000 (118,278 left) T/R: 10.3s
-# **---------------------------------**
-# ETA: 09/04/2026 11:58 AM, 14d 00h 18m 56s
-# Current time: 08/21/2026 11:39:41 AM
-# **---------------------------------**
```

* **T/A:** Average Time per Ascension. Takes every ascension in the current session and calculates the average time per ascension.

* **Session:** Your current session ascensions. Starts at 0 and increases by 1 every successful ascension.

* **Total:** Your total ascension count. This is calculated from the `foreverpurchases` variable + 399.

* **Current session time:** The amount of time the current session has been running. This starts at 0 and is displayed in days, hours, minutes, and seconds.

* **Total runtime:** The persistent amount of time the macro has been running. This increases every time the macro runs and is saved whenever an ascension occurs.

* **Uptime:** The percentage of the session where the macro successfully completed an ascension. This is calculated using successful ascensions compared to successful ascensions + breaks.

* **EST Daily pace:** The estimated number of ascensions the macro could complete in 24 hours based on the current session's average T/A. This calculation uses the full-precision T/A rather than the rounded T/A displayed above.

* **131,722/250,000:** Your current total ascensions / your configured ascension goal.

* **(118,278 left):** The number of ascensions remaining until the configured goal is reached.

* **T/R:** Time per Run. Shows how long it took the macro to reach the current ascension. This can be useful for diagnosing potential network instability or unusually slow ascensions.

* **ETA:** The estimated date and time when the configured ascension goal will be reached. The time is displayed using your device's local timezone.

* **14d 00h 18m 56s:** The estimated amount of time remaining until the configured ascension goal is reached, based on the current T/A.

* **Current time:** Your device's current local date and time. The format is Month / Day / Year Hours : Minutes : Seconds AM/PM.

You can join the Discord here: https://discord.gg/SXeWNaZR9J

**Last updated August 21st, 2026**

