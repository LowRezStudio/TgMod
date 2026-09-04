class GFxEngine extends Object
    native
    config(Engine);

struct native GCReference
{
    var const Object m_object;
    var int m_count;
    var int m_statid;

    structdefaultproperties
    {
        m_object=none
        m_count=0
        m_statid=0
    }
};

var private transient array<GCReference> GCReferences;
var private transient int RefCount;
var config array<config name> ForceGarbageCollectUponReleaseTextures;

defaultproperties
{
    RefCount=1
}