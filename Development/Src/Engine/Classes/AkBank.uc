class AkBank extends Object
    native
    config(Engine);

var () bool AutoLoad;
var () bool GenerateDefinition;
var transient bool bIsAsyncLoading;

defaultproperties
{
    AutoLoad=true
    GenerateDefinition=true
}
