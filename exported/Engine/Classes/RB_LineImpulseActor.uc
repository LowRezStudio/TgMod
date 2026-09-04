class RB_LineImpulseActor extends RigidBodyBase
    native(Physics)
    placeable
    hidecategories(Navigation);

var() interp float ImpulseStrength;
var() float ImpulseRange;
var() bool bVelChange;
var() bool bStopAtFirstHit;
var() bool bCauseFracture;
var export editinline ArrowComponent Arrow;
var repnotify byte ImpulseCount;

replication
{
    // Pos:0x000
    if(bNetDirty)
        ImpulseCount;
}

// Export URB_LineImpulseActor::execFireLineImpulse(FFrame&, void* const)
native final function FireLineImpulse();

simulated function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x58
    if(inAction.InputLinks[0].bHasImpulse)
    {
        FireLineImpulse();
        ImpulseCount++;
        bForceNetUpdate = true;
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'ImpulseCount')
    {
        FireLineImpulse();
    }
    //return;    
}

defaultproperties
{
    ImpulseStrength=900.0000000
    ImpulseRange=200.0000000
    Components[0]=none
    Components[1]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    bEdShouldSnap=true
    NetUpdateFrequency=0.1000000
}