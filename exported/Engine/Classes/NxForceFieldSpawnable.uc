class NxForceFieldSpawnable extends Actor
    native(ForceField)
    notplaceable
    hidecategories(Navigation);

var() export editinline NxForceFieldComponent ForceFieldComponent;

simulated function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x5B
    if(inAction.InputLinks[0].bHasImpulse)
    {
        ForceFieldComponent.bForceActive = true;        
    }
    else
    {
        // End:0xB6
        if(inAction.InputLinks[1].bHasImpulse)
        {
            ForceFieldComponent.bForceActive = false;            
        }
        else
        {
            // End:0x12F
            if(inAction.InputLinks[2].bHasImpulse)
            {
                ForceFieldComponent.bForceActive = !ForceFieldComponent.bForceActive;
            }
        }
    }
    //return;    
}

defaultproperties
{
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=0.1000000
}