class LevelStreamingVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Collision,Volume);

enum EStreamingVolumeUsage
{
    SVB_Loading,                    // 0
    SVB_LoadingAndVisibility,       // 1
    SVB_VisibilityBlockingOnLoad,   // 2
    SVB_BlockingOnLoad,             // 3
    SVB_LoadingNotVisible,          // 4
    SVB_MAX                         // 5
};

struct CheckpointRecord
{
    var bool bDisabled;

    structdefaultproperties
    {
        bDisabled=false
    }
};

var() noimport const editconst array<editconst LevelStreaming> StreamingLevels;
var() bool bEditorPreVisOnly;
var() bool bDisabled;
var() bool bTestDistanceToVolume;
var() LevelStreamingVolume.EStreamingVolumeUsage StreamingUsage;
var deprecated LevelStreamingVolume.EStreamingVolumeUsage Usage;
var() float TestVolumeDistance;

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bDisabled = false;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bDisabled = true;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bDisabled = !bDisabled;
            }
        }
    }
    //return;    
}

function CreateCheckpointRecord(out CheckpointRecord Record)
{
    Record.bDisabled = bDisabled;
    //return;    
}

function ApplyCheckpointRecord(const out CheckpointRecord Record)
{
    bDisabled = Record.bDisabled;
    //return;    
}

defaultproperties
{
    StreamingUsage=EStreamingVolumeUsage.SVB_LoadingAndVisibility
    BrushColor=(R=255,G=165,B=0,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__LevelStreamingVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        CollideActors=false
        BlockNonZeroExtent=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bCollideActors=false
    bForceAllowKismetModification=true
    CollisionComponent=BrushComponent0
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
}