#Requires AutoHotkey v2.0

; Numbers can be entered directly after := 
; Text must be wrapped in quotation marks ("")
; Example: number := 100
; Example: text := "hello"
; Exception: True/False such as reconnectoption
; webhook_msg and ServerLink must be wrapped in quotation marks

ui_variation := 1
; UI variation 1 = 5/5 UI icons are on the screen
; UI variation 2 = 3/5 UI icons are on the screen
; UI variation 3 = 4/5 UI icons are on the screen

f2p_mode := false
; Enable Free To Play (F2P) mode if you do not own remote buy
; Disable it if you have remote buy bought
; Enable which UI variation you have AFTER buying remote buy

seconds_delay := 25
; Delay, in seconds, before the macro runs its auto-fix
; Default is 25, minimum is 25

screen_width := 1920
screen_height := 1080
; Screen width and height for your display. Only 16:9 is supported
; 2560x1440 = screen_width := 2560, screen_height := 1440
; 1920x1080 = screen_width := 1920, screen_height := 1080

updatespeed := 100
; Update speed of the macro. Lower values provide more precise average time
; at the cost of potentially slowing down the macro
; Default is 100 (100ms), recommended is between 100 and 1000
; (100ms and 1000ms or 1 second)

reconnectoption := false
ServerLink := ""
; If reconnectoption = true, you must have a valid Roblox private server link in ServerLink

foreverpurchases := 0
goal := 0
webhook_msg := ""
your_discord_user_id := 0
; Optional stats for your webhook posting. Foreverpurchases goes up by 1 on every ascension.
; Foreverpurchases is your forever purchases amount on your Roblox UI
; Goal is your ascension goal
; You must put a valid Discord webhook in webhook_msg to get the webhook and stats posted
; You can put a valid Discord user ID in your_discord_user_id to be pinged if the macro breaks

totalruntime := 0
; Total runtime in seconds between all of your runs
; Default is 0, increases by 1 every second, and persists between runs
; The value is saved on ascension
