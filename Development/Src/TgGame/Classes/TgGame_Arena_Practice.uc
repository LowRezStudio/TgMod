class TgGame_Arena_Practice extends TgGame_Arena
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

function SpawnBots() { }

defaultproperties
{
    m_GameType=TGT_ARENA_PRACTICE
}
