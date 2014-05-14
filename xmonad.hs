import XMonad
import XMonad.Hooks.ManageDocks

myManagementHooks :: [ManageHook]
myManagementHooks = [
  resource =? "stalonetray" --> doIgnore
  ]

main = xmonad defaultConfig
    { modMask = mod4Mask
    , terminal = "konsole"
    , focusFollowsMouse = False
    , manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks
    }
