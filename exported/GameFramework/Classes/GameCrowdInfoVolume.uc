class GameCrowdInfoVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display);

var() array<GameCrowdDestination> PotentialSpawnPoints;

simulated function Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local Pawn P;
    local GameCrowdPopulationManager PopMgr;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    P = Pawn(Other);
    // End:0xDE
    if((P != none) && P.IsHumanControlled())
    {
        PopMgr = GameCrowdPopulationManager(WorldInfo.PopulationManager);
        // End:0xDE
        if(PopMgr != none)
        {
            PopMgr.SetCrowdInfoVolume(self);
        }
    }
    //return;    
}

simulated function UnTouch(Actor Other)
{
    local Pawn P;
    local GameCrowdPopulationManager PopMgr;

    super(Actor).UnTouch(Other);
    P = Pawn(Other);
    // End:0xC3
    if((P != none) && P.IsHumanControlled())
    {
        PopMgr = GameCrowdPopulationManager(WorldInfo.PopulationManager);
        // End:0xC3
        if(PopMgr != none)
        {
            PopMgr.SetCrowdInfoVolume(none);
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: BrushComponent'GameFramework.Default__GameCrowdInfoVolume.BrushComponent0'
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