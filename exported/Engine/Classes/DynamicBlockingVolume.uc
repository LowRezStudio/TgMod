class DynamicBlockingVolume extends BlockingVolume
    native
    placeable
    hidecategories(Navigation,Object,Display);

struct CheckpointRecord
{
    var Vector Location;
    var Rotator Rotation;
    var bool bCollideActors;
    var bool bBlockActors;
    var bool bNeedsReplication;

    structdefaultproperties
    {
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Rotation=(Pitch=0,Yaw=0,Roll=0)
        bCollideActors=false
        bBlockActors=false
        bNeedsReplication=false
    }
};

var() bool bEnabled;
var() bool bHandleNavMeshRegistrationInGame;
var bool bHasRegisteredObstacle;

// Export UDynamicBlockingVolume::execRegisterObstacle(FFrame&, void* const)
native final function RegisterObstacle();

// Export UDynamicBlockingVolume::execUnRegisterObstacle(FFrame&, void* const)
native final function UnRegisterObstacle();

simulated event PostBeginPlay()
{
    super(Volume).PostBeginPlay();
    SetCollision(bEnabled, bBlockActors);
    //return;    
}

function CreateCheckpointRecord(out CheckpointRecord Record)
{
    Record.Location = Location;
    Record.Rotation = Rotation;
    Record.bCollideActors = bCollideActors;
    Record.bBlockActors = bBlockActors;
    Record.bNeedsReplication = int(RemoteRole) != int(ROLE_None);
    //return;    
}

function ApplyCheckpointRecord(const out CheckpointRecord Record)
{
    // End:0x4D
    if(!bHardAttach)
    {
        SetLocation(Record.Location);
        SetRotation(Record.Rotation);
    }
    CollisionComponent.SetActorCollision(true, true);
    CollisionComponent.SetTraceBlocking(false, true);
    CollisionComponent.SetBlockRigidBody(Record.bCollideActors);
    SetCollision(Record.bCollideActors, Record.bBlockActors);
    // End:0x134
    if(Record.bNeedsReplication)
    {
        ForceNetRelevant();
    }
    //return;    
}

simulated event CollisionChanged()
{
    super(Volume).CollisionChanged();
    // End:0xA0
    if((int(Role) == int(ROLE_Authority)) && bHandleNavMeshRegistrationInGame)
    {
        // End:0x69
        if(bHasRegisteredObstacle && !bCollideActors || !bBlockActors)
        {
            UnRegisterObstacle();            
        }
        else
        {
            // End:0xA0
            if((!bHasRegisteredObstacle && bCollideActors) && bBlockActors)
            {
                RegisterObstacle();
            }
        }
    }
    //return;    
}

function OnChangeCollision(SeqAct_ChangeCollision Action)
{
    super(Actor).OnChangeCollision(Action);
    CollisionChanged();
    //return;    
}

defaultproperties
{
    bEnabled=true
    bHandleNavMeshRegistrationInGame=true
    BrushColor=(R=255,G=255,B=100,A=255)
    // Reference: BrushComponent'Engine.Default__DynamicBlockingVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__BlockingVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Physics=EPhysics.PHYS_Interpolating
    bStatic=false
    bWorldGeometry=false
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    m_bSupportsRelativeLocationBase=true
    CollisionComponent=BrushComponent0
}