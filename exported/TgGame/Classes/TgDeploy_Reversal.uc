class TgDeploy_Reversal extends TgDeploy_Shield
    native(ChampAndroxus)
    notplaceable
    hidecategories(Navigation);

var int m_nLargeMeshID;
var export editinline MeshComponent m_SmallMesh;
var export editinline MeshComponent m_LargeMesh;
var repnotify float r_fVengeanceDamage;
var repnotify float r_fAccumulatedDamage;
var repnotify float r_fMinimumDamage;
var TgPawn m_CachedPawnOwner;
var TgDeviceForm_Reversal m_ReversalForm;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fAccumulatedDamage, r_fMinimumDamage, 
        r_fVengeanceDamage;
}

// Export UTgDeploy_Reversal::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

// Export UTgDeploy_Reversal::execScaleFXByDamage(FFrame&, void* const)
native function ScaleFXByDamage();

// Export UTgDeploy_Reversal::execSendDamageToDevice(FFrame&, void* const)
native function SendDamageToDevice();

// Export UTgDeploy_Reversal::execToggleLargeMesh(FFrame&, void* const)
native function ToggleLargeMesh();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2E
    if(VarName == 'r_fAccumulatedDamage')
    {
        ScaleFXByDamage();
        SendDamageToDevice();        
    }
    else
    {
        // End:0x52
        if(VarName == 'r_fMinimumDamage')
        {
            ScaleFXByDamage();            
        }
        else
        {
            // End:0x87
            if(VarName == 'r_fVengeanceDamage')
            {
                ToggleLargeMesh();
                ScaleFXByDamage();
                SendDamageToDevice();
            }
        }
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    super(TgDeployable).DestroyIt(bSkipFx);
    // End:0x64
    if((r_fAccumulatedDamage > float(0)) && c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('Reversal_Fire', 0);
    }
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    return;
    //return;    
}

defaultproperties
{
    m_nLargeMeshID=5823
    m_bMovableProjBlocker=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Reversal.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bOnlyBlockShotsFromFront=true)
    m_nInitHUDOverlayDisplayMask=0
    Components[0]=MyLightEnvironment
}