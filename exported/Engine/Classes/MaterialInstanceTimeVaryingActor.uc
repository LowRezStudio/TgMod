class MaterialInstanceTimeVaryingActor extends Actor
    placeable
    hidecategories(Navigation,Movement,Advanced,Collision,Display,Actor,Attachment);

var() MaterialInstanceTimeVarying MatInst;

defaultproperties
{
    Components[0]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bNoDelete=true
}