class MobileMenuImage extends MobileMenuObject
    native;

enum MenuImageDrawStyle
{
    IDS_Normal,                     // 0
    IDS_Stretched,                  // 1
    IDS_Tile,                       // 2
    IDS_MAX                         // 3
};

var Texture2D Image;
var MobileMenuImage.MenuImageDrawStyle ImageDrawStyle;
var UVCoords ImageUVs;
var LinearColor ImageColor;

function RenderObject(Canvas Canvas, float DeltaTime)
{
    local float W, H, U, V, UL, VL;

    local LinearColor DrawColor;

    SetCanvasPos(Canvas);
    // End:0xD0
    if(ImageUVs.bCustomCoords)
    {
        U = ImageUVs.U;
        V = ImageUVs.V;
        UL = ImageUVs.UL;
        VL = ImageUVs.VL;        
    }
    else
    {
        U = 0.0000000;
        V = 0.0000000;
        UL = float(Image.SizeX);
        VL = float(Image.SizeY);
    }
    switch(ImageDrawStyle)
    {
        // End:0x1ED
        case 0:
            W = ((Width > UL) ? UL : Width);
            H = ((Height > VL) ? VL : Height);
            UL = W;
            VL = H;
            // End:0x272
            break;
        // End:0x21B
        case 1:
            W = Width;
            H = Height;
            // End:0x272
            break;
        // End:0x26F
        case 2:
            W = Width;
            H = Height;
            UL = W;
            VL = H;
            // End:0x272
            break;
        // End:0xFFFF
        default:
            break;
    }
    DrawColor = ImageColor;
    DrawColor.A *= (Opacity * OwnerScene.Opacity);
    Canvas.DrawTile(Image, W, H, U, V, UL, VL, DrawColor);
    //return;    
}

defaultproperties
{
    ImageColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
}