class DynamicPhysicsVolume extends PhysicsVolume
    placeable
    hidecategories(Navigation,Object,Display);

var() bool bEnabled;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetCollision(bEnabled, bBlockActors);
    //return;    
}

defaultproperties
{
    bEnabled=true
    BrushColor=(R=100,G=255,B=255,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__DynamicPhysicsVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Physics=EPhysics.PHYS_Interpolating
    bStatic=false
    CollisionComponent=BrushComponent0
}