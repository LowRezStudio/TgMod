class TgGame_Arena_Escort_Practice extends TgGame_Arena_Escort
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

function SpawnBots() { }

defaultproperties
{
    m_GameType=TGT_ARENA_ESCORT_PRACTICE
}
