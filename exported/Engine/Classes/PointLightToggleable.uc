class PointLightToggleable extends PointLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,PointLights);

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
    // Reference: PointLightComponent'Engine.Default__PointLightToggleable.PointLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PointLightComponent0'
    // Archetype: PointLightComponent'Engine.Default__PointLight.PointLightComponent0'
    begin object name="PointLightComponent0"
        LightmassSettings=(IndirectLightingScale=0.0000000)
        UseDirectLightMap=false
    end object
    LightComponent=PointLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=PointLightComponent0
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bHardAttach=true
}