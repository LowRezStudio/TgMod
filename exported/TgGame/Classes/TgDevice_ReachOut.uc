class TgDevice_ReachOut extends TgDevice_LongReach
    native(ChampFernando)
    hidecategories(Navigation);

// Export UTgDevice_ReachOut::execIsNuggetValid(FFrame&, void* const)
native function bool IsNuggetValid(Actor Target);

defaultproperties
{
    m_bAutoActivateAura=false
}