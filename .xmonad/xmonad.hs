import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

--import Control.OldException
import Control.Monad
-- import DBus
-- import DBus.Connection
-- import DBus.Message

-- import XMonad.Layout.LayoutCombinators
import XMonad.Layout.NoBorders
import XMonad.Layout.IM
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.FixedColumn
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig

import qualified Data.Map as M
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.XMonad

import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S

import XMonad.Actions.CycleWS
import Data.Ratio ((%))

-- This retry is really awkward, but sometimes DBus won't let us get our
-- name unless we retry a couple times.
-- getWellKnownName :: Connection -> IO ()
-- getWellKnownName dbus = tryGetName `catchDyn` (\ (DBus.Error _ _) ->
--                                                 getWellKnownName dbus)
-- where
--  tryGetName = do
--    namereq <- newMethodCall serviceDBus pathDBus interfaceDBus "RequestName"
--    addArgs namereq [String "org.xmonad.Log", Word32 5]
--    sendWithReplyAndBlock dbus namereq 0
--    return ()


main :: IO ()
main = xmonad $ gnomeConfig
  { logHook    = myLogHookWithPP $ defaultPP {
           ppOrder    = take 1 . drop 2
           , ppTitle    = pangoColor "#003366" . shorten 120
           , ppUrgent   = pangoColor "red"
           }
  , layoutHook = avoidStruts $ smartBorders $ myLayout
  , handleEventHook = fullscreenEventHook
  , manageHook = myManageHook
  , focusFollowsMouse = False
  , keys       = newKeys
  , terminal   = "rxvt"
  , modMask    = mod5Mask
  , startupHook = setWMName "LG3D"  -- Needed for Idea to work.
  } `additionalKeysP` multiKeys

myManageHook = composeAll
    [ manageHook gnomeConfig
    , className =? "mpv"               --> doFloat
    , className =? "mplayer2"          --> doFloat
    , className =? "Gimp"              --> doFloat
    , resource  =? "desktop_window"    --> doIgnore
    , isFullscreen                     --> doFullFloat
      -- chrome chat
    , stringProperty "WM_WINDOW_ROLE" =? "pop-up" --> doFloat
    ]

myLogHookWithPP :: PP -> X ()
myLogHookWithPP pp = do
    ewmhDesktopsLogHook
    dynamicLogWithPP $ pp

--myOutput dbus str = do
--  let str'  = "<span font=\"Terminus 9 Bold\">" ++ str ++ "</span>"
--      str'' = sanitize str'
--  msg <- newSignal "/org/xmonad/Log" "org.xmonad.Log" "Update"
--  addArgs msg [String str'']
--  -- If the send fails, ignore it.
--  send dbus msg 0 `catchDyn`(\ (DBus.Error _name _msg) -> return 0)
--  return ()

pangoColor :: String -> String -> String
pangoColor fg = wrap left right
 where
  left  = "<span foreground=\"" ++ fg ++ "\">"
  right = "</span>"

sanitize :: String -> String
sanitize [] = []
sanitize (x:rest) | fromEnum x > 127 = "&#" ++ show (fromEnum x) ++ "; " ++
                                       sanitize rest
                  | otherwise        = x : sanitize rest


myResizable = ResizableTall 1 (3/100) (1/2) []

myLayout
    = tiled
    ||| myResizable
---    ||| FixedColumn 1 20 84 10
    ||| Full
    ||| simpleTabbed
    ||| (reflectHoriz $ withIM (1%12) (Title "Buddy List") (reflectHoriz $ myResizable))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by# master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

delKeys x = foldr M.delete (keys defaultConfig x) (keysToRemove x)

newKeys x = M.union (delKeys x) (M.fromList (myKeys x))

myKeys conf@(XConfig {XMonad.modMask = modm}) =
        [ ((modm, xK_b     ), sendMessage ToggleStruts)
        , ((modm, xK_p     ), shellPrompt myXPConfig)
        , ((modm, xK_grave), windowPromptGoto myXPConfig)
        , ((modm, xK_s), S.promptSearch myXPConfig S.google)
        , ((modm .|. controlMask, xK_x), xmonadPrompt myXPConfig)
        , ((modm,               xK_bracketright), nextWS)
        , ((modm,               xK_bracketleft ), prevWS)
        , ((modm .|. shiftMask, xK_bracketright), shiftToNext >> nextWS)
        , ((modm .|. shiftMask, xK_bracketleft ), shiftToPrev >> prevWS)
        , ((modm,               xK_a),            sendMessage MirrorShrink)
        , ((modm,               xK_z),            sendMessage MirrorExpand)
        , ((controlMask .|. mod1Mask, xK_l),      spawn "gnome-screensaver-command -l")
        , ((controlMask .|. mod1Mask, xK_s),      spawn "sshot")
        , ((controlMask .|. mod1Mask, xK_r),      spawn "killall -USR1 redshift")
        ]

multiKeys =
  [ ("<XF86AudioMute>",         spawn "amixer -D pulse set Master 1+ toggle")
  , ("<XF86AudioMicMute>",      spawn "amixer -D pulse set Capture toggle")
  , ("<XF86AudioLowerVolume>",  spawn "amixer -D pulse set Master 5%- unmute")
  , ("<XF86AudioRaiseVolume>",  spawn "amixer -D pulse set Master 5%+ unmute")
  , ("<XF86MonBrightnessUp>",   spawn "xbacklight -inc 5")
  , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
  ]

keysToRemove :: XConfig Layout -> [(KeyMask, KeySym)]
keysToRemove XConfig{modMask = modm} =
        [ (modm,               xK_p )
        , (modm .|. shiftMask, xK_p )
        ]


myXPConfig = defaultXPConfig {
  font = "-Misc-Fixed-Medium-R-Normal-*-18-*-*-*-*-*-*-*",
  bgColor = "black",
  fgColor = "green",
  position = Top,
  height = 22
  }
