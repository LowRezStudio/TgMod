class TgDeploy_IllusionLongbow extends TgDeployable
    native(ChampLongbow)
    notplaceable
    hidecategories(Navigation);

var int c_nDefaultBodyMeshId;
var int c_nDefaultHeadMeshId;
var int c_nDefaultWeaponMeshId;
var export editinline TgSkeletalMeshComponent m_HeadMesh;
var export editinline TgSkeletalMeshComponent_Weapon m_WeaponMesh;
var array<MaterialInstanceConstant> m_bodyReplacementMICs;
var array<MaterialInstanceConstant> m_headReplacementMICs;
var array<MaterialInstanceConstant> m_weaponReplacementMICs;
var bool m_bFadingAway;
var const float m_fLifeAfterDeathOverride;
var TgCollisionProxy_Cylinder m_FxCollisionProxy;
var float m_fCollisionRadius;

// Export UTgDeploy_IllusionLongbow::execUpdateFadeAway(FFrame&, void* const)
native function UpdateFadeAway();

// Export UTgDeploy_IllusionLongbow::execFixupMeshComponent(FFrame&, void* const)
native function FixupMeshComponent(int nMeshId, TgSkeletalMeshComponent Component);

// Export UTgDeploy_IllusionLongbow::execReplaceWithFadeOutMaterial(FFrame&, void* const)
native function ReplaceWithFadeOutMaterial();

simulated event OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn pawnOther;
    local editinline MeshComponent ComponentIt;

    // End:0xDB
    if(((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Other != none) && c_Mesh != none)
    {
        pawnOther = TgPawn(Other);
        // End:0xDB
        if((pawnOther != none) && pawnOther.IsLocallyControlled())
        {
            // End:0xDA
            foreach ComponentList(Class'Engine.MeshComponent', ComponentIt)
            {
                ComponentIt.SetHidden(true);                
            }            
        }
    }
    //return;    
}

simulated event OnProxyUnTouch(Actor Other)
{
    local TgPawn pawnOther;
    local editinline MeshComponent ComponentIt;

    // End:0xDB
    if(((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Other != none) && c_Mesh != none)
    {
        pawnOther = TgPawn(Other);
        // End:0xDB
        if((pawnOther != none) && pawnOther.IsLocallyControlled())
        {
            // End:0xDA
            foreach ComponentList(Class'Engine.MeshComponent', ComponentIt)
            {
                ComponentIt.SetHidden(false);                
            }            
        }
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local editinline MeshComponent ComponentIt;

    super.DestroyIt(bSkipFx);
    // End:0x88
    if(m_FxCollisionProxy != none)
    {
        m_FxCollisionProxy.Destroy();
        m_FxCollisionProxy = none;
        // End:0x87
        foreach ComponentList(Class'Engine.MeshComponent', ComponentIt)
        {
            ComponentIt.SetHidden(false);            
        }        
    }
    //return;    
}

simulated event Destroyed()
{
    // End:0x32
    if(m_FxCollisionProxy != none)
    {
        m_FxCollisionProxy.Destroy();
        m_FxCollisionProxy = none;
    }
    super.Destroyed();
    //return;    
}

simulated event SpawnCollisionProxy()
{
    // End:0x32
    if(m_FxCollisionProxy != none)
    {
        m_FxCollisionProxy.Destroy();
        m_FxCollisionProxy = none;
    }
    m_FxCollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, self.Location,,, true);
    // End:0x179
    if(m_FxCollisionProxy != none)
    {
        m_FxCollisionProxy.SetBase(self);
        m_FxCollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
        m_FxCollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
        m_FxCollisionProxy.DelegatesUpdated();
        m_FxCollisionProxy.m_CollisionCylinder.SetCylinderSize(m_fCollisionRadius, m_fCollisionRadius);
        m_FxCollisionProxy.DelegatesUpdated();
    }
    //return;    
}

defaultproperties
{
    c_nDefaultBodyMeshId=6043
    c_nDefaultHeadMeshId=6700
    c_nDefaultWeaponMeshId=6505
    m_fLifeAfterDeathOverride=1.5000000
    m_fCollisionRadius=7.0000000
    m_bUseSilhouettesOverride=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_IllusionLongbow.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}