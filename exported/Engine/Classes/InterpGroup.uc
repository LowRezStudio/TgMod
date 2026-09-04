class InterpGroup extends Object
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct InterpEdSelKey
{
    var InterpGroup Group;
    var InterpTrack Track;
    var int KeyIndex;
    var float UnsnappedPosition;

    structdefaultproperties
    {
        Group=none
        Track=none
        KeyIndex=0
        UnsnappedPosition=0.0000000
    }
};

var private native const noexport Pointer VfTable_FInterpEdInputInterface;
var export array<export InterpTrack> InterpTracks;
var name GroupName;
var() Color GroupColor;
var() array<AnimSet> GroupAnimSets;
var bool bCollapsed;
var transient bool bVisible;
var bool bIsFolder;
var bool bIsParented;
var transient bool bIsSelected;

defaultproperties
{
    GroupName="InterpGroup"
    GroupColor=(R=100,G=80,B=200,A=255)
    bVisible=true
}