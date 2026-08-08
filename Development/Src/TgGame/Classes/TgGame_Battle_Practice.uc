class TgGame_Battle_Practice extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

native function int GetNextVulnerableTowerId(int nBotId);  // Export UTgGame_Battle_Practice::execGetNextVulnerableTowerId(FFrame&, void* const)

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle_Practice::execGetRespawnTime(FFrame&, void* const)

native function MarkAsReady(Player P);  // Export UTgGame_Battle_Practice::execMarkAsReady(FFrame&, void* const)

native function CheckTeamAce(Controller Killer, Controller Killed);  // Export UTgGame_Battle_Practice::execCheckTeamAce(FFrame&, void* const)

function float GetSetupTime() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

defaultproperties
{
    m_nStartingLevel=3
    m_GameType=TGT_BATTLE_PRACTICE
}
