class ImageReflection extends Actor
    native(Mesh)
    placeable
    hidecategories(Navigation)
    autoexpandcategories(ImageReflection,ImageBasedReflectionComponent);

var repnotify bool bEnabled;
var export editinline deprecated ImageReflectionComponent ReflectionComponent;
var() export editinline ImageBasedReflectionComponent ImageReflectionComponent;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        bEnabled;
}

event PostBeginPlay()
{
    super.PostBeginPlay();
    bEnabled = ImageReflectionComponent.bEnabled;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x43
    if(VarName == 'bEnabled')
    {
        ImageReflectionComponent.SetEnabled(bEnabled);        
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
        ImageReflectionComponent.SetEnabled(true);        
    }
    else
    {
        // End:0xB4
        if(Action.InputLinks[1].bHasImpulse)
        {
            ImageReflectionComponent.SetEnabled(false);            
        }
        else
        {
            // End:0x12C
            if(Action.InputLinks[2].bHasImpulse)
            {
                ImageReflectionComponent.SetEnabled(!ImageReflectionComponent.bEnabled);
            }
        }
    }
    bEnabled = ImageReflectionComponent.bEnabled;
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.ImageReflection.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

defaultproperties
{
    bEnabled=true
    // Reference: ImageBasedReflectionComponent'Engine.Default__ImageReflection.ReflectionComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ReflectionComponent0'
    begin object name="ReflectionComponent0" class=Engine.ImageBasedReflectionComponent
        ReplacementPrimitive=none
    end object
    ImageReflectionComponent=ReflectionComponent0
    Components[0]=ReflectionComponent0
    bNoDelete=true
    bSkipActorPropertyReplication=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=10.0000000
}