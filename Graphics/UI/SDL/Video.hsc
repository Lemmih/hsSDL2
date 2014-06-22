{-# LANGUAGE RecordWildCards #-}
#include "SDL.h"
-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.UI.SDL.Video
-- Copyright   :  (c) David Himmelstrup 2005
-- License     :  BSD-like
--
-- Maintainer  :  lemmih@gmail.com
-- Stability   :  provisional
-- Portability :  portable
--
-----------------------------------------------------------------------------
module Graphics.UI.SDL.Video
  ( -- * Window management
    withWindow
  , createWindow
  , createWindowFrom
  , destroyWindow

  , showWindow
  , hideWindow
  , maximizeWindow
  , minimizeWindow
  , raiseWindow
  , restoreWindow

  , setWindowBrightness
  , getWindowBrightness

  , setWindowGrab
  , getWindowGrab
  , setWindowIcon

  , setWindowMaximumSize
  , getWindowMaximumSize

  , setWindowMinimumSize
  , getWindowMinimumSize

  , setWindowPosition
  , getWindowPosition

  , setWindowSize
  , getWindowSize

  , setWindowTitle
  , getWindowTitle

  , getWindowPixelFormat

  , setWindowDisplayMode
  , getWindowDisplayMode

  , getWindowDisplayIndex

  , WindowID
  , getWindowID
  , getWindowFromID

    -- * OpenGL
  , GLattr(..)
  , withBoundTexture
  , withOpenGL
  , glBindTexture
  , glCreateContext
  , glDeleteContext
  , glExtensionSupported
  , glResetAttributes
  , glSetAttribute
  , glGetAttribute
  , glGetCurrentContext
  , glGetCurrentWindow
  , glGetDrawableSize
  , glSwapWindow
  , glUnbindTexture

    -- * Surfaces
  , surfaceFormat

    -- * Screensaver handling
  , disableScreenSaver
  , enableScreenSaver
  , withoutScreenSaver
  , isScreenSaverEnabled

    -- * Pixel formats
  , allocFormat
  , mapRGB
  , mapRGBA

    -- * Display Modes
  , DisplayMode(..)
  , getClosestDisplayMode
  , getCurrentDisplayMode
  , getDesktopDisplayMode
  , getDisplayMode

  , getDisplayName
  , getNumDisplayModes
  , getNumVideoDisplays
  , getCurrentVideoDriver
  , getDisplayBounds
  , getNumVideoDrivers
  , getVideoDriver
  , getWindowFlags

  , videoInit
  , videoQuit
  ) where

import Control.Applicative
import Control.Exception (bracket, bracket_)
import Control.Monad
import Data.ByteString (useAsCString)
import Data.Text.Encoding
import Foreign hiding (void)
import Foreign.C
import Foreign.C.Types

import Graphics.UI.SDL.Types
import Graphics.UI.SDL.Utilities
import Graphics.UI.SDL.General
import Graphics.UI.SDL.Rect (Rect(..))
import Graphics.UI.SDL.Raw

import qualified Data.Text as T


type WindowID = Int

data GLattr
   = GLRedSize
   | GLGreenSize
   | GLBlueSize
   | GLAlphaSize
   | GLBufferSize
   | GLDoublebuffer
   | GLDepthSize
   | GLStencilSize
   | GLAccumRedSize
   | GLAccumGreenSize
   | GLAccumBlueSize
   | GLAccumAlphaSize
   | GLStereo
   | GLMultisamplebuffers
   | GLMultisamplesamples
   | GLAcceleratedVisual
   | GLRetainedBacking
   | GLContextMajorVersion
   | GLContextMinorVersion
   | GLContextEgl
   | GLContextFlags
   | GLContextProfileMask
   | GLShareWithCurrentContext
   | GLFramebufferSrgbCapable
  deriving (Show, Eq)

instance Enum GLattr where
  toEnum #{const SDL_GL_RED_SIZE} = GLRedSize
  toEnum #{const SDL_GL_GREEN_SIZE} = GLGreenSize
  toEnum #{const SDL_GL_BLUE_SIZE} = GLBlueSize
  toEnum #{const SDL_GL_ALPHA_SIZE} = GLAlphaSize
  toEnum #{const SDL_GL_BUFFER_SIZE} = GLBufferSize
  toEnum #{const SDL_GL_DOUBLEBUFFER} = GLDoublebuffer
  toEnum #{const SDL_GL_DEPTH_SIZE} = GLDepthSize
  toEnum #{const SDL_GL_STENCIL_SIZE} = GLStencilSize
  toEnum #{const SDL_GL_ACCUM_RED_SIZE} = GLAccumRedSize
  toEnum #{const SDL_GL_ACCUM_GREEN_SIZE} = GLAccumGreenSize
  toEnum #{const SDL_GL_ACCUM_BLUE_SIZE} = GLAccumBlueSize
  toEnum #{const SDL_GL_ACCUM_ALPHA_SIZE} = GLAccumAlphaSize
  toEnum #{const SDL_GL_STEREO} = GLStereo
  toEnum #{const SDL_GL_MULTISAMPLEBUFFERS} = GLMultisamplebuffers
  toEnum #{const SDL_GL_MULTISAMPLESAMPLES} = GLMultisamplesamples
  toEnum #{const SDL_GL_ACCELERATED_VISUAL} = GLAcceleratedVisual
  toEnum #{const SDL_GL_RETAINED_BACKING} = GLRetainedBacking
  toEnum #{const SDL_GL_CONTEXT_MAJOR_VERSION} = GLContextMajorVersion
  toEnum #{const SDL_GL_CONTEXT_MINOR_VERSION} = GLContextMinorVersion
  toEnum #{const SDL_GL_CONTEXT_EGL} = GLContextEgl
  toEnum #{const SDL_GL_CONTEXT_FLAGS} = GLContextFlags
  toEnum #{const SDL_GL_CONTEXT_PROFILE_MASK} = GLContextProfileMask
  toEnum #{const SDL_GL_SHARE_WITH_CURRENT_CONTEXT} = GLShareWithCurrentContext
  toEnum #{const SDL_GL_FRAMEBUFFER_SRGB_CAPABLE} = GLFramebufferSrgbCapable
  toEnum _ = error "GLattr.toEnum: Invalid argument"

  fromEnum GLRedSize = #{const SDL_GL_RED_SIZE}
  fromEnum GLGreenSize = #{const SDL_GL_GREEN_SIZE}
  fromEnum GLBlueSize = #{const SDL_GL_BLUE_SIZE}
  fromEnum GLAlphaSize = #{const SDL_GL_ALPHA_SIZE}
  fromEnum GLBufferSize = #{const SDL_GL_BUFFER_SIZE}
  fromEnum GLDoublebuffer = #{const SDL_GL_DOUBLEBUFFER}
  fromEnum GLDepthSize = #{const SDL_GL_DEPTH_SIZE}
  fromEnum GLStencilSize = #{const SDL_GL_STENCIL_SIZE}
  fromEnum GLAccumRedSize = #{const SDL_GL_ACCUM_RED_SIZE}
  fromEnum GLAccumGreenSize = #{const SDL_GL_ACCUM_GREEN_SIZE}
  fromEnum GLAccumBlueSize = #{const SDL_GL_ACCUM_BLUE_SIZE}
  fromEnum GLAccumAlphaSize = #{const SDL_GL_ACCUM_ALPHA_SIZE}
  fromEnum GLStereo = #{const SDL_GL_STEREO}
  fromEnum GLMultisamplebuffers = #{const SDL_GL_MULTISAMPLEBUFFERS}
  fromEnum GLMultisamplesamples = #{const SDL_GL_MULTISAMPLESAMPLES}
  fromEnum GLAcceleratedVisual = #{const SDL_GL_ACCELERATED_VISUAL}
  fromEnum GLRetainedBacking = #{const SDL_GL_RETAINED_BACKING}
  fromEnum GLContextMajorVersion = #{const SDL_GL_CONTEXT_MAJOR_VERSION}
  fromEnum GLContextMinorVersion = #{const SDL_GL_CONTEXT_MINOR_VERSION}
  fromEnum GLContextEgl = #{const SDL_GL_CONTEXT_EGL}
  fromEnum GLContextFlags = #{const SDL_GL_CONTEXT_FLAGS}
  fromEnum GLContextProfileMask = #{const SDL_GL_CONTEXT_PROFILE_MASK}
  fromEnum GLShareWithCurrentContext = #{const SDL_GL_SHARE_WITH_CURRENT_CONTEXT}
  fromEnum GLFramebufferSrgbCapable = #{const SDL_GL_FRAMEBUFFER_SRGB_CAPABLE}

--------------------------------------------------------------------------------
-- XXX: Will SDL2 always copy the given cstring?
withUtf8CString :: String -> (CString -> IO a) -> IO a
withUtf8CString = useAsCString . encodeUtf8 . T.pack

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_CreateWindow"
  sdlCreateWindow :: CString -> CInt -> CInt -> CInt -> CInt -> #{type Uint32} -> IO (Ptr WindowStruct)

createWindow :: String -> Position -> Size -> [WindowFlag] -> IO Window
createWindow title (Position x y) (Size w h) flags =
  withUtf8CString title $ \cstr -> do
    window <- fatalSDLNull "SDL_CreateWindow" $
      sdlCreateWindow
        cstr (fromIntegral x) (fromIntegral y) (fromIntegral w) (fromIntegral h)
             (toBitmask windowFlagToC flags)
    mkFinalizedWindow window

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_CreateWindowFrom"
  sdlCreateWindowFrom :: Ptr a -> IO (Ptr WindowStruct)

createWindowFrom :: Ptr a -> IO Window
createWindowFrom = fatalSDLNull "SDL_CreateWindowFrom" . sdlCreateWindowFrom >=> mkFinalizedWindow

--------------------------------------------------------------------------------
withWindow :: String -> Position -> Size -> [WindowFlag] -> (Window -> IO r) -> IO r
withWindow title position size flags =
  bracket (createWindow title position size flags) destroyWindow

destroyWindow :: Window -> IO ()
destroyWindow = finalizeForeignPtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_CreateContext"
  sdlGlCreateContext :: Ptr WindowStruct -> IO (Ptr GLContextStruct)

glCreateContext :: Window -> IO GLContext
glCreateContext w = withForeignPtr w $
  fatalSDLNull "SDL_GL_CreateContext" . sdlGlCreateContext >=>
    newForeignPtr sdlGlDeleteContext_finalizer

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_GetCurrentContext"
  sdlGlGetCurrentContext :: IO (Ptr GLContextStruct)

glGetCurrentContext :: IO GLContext
glGetCurrentContext =
  fatalSDLNull "SDL_GL_GetCurrentContext" sdlGlGetCurrentContext >>= newForeignPtr_

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_GetCurrentWindow"
  sdlGlGetCurrentWindow :: IO (Ptr WindowStruct)

glGetCurrentWindow :: IO Window
glGetCurrentWindow =
  fatalSDLNull "SDL_GL_GetCurrentWindow" sdlGlGetCurrentWindow >>= newForeignPtr_

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_GetDrawableSize"
  sdlGlGetDrawableSize :: Ptr WindowStruct -> Ptr #{type int} -> Ptr #{type int} -> IO ()

glGetDrawableSize :: Window -> IO Size
glGetDrawableSize window = withForeignPtr window $ \cWin ->
  alloca $ \wPtr -> alloca $ \hPtr -> do
    sdlGlGetDrawableSize cWin wPtr hPtr
    Size <$> (fromIntegral <$> peek wPtr) <*> (fromIntegral <$> peek hPtr)

--------------------------------------------------------------------------------
foreign import ccall unsafe "&SDL_GL_DeleteContext"
  sdlGlDeleteContext_finalizer :: FunPtr (Ptr GLContextStruct -> IO ())

glDeleteContext :: GLContext -> IO ()
glDeleteContext = finalizeForeignPtr

--------------------------------------------------------------------------------
withOpenGL :: Window -> IO a -> IO a
withOpenGL win = bracket (glCreateContext win) glDeleteContext . const

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_ExtensionSupported"
  sdlGlExtensionSupported :: CString -> IO #{type SDL_bool}

glExtensionSupported :: String -> IO Bool
glExtensionSupported ext = withCString ext $
  fmap sdlBoolToBool . sdlGlExtensionSupported

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_ResetAttributes"
  glResetAttributes :: IO ()

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_SetAttribute"
  sdlGlSetAttribute :: #{type SDL_GLattr} -> #{type int} -> IO #{type int}

glSetAttribute :: GLattr -> Int -> IO ()
glSetAttribute attr val = do
  let attr' = fromIntegral $ fromEnum attr
      val'  = fromIntegral val
  ret <- sdlGlSetAttribute attr' val'
  handleErrorICond "glSetAttribute" ret (== 0) $ (const $ return ())

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_GetAttribute"
  sdlGlGetAttribute :: #{type SDL_GLattr} -> Ptr #{type int} -> IO #{type int}

glGetAttribute :: GLattr -> IO Int
glGetAttribute attr =
  alloca $ \val' -> do
    let attr' = fromIntegral $ fromEnum attr
    ret <- sdlGlGetAttribute attr' val'
    handleErrorICond "glGetAttribute" ret (== 0) $ (const $ peek val' >>= return . fromIntegral)

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_SwapWindow"
  sdlGlSwapWindow :: Ptr WindowStruct -> IO ()

glSwapWindow :: Window -> IO ()
glSwapWindow w = withForeignPtr w sdlGlSwapWindow

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_BindTexture"
  sdlGlBindTexture :: Ptr TextureStruct -> Ptr CFloat -> Ptr CFloat -> IO #{type int}

-- | Bind a texture to the active texture unit in the current OpenGL context.
glBindTexture :: Texture -> IO ()
glBindTexture tex = void $ withForeignPtr tex $ \texp ->
  fatalSDLBool "SDL_GL_BindTexture" $ sdlGlBindTexture texp nullPtr nullPtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GL_UnbindTexture"
  sdlGlUnbindTexture :: Ptr TextureStruct -> IO CInt

-- | Unbind a texture from the current OpenGL context.
glUnbindTexture :: Texture -> IO ()
glUnbindTexture tex = Control.Monad.void $ withForeignPtr tex $ \texp ->
  sdlGlUnbindTexture texp

-- | Run an action with a texture bound to the active texture unit in the current OpenGL context, and unbind it afterwards.
withBoundTexture :: Texture -> IO a -> IO a
withBoundTexture tex = bracket_ (glBindTexture tex) (glUnbindTexture tex)

--------------------------------------------------------------------------------
-- void SDL_DisableScreenSaver(void)
foreign import ccall unsafe "SDL_DisableScreenSaver"
  disableScreenSaver :: IO ()

-- void SDL_EnableScreenSaver(void)
foreign import ccall unsafe "SDL_EnableScreenSaver"
  enableScreenSaver :: IO ()

withoutScreenSaver :: IO a -> IO a
withoutScreenSaver = bracket_ disableScreenSaver enableScreenSaver

-- SDL_bool SDL_IsScreenSaverEnabled(void)
foreign import ccall unsafe "SDL_IsScreenSaverEnabled"
  sdlIsScreenSaverEnabled :: IO SDL_bool

isScreenSaverEnabled :: IO Bool
isScreenSaverEnabled = fmap (/= 0) sdlIsScreenSaverEnabled

-- void SDL_HideWindow(SDL_Window* window)
foreign import ccall unsafe "SDL_HideWindow" sdlHideWindow :: Ptr WindowStruct -> IO ()

hideWindow :: Window -> IO ()
hideWindow win = withForeignPtr win sdlHideWindow

-- void SDL_MaximizeWindow(SDL_Window* window)
foreign import ccall unsafe "SDL_MaximizeWindow" sdlMaximizeWindow :: Ptr WindowStruct -> IO ()

maximizeWindow :: Window -> IO ()
maximizeWindow win = withForeignPtr win sdlMaximizeWindow

-- void SDL_MinimizeWindow(SDL_Window* window)
foreign import ccall unsafe "SDL_MinimizeWindow" sdlMinimizeWindow :: Ptr WindowStruct -> IO ()

minimizeWindow :: Window -> IO ()
minimizeWindow win = withForeignPtr win sdlMinimizeWindow

-- void SDL_RaiseWindow(SDL_Window* window)
foreign import ccall unsafe "SDL_RaiseWindow" sdlRaiseWindow :: Ptr WindowStruct -> IO ()

raiseWindow :: Window -> IO ()
raiseWindow win = withForeignPtr win sdlRaiseWindow

-- void SDL_RestoreWindow(SDL_Window* window)
foreign import ccall unsafe "SDL_RestoreWindow" sdlRestoreWindow :: Ptr WindowStruct -> IO ()

restoreWindow :: Window -> IO ()
restoreWindow win = withForeignPtr win sdlRestoreWindow

-- void SDL_ShowWindow(SDL_Window* window)
foreign import ccall unsafe "SDL_ShowWindow" sdlShowWindow :: Ptr WindowStruct -> IO ()

showWindow :: Window -> IO ()
showWindow win = withForeignPtr win sdlShowWindow

-- int SDL_SetWindowBrightness(SDL_Window* window, float brightness)
foreign import ccall unsafe "SDL_SetWindowBrightness"
  sdlSetWindowBrightness :: Ptr WindowStruct -> CFloat -> IO CInt

setWindowBrightness :: Window -> Double -> IO ()
setWindowBrightness win brightness =
  unwrapBool "setWindowBrightness" $
  withForeignPtr win $ \cw ->
    fmap (==0) (sdlSetWindowBrightness cw (realToFrac brightness))

-- float SDL_GetWindowBrightness(SDL_Window* window)
foreign import ccall unsafe "SDL_GetWindowBrightness"
  sdlGetWindowBrightness :: Ptr WindowStruct -> IO CFloat

-- FIXME: Error handling?
getWindowBrightness :: Window -> IO Double
getWindowBrightness win =
  withForeignPtr win $
  fmap realToFrac . sdlGetWindowBrightness

-- void* SDL_SetWindowData(SDL_Window* window, const char* name, void* userdata)
-- void* SDL_GetWindowData(SDL_Window* window, const char* name)
-- int SDL_SetWindowFullscreen(SDL_Window* window, Uint32 flags)
-- int SDL_SetWindowGammaRamp(SDL_Window*window,const Uint16* red,const Uint16* green,const Uint16* blue)
-- int SDL_GetWindowGammaRamp(SDL_Window* window,Uint16*red,Uint16*green,Uint16*blue)

-- void SDL_SetWindowGrab(SDL_Window* window, SDL_bool    grabbed)
foreign import ccall unsafe "SDL_SetWindowGrab"
  sdlSetWindowGrab :: Ptr WindowStruct -> SDL_bool -> IO ()

setWindowGrab :: Window -> Bool -> IO ()
setWindowGrab win flag =
  withForeignPtr win $ \cw ->
  sdlSetWindowGrab cw (if flag then 1 else 0)

-- SDL_bool SDL_GetWindowGrab(SDL_Window* window)
foreign import ccall unsafe "SDL_GetWindowGrab"
  sdlGetWindowGrab :: Ptr WindowStruct -> IO SDL_bool

getWindowGrab :: Window -> IO Bool
getWindowGrab win = withForeignPtr win $ fmap (/=0) . sdlGetWindowGrab

foreign import ccall unsafe "SDL_SetWindowIcon"
  sdlSetWindowIcon :: Ptr WindowStruct -> Ptr SurfaceStruct -> IO ()

setWindowIcon :: Window -> Surface -> IO ()
setWindowIcon win icon =
  withForeignPtr win $ \cw ->
    withForeignPtr icon $ \icon' -> sdlSetWindowIcon cw icon'

-- void SDL_SetWindowMaximumSize(SDL_Window* window,int max_w,int max_h)
foreign import ccall unsafe "SDL_SetWindowMaximumSize"
  sdlSetWindowMaximumSize :: Ptr WindowStruct -> CInt -> CInt -> IO ()

setWindowMaximumSize :: Window -> Size -> IO ()
setWindowMaximumSize win (Size width height) =
  withForeignPtr win $ \cw ->
  sdlSetWindowMaximumSize cw (fromIntegral height) (fromIntegral width)

-- void SDL_GetWindowMaximumSize(SDL_Window* window,int*w,int*h)
foreign import ccall unsafe "SDL_GetWindowMaximumSize"
  sdlGetWindowMaximumSize :: Ptr WindowStruct -> Ptr CInt -> Ptr CInt -> IO ()

getWindowMaximumSize :: Window -> IO Size
getWindowMaximumSize win =
  withForeignPtr win $ \cw ->
  alloca $ \widthPtr ->
  alloca $ \heightPtr -> do
    sdlGetWindowMaximumSize cw widthPtr heightPtr
    mkSize <$> peek widthPtr <*> peek heightPtr

-- void SDL_SetWindowMinimumSize(SDL_Window* window,int min_w,int min_h)
foreign import ccall unsafe "SDL_SetWindowMinimumSize"
  sdlSetWindowMinimumSize :: Ptr WindowStruct -> CInt -> CInt -> IO ()

setWindowMinimumSize :: Window -> Size -> IO ()
setWindowMinimumSize win (Size width height) =
  withForeignPtr win $ \cw ->
  sdlSetWindowMinimumSize cw (fromIntegral width) (fromIntegral height)

-- void SDL_GetWindowMinimumSize(SDL_Window* window, int*w, int*h)
foreign import ccall unsafe "SDL_GetWindowMinimumSize"
  sdlGetWindowMinimumSize :: Ptr WindowStruct -> Ptr CInt -> Ptr CInt -> IO ()

getWindowMinimumSize :: Window -> IO Size
getWindowMinimumSize win =
  withForeignPtr win $ \cw ->
  alloca $ \widthPtr ->
  alloca $ \heightPtr -> do
    sdlGetWindowMinimumSize cw widthPtr heightPtr
    mkSize <$> peek widthPtr <*> peek heightPtr

-- void SDL_SetWindowPosition(SDL_Window* window, int x, int y)
foreign import ccall unsafe "SDL_SetWindowPosition"
  sdlSetWindowPosition :: Ptr WindowStruct -> CInt -> CInt -> IO ()

setWindowPosition :: Window -> Position -> IO ()
setWindowPosition win (Position x y) =
  withForeignPtr win $ \cw ->
  sdlSetWindowPosition cw (fromIntegral x) (fromIntegral y)

-- void SDL_GetWindowPosition(SDL_Window* window, int*x, int*y)
foreign import ccall unsafe "SDL_GetWindowPosition"
  sdlGetWindowPosition :: Ptr WindowStruct -> Ptr CInt -> Ptr CInt -> IO ()

getWindowPosition :: Window -> IO Position
getWindowPosition win =
  withForeignPtr win $ \cw ->
  alloca $ \xPtr ->
  alloca $ \yPtr -> do
    sdlGetWindowPosition cw xPtr yPtr
    mkPosition <$> peek xPtr <*> peek yPtr

-- void SDL_SetWindowSize(SDL_Window* window, int w, int h)
foreign import ccall unsafe "SDL_SetWindowSize"
  sdlSetWindowSize :: Ptr WindowStruct -> CInt -> CInt -> IO ()

setWindowSize :: Window -> Size -> IO ()
setWindowSize win (Size width height) =
  withForeignPtr win $ \cw ->
  sdlSetWindowSize cw (fromIntegral width) (fromIntegral height)

-- void SDL_GetWindowSize(SDL_Window* window, int*w, int*h)
foreign import ccall unsafe "SDL_GetWindowSize"
  sdlGetWindowSize :: Ptr WindowStruct -> Ptr CInt -> Ptr CInt -> IO ()

getWindowSize :: Window -> IO Size
getWindowSize win =
  withForeignPtr win $ \cw ->
  alloca $ \widthPtr ->
  alloca $ \heightPtr -> do
    sdlGetWindowSize cw widthPtr heightPtr
    mkSize <$> peek widthPtr <*> peek heightPtr

-- void SDL_SetWindowTitle(SDL_Window* window, const char* title)
foreign import ccall unsafe "SDL_SetWindowTitle"
  sdlSetWindowTitle :: Ptr WindowStruct -> CString -> IO ()

setWindowTitle :: Window -> String -> IO ()
setWindowTitle win title =
  withUtf8CString title $ \cstr ->
        withForeignPtr win $ \winptr -> sdlSetWindowTitle winptr cstr

-- const char* SDL_GetWindowTitle(SDL_Window* window)

foreign import ccall unsafe "SDL_GetWindowTitle"
  sdlGetWindowTitle :: Ptr WindowStruct -> IO CString

getWindowTitle :: Window -> IO String
getWindowTitle w = withForeignPtr w $ sdlGetWindowTitle >=> peekCString

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetWindowPixelFormat"
  sdlGetWindowPixelFormat :: Ptr WindowStruct -> IO Word32

foreign import ccall unsafe "SDL_AllocFormat"
  sdlAllocFormat :: Word32 -> IO (Ptr PixelFormatStruct)

getWindowPixelFormat :: Window -> IO Word32
getWindowPixelFormat w = withForeignPtr w sdlGetWindowPixelFormat

allocFormat :: Word32 -> IO PixelFormat
allocFormat pf = sdlAllocFormat pf >>= newForeignPtr sdlFreeFormat_finalizer

foreign import ccall unsafe "&SDL_FreeFormat"
  sdlFreeFormat_finalizer :: FunPtr (Ptr PixelFormatStruct -> IO ())

foreign import ccall unsafe "SDL_MapRGB"
  sdlMapRGB :: Ptr PixelFormatStruct -> Word8 -> Word8 -> Word8 -> IO Word32

mapRGB :: PixelFormat -> Word8 -> Word8 -> Word8 -> IO Word32
mapRGB p r g b = withForeignPtr p $ \cp -> sdlMapRGB cp r g b

foreign import ccall unsafe "SDL_MapRGBA"
  sdlMapRGBA :: Ptr PixelFormatStruct -> Word8 -> Word8 -> Word8 -> Word8 -> IO Word32

mapRGBA :: PixelFormat -> Word8 -> Word8 -> Word8 -> Word8 -> IO Word32
mapRGBA p r g b a = withForeignPtr p $ \cp -> sdlMapRGBA cp r g b a

surfaceFormat :: Surface -> IO PixelFormat
surfaceFormat s =
  withForeignPtr s $ \cs ->
  #{peek SDL_Surface, format} cs >>= newForeignPtr_

--------------------------------------------------------------------------------
data DisplayMode = DisplayMode { displayModeFormat :: PixelFormatEnum
                               , displayModeWidth  :: #{type int}
                               , displayModeHeight :: #{type int}
                               , displayModeRefreshRate :: #{type int}
                               } deriving (Eq, Show)

instance Storable DisplayMode where
  sizeOf = const #{size SDL_DisplayMode}

  alignment = const 4

  poke ptr DisplayMode{..} = do
    #{poke SDL_DisplayMode, format} ptr (pixelFormatEnumToC displayModeFormat)
    #{poke SDL_DisplayMode, w} ptr displayModeWidth
    #{poke SDL_DisplayMode, h} ptr displayModeHeight
    #{poke SDL_DisplayMode, refresh_rate} ptr displayModeRefreshRate
    #{poke SDL_DisplayMode, driverdata} ptr nullPtr

  peek ptr = DisplayMode
    <$> (pixelFormatEnumFromC <$> #{peek SDL_DisplayMode, format} ptr)
    <*> #{peek SDL_DisplayMode, w} ptr
    <*> #{peek SDL_DisplayMode, h} ptr
    <*> #{peek SDL_DisplayMode, refresh_rate} ptr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetDisplayMode"
  sdlGetDisplayMode :: #{type int} -> #{type int} -> Ptr DisplayMode -> IO #{type int}

getDisplayMode :: #{type int} -> #{type int} -> IO DisplayMode
getDisplayMode d m = alloca $ \displayModePtr -> do
  fatalSDLBool "SDL_GetDisplayMode" (sdlGetDisplayMode d m displayModePtr)
  peek displayModePtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetCurrentDisplayMode"
  sdlGetCurrentDisplayMode :: #{type int} -> Ptr DisplayMode -> IO #{type int}

getCurrentDisplayMode :: #{type int} -> IO DisplayMode
getCurrentDisplayMode d = alloca $ \displayModePtr -> do
  fatalSDLBool "SDL_GetCurrentDisplayMode" (sdlGetCurrentDisplayMode d displayModePtr)
  peek displayModePtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetDesktopDisplayMode"
  sdlGetDesktopDisplayMode :: #{type int} -> Ptr DisplayMode -> IO #{type int}

getDesktopDisplayMode :: #{type int} -> IO DisplayMode
getDesktopDisplayMode d = alloca $ \displayModePtr -> do
  fatalSDLBool "SDL_GetDesktopDisplayMode" (sdlGetDesktopDisplayMode d displayModePtr)
  peek displayModePtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetClosestDisplayMode"
  sdlGetClosestDisplayMode :: #{type int} -> Ptr DisplayMode -> Ptr DisplayMode -> IO (Ptr DisplayMode)

getClosestDisplayMode :: #{type int} -> DisplayMode -> IO (Maybe DisplayMode)
getClosestDisplayMode d mode =
  with mode $ \modePtr ->
  alloca $ \closestPtr -> do
    _ <- sdlGetClosestDisplayMode d modePtr closestPtr
    maybePeek peek closestPtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetWindowDisplayMode"
  sdlGetWindowDisplayMode :: Ptr WindowStruct -> Ptr DisplayMode -> IO #{type int}

getWindowDisplayMode :: Window -> IO DisplayMode
getWindowDisplayMode win =
  alloca $ \modePtr ->
  withForeignPtr win $ \cw -> do
    fatalSDLBool "SDL_GetWindowDisplayMode" (sdlGetWindowDisplayMode cw modePtr)
    peek modePtr

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_SetWindowDisplayMode"
  sdlSetWindowDisplayMode :: Ptr WindowStruct -> Ptr DisplayMode -> IO #{type int}

setWindowDisplayMode :: Window -> Maybe DisplayMode -> IO ()
setWindowDisplayMode win mode =
  withForeignPtr win $ \cw ->
  maybeWith with mode $ \modePtr ->
  fatalSDLBool "SDL_SetWindowDisplayMode" (sdlSetWindowDisplayMode cw modePtr)

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetWindowDisplayIndex"
  sdlGetWindowDisplayIndex :: Ptr WindowStruct -> IO #{type int}

getWindowDisplayIndex :: Window -> IO Int
getWindowDisplayIndex win =
  withForeignPtr win $ \cw -> do
    ret <- sdlGetWindowDisplayIndex cw
    handleErrorI "getWindowDisplayIndex" ret (return . fromIntegral)

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetWindowID"
  sdlGetWindowID :: Ptr WindowStruct -> IO #{type Uint32}

getWindowID :: Window -> IO WindowID
getWindowID win =
  withForeignPtr win $ \cw -> fromIntegral <$> sdlGetWindowID cw

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetWindowFromID"
  sdlGetWindowFromID :: #{type Uint32} -> IO (Ptr WindowStruct)

getWindowFromID :: WindowID -> IO Window
getWindowFromID wid = do
  cw <- sdlGetWindowFromID (fromIntegral wid)
  handleError "getWindowFromID" cw mkFinalizedWindow

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetDisplayName"
  sdlGetDisplayName :: #{type int} -> IO CString

getDisplayName :: #{type int} -> IO String
getDisplayName i =
  fatalSDLNull "SDL_GetDisplayName" (sdlGetDisplayName i) >>= peekCString

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetNumDisplayModes"
  getNumDisplayModes :: #{type int} -> IO #{type int}
--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetNumVideoDisplays"
  getNumVideoDisplays :: IO #{type int}

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetCurrentVideoDriver"
  sdlGetCurrentVideoDriver :: IO CString

getCurrentVideoDriver :: IO String
getCurrentVideoDriver = sdlGetCurrentVideoDriver >>= peekCString

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetDisplayBounds"
  sdlGetDisplayBounds :: #{type int} -> Ptr Rect -> IO #{type int}

getDisplayBounds :: Int -> IO Rect
getDisplayBounds index =
  alloca $ \rect -> do
    ret <- sdlGetDisplayBounds (fromIntegral index) rect
    handleErrorI "getDisplayBounds" ret $ return $ peek rect

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetNumVideoDrivers"
  getNumVideoDrivers :: IO #{type int}

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetVideoDriver"
  sdlGetVideoDriver :: #{type int} -> IO CString

getVideoDriver :: #{type int} -> IO String
getVideoDriver =
  fatalSDLNull "SDL_GetVideoDriver" . sdlGetVideoDriver >=> peekCString

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_GetWindowFlags"
  sdlGetWindowFlags :: Ptr WindowStruct -> IO #{type Uint32}

getWindowFlags :: Window -> IO [WindowFlag]
getWindowFlags w = withForeignPtr w $
  fmap (fromBitmask windowFlagToC) . sdlGetWindowFlags

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_VideoInit"
  videoInit :: IO ()

--------------------------------------------------------------------------------
foreign import ccall unsafe "SDL_VideoQuit"
  videoQuit :: IO ()
