class UIDataChampions extends UIDataObject
    native(UIData);

var UIDataChampion m_pActiveChampion;
var array<UIDataChampion> m_Champions;
var array<UIDataChampion> m_PvEChampions;
var array<UIDataItem> m_Collections;
var native map{VOID,VOID} m_PerChampionCollections;
var native map{VOID,VOID} m_ChampionIdToData;
