class ExponentialHeightFog extends Info
    placeable
    hidecategories(Navigation,Collision)
    classgroup(Fog);

var() const editconst export editinline ExponentialHeightFogComponent Component;
var repnotify bool bEnabled;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        bEnabled;
}

simulated event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    bEnabled = Component.bEnabled;
    // End:0x8D
    if(WorldInfo.GRI != none)
    {
        WorldInfo.GRI.OnFogAdded(self);
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x43
    if(VarName == 'bEnabled')
    {
        Component.SetEnabled(bEnabled);        
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
        Component.SetEnabled(true);        
    }
    else
    {
        // End:0xB4
        if(Action.InputLinks[1].bHasImpulse)
        {
            Component.SetEnabled(false);            
        }
        else
        {
            // End:0x12C
            if(Action.InputLinks[2].bHasImpulse)
            {
                Component.SetEnabled(!Component.bEnabled);
            }
        }
    }
    bEnabled = Component.bEnabled;
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.ExponentialHeightFog.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

defaultproperties
{
    // Reference: ExponentialHeightFogComponent'Engine.Default__ExponentialHeightFog.HeightFogComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'HeightFogComponent0'
    begin object name="HeightFogComponent0" class=Engine.ExponentialHeightFogComponent
    end object
    Component=HeightFogComponent0
    Components[0]=none
    Components[1]=HeightFogComponent0
    DrawScale=5.0000000
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bNoDelete=true
    bServerTickIsDisabled=true
}