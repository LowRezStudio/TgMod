class SeqAct_MultiLevelStreaming extends SeqAct_LevelStreamingBase
    native(Sequence)
    hidecategories(Object);

struct native LevelStreamingNameCombo
{
    var const LevelStreaming Level;
    var() const name LevelName;

    structdefaultproperties
    {
        Level=none
        LevelName="None"
    }
};

var() array<LevelStreamingNameCombo> Levels;
var() bool bUnloadAllOtherLevels;
var transient bool bStatusIsOk;

defaultproperties
{
    ObjName="Stream Levels"
}