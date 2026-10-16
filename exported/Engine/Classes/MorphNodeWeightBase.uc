class MorphNodeWeightBase extends MorphNodeBase
    abstract
    native(Anim)
    hidecategories(Object,Object,Object);

struct native MorphNodeConn
{
    var array<MorphNodeBase> ChildNodes;
    var name ConnName;
    var int DrawY;

    structdefaultproperties
    {
        ChildNodes=none
        ConnName="None"
        DrawY=0
    }
};

var array<MorphNodeConn> NodeConns;
