class TgSeqEvent_TakeDamage extends SequenceEvent
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

event HandleDamage(Actor InOriginator, Actor InInstigator, int inAmount, Class<DamageType> inDamageType, TgDevice InDevice)
{
    local SeqVar_Float FloatVar;
    local TgSeqVar_DamageType DamageVar;
    local SeqVar_Object DeviceVar;
    local bool bAlreadyActivatedThisTick;

    PublishLinkedVariableValues();
    // End:0x20F
    if(((InOriginator != none) && bEnabled) && !bPlayerOnly || (InInstigator != none) && InInstigator.IsPlayerOwned())
    {
        bAlreadyActivatedThisTick = bActive && ActivationTime ~= GetWorldInfo().TimeSeconds;
        // End:0x20F
        if(CheckActivate(InOriginator, InInstigator, false))
        {
            // End:0x167
            foreach LinkedVariables(Class'Engine.SeqVar_Float', FloatVar, "Damage Taken")
            {
                // End:0x13C
                if(bAlreadyActivatedThisTick)
                {
                    FloatVar.FloatValue += float(inAmount);
                    // End:0x166
                    continue;
                }
                FloatVar.FloatValue = float(inAmount);                
            }            
            // End:0x1BD
            foreach LinkedVariables(Class'TgGame.TgSeqVar_DamageType', DamageVar, "Damage Type")
            {
                DamageVar.DamageTypeValue = inDamageType;                
            }            
            // End:0x20E
            foreach LinkedVariables(Class'Engine.SeqVar_Object', DeviceVar, "Device")
            {
                DeviceVar.SetObjectValue(InDevice);                
            }            
        }
    }
    //return;    
}

defaultproperties
{
    MaxTriggerCount=0
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Damage Taken",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'TgGame.TgSeqVar_DamageType',LinkedVariables=none,LinkDesc="Damage Type",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[3]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Device",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Paladins Take Damage"
}