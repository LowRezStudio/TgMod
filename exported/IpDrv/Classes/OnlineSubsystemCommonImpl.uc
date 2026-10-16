class OnlineSubsystemCommonImpl extends OnlineSubsystem
    abstract
    native
    config(Engine);

var native const transient Pointer VoiceEngine;
var config int MaxLocalTalkers;
var config int MaxRemoteTalkers;
var config bool bIsUsingSpeechRecognition;
var OnlineGameInterfaceImpl GameInterfaceImpl;
var OnlineAuthInterfaceImpl AuthInterfaceImpl;

event string GetPlayerNicknameFromIndex(int UserIndex)
{
    //return ReturnValue;    
}

// Export UOnlineSubsystemCommonImpl::execIsPlayerInSession(FFrame&, void* const)
native function bool IsPlayerInSession(name SessionName, UniqueNetId PlayerID);

function GetRegisteredPlayers(name SessionName, out array<UniqueNetId> OutRegisteredPlayers)
{
    local int Idx, PlayerIdx;

    OutRegisteredPlayers.Length = 0;
    Idx = 0;
    J0x17:

    // End:0x14B [Loop If]
    if(Idx < Sessions.Length)
    {
        // End:0x13D
        if(Sessions[Idx].SessionName == SessionName)
        {
            OutRegisteredPlayers.Length = Sessions[Idx].Registrants.Length;
            PlayerIdx = 0;
            J0xA0:

            // End:0x13A [Loop If]
            if(PlayerIdx < Sessions[Idx].Registrants.Length)
            {
                OutRegisteredPlayers[PlayerIdx] = Sessions[Idx].Registrants[PlayerIdx].PlayerNetId;
                PlayerIdx++;
                // [Loop Continue]
                goto J0xA0;
            }
            // [Explicit Break]
            goto J0x14B;
        }
        Idx++;
        // [Loop Continue]
        goto J0x17;
    }
    J0x14B:

    //return;    
}

defaultproperties
{
    MaxLocalTalkers=1
    MaxRemoteTalkers=16
}