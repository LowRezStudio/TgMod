class TgInventoryObject_Listen_Combo_Evie extends TgInventoryObject_Listen_Combo
    native(Inventory);

const EVIE_COMBO_DEVICE_ID_BLINK = 10315;
const EVIE_COMBO_DEVICE_ID_ICE_BLOCK = 11414;
const EVIE_COMBO_DEVICE_ID_ICE_BLOCK_SUB = 14403;

var array<Actor> m_MarkedTargets;
var float m_fBlinkTimestamp;
var float m_fIceBlockTimestamp;

// Export UTgInventoryObject_Listen_Combo_Evie::execMarksExpired(FFrame&, void* const)
native function MarksExpired();
