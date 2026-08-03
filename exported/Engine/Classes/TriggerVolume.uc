class TriggerVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x43
    if(BrushComponent != none)
    {
        bProjTarget = BrushComponent.BlockZeroExtent;
    }
    //return;    
}

simulated function bool StopsProjectile(Projectile P)
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    BrushColor=(R=100,G=255,B=100,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__TriggerVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bProjTarget=true
    CollisionComponent=BrushComponent0
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
    SupportedEvents[1]=Class'Engine.SeqEvent_TakeDamage'
}