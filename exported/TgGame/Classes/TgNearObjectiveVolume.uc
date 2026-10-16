class TgNearObjectiveVolume extends Volume
    hidecategories(Navigation,Object,Movement,Display);

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn TgP;

    TgP = TgPawn(Other);
    // End:0x4B
    if(TgP != none)
    {
        TgP.m_NearObjectiveVolume = self;
    }
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

event UnTouch(Actor Other)
{
    local TgPawn TgP;

    TgP = TgPawn(Other);
    // End:0x4B
    if(TgP != none)
    {
        TgP.m_NearObjectiveVolume = none;
    }
    super(Actor).UnTouch(Other);
    //return;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgNearObjectiveVolume.BrushComponent0'
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