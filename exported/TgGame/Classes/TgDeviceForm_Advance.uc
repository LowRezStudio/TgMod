class TgDeviceForm_Advance extends TgDeviceForm;

event Generic1(optional byte byExtraData)
{
    DeactivateFxGroup('Land_Special');
    ActivateFxGroup('Land_Special');
    //return;    
}

event Generic2(optional byte byExtraData)
{
    DeactivateFxGroup('Jump_Special');
    ActivateFxGroup('Jump_Special');
    //return;    
}
