--###################################################################################################################
--###################################################################################################################
--###                                                                                                             ###
--###                                                                                                             ###
--###    MMP"""""""MM                                                           M""MMM""MMM""M M"""""`'"""`YM     ###
--###    M' .mmmm  MM                                                           M  MMM  MMM  M M  mm.  mm.  M     ###
--###    M         `M dP  dP  dP .d8888b. .d8888b. .d8888b. 88d8b.d8b. .d8888b. M  MMP  MMP  M M  MMM  MMM  M     ###
--###    M  MMMMM  MM 88  88  88 88ooood8 Y8ooooo. 88'  `88 88'`88'`88 88ooood8 M  MM'  MM' .M M  MMM  MMM  M     ###
--###    M  MMMMM  MM 88.88b.88' 88.  ...       88 88.  .88 88  88  88 88.  ... M  `' . '' .MM M  MMM  MMM  M     ###
--###    M  MMMMM  MM 8888P Y8P  `88888P' `88888P' `88888P' dP  dP  dP `88888P' M  `' . '' .MM M  MMM  MMM  M     ###
--###    MMMMMMMMMMMM                                                           MMMMMMMMMMMMMM MMMMMMMMMMMMMM     ###
--###                                                                                                             ###
--###                                                                       Автор конфигурации: SkullGamer205     ###
--###################################################################################################################
--###################################################################################################################
--
--      \  |                  
--     |\/ |  _ \ __ \  |   | 
--     |   |  __/ |   | |   | 
--    _|  _|\___|_|  _|\__,_| 
--                            
--
local menu = {}
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local freedesktop = require("module.freedesktop")

-- {{{ Mouse bindings
-- root.buttons(gears.table.join(
--     awful.button({ }, 3, function () MainMenu:toggle() end)
-- ))

-- Valuables
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
app_menu = string.format("%s/.config/awesome/scripts/launcher.sh", os.getenv("HOME"))
power_menu = string.format("%s/.config/awesome/scripts/powermenu.sh", os.getenv("HOME"))
suspend = "loginctl suspend"
reboot = "loginctl reboot"
poweroff = "loginctl poweroff"
home_dir = string.format("%s/", os.getenv("HOME"))
desktop_dir = string.format("%s/.local/share/applications/", os.getenv("HOME"))
icon_1_dir = string.format("/home/skullgamer205/.local/share/icons/oomox-gruvbox-dark-hard/")
icon_2_dir = string.format("/home/skullgamer205/.local/share/icons/oomox-gruvbox/")
icon_3_dir = string.format("/usr/share/icons/hicolor/")
icon_4_dir = string.format("%s/.icons/oomox-Crux-Midnight/", os.getenv("HOME"))
icon_5_dir = string.format("/usr/share/icons/SE98/")
close = function (c) c:kill() end
-- {{{ Menu
 beautiful.menu_width = 112
beautiful.menu_font = "Terminess Nerd Font Mono 9"
beautiful.menu_bg_normal = xrdb.background
beautiful.avatar_icon = string.format("%s/.face", os.getenv("HOME"))
beautiful.star_icon = "/usr/share/icons/hicolor/scalable/emblems/emblem-xapp-favorite.svg"
-- Create a launcher widget and a main menu


--MainMenu = freedesktop.menu.build( { before = {
--                                    { "SkullGamer205", menu.user, beautiful.awesome_icon },
--                                    { "- - - - - -"},
--                                    { "быстрый доступ", menu.favorites, beautiful.star_icon },
--                                    { "- - - - - -"},},
--                                     submenu = {"Все программы"},
--                        })

MainMenu = freedesktop.menu.build( { before = { {  string.format("%s", os.getenv("USER")), {
                                      { "AwesomeWM", {
                                          { "Горячие клавиши", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, '/usr/share/icons/breeze-dark/devices/16/input-keyboard-virtual.svg' },
                                          { "Помощь", terminal .. " -e man awesome", icon_1_dir ..'actions/scalable/help-faq.svg' },
                                          { "Конфигурация", editor_cmd .. " " .. awesome.conffile, icon_2_dir ..'16x16/actions/configure.svg' },
                                          { "- - - - - -"},
                                          { "Перезагрузить", awesome.restart, icon_2_dir ..'22x22/actions/reload.svg' },
                                          { "Выход", function() awesome.quit() end , icon_1_dir ..'apps/scalable/system-shutdown.svg'},
                                       }, beautiful.awesome_icon},
                                      { "- - - - - -"},
                                      { "Меню приложений", app_menu, icon_2_dir ..'16x16/actions/format-justify-fill.svg'},
                                      { "Меню питания", power_menu, icon_1_dir ..'apps/scalable/system-shutdown.svg'},
                                      { "- - - - - -"},
                                      { "Ждущий режим", suspend, icon_1_dir ..'/apps/scalable/system-hibernate.svg'},
                                      { "Перезагрузка", reboot, icon_1_dir ..'/apps/scalable/system-reboot.svg'},
                                      { "Выключение", poweroff, icon_1_dir ..'apps/scalable/system-shutdown.svg'},
                                  }, beautiful.avatar_icon},
                                  { "- - - - - -"},
                                  { "быстрый доступ", {
                                      { "Браузеры" , {
                                          { "Librewolf" , 'prime librewolf' ,icon_3_dir ..'/16x16/apps/librewolf.png'},
--                                          { "Vieb", 'prime vieb', icon_3_dir ..'16x16/apps/vieb.png' },
--                                          { "Lynx", terminal .. " -e lynx"},
                                      } , icon_1_dir ..'categories/scalable/applications-webbrowsers.svg' },
                                      { "Игры" , {
                                          {" | itch.io",home_dir ..'/.itch/itch',icon_3_dir ..'128x128/apps/itch.png'},
                                          {" | TWad",'prime twad -rofi',home_dir ..'/Doom/icons8-doom-logo-512.png'},
                                          {" | PollyMC",'prime pollymc',icon_2_dir ..'16x16/apps/org.fn2006.PollyMC.svg'},
					  {" | SLADE 3",'prime slade',icon_2_dir ..'16x16/apps/slade.svg'},
                                          { "- - - - - -"},
                                          {"MoonDust - Editor",home_dir ..'/applications/Mario/smbx/TheXTech/exec/moondust-editor',home_dir ..'/applications/.icons/moondust-editor.png'},
                                          {"SMBX",home_dir ..'/applications/Mario/smbx/TheXTech/exec/smbx',home_dir ..'/applications/Mario/smbx/TheXTech/assets/SMBX/graphics/ui/icon/thextech.ico'},
                                          { "- - - - - -"},
                                          {"Celeste",home_dir .. '/applications/Celeste/celeste', home_dir .. '/applications/Celeste/game_icon.png'},
                                          {"Olympus", 'prime olympus', home_dir ..'/applications/Celeste/Everest/olympus.png'},
                                          {"Lönn",desktop_dir ..'/Lönn.desktop', home_dir .. '/applications/Celeste/Lönn/icon.png'},
                                          { "- - - - - -"},
                                          {"  | Mindustry",home_dir ..'/applications/mindustry/Mindustry-mangohud.sh',home_dir ..'/applications/mindustry/icon.png'},
                                          {" | OSU! Lazer" , 'prime-run osu-lazer' , home_dir ..'/applications/OSU/osu.svg'},
                                          {" | Steam" , 'prime-run steam' , icon_2_dir ..'16x16/apps/steam.svg'},
                                          {" | [GAMESCOPE] Steam" , 'prime gamescope --backend wayland -w 1920 -h 1080 -W 1920 -H 1080 --force-windows-fullscreen -f -b --adaptive-sync -e --disable-layers --disable-xres  --synchronous-x11 --default-touch-mode 3 --force-grab-cursor --mangoapp -r 75 steam-native' , icon_2_dir ..'16x16/apps/steam.svg'},
                                      } , icon_1_dir ..'categories/scalable/applications-games.svg' },
                                      { "Медиа" , {
                                          {"VLC",'vlc',icon_3_dir ..'128x128/apps/vlc-xmas.png'},
                                          {"Audacious",'audacious',icon_1_dir ..'apps/scalable/audacious.svg'},
                                          {"ncmpc", terminal .. ' -e ncmpc -C -m --host=127.0.0.1 --port=6600',icon_2_dir ..'actions/scalable/music-library.svg'},
                                          {"MPV",'mpv',icon_2_dir ..'32x32/apps/mpv.svg'},
                                      } , icon_1_dir .."categories/scalable/multimedia_section.svg" },
                                      { "Общение" , {
                                          {"Vesktop",'prime vesktop', icon_3_dir ..'16x16/apps/vesktop.png'},
                                          {"Forkgram",'forkgram',icon_2_dir ..'16x16/apps/forkgram.svg'},
                                          {"Element",'element-desktop',icon_2_dir ..'16x16/apps/element-desktop.svg'},
                                      } , icon_1_dir .."categories/scalable/applications-chat.svg" },
                                      { "Проводник" , {
                                          {"Thunar",'thunar',icon_2_dir ..'16x16/apps/thunar.svg'},
                                          {"MC", terminal .. ' -e mc',icon_2_dir ..'16x16/apps/mc.svg'},
                                          {"LF", terminal .. ' -e lf',icon_2_dir ..'symbolic/apps/system-file-manager-symbolic.svg'},
                                      } , icon_1_dir .."actions/scalable/fileopen.svg" },
                                      { "Блокноты" , {
                                          {"Emacs",'emacs',icon_2_dir ..'32x32/apps/emacs.svg'},
--                                          {"Helix",terminal .. ' -e helix',icon_3_dir ..'256x256/apps/helix.png'},
                                          {"Micro",terminal .. ' -e micro',icon_3_dir ..'scalable/apps/micro.svg'},
                                          {"QOwnNotes",'QOwnNotes', icon_2_dir ..'16x16/apps/QOwnNotes.svg'},
                                      } , icon_1_dir .."categories/scalable/applications-drawing.svg" },
                                      { "Утилиты" , {
                                          {"Glances", terminal .. ' -e glances',icon_2_dir ..'16x16/apps/bashtop.svg'},
                                          {"btop", terminal .. ' -e btop',icon_2_dir ..'16x16/apps/btop.svg'},
                                          {"nvtop", terminal .. ' -e nvtop', icon_2_dir ..'16x16/apps/nvtop.svg'},
                                          {"newsboat", terminal .. ' -e newsboat',icon_2_dir ..'16x16/apps/akregator.svg'},
                                          {"Windows 7 x64",'prime ' .. home_dir ..'.bin/qemu-win7x64' ,icon_2_dir ..'16x16/categories/windows95.svg'},
                                      } , icon_1_dir .."categories/scalable/xfce-utils.svg" },
                                      { "Прочее" , {
                                          {"ls -> exa"},
                                          {"cat -> bat"},
                                          {"find -> fd"},
                                      } , icon_1_dir .."categories/scalable/applications-other.svg" },
                                      { "OSINT" , {
                                          {"Snoop",terminal .. '-e /home/skullgamer205/applications/OSINT/Snoop/snoop_cli',''},
                                          {"MOSINT", terminal .. ' -e /home/skullgamer205/applications/OSINT/MOSINT/mosint',''},
                                      }},
                                      { "Персонализация", {
                                          {"Themix",'themix-gui',icon_1_dir ..'medium/apps/colorhug-ccmx.svg'},
                                          {"Pywal-Telegram", terminal .. ' -e wal-telegram --wal -r',icon_1_dir ..'medium/apps/colorhug-ccmx.svg'},
                                          {"Pywal-Discord",'',icon_1_dir ..'medium/apps/colorhug-ccmx.svg'},
                                      }, icon_1_dir .."medium/apps/colorhug-ccmx.svg" },
                                      { "urxvt", terminal, icon_1_dir .."apps/scalable/terminal.svg" },
                                  }, beautiful.star_icon },
                                  { "- - - - - -"},},
                                  submenu = {"Все программы"},
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

return menu
