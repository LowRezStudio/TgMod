class MobileMenuButton extends MobileMenuObject;

var Texture2D Images[2];
var UVCoords ImagesUVs[2];
var LinearColor ImageColor;
var string Caption;
var LinearColor CaptionColor;

function InitMenuObject(MobilePlayerInput PlayerInput, MobileMenuScene Scene, int ScreenWidth, int ScreenHeight, bool bIsFirstInitialization)
{
    local int I;

    super.InitMenuObject(PlayerInput, Scene, ScreenWidth, ScreenHeight, bIsFirstInitialization);
    I = 0;
    J0x43:

    // End:0x1A2 [Loop If]
    if(I < 2)
    {
        // End:0x194
        if(!ImagesUVs[I].bCustomCoords && Images[I] != none)
        {
            ImagesUVs[I].U = 0.0000000;
            ImagesUVs[I].V = 0.0000000;
            ImagesUVs[I].UL = float(Images[I].SizeX);
            ImagesUVs[I].VL = float(Images[I].SizeY);
        }
        I++;
        // [Loop Continue]
        goto J0x43;
    }
    //return;    
}

function RenderObject(Canvas Canvas, float DeltaTime)
{
    local int Idx;
    local LinearColor DrawColor;

    Idx = ((bIsTouched || bIsHighlighted) ? 1 : 0);
    SetCanvasPos(Canvas);
    DrawColor = ImageColor;
    DrawColor.A *= (Opacity * OwnerScene.Opacity);
    Canvas.DrawTile(Images[Idx], Width, Height, ImagesUVs[Idx].U, ImagesUVs[Idx].V, ImagesUVs[Idx].UL, ImagesUVs[Idx].VL, DrawColor);
    RenderCaption(Canvas);
    //return;    
}

function RenderCaption(Canvas Canvas)
{
    local float UL, VL;

    // End:0x265
    if(Caption != "")
    {
        Canvas.Font = OwnerScene.SceneCaptionFont;
        Canvas.TextSize(Caption, UL, VL);
        SetCanvasPos(Canvas, (Width / float(2)) - (UL / float(2)), (Height / float(2)) - (VL / float(2)));
        Canvas.DrawColor.R = byte(CaptionColor.R * 255.0000000);
        Canvas.DrawColor.G = byte(CaptionColor.G * 255.0000000);
        Canvas.DrawColor.B = byte(CaptionColor.B * 255.0000000);
        Canvas.DrawColor.A = byte(CaptionColor.A * 255.0000000);
        Canvas.DrawText(Caption);
    }
    //return;    
}

defaultproperties
{
    ImageColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    CaptionColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    bIsActive=true
}