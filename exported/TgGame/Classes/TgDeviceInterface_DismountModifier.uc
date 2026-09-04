interface TgDeviceInterface_DismountModifier extends Interface
    abstract
    native;

simulated event bool ShouldOverrideDismount(int DamageAmt)
{
    //return ReturnValue;    
}
