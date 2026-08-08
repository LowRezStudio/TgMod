class TgAnimBlendByNodeName extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct RelevantNodeNameNodes {
    var AnimNode CachedNode;
    var int ChildIndex;
    structdefaultproperties {}
};

struct NodeNameToChildIndex {
    var () name NodeName;
    var () int ChildIndex;
    structdefaultproperties {}
};

var () array<NodeNameToChildIndex> m_NodeNameToChildIndex;
var transient array<RelevantNodeNameNodes> m_CachedNodes;
var transient AnimNode m_LastSuccessfulAnimNode;
var transient bool m_bHasCachedNodes;

defaultproperties
{
    DefaultBlendTime=0.1500000
    bPlayActiveChild=true
}
