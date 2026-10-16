class TgDeploy_ShieldBarik extends TgDeploy_Shield
    native(ChampBarik)
    notplaceable
    hidecategories(Navigation);

var repnotify bool r_bHasCapsule;
var repnotify bool r_bHasAcceleratorField;
var repnotify bool r_bHasImpede;
var repnotify bool r_bHasBunker;
var repnotify bool r_bHasFortify;
var array<Actor> m_AcceleratedActors;
var TgPawn m_CachedPawnOwner;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_bHasCapsule;

    // Pos:0x020
    if(int(Role) == int(ROLE_Authority))
        r_bHasAcceleratorField, r_bHasBunker, 
        r_bHasFortify, r_bHasImpede;
}

// Export UTgDeploy_ShieldBarik::execToggleFX(FFrame&, void* const)
native function ToggleFX();

// Export UTgDeploy_ShieldBarik::execToggleLockdownMode(FFrame&, void* const)
native function ToggleLockdownMode(bool bSetActive);

simulated event ReplicatedEvent(name VarName)
{
    // End:0x53
    if(((VarName == 'r_bHasAcceleratorField') || VarName == 'r_bHasImpede') || VarName == 'r_bHasBunker')
    {
        ToggleFX();
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgDevice_AcceleratorField acceleratorFieldDevice;
    local TgDevice_Impede impedeDevice;
    local TgDevice comboDevice;
    local TgInventoryObject_Listen_Combo_Barik comboListener;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x23F
    if(m_CachedPawnOwner != none)
    {
        // End:0xF4
        if(r_bHasAcceleratorField && m_AcceleratedActors.Find(Other) == -1)
        {
            acceleratorFieldDevice = TgDevice_AcceleratorField(m_CachedPawnOwner.GetActiveDeviceByClass('TgDevice_AcceleratorField'));
            // End:0xF4
            if(acceleratorFieldDevice != none)
            {
                acceleratorFieldDevice.ApplyTouchEffect(Other);
                m_AcceleratedActors.AddItem(Other);
            }
        }
        // End:0x173
        if(r_bHasImpede)
        {
            impedeDevice = TgDevice_Impede(m_CachedPawnOwner.GetActiveDeviceByClass('TgDevice_Impede'));
            // End:0x173
            if(impedeDevice != none)
            {
                impedeDevice.ApplyTouchEffect(Other);
            }
        }
        comboDevice = m_CachedPawnOwner.GetDeviceById(14317);
        // End:0x23F
        if((comboDevice != none) && comboDevice.s_InventoryObject != none)
        {
            comboListener = TgInventoryObject_Listen_Combo_Barik(comboDevice.s_InventoryObject);
            // End:0x23F
            if(comboListener != none)
            {
                comboListener.TouchedBarricade(Other, self);
            }
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_ShieldBarik.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}