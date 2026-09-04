class RB_Thruster extends RigidBodyBase
    native(Physics)
    placeable
    hidecategories(Navigation);

var() bool bThrustEnabled;
var() interp float ThrustStrength;

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bThrustEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bThrustEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bThrustEnabled = !bThrustEnabled;
            }
        }
    }
    //return;    
}

defaultproperties
{
    ThrustStrength=100.0000000
    Components[0]=none
    Components[1]=none
    bHardAttach=true
    bEdShouldSnap=true
}