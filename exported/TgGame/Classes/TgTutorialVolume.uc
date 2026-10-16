class TgTutorialVolume extends Volume
    hidecategories(Navigation,Object,Movement,Display);

var bool m_bHasLocalPawn;
var bool m_bHasSeenLocalPawnBefore;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPlayerController TgPC;

    // End:0x7F
    if(!m_bHasLocalPawn)
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x7F
        if(TgPC != none)
        {
            // End:0x7F
            if(TgPC.Pawn == Other)
            {
                m_bHasLocalPawn = true;
                m_bHasSeenLocalPawnBefore = true;
            }
        }
    }
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

event UnTouch(Actor Other)
{
    local TgPlayerController TgPC;

    // End:0x71
    if(m_bHasLocalPawn)
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x71
        if(TgPC != none)
        {
            // End:0x71
            if(TgPC.Pawn == Other)
            {
                m_bHasLocalPawn = false;
            }
        }
    }
    super(Actor).UnTouch(Other);
    //return;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgTutorialVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}