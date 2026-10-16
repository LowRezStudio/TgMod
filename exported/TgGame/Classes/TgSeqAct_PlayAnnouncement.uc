class TgSeqAct_PlayAnnouncement extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

var() bool bPlayImmediately;
var() bool bFlushOthers;
var() int SoundIndex;
var() SoundCue OptionalCue;

event Activated()
{
    local TgPlayerController CurrPC;
    local WorldInfo World;

    World = Class'Engine.WorldInfo'.static.GetWorldInfo();
    // End:0x65
    if((World == none) || int(World.NetMode) == int(NM_Client))
    {
        return;
    }
    // End:0xDF
    foreach World.AllControllers(Class'TgGame.TgPlayerController', CurrPC)
    {
        CurrPC.PlayTutorialAnnouncement(SoundIndex, OptionalCue, bPlayImmediately, bFlushOthers);        
    }    
    //return;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    ObjName="Tutorial Announcement"
}