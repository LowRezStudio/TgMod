class RB_RadialImpulseActor extends RigidBodyBase
    native(Physics)
    placeable
    hidecategories(Navigation);

var export editinline DrawSphereComponent RenderComponent;
var() const editconst export editinline RB_RadialImpulseComponent ImpulseComponent;
var repnotify byte ImpulseCount;

replication
{
    // Pos:0x000
    if(bNetDirty)
        ImpulseCount;
}

simulated function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x76
    if(inAction.InputLinks[0].bHasImpulse)
    {
        ImpulseComponent.FireImpulse(Location);
        ImpulseCount++;
        bForceNetUpdate = true;
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x3F
    if(VarName == 'ImpulseCount')
    {
        ImpulseComponent.FireImpulse(Location);
    }
    //return;    
}

defaultproperties
{
    // Reference: RB_RadialImpulseComponent'Engine.Default__RB_RadialImpulseActor.ImpulseComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ImpulseComponent0'
    begin object name="ImpulseComponent0" class=Engine.RB_RadialImpulseComponent
        ReplacementPrimitive=none
    end object
    ImpulseComponent=ImpulseComponent0
    Components[0]=none
    Components[1]=ImpulseComponent0
    Components[2]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    bEdShouldSnap=true
    NetUpdateFrequency=0.1000000
}