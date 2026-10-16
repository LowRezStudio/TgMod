class TgDeploy_Gourd extends TgDeploy_EffectField
    native(ChampMalDamba)
    placeable
    hidecategories(Navigation);

var repnotify bool r_bHasRipenedGourd;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasRipenedGourd;
}

// Export UTgDeploy_Gourd::execToggleRipenedGourdFX(FFrame&, void* const)
native function ToggleRipenedGourdFX();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_bHasRipenedGourd')
    {
        ToggleRipenedGourdFX();
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn PawnOwner;
    local TgDevice_GourdMod modDevice;
    local int I;
    local bool bIsAlreadyTracked;

    // End:0x0F
    if(m_bInDestroyedState)
    {
        return;
    }
    bIsAlreadyTracked = false;
    // End:0x47
    if(m_TouchingPawns.Find(Other) != -1)
    {
        bIsAlreadyTracked = true;
    }
    super.OnProxyTouch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x206
    if(m_TouchingPawns.Find(Other) != -1)
    {
        // End:0x206
        if(!bIsAlreadyTracked)
        {
            PawnOwner = TgPawn(Instigator);
            // End:0x206
            if(PawnOwner != none)
            {
                I = 0;
                J0xDA:

                // End:0x206 [Loop If]
                if(I < 33)
                {
                    // End:0x1F8
                    if((PawnOwner.m_EquippedDevices[I] != none) && PawnOwner.m_EquippedDevices[I].IsActive())
                    {
                        modDevice = TgDevice_GourdMod(PawnOwner.m_EquippedDevices[I]);
                        // End:0x1F8
                        if(modDevice != none)
                        {
                            modDevice.ApplyOnTouchEffect(Other);
                            modDevice.ApplyEffect(self, Other);
                        }
                    }
                    ++I;
                    // [Loop Continue]
                    goto J0xDA;
                }
            }
        }
    }
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    local TgPawn PawnOwner;
    local TgDevice_GourdMod modDevice;
    local int I;

    PawnOwner = TgPawn(Instigator);
    // End:0xF5
    if(PawnOwner != none)
    {
        I = 0;
        J0x36:

        // End:0xF5 [Loop If]
        if(I < 33)
        {
            // End:0xE7
            if(PawnOwner.m_EquippedDevices[I] != none)
            {
                modDevice = TgDevice_GourdMod(PawnOwner.m_EquippedDevices[I]);
                // End:0xE7
                if(modDevice != none)
                {
                    modDevice.RemoveEffect(self, Other);
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x36;
        }
    }
    super.OnProxyUnTouch(Other);
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Gourd.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}