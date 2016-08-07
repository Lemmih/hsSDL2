#include "SDL.h"
module Graphics.UI.SDL.Mouse
  ( createColorCursor
  , CursorPixelBit(..)
  , packCursorPixelBits
  , createCursor
  , setCursor
  , createSystemCursor
  , systemCursorArrow
  , systemCursorIBeam
  , systemCursorWait
  , systemCursorCrosshair
  , systemCursorWaitArrow
  , systemCursorSizeNWSE
  , systemCursorSizeNESW
  , systemCursorSizeWE
  , systemCursorSizeNS
  , systemCursorSizeAll
  , systemCursorNo
  , systemCursorHand
  , numSystemCursors
  , freeCursor
  , getCursor
  , getDefaultCursor
  , getMouseFocus
  , getRelativeMouseMode
  , setRelativeMouseMode
  , CursorToggle(..)
  , showCursor
  , warpMouseInWindow
  ) where

import Foreign
import Data.Maybe (fromMaybe)
import Data.List (unfoldr)
import Control.Applicative ((<$>))

import Graphics.UI.SDL.Types
import Graphics.UI.SDL.Error
import Graphics.UI.SDL.Utilities


foreign import ccall unsafe "SDL_CreateColorCursor"
  sdlCreateColorCursor :: Ptr SurfaceStruct -> #{type int} -> #{type int} -> IO (Ptr CursorStruct)

createColorCursor :: Surface -> #{type int} -> #{type int} -> IO (Ptr CursorStruct)
createColorCursor s x y =
  withForeignPtr s $ \sptr ->
    fatalSDLNull "SDL_CreateColorCursor" (sdlCreateColorCursor sptr x y)

foreign import ccall unsafe "SDL_CreateCursor"
  sdlCreateCursor :: Ptr #{type Uint8} -> Ptr #{type Uint8}
                  -> #{type int} -> #{type int} -> #{type int} -> #{type int} -> IO (Ptr CursorStruct)

data CursorPixelBit
  = On
  | Off
  deriving (Eq, Show)

cursorPixelBitToUint8 :: CursorPixelBit -> #{type Uint8}
cursorPixelBitToUint8 On  = 1
cursorPixelBitToUint8 Off = 0

packCursorPixelBits :: [CursorPixelBit] -> [#{type Uint8}]
packCursorPixelBits pixels =
  fmap pack chunks
  where pack bits  = foldl (\uint8 b -> (.|.) (uint8 `shift` 1) b) 0 bits
        chunk n    = takeWhile (not . null) . unfoldr (Just . splitAt n)
        chunks     = fmap (fmap cursorPixelBitToUint8) $ chunk bitsUInt8 pixels
        bitsUInt8  = 8

-- | pixels and mask should have a CursorPixelBit for every bit in a Uint8 (8 bits)
--   See the SDL documentation for the effect of each combination of bits
createCursor :: [CursorPixelBit] -> [CursorPixelBit] -> (#{type int}, #{type int}) -> (#{type int}, #{type int}) -> IO (Ptr CursorStruct)
createCursor pixels mask (width, height) (hot_x, hot_y) =
  withArray (packCursorPixelBits pixels) $ \ptrpixels ->
  withArray (packCursorPixelBits mask)   $ \ptrmask   ->
    fatalSDLNull "SDL_CreateCursor" $
      sdlCreateCursor ptrpixels ptrmask width height hot_x hot_y

newtype SystemCursor = SystemCursor { unwrapSystemCursor :: #{type int} }
#{enum SystemCursor, SystemCursor
, systemCursorArrow     = SDL_SYSTEM_CURSOR_ARROW
, systemCursorIBeam     = SDL_SYSTEM_CURSOR_IBEAM
, systemCursorWait      = SDL_SYSTEM_CURSOR_WAIT
, systemCursorCrosshair = SDL_SYSTEM_CURSOR_CROSSHAIR
, systemCursorWaitArrow = SDL_SYSTEM_CURSOR_WAITARROW
, systemCursorSizeNWSE  = SDL_SYSTEM_CURSOR_SIZENWSE
, systemCursorSizeNESW  = SDL_SYSTEM_CURSOR_SIZENESW
, systemCursorSizeWE    = SDL_SYSTEM_CURSOR_SIZEWE
, systemCursorSizeNS    = SDL_SYSTEM_CURSOR_SIZENS
, systemCursorSizeAll   = SDL_SYSTEM_CURSOR_SIZEALL
, systemCursorNo        = SDL_SYSTEM_CURSOR_NO
, systemCursorHand      = SDL_SYSTEM_CURSOR_HAND
, numSystemCursors      = SDL_NUM_SYSTEM_CURSORS
}

foreign import ccall unsafe "SDL_CreateSystemCursor"
  sdlCreateSystemCursor :: #{type int}-> IO (Ptr CursorStruct)

createSystemCursor :: SystemCursor -> IO (Ptr CursorStruct)
createSystemCursor sc =
  fatalSDLNull "SDL_CreateSystemCursor" $ sdlCreateSystemCursor (unwrapSystemCursor sc)

foreign import ccall unsafe "SDL_FreeCursor"
  freeCursor :: Ptr CursorStruct -> IO ()

foreign import ccall unsafe "SDL_GetCursor"
  sdlGetCursor :: IO (Ptr CursorStruct)

getCursor :: IO (Ptr CursorStruct)
getCursor =
  fatalSDLNull "SDL_GetCursor" $ sdlGetCursor

foreign import ccall unsafe "SDL_GetDefaultCursor"
  sdlGetDefaultCursor :: IO (Ptr CursorStruct)

getDefaultCursor :: IO (Ptr CursorStruct)
getDefaultCursor =
  fatalSDLNull "SDL_GetDefaultCursor" sdlGetDefaultCursor

foreign import ccall unsafe "SDL_GetMouseFocus"
  getMouseFocus :: IO (Ptr WindowStruct)

foreign import ccall unsafe "SDL_GetRelativeMouseMode"
  sdlGetRelativeMouseMode :: IO SDL_bool

getRelativeMouseMode :: IO Bool
getRelativeMouseMode = fmap sdlBoolToBool sdlGetRelativeMouseMode

foreign import ccall unsafe "SDL_SetCursor"
  setCursor :: Ptr CursorStruct -> IO ()

foreign import ccall unsafe "SDL_SetRelativeMouseMode"
  sdlSetRelativeMouseMode :: SDL_bool -> IO #{type int}

setRelativeMouseMode :: Bool -> IO ()
setRelativeMouseMode toggle =
  fatalSDLBool "SDL_SetRelativeMouseMode" $ sdlSetRelativeMouseMode sdl_toggle
    where sdl_toggle = boolToSdlBool toggle

data CursorToggle
  = Show
  | Hide
  | Query
  deriving (Eq, Show)

foreign import ccall unsafe "SDL_ShowCursor"
  sdlShowCursor :: #{type int} -> IO #{type int}

showCursor :: CursorToggle -> IO CursorToggle
showCursor curshow = do
  ret <- sdlShowCursor $ cursorToggleToC curshow
  case ret of
    0 -> return Hide
    1 -> return Show
    _ -> (fromMaybe "(no error message)" <$> getError) >>= \msg ->
           error $ "SDL_ShowCursor failed: " ++ msg
  where cursorToggleToC Show  = 1
        cursorToggleToC Hide  = 0
        cursorToggleToC Query = -1

foreign import ccall unsafe "SDL_WarpMouseInWindow"
  warpMouseInWindow :: Ptr WindowStruct -> #{type int} -> #{type int} -> IO ()

