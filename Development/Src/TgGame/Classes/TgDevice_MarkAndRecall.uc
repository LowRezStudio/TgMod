class TgDevice_MarkAndRecall extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var Vector m_markedLocation;
var Rotator m_markedRotation;
var bool m_bMarked;

simulated function FireAmmunition() { }
