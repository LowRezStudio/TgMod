class TgFortressVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display);

var() int TaskforceIndex;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn OtherPawn;

    OtherPawn = TgPawn(Other);
    // End:0x53
    if(OtherPawn != none)
    {
        OtherPawn.r_nInsideTaskForceBase = TaskforceIndex;
    }
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

event UnTouch(Actor Other)
{
    local TgPawn OtherPawn;

    OtherPawn = TgPawn(Other);
    // End:0x4B
    if(OtherPawn != none)
    {
        OtherPawn.r_nInsideTaskForceBase = 0;
    }
    super(Actor).UnTouch(Other);
    //return;    
}

event PostBeginPlay()
{
    local TgGame Game;

    super.PostBeginPlay();
    Game = TgGame(WorldInfo.Game);
    // End:0x83
    if((int(Role) == int(ROLE_Authority)) && Game != none)
    {
        Game.s_FortressVolumes.AddItem(self);
    }
    //return;    
}

defaultproperties
{
    TaskforceIndex=-1
    // Reference: BrushComponent'TgGame.Default__TgFortressVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionType=ECollisionType.COLLIDE_NoCollision
    CollisionComponent=BrushComponent0
}