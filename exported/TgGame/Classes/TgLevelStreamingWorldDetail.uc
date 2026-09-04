class TgLevelStreamingWorldDetail extends LevelStreaming
    native
    editinlinenew;

var(WorldDetail) int MinimumWorldDetailLevel;
var(WorldDetail) int MaximumWorldDetailLevel;
var transient byte CachedDetailCheck;
var transient int LastUpdateTime;

defaultproperties
{
    MinimumWorldDetailLevel=1
    MaximumWorldDetailLevel=-1
    LastUpdateTime=-1
}