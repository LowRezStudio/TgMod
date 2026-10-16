class RB_RadialForceActor extends RigidBodyBase
    native(ForceField)
    placeable
    hidecategories(Navigation);

enum ERadialForceType
{
    RFT_Force,                      // 0
    RFT_Impulse,                    // 1
    RFT_MAX                         // 2
};

var export editinline DrawSphereComponent RenderComponent;
var() interp float ForceStrength;
var() interp float ForceRadius;
var() interp float SwirlStrength;
var() interp float SpinTorque;
var() export PrimitiveComponent.ERadialImpulseFalloff ForceFalloff;
var() RB_RadialForceActor.ERadialForceType RadialForceMode;
var() bool bForceActive;
var() bool bForceApplyToCloth;
var() bool bForceApplyToFluid;
var() bool bForceApplyToRigidBodies;
var() bool bForceApplyToProjectiles;
var() const RBCollisionChannelContainer CollideWithChannels;

replication
{
    // Pos:0x000
    if(bNetDirty)
        bForceActive;
}

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
    // Reference: DrawSphereComponent'Engine.Default__RB_RadialForceActor.DrawSphere0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawSphere0'
    begin object name="DrawSphere0" class=Engine.DrawSphereComponent
        SphereColor=(R=64,G=70,B=255,A=255)
        SphereRadius=200.0000000
        bDrawOnlyIfSelected=true
        ReplacementPrimitive=none
    end object
    RenderComponent=DrawSphere0
    ForceStrength=10.0000000
    ForceRadius=200.0000000
    bForceApplyToCloth=true
    bForceApplyToFluid=true
    bForceApplyToRigidBodies=true
    CollideWithChannels=(Default=true,Nothing=false,Pawn=true,Vehicle=true,Water=true,GameplayPhysics=true,EffectPhysics=true,Untitled1=true,Untitled2=true,Untitled3=true,Untitled4=true,Cloth=true,FluidDrain=true,SoftBody=false,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false)
    Components[0]=DrawSphere0
    Components[1]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=0.1000000
}