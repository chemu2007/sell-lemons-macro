# How to update

1. Download latest version of `macro.ahk`

2. Replace your version of `macro.ahk` with the latest version

3. Check if there are any additions to `userconfig.ahk` and update accordingly

# How to use

1. Go to the [Releases](https://github.com/chemu2007/sell-lemons-macro/releases) page and download the latest release. Extract the ZIP file to your desired location.

2. If you do not have AutoHotkey already installed, I have included the setup for the version that I edit.

3. Open `userconfig.ahk` in Notepad, here you can change the variables if needed.

   * **UI variation** = What variation of the UI that pops up when you press the up arrow to reveal the remote buy purchases.

     * **Variation 1** = 5/5 UI icons are present.
     * **Variation 2** = 3/5 UI icons are present.
     * **Variation 3** = 4/5 UI icons are present.

     (If you are F2P, which there currently isn't support for, you would pick the variation AFTER buying remote buy.)

     **f2p_mode** = If you are free to play, meaning you need to buy remote buy every ascension, enable this

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

**Error code 6:** Roblox is being force-restarted as part of Error 4's recovery process. The macro will close Roblox, reopen the configured private server, wait for Roblox to launch, and then resume the macro. (Roblox relaunch test forcefully triggers this code) (If the macro becomes stuck at this error, verify that your serverLink is a valid Roblox private server link.)

**Error code 7:** The macro detected the ascension screen but the ascension confirmation pixel remained detected for 10 seconds. The macro broke out of the ascension detection loop and continued running.

## How to interpret the webhook

Example

**🟢 Ascension successful**

**Performance:**

Time per Ascension: 9.59s
Time this Ascension: 9.0s
Uptime: 99.45%
Daily pace: 9,010/day

**Progress:**

161,786 / 250,000 (64.71%)
█████████████░░░░░░░
88,214 remaining

**Runtime**

Session: 0d 16h 56m 01s
Total: 3d 11h 35m 02s

**ETA**

09/05/2026 2:00 AM
9d 18h 58m 55s remaining

**V2.1.1 EXP, 08/26/2026 7:01:53 AM**

Ascension successful: The macro successfully completed an ascension.

Time per Ascension: Average time taken per ascension in the current session.

Time this Ascension: How long the most recently completed ascension took.

Uptime: Percentage of the session where the macro was actively running.

Daily pace: Estimated number of ascensions the macro can complete per day.

Progress: Current ascension count, goal, percentage completed, and remaining ascensions.

Session: How long the current macro session has been running.

Total: Total runtime across sessions, based on `totalruntime`.

ETA: Estimated time and date when the configured goal will be reached.

Version: Current macro version and the time the webhook was generated.

Time formats are in MONTH / DAY / YEAR HH:MM:SS AM/PM

24 hour formats may be supported in a later update

You can join the Discord here: https://discord.gg/SXeWNaZR9J
