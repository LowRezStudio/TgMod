class TgGame_Battle_Aram_Practice extends TgGame_Battle_Aram
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

defaultproperties
{
    m_GameType=TGT_BATTLE_ARAM_PRACTICE
}
