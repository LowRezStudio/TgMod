class TgGame_Battle_Joust extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const AUTO_FORFEIT_TIME_SEC = 120.0f;

native function int GetNextVulnerableTowerId(int nBotId);  // Export UTgGame_Battle_Joust::execGetNextVulnerableTowerId(FFrame&, void* const)

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle_Joust::execGetRespawnTime(FFrame&, void* const)

native function MarkAsReady(Player P);  // Export UTgGame_Battle_Joust::execMarkAsReady(FFrame&, void* const)

native function CheckTeamAce(Controller Killer, Controller Killed);  // Export UTgGame_Battle_Joust::execCheckTeamAce(FFrame&, void* const)

native function AutoForfeit();  // Export UTgGame_Battle_Joust::execAutoForfeit(FFrame&, void* const)

function float GetSetupTime() { }

defaultproperties
{
    m_bEnableCrowdEvents=true
    m_nStartingLevel=3
    m_GameType=TGT_BATTLE_JOUST
}
