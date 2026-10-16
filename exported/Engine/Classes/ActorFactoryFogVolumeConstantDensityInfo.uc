class ActorFactoryFogVolumeConstantDensityInfo extends ActorFactory
    native(FogVolume)
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var MaterialInterface SelectedMaterial;
var bool bNothingSelected;

defaultproperties
{
    MenuName="Add FogVolumeConstantDensityInfo"
    NewActorClass=Class'Engine.FogVolumeConstantDensityInfo'
}