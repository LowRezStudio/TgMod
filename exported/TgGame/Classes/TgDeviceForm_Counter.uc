class TgDeviceForm_Counter extends TgDeviceForm
    native(ChampDarklord);

event Generic1(optional byte byExtraData)
{
    ActivateFxGroup('Darklord_AttackBlocked');
    //return;    
}
