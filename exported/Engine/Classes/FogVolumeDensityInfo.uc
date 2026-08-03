class FogVolumeDensityInfo extends Info
    abstract
    native(FogVolume)
    notplaceable
    hidecategories(Navigation,Collision)
    classgroup(Fog)
    autoexpandcategories(FogVolumeDensityInfo);

struct CheckpointRecord
{
    var bool bEnabled;

    structdefaultproperties
    {
        bEnabled=false
    }
};

var() export editinline FogVolumeDensityComponent DensityComponent;
var() export editinline StaticMeshComponent AutomaticMeshComponent;
var repnotify bool bEnabled;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        bEnabled;
}

event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    // End:0x43
    if(DensityComponent != none)
    {
        bEnabled = DensityComponent.bEnabled;
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x43
    if(VarName == 'bEnabled')
    {
        DensityComponent.SetEnabled(bEnabled);        
    }
    else
    {
        super(Actor).ReplicatedEvent(VarName);
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x5A
    if(Action.InputLinks[0].bHasImpulse)
    {
        DensityComponent.SetEnabled(true);        
    }
    else
    {
        // End:0xB4
        if(Action.InputLinks[1].bHasImpulse)
        {
            DensityComponent.SetEnabled(false);            
        }
        else
        {
            // End:0x12C
            if(Action.InputLinks[2].bHasImpulse)
            {
                DensityComponent.SetEnabled(!DensityComponent.bEnabled);
            }
        }
    }
    bEnabled = DensityComponent.bEnabled;
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.FogVolumeDensityInfo.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

function bool ShouldSaveForCheckpoint()
{
    return int(RemoteRole) != int(ROLE_None);
    //return ReturnValue;    
}

function CreateCheckpointRecord(out CheckpointRecord Record)
{
    Record.bEnabled = bEnabled;
    //return;    
}

function ApplyCheckpointRecord(const out CheckpointRecord Record)
{
    bEnabled = Record.bEnabled;
    DensityComponent.SetEnabled(bEnabled);
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.FogVolumeDensityInfo.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__FogVolumeDensityInfo.AutomaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AutomaticMeshComponent0'
    begin object name="AutomaticMeshComponent0" class=Engine.StaticMeshComponent
        StaticMesh=StaticMesh'EngineMeshes.Cube'
        WireframeColor=(R=100,G=100,B=200,A=255)
        ReplacementPrimitive=none
        bIgnoreOwnerHidden=true
        bUseAsOccluder=false
        bSelectable=false
        bAcceptsStaticDecals=false
        bAcceptsDynamicDecals=false
        CastShadow=false
        bCastDynamicShadow=false
        bAcceptsLights=false
        bAcceptsDynamicLights=false
        BlockRigidBody=false
    end object
    AutomaticMeshComponent=AutomaticMeshComponent0
    Components[0]=none
    Components[1]=AutomaticMeshComponent0
    bNoDelete=true
}