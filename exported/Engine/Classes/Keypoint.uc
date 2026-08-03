class Keypoint extends Actor
    abstract
    native
    placeable
    hidecategories(Navigation);

var() export editinline SpriteComponent SpriteComp;

defaultproperties
{
    Components[0]=none
    bStatic=true
    bHidden=true
}