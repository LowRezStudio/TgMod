class TgGameDC_EffectList extends TgDataChunk within GFxMoviePlayer
    native(GameUI);

const MAX_UI_EFFECTS = 16;

var TgGameDC_Effect m_EffectList[16];

// Export UTgGameDC_EffectList::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgGameDC_EffectList::execUpdateEffects(FFrame&, void* const)
native function UpdateEffects(TgEffectManager effectManager, int indexChanged);
