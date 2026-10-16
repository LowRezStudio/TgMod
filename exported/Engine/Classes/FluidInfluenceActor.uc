class FluidInfluenceActor extends Actor
    native(Fluid)
    placeable
    hidecategories(Navigation)
    classgroup(Fluid);

var private export editinline ArrowComponent FlowDirection;
var private export editinline SpriteComponent Sprite;
var() const editconst export editinline FluidInfluenceComponent InfluenceComponent;
var repnotify bool bActive;
var repnotify bool bToggled;

replication
{
    // Pos:0x000
    if(bNetDirty)
        bActive, bToggled;
}

simulated function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x5B
    if(inAction.InputLinks[0].bHasImpulse)
    {
        InfluenceComponent.bActive = true;        
    }
    else
    {
        // End:0xB6
        if(inAction.InputLinks[1].bHasImpulse)
        {
            InfluenceComponent.bActive = false;            
        }
        else
        {
            // End:0x150
            if(inAction.InputLinks[2].bHasImpulse)
            {
                InfluenceComponent.bActive = !InfluenceComponent.bActive;
                InfluenceComponent.bIsToggleTriggered = true;
            }
        }
    }
    bActive = InfluenceComponent.bActive;
    bToggled = InfluenceComponent.bIsToggleTriggered;
    bForceNetUpdate = true;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x44
    if(VarName == 'bActive')
    {
        InfluenceComponent.bActive = bActive;        
    }
    else
    {
        // End:0x88
        if(VarName == 'bToggled')
        {
            InfluenceComponent.bIsToggleTriggered = bToggled;            
        }
        else
        {
            super.ReplicatedEvent(VarName);
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: FluidInfluenceComponent'Engine.Default__FluidInfluenceActor.NewInfluenceComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'NewInfluenceComponent'
    begin object name="NewInfluenceComponent" class=Engine.FluidInfluenceComponent
        ReplacementPrimitive=none
    end object
    InfluenceComponent=NewInfluenceComponent
    Components[0]=none
    Components[1]=none
    Components[2]=NewInfluenceComponent
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=0.1000000
}