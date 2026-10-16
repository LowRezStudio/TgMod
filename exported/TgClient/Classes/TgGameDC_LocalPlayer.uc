class TgGameDC_LocalPlayer extends TgGameDC_Player within GFxMoviePlayer
    native(GameUI);

// Export UTgGameDC_LocalPlayer::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgGameDC_LocalPlayer::execSetVendorItemList(FFrame&, void* const)
native function SetVendorItemList(array<int> nItemIds);

// Export UTgGameDC_LocalPlayer::execUpdateSpectatorViewTarget(FFrame&, void* const)
native function UpdateSpectatorViewTarget(TgGameDC_MapEntity entity);

defaultproperties
{
    m_bClearOnMapChange=false
}