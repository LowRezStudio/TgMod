class MobileSecondaryViewportClient extends SecondaryViewportClient
    transient
    native;

event PostRender(Canvas Canvas)
{
    local PlayerController PC;
    local MobilePlayerInput MPI;
    local MobileHUD MH;

    // End:0x134
    foreach Class'Engine.Engine'.static.GetCurrentWorldInfo().LocalPlayerControllers(Class'Engine.PlayerController', PC)
    {
        MPI = MobilePlayerInput(PC.PlayerInput);
        // End:0x133
        if(MPI != none)
        {
            MH = MobileHUD(PC.myHUD);
            // End:0x133
            if(MH != none)
            {
                MH.Canvas = Canvas;
                MH.DrawInputZoneOverlays();
                MH.RenderMobileMenu();
                // End:0x134
                break;
            }
        }        
    }    
    //return;    
}
