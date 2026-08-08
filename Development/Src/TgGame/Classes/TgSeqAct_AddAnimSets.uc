class TgSeqAct_AddAnimSets extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () array<AnimSet> m_MaleAnimSets;
var () array<AnimSet> m_FemaleAnimSets;
var () bool m_bAppendToExisting;

defaultproperties
{
    m_bAppendToExisting=true
    ObjName="Add Anim Sets"
}
