class TgMissionListVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var(Object) editconst int m_nMapObjectId;
var() int s_nQueueTableId;
var() int s_nQueueTableMsgId;
var() Teleporter m_Teleporter;

defaultproperties
{
    // Reference: BrushComponent'TgGame.Default__TgMissionListVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}