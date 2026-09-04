class TgDeviceForm_RocketLauncher extends TgDeviceForm;

event Generic1(optional byte byExtraData)
{
    super.Generic1(byExtraData);
    ((int(byExtraData) == int(1)) ? ActivateFxGroup('RuckusMissile') : DeactivateFxGroup('RuckusMissile'));
    //return;    
}
