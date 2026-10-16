class ActorFactoryVehicle extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() Class<Vehicle> VehicleClass;

defaultproperties
{
    VehicleClass=Class'Engine.Vehicle'
    bPlaceable=false
}