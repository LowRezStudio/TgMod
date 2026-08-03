class TgDevice_LegDay extends TgDevice
    hidecategories(Navigation);

function ModifyLeapParams(out float scaleLateral, out float scaleVertical, out float additiveLateral, out float additiveVertical)
{
    local TgDeviceFire deviceFire;

    deviceFire = GetCurrentFire();
    // End:0xDC
    if(IsActive() && deviceFire != none)
    {
        scaleLateral *= deviceFire.GetCustomValue4();
        scaleVertical *= deviceFire.GetCustomValue3();
        additiveLateral *= deviceFire.GetCustomValue2();
        additiveVertical *= deviceFire.GetCustomValue1();
    }
    //return;    
}
