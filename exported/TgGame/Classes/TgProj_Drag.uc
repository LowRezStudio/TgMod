class TgProj_Drag extends TgProj_Simulated
    native(ChampMakoa)
    hidecategories(Navigation);

var TgDeviceForm_Drag m_DragForm;
var float m_fCollisionHeightScale;

simulated event SpawnFlightEffects()
{
    local TgPawn PawnOwner;
    local int I;

    super(TgProjectile).SpawnFlightEffects();
    PawnOwner = TgPawn(Instigator);
    // End:0xCA
    if(PawnOwner != none)
    {
        I = 0;
        J0x40:

        // End:0xCA [Loop If]
        if(I < 33)
        {
            m_DragForm = TgDeviceForm_Drag(PawnOwner.c_EquipForm[I]);
            // End:0xBC
            if(m_DragForm != none)
            {
                m_DragForm.ConnectBeamToTarget(self);
                return;
            }
            I++;
            // [Loop Continue]
            goto J0x40;
        }
    }
    //return;    
}

function RangeReached()
{
    local TgDevice_Drag dragDevice;

    // End:0xBF
    if(((int(WorldInfo.NetMode) != int(NM_Client)) && m_OwnerFireMode != none) && m_OwnerFireMode.m_Owner != none)
    {
        dragDevice = TgDevice_Drag(m_OwnerFireMode.m_Owner);
        // End:0xBF
        if(dragDevice != none)
        {
            dragDevice.MissPull();
        }
    }
    ServerDetonate();
    //return;    
}

simulated event Fizzle()
{
    local TgDevice_Drag dragDevice;

    // End:0xBF
    if(((int(WorldInfo.NetMode) != int(NM_Client)) && m_OwnerFireMode != none) && m_OwnerFireMode.m_Owner != none)
    {
        dragDevice = TgDevice_Drag(m_OwnerFireMode.m_Owner);
        // End:0xBF
        if(dragDevice != none)
        {
            dragDevice.BreakPull();
        }
    }
    super.Fizzle();
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x3B
    if(!m_bHasExploded)
    {
        // End:0x3B
        if(!StartDrag(Target, HitLocation))
        {
            Target = none;
        }
    }
    super.ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

simulated function bool StartDrag(Actor Target, Vector HitLocation)
{
    local TgDevice_Drag dragDevice;

    // End:0xD2
    if(((int(WorldInfo.NetMode) != int(NM_Client)) && m_OwnerFireMode != none) && m_OwnerFireMode.m_Owner != none)
    {
        dragDevice = TgDevice_Drag(m_OwnerFireMode.m_Owner);
        // End:0xD2
        if(dragDevice != none)
        {
            return dragDevice.PullTarget(Target, HitLocation);
        }
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_fCollisionHeightScale=2.0000000
    m_bExplodeAtMaxRange=true
    m_bCanSpawnOnClientFirst=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Drag.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Drag.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}