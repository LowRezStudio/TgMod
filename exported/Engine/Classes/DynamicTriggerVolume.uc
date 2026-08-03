class DynamicTriggerVolume extends TriggerVolume
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
    // Reference: BrushComponent'Engine.Default__DynamicTriggerVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__TriggerVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    CollisionComponent=BrushComponent0
}