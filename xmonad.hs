import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO

myManagementHooks :: [ManageHook]
myManagementHooks = [
  resource =? "stalonetray" --> doIgnore
  ]

xmobarTitleColor = "#FFB6B0"
xmobarCurrentWorkspaceColor = "#CEFFAC"

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { modMask = mod4Mask
        , terminal = "konsole"
        , focusFollowsMouse = False
        , manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
                        , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                        , ppSep = "    "
                        }
        }
