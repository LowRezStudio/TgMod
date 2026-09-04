class TgGame_Battle_Conquest extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_fGodXpCoefficient=0.2500000
    m_fGodXpCoefficientLoss=0.2500000
    m_fGodXpWinBonus=5.0000000
    m_BasePlayerGoldReward=150.0000000
}