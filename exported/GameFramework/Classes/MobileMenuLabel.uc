class MobileMenuLabel extends MobileMenuObject;

var string Caption;
var Font TextFont;
var Color TextColor;
var Color TouchedColor;
var float TextXScale;
var float TextYScale;
var bool bAutoSize;

function RenderObject(Canvas Canvas, float DeltaTime)
{
    local float CX, CY, TX, TY;

    CX = Canvas.ClipX;
    CY = Canvas.ClipY;
    Canvas.Font = TextFont;
    // End:0xFD
    if(bAutoSize)
    {
        Canvas.TextSize(Caption, TX, TY);
        Width = TX * TextXScale;
        Height = TY * TextYScale;
    }
    Canvas.DrawColor = ((bIsTouched) ? TouchedColor : TextColor);
    Canvas.DrawColor.A *= (Opacity * OwnerScene.Opacity);
    SetCanvasPos(Canvas);
    Canvas.ClipX = Canvas.CurX + Width;
    Canvas.ClipY = Canvas.CurY + Height;
    Canvas.DrawText(Caption,, TextXScale, TextYScale);
    Canvas.ClipX = CX;
    Canvas.ClipY = CY;
    //return;    
}

defaultproperties
{
    TextXScale=1.0000000
    TextYScale=1.0000000
    bAutoSize=true
}