class SpotLightToggleable extends SpotLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,SpotLights);

struct CheckpointRecord
{
    var bool bEnabled;

    structdefaultproperties
    {
        bEnabled=false
    }
};

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
    LightComponent.SetEnabled(bEnabled);
    ForceNetRelevant();
    //return;    
}

defaultproperties
{
    // Reference: SpotLightComponent'Engine.Default__SpotLightToggleable.SpotLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SpotLightComponent0'
    // Archetype: SpotLightComponent'Engine.Default__SpotLight.SpotLightComponent0'
    begin object name="SpotLightComponent0"
        LightmassSettings=(IndirectLightingScale=0.0000000)
        UseDirectLightMap=false
    end object
    LightComponent=SpotLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=none
    Components[4]=none
    Components[5]=SpotLightComponent0
    Components[6]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bHardAttach=true
}