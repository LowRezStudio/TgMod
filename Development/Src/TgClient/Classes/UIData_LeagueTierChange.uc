class UIData_LeagueTierChange extends UIData
    native(UIData)
    config(Engine);

enum UIDLTC_PromotionType {
    UIDLTC_Promoted,  // 0
    UIDLTC_Demoted,  // 1
};

var UIDataLeague m_League;
var UIDataLeagueTier m_PrevTier;
var UIDataLeagueTier m_NextTier;
var UIData_LeagueTierChange.UIDLTC_PromotionType m_ePromotionType;
