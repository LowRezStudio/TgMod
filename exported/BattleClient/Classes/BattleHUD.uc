class BattleHUD extends TgClientHUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

// Export UBattleHUD::execBattleHUDFunction(FFrame&, void* const)
native function BattleHUDFunction();

defaultproperties
{
    // Reference: PComPictureInPicture'BattleClient.Default__BattleHUD.PictureInPicture'
    // Archetype: PComPictureInPicture'TgClient.Default__TgClientHUD.PictureInPicture'
    begin object name="PictureInPicture"
    end object
    m_PictureInPicture=PictureInPicture
}