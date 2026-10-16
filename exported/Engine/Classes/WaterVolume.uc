class WaterVolume extends PhysicsVolume
    notplaceable
    hidecategories(Navigation,Object,Movement,Display);

var() SoundCue EntrySound;
var() Class<Actor> EntryActor;
var() SoundCue ExitSound;
var() Class<Actor> ExitActor;

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x63
    if(Other.CanSplash())
    {
        PlayEntrySplash(Other);
    }
    //return;    
}

function PlayEntrySplash(Actor Other)
{
    // End:0x7E
    if(EntrySound != none)
    {
        Other.PlaySound(EntrySound);
        // End:0x7E
        if(Other.Instigator != none)
        {
            Other.MakeNoise(1.0000000);
        }
    }
    // End:0xA6
    if(EntryActor != none)
    {
        Spawn(EntryActor);
    }
    //return;    
}

event UnTouch(Actor Other)
{
    // End:0x35
    if(Other.CanSplash())
    {
        PlayExitSplash(Other);
    }
    //return;    
}

function PlayExitSplash(Actor Other)
{
    // End:0x7E
    if(ExitSound != none)
    {
        Other.PlaySound(ExitSound);
        // End:0x7E
        if(Other.Instigator != none)
        {
            Other.MakeNoise(1.0000000);
        }
    }
    // End:0xA6
    if(ExitActor != none)
    {
        Spawn(ExitActor);
    }
    //return;    
}

defaultproperties
{
    bWaterVolume=true
    FluidFriction=2.4000000
    // Reference: BrushComponent'Engine.Default__WaterVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_Water
        bDisableAllRigidBody=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}