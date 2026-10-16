class UIData_LeagueTierChange extends UIData
    native(UIData);

enum UIDLTC_PromotionType
{
    UIDLTC_Promoted,                // 0
    UIDLTC_Demoted,                 // 1
    UIDLTC_MAX                      // 2
};

var UIDataLeague m_League;
var UIDataLeagueTier m_PrevTier;
var UIDataLeagueTier m_NextTier;
var UIData_LeagueTierChange.UIDLTC_PromotionType m_ePromotionType;
