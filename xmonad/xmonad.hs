-- core imports
import XMonad
import System.Exit
import qualified XMonad.StackSet as W

-- contrib imports
import XMonad.Util.EZConfig                                 -- easy keybind setting
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
-- layouts
import XMonad.Layout.Grid
import XMonad.Layout.Dwindle
import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.Gaps
import XMonad.Layout.Spacing

-- xmobar
import XMonad.Hooks.DynamicLog

main :: IO ()
main = xmonad . ewmh =<< xmobar cfg

cfg = def
    {   modMask             = mod4Mask
    ,   terminal            = "alacritty"
    ,   focusFollowsMouse   = False
    ,   clickJustFocuses    = False
    ,   borderWidth         = 3
    ,   normalBorderColor   = "#444444"
    ,   focusedBorderColor  = "#aaaaaa"
    ,   layoutHook          = layouts 
    ,   manageHook          = insertPosition Below Newer
    }
  `additionalKeysP`
    [ ("M-q", kill)                                         -- kill current window

    , ("M-<Tab>", sendMessage NextLayout)                   -- rotate through layouts

    , ("M-<Space>", windows W.swapMaster)                   -- Swap the focused window and the master window

    , ("M-i", sendMessage (IncMasterN 1))                   -- increment master nodes

    , ("M-S-i", sendMessage (IncMasterN (-1)))              -- deincrement master node

    , ("M-S-<Escape>", io (exitWith ExitSuccess))           -- Quit xmonad

    , ("M-<Escape>", spawn "xmonad --recompile; xmonad --restart")      -- Restart xmonad
    ]

layouts = spacingRaw False (Border 0 10 0 10) True (Border 10 0 10 0) True $ tiled ||| center ||| Grid ||| Dwindle R CW 1.5 1.1 ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    center  = ThreeColMid nmaster delta ratio 
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes
