class SeqVar_Player extends SeqVar_Object
    native(Sequence)
    hidecategories(Object);

var transient array<Object> Players;
var() bool bAllPlayers;
var() int PlayerIdx;

// Export USeqVar_Player::execUpdatePlayersList(FFrame&, void* const)
native final function UpdatePlayersList();

function Object GetObjectValue()
{
    local Controller C;

    UpdatePlayersList();
    // End:0x99
    if(Players.Length > 0)
    {
        // End:0x73
        if((bAllPlayers || PlayerIdx < 0) || PlayerIdx >= Players.Length)
        {
            C = Controller(Players[0]);            
        }
        else
        {
            C = Controller(Players[PlayerIdx]);
        }
    }
    return (((C != none) && C.Pawn != none) ? C.Pawn : C);
    //return ReturnValue;    
}

defaultproperties
{
    bAllPlayers=true
    SupportedClasses[0]=Class'Engine.Controller'
    SupportedClasses[1]=Class'Engine.Pawn'
    ObjName="Player"
}