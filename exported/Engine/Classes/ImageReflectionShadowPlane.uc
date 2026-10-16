class ImageReflectionShadowPlane extends Actor
    native(Mesh)
    placeable
    hidecategories(Navigation);

var repnotify bool bEnabled;
var() export editinline ImageReflectionShadowPlaneComponent ReflectionShadowComponent;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        bEnabled;
}

event PostBeginPlay()
{
    super.PostBeginPlay();
    bEnabled = ReflectionShadowComponent.bEnabled;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x43
    if(VarName == 'bEnabled')
    {
        ReflectionShadowComponent.SetEnabled(bEnabled);        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x5A
    if(Action.InputLinks[0].bHasImpulse)
    {
        ReflectionShadowComponent.SetEnabled(true);        
    }
    else
    {
        // End:0xB4
        if(Action.InputLinks[1].bHasImpulse)
        {
            ReflectionShadowComponent.SetEnabled(false);            
        }
        else
        {
            // End:0x12C
            if(Action.InputLinks[2].bHasImpulse)
            {
                ReflectionShadowComponent.SetEnabled(!ReflectionShadowComponent.bEnabled);
            }
        }
    }
    bEnabled = ReflectionShadowComponent.bEnabled;
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.ImageReflectionShadowPlane.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

defaultproperties
{
    bEnabled=true
    // Reference: ImageReflectionShadowPlaneComponent'Engine.Default__ImageReflectionShadowPlane.ReflectionComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ReflectionComponent0'
    begin object name="ReflectionComponent0" class=Engine.ImageReflectionShadowPlaneComponent
        ReplacementPrimitive=none
    end object
    ReflectionShadowComponent=ReflectionComponent0
    Components[0]=ReflectionComponent0
    Components[1]=none
    Physics=EPhysics.PHYS_Interpolating
    bNoDelete=true
    bSkipActorPropertyReplication=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=10.0000000
}