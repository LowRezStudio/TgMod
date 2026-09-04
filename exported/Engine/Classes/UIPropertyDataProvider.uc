class UIPropertyDataProvider extends UIDataProvider
    abstract
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

var const array< Class<Property> > ComplexPropertyTypes;
//var delegate<CanSupportComplexPropertyType> __CanSupportComplexPropertyType__Delegate;

delegate bool CanSupportComplexPropertyType(Property UnsupportedProperty)
{
    //return ReturnValue;    
}

defaultproperties
{
    ComplexPropertyTypes[0]=Class'Core.StructProperty'
    ComplexPropertyTypes[1]=Class'Core.MapProperty'
    ComplexPropertyTypes[2]=Class'Core.ArrayProperty'
    ComplexPropertyTypes[3]=Class'Core.DelegateProperty'
}