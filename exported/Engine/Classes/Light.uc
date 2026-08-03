class Light extends Actor
    native(Light)
    notplaceable
    hidecategories(Navigation)
    classgroup(Lights);

var() const editconst export editinline LightComponent LightComponent;
var repnotify bool bEnabled;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        bEnabled;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x43
    if(VarName == 'bEnabled')
    {
        LightComponent.SetEnabled(bEnabled);        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x198
    if(!bStatic)
    {
        // End:0x69
        if(Action.InputLinks[0].bHasImpulse)
        {
            LightComponent.SetEnabled(true);            
        }
        else
        {
            // End:0xC3
            if(Action.InputLinks[1].bHasImpulse)
            {
                LightComponent.SetEnabled(false);                
            }
            else
            {
                // End:0x13B
                if(Action.InputLinks[2].bHasImpulse)
                {
                    LightComponent.SetEnabled(!LightComponent.bEnabled);
                }
            }
        }
        bEnabled = LightComponent.bEnabled;
        ForceNetRelevant();
        SetForcedInitialReplicatedProperty(BoolProperty'Engine.Light.bEnabled', bEnabled == default.bEnabled);
    }
    //return;    
}

defaultproperties
{
    Components[0]=none
    bStatic=true
    bHidden=true
    bNoDelete=true
    bRouteBeginPlayEvenIfStatic=false
    bMovable=false
}