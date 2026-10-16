class PComUIManagerBase extends Object
    abstract
    native;

struct native ManagerImage
{
    var init string strImageName;
    var Texture2DDynamic pTexture;

    structdefaultproperties
    {
        strImageName=""
        pTexture=none
    }
};

var bool m_bDebugDraw;
var init array<init ManagerImage> m_cachedImages;
var init string m_strJson;

event DebugDraw(Canvas Canvas)
{
    local float PosX, PosY;
    local int Idx;

    // End:0x11
    if(!m_bDebugDraw)
    {
        return;
    }
    PosX = 0.0000000;
    PosY = 0.0000000;
    Idx = 0;
    J0x3A:

    // End:0x288 [Loop If]
    if(Idx < m_cachedImages.Length)
    {
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.SetPos(PosX, PosY);
        Canvas.DrawTexture(m_cachedImages[Idx].pTexture, 1.0000000);
        Canvas.SetDrawColor(0, 255, 0, 255);
        Canvas.SetPos(PosX, PosY);
        Canvas.DrawBox(float(m_cachedImages[Idx].pTexture.SizeX), float(m_cachedImages[Idx].pTexture.SizeY));
        PosY += float(m_cachedImages[Idx].pTexture.SizeY);
        // End:0x27A
        if(PosY > Canvas.ClipY)
        {
            PosY = 0.0000000;
            PosX += float(50);
        }
        Idx++;
        // [Loop Continue]
        goto J0x3A;
    }
    //return;    
}
