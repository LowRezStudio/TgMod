class TgGame_Battle_Conquest_Practice extends TgGame_Battle_Conquest
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

defaultproperties
{
    m_GameType=TGT_BATTLE_PRACTICE
}
