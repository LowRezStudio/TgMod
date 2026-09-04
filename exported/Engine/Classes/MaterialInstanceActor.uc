class MaterialInstanceActor extends Actor
    native
    placeable
    hidecategories(Navigation,Movement,Advanced,Collision,Display,Actor,Attachment);

var() MaterialInstanceConstant MatInst;

defaultproperties
{
    Components[0]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWorkThreaded
    bNoDelete=true
    bServerTickIsDisabled=true
}