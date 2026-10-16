class TgDevice_ReachOut extends TgDevice_LongReach
    native(ChampFernando)
    hidecategories(Navigation)
    config(Engine);

native function bool IsNuggetValid(Actor Target);  // Export UTgDevice_ReachOut::execIsNuggetValid(FFrame&, void* const)

defaultproperties
{
    m_bAutoActivateAura=false
}
