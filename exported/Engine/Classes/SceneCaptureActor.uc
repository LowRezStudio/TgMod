class SceneCaptureActor extends Actor
    abstract
    native
    notplaceable
    hidecategories(Navigation);

var() const export editinline SceneCaptureComponent SceneCapture;

simulated function OnToggle(SeqAct_Toggle Action)
{
    local bool bEnable;

    // End:0x11
    if(SceneCapture == none)
    {
        return;
    }
    // End:0x57
    if(Action.InputLinks[0].bHasImpulse)
    {
        bEnable = true;        
    }
    else
    {
        // End:0x9D
        if(Action.InputLinks[1].bHasImpulse)
        {
            bEnable = false;            
        }
        else
        {
            // End:0x101
            if(Action.InputLinks[2].bHasImpulse)
            {
                bEnable = !SceneCapture.bEnabled;
            }
        }
    }
    SceneCapture.SetEnabled(bEnable);
    //return;    
}

defaultproperties
{
    Components[0]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
}