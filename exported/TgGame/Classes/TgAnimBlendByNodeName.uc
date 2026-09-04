class TgAnimBlendByNodeName extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native RelevantNodeNameNodes
{
    var AnimNode CachedNode;
    var int ChildIndex;

    structdefaultproperties
    {
        CachedNode=none
        ChildIndex=0
    }
};

struct native NodeNameToChildIndex
{
    var() name NodeName;
    var() int ChildIndex;

    structdefaultproperties
    {
        NodeName="None"
        ChildIndex=0
    }
};

var() array<NodeNameToChildIndex> m_NodeNameToChildIndex;
var transient array<RelevantNodeNameNodes> m_CachedNodes;
var transient AnimNode m_LastSuccessfulAnimNode;
var transient bool m_bHasCachedNodes;

defaultproperties
{
    DefaultBlendTime=0.1500000
    bPlayActiveChild=true
}