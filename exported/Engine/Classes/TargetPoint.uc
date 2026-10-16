class TargetPoint extends Keypoint
    native
    placeable
    hidecategories(Navigation);

var transient int SpawnRefCount;

defaultproperties
{
    Components[0]=none
    Components[1]=none
    bStatic=false
    bNoDelete=true
}