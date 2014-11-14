local ffi = require "ffi"

local IMAGE_WIDTH = 400
local IMAGE_HEIGHT = 60

local image = {}

ffi.cdef[[
typedef void MagickWand;
typedef void PixelWand;
typedef void DrawingWand;
typedef int MagickBooleanType;
typedef int ExceptionType;
typedef int ssize_t;
typedef int CompositeOperator;
typedef enum {
  ForgetGravity,
  NorthWestGravity,
  NorthGravity,
  NorthEastGravity,
  WestGravity,
  CenterGravity,
  EastGravity,
  SouthWestGravity,
  SouthGravity,
  SouthEastGravity,
  StaticGravitys
} GravityType;
typedef enum {
  UndefinedInterpolatePixel,
  AverageInterpolatePixel,
  Average9InterpolatePixel,
  Average16InterpolatePixel,
  BackgroundInterpolatePixel,
  BilinearInterpolatePixel,
  BlendInterpolatePixel,
  CatromInterpolatePixel,
  IntegerInterpolatePixel,
  MeshInterpolatePixel,
  NearestInterpolatePixel,
  SplineInterpolatePixel
} PixelInterpolateMethod;
void MagickWandGenesis();
MagickWand* NewMagickWand();
MagickWand* DestroyMagickWand(MagickWand* magick_wand);
PixelWand* NewPixelWand();
MagickBooleanType PixelSetColor(PixelWand* pixel_wand,const char* color);
PixelWand* DestroyPixelWand(PixelWand* pixel_wand);
MagickBooleanType MagickNewImage(MagickWand* magick_wand, const size_t columns, const size_t rows, const PixelWand* background);
MagickBooleanType MagickSetFormat(MagickWand* magick_wand, const char* format);
MagickBooleanType MagickSetImageBackgroundColor(MagickWand* magick_wand, const PixelWand* pixel_wand);
DrawingWand* NewDrawingWand();
DrawingWand* DestroyDrawingWand(DrawingWand* drawing_wand);
void DrawSetGravity(DrawingWand*wand, const GravityType gravity);
MagickBooleanType DrawSetFont(DrawingWand* drawing_wand, const char* font_name);
void DrawSetTextKerning(DrawingWand* drawing_wand, const double kerning);
void DrawSetTextInterwordSpacing(DrawingWand* drawing_wand, const double interword_spacing);
void DrawSetFillColor(DrawingWand* drawing_wand, const PixelWand* pixel_wand);
void DrawSetStrokeColor(DrawingWand* drawing_wand, const PixelWand* pixel_wand);
void DrawSetStrokeWidth(DrawingWand* drawing_wand, const double stroke_width);
void DrawSetFontSize(DrawingWand* drawing_wand, const double pointsize);
void DrawAnnotation(DrawingWand* drawing_wand, const double x, const double y, const unsigned char* text);
void DrawCircle(DrawingWand* drawing_wand, const double ox, const double oy, const double px, const double py);
MagickBooleanType MagickDrawImage(MagickWand* magick_wand, const DrawingWand* drawing_wand);
MagickBooleanType MagickWaveImage(MagickWand* magick_wand, const double amplitude, const double wave_length, const PixelInterpolateMethod method);
MagickBooleanType MagickCropImage(MagickWand* magick_wand, const size_t width, const size_t height, const ssize_t x, const ssize_t y);
unsigned char* MagickGetImageBlob(MagickWand* magick_wand, size_t* len);
void* MagickRelinquishMemory(void* ref);
]]

local MagickWand = ffi.load('MagickWand')

function image.create(text, type, background, foreground)
  math.randomseed(os.time())

  local magick_wand = MagickWand.NewMagickWand()
  local pixel_wand = MagickWand.NewPixelWand()
  local drawing_wand = MagickWand.NewDrawingWand()

  function finalize()
    MagickWand.DestroyDrawingWand(drawing_wand)
    MagickWand.DestroyPixelWand(pixel_wand)
    MagickWand.DestroyMagickWand(magick_wand)
  end

  MagickWand.PixelSetColor(pixel_wand, background or "white")
  if not MagickWand.MagickNewImage(magick_wand, IMAGE_WIDTH, IMAGE_HEIGHT, pixel_wand) then
    ngx.log(ngx.ERROR, "Failed to create image")
    finalize()
    return nil
  end
  if not MagickWand.MagickSetFormat(magick_wand, type or "png") then
    ngx.log(ngx.ERROR, "Failed to set image format")
    finalize()
    return nil
  end
  MagickWand.MagickSetImageBackgroundColor(magick_wand, pixel_wand)
  if not MagickWand.DrawSetFont(drawing_wand, "fonts/impact.ttf") then
    ngx.log(ngx.ERROR, "Failed to load font")
    finalize()
    return nil
  end
  MagickWand.DrawSetFontSize(drawing_wand, 20)
  MagickWand.DrawSetTextKerning(drawing_wand, -1.5)
  MagickWand.DrawSetTextInterwordSpacing(drawing_wand, 20)
  MagickWand.DrawSetFillColor(drawing_wand, pixel_wand)
  MagickWand.PixelSetColor(pixel_wand, foreground or "black")
  MagickWand.DrawSetStrokeColor(drawing_wand, pixel_wand)
  MagickWand.DrawSetStrokeWidth(drawing_wand, 0.7)
  MagickWand.DrawSetGravity(drawing_wand, MagickWand.CenterGravity)
  MagickWand.DrawAnnotation(drawing_wand, 0, 0, text)
  for i = 1, 5 do
    local x = math.random(20, IMAGE_WIDTH - 20)
    local y = math.random(20, IMAGE_HEIGHT - 20)
    local diameter = math.random(1, 2)
    MagickWand.DrawCircle(drawing_wand, x, y, x + diameter, y + diameter)
  end
  if not MagickWand.MagickDrawImage(magick_wand, drawing_wand) then
    ngx.log(ngx.ERROR, "Failed to draw")
    finalize()
    return nil
  end
  for i = 1, 2 do 
    MagickWand.MagickWaveImage(magick_wand, 2, math.random(30, 60), MagickWand.AverageInterpolatePixel)
  end
  MagickWand.MagickCropImage(magick_wand, IMAGE_WIDTH, IMAGE_HEIGHT, 0, 0)

  local len = ffi.new("size_t[1]", 0)
  local blob = MagickWand.MagickGetImageBlob(magick_wand, len)
  local data = ffi.string(blob, len[0])
  MagickWand.MagickRelinquishMemory(blob)
  finalize()
  return data
end

MagickWand.MagickWandGenesis()

return image