class TgMapBoundsVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () Texture2D MinimapImage;

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
