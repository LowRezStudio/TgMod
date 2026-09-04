class TgGame_Battle_Expert extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

event TriggerBonusMinions(TgRepInfo_TaskForce tf, int nLane) { }

defaultproperties
{
    m_GameType=TGT_BATTLE_EXPERT
}
