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

     Default is 25 seconds, minimum is 25 seconds. Unless you are laggy, you should be able to stay on 25ms.

   * **Screen_width and screen_height:**

     Based on your screen's resolution. If you're running on 2560x1440, put screen_width to 2560 and screen_height to 1440.

     If you're running on 1920x1080, put screen_width to 1920 and screen_height to 1080. Currently only 16:9 displays are supported.

   * **Updatespeed:** The rate in which the seconds are updated. Lower values mean more precise inputs at a cost of potentially lagging your computer.

     Default is 100ms, if you are lagging, switch it to 1000ms. Recommended to stay between 100ms and 1000ms.

   * **reconnectoption & serverlink:** If you wish to have Roblox to automatically relaunch in the event of an error it cannot fix without relaunching, set this to true.

     If reconnectoption is set to true, you must have a valid Roblox private server link in serverlink.

   * **Optional settings, foreverpurchases, goal, webhook_msg, your_discord_user_id:** These are optional settings and only known if you have a webhook in webhook_msg.

     * **Foreverpurchases:** Put your foreverpurchase amount here and it will automatically go up in the stats to show your ascension count.

     * **Goal:** Put an ascension goal here and you will be able to see an ETA until you hit said goal in the webhook.

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

If both are correct and the macro is still stuck, message ".chemu." on Discord with a screenshot of the macro at the error code and I can help.

You can join the discord here: https://discord.gg/SXeWNaZR9J

**Last updated August 21st, 2026**
