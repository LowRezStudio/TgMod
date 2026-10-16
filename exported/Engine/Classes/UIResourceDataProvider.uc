class UIResourceDataProvider extends UIPropertyDataProvider
    abstract
    transient
    native(UIPrivate)
    config(Game)
    perobjectconfig
    hidecategories(Object,UIRoot);

var config bool bSkipDuringEnumeration;

event InitializeProvider(bool bIsEditor)
{
    //return;    
}

defaultproperties
{
    ComplexPropertyTypes[0]=Class'Core.StructProperty'
    ComplexPropertyTypes[1]=Class'Core.MapProperty'
    ComplexPropertyTypes[2]=Class'Core.DelegateProperty'
}