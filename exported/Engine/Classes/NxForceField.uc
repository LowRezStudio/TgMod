class NxForceField extends Actor
    abstract
    native(ForceField)
    notplaceable
    hidecategories(Navigation)
    classgroup(Physics);

var() int ExcludeChannel;
var() bool bForceActive;
var() const RBCollisionChannelContainer CollideWithChannels;
var() const PrimitiveComponent.ERBCollisionChannel RBChannel;
var native const transient Pointer ForceField;
var native const transient array<Pointer> ConvexMeshes;
var native const transient array<Pointer> ExclusionShapes;
var native const transient array<Pointer> ExclusionShapePoses;
var native const transient Pointer U2NRotation;
var native const int SceneIndex;

replication
{
    // Pos:0x000
    if(bNetDirty)
        bForceActive;
}

// Export UNxForceField::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

simulated function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bForceActive = true;        
    }
    else
    {
        // End:0x8C
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bForceActive = false;            
        }
        else
        {
            // End:0xDB
            if(inAction.InputLinks[2].bHasImpulse)
            {
                bForceActive = !bForceActive;
            }
        }
    }
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.RB_RadialForceActor.bForceActive', bForceActive == default.bForceActive);
    //return;    
}

defaultproperties
{
    bForceActive=true
    CollideWithChannels=(Default=true,Nothing=false,Pawn=true,Vehicle=true,Water=true,GameplayPhysics=true,EffectPhysics=true,Untitled1=true,Untitled2=true,Untitled3=true,Untitled4=false,Cloth=true,FluidDrain=true,SoftBody=true,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false)
    RBChannel=ERBCollisionChannel.RBCC_Nothing
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=0.1000000
}