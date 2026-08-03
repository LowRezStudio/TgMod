class UIManager extends Object within UIInteraction
    native;

// Export UUIManager::execGetUIManager(FFrame&, void* const)
native static final function UIManager GetUIManager();

// Export UUIManager::execCanUnpauseInternalUI(FFrame&, void* const)
native final function bool CanUnpauseInternalUI();

event PauseGame(bool bDesiredPauseState, optional int PlayerIndex = 0)
{
    local PlayerController PlayerOwner;
    local Engine Eng;

    Eng = Class'Engine.Engine'.static.GetEngine();
    // End:0x11B
    if(Eng.GamePlayers.Length > 0)
    {
        PlayerIndex = Clamp(PlayerIndex, 0, Eng.GamePlayers.Length - 1);
        PlayerOwner = Eng.GamePlayers[PlayerIndex].Actor;
        // End:0x11B
        if(PlayerOwner != none)
        {
            PlayerOwner.SetPause(bDesiredPauseState, CanUnpauseInternalUI);
        }
    }
    //return;    
}

function NotifyPlayerAdded(int PlayerIndex, LocalPlayer AddedPlayer)
{
    //return;    
}

function NotifyPlayerRemoved(int PlayerIndex, LocalPlayer RemovedPlayer)
{
    //return;    
}

function int FindLocalPlayerIndex(Player P)
{
    local Engine Engine;
    local int I;

    Engine = Class'Engine.Engine'.static.GetEngine();
    I = 0;
    J0x34:

    // End:0xAF [Loop If]
    if(I < Engine.GamePlayers.Length)
    {
        // End:0xA1
        if(Engine.GamePlayers[I] == P)
        {
            return I;
        }
        I++;
        // [Loop Continue]
        goto J0x34;
    }
    return 0;
    //return ReturnValue;    
}
