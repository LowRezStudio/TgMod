class Volume extends Brush
    native
    nativereplication
    notplaceable
    hidecategories(Navigation,Object,Movement,Display);

var Actor AssociatedActor;
var() bool bForcePawnWalk;
var() bool bProcessAllActors;
var() bool bExcludeNavmesh;
var(Collision) bool bPawnsOnly;
var(Collision) bool bLocalPawnsOnly;

// Export UVolume::execEncompasses(FFrame&, void* const)
native function bool Encompasses(Actor Other);

// Export UVolume::execEncompassesPoint(FFrame&, void* const)
native function bool EncompassesPoint(Vector Loc);

event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    // End:0x34
    if(AssociatedActor != none)
    {
        GotoState('AssociatedTouch');
        InitialState = GetStateName();
    }
    // End:0x83
    if(((int(WorldInfo.NetMode) == int(NM_DedicatedServer)) && bLocalPawnsOnly) && !bProcessAllActors)
    {
        SetCollision(false, false);
    }
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    super(Actor).DisplayDebug(HUD, out_YL, out_YPos);
    HUD.Canvas.DrawText("AssociatedActor " $ string(AssociatedActor), false);
    out_YPos += out_YL;
    HUD.Canvas.SetPos(4.0000000, out_YPos);
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x58
    if(Action.InputLinks[0].bHasImpulse)
    {
        // End:0x55
        if(!bCollideActors)
        {
            SetCollision(true, bBlockActors);
        }        
    }
    else
    {
        // End:0xAE
        if(Action.InputLinks[1].bHasImpulse)
        {
            // End:0xAB
            if(bCollideActors)
            {
                SetCollision(false, bBlockActors);
            }            
        }
        else
        {
            // End:0x100
            if(Action.InputLinks[2].bHasImpulse)
            {
                SetCollision(!bCollideActors, bBlockActors);
            }
        }
    }
    CollisionComponent.SetActorCollision(bCollideActors, CollisionComponent.BlockActors);
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.Actor.bCollideActors', bCollideActors == default.bCollideActors);
    //return;    
}

simulated event CollisionChanged()
{
    CollisionComponent.SetBlockRigidBody(bCollideActors && bBlockActors);
    //return;    
}

event ProcessActorSetVolume(Actor Other)
{
    //return;    
}

state AssociatedTouch
{
    event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
    {
        AssociatedActor.Touch(Other, OtherComp, HitLocation, HitNormal);
        //return;        
    }

    event UnTouch(Actor Other)
    {
        AssociatedActor.UnTouch(Other);
        //return;        
    }

    event BeginState(name PreviousStateName)
    {
        local Actor A;

        // End:0x58
        foreach TouchingActors(Class'Engine.Actor', A)
        {
            Touch(A, none, A.Location, vect(0.0000000, 0.0000000, 1.0000000));            
        }        
        //return;        
    }
    stop;    
}

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__Volume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Brush.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        bAcceptsLights=true
        CollideActors=true
        BlockNonZeroExtent=true
        bDisableAllRigidBody=true
        AlwaysLoadOnClient=true
        AlwaysLoadOnServer=true
        LightingChannels=(bInitialized=true,Dynamic=true)
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bSkipActorPropertyReplication=true
    bCollideActors=true
    CollisionComponent=BrushComponent0
}