class GameCrowdGroup extends Object
    native;

var array<GameCrowdAgent> Members;

function AddMember(GameCrowdAgent Agent)
{
    Members[Members.Length] = Agent;
    Agent.MyGroup = self;
    //return;    
}

function RemoveMember(GameCrowdAgent Agent)
{
    Members.RemoveItem(Agent);
    Agent.MyGroup = none;
    //return;    
}

function UpdateDestinations(GameCrowdDestination NewDestination)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xDE [Loop If]
    if(I < Members.Length)
    {
        // End:0xD0
        if((Members[I] != none) && Members[I].CurrentDestination != NewDestination)
        {
            Members[I].SetCurrentDestination(NewDestination);
            Members[I].UpdateIntermediatePoint();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}
