class Note extends Actor
    native
    placeable
    hidecategories(Navigation);

defaultproperties
{
    Components[0]=none
    Components[1]=none
    bStatic=true
    bHidden=true
    bNoDelete=true
    bRouteBeginPlayEvenIfStatic=false
    bMovable=false
}