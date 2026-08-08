class BattleHUD extends TgClientHUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

native function BattleHUDFunction();  // Export UBattleHUD::execBattleHUDFunction(FFrame&, void* const)

defaultproperties
{}
