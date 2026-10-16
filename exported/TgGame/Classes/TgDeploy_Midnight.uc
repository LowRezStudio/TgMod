class TgDeploy_Midnight extends TgDeployable
    native(ChampBlades)
    placeable
    hidecategories(Navigation);

var repnotify float r_fPersistTime;
var TgPawn r_TargetPawn;
var MaterialInstanceConstant m_pMIC;
var const Class<TgMidnightFogVolumeDensityInfo> m_FogInfoClass;
var TgMidnightFogVolumeDensityInfo m_FogInfo;
var bool m_bCleanedUp;
var bool m_b3PFxActive;
var bool m_b1PSoundActive;

replication
{
    // Pos:0x000
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        r_TargetPawn, r_fPersistTime;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_fPersistTime')
    {
        SetPersistTimer();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event SetPersistTimer()
{
    // End:0x2A
    if(r_fPersistTime > 0.0000000)
    {
        SetTimer(r_fPersistTime, false, 'MidnightDeployablePersistTimer');
    }
    // End:0x7D
    if((m_FogInfo != none) && r_fPersistTime > 0.0000000)
    {
        m_FogInfo.m_fDestroyTimer = r_fPersistTime * 1.2500000;
    }
    //return;    
}

// Export UTgDeploy_Midnight::execApplyCameraEffectParams(FFrame&, void* const)
native function ApplyCameraEffectParams();

simulated function MidnightDeployablePersistTimer()
{
    // End:0x59
    if((m_FogInfo != none) && !m_FogInfo.m_bIsFadingOut)
    {
        m_FogInfo.FadeOut(0.5000000);
    }
    //return;    
}

simulated function Destroyed()
{
    Cleanup();
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    Cleanup();
    super.DestroyIt(bSkipFx);
    //return;    
}

simulated function Cleanup()
{
    // End:0x156
    if(!m_bCleanedUp)
    {
        m_bCleanedUp = true;
        // End:0x98
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0x98
            if(r_TargetPawn != none)
            {
                r_TargetPawn.RemoveBlindingDeployable(self);
                // End:0x98
                if(m_FireMode != none)
                {
                    m_FireMode.RemoveHitSpecial(r_TargetPawn, true);
                }
            }
        }
        // End:0xF1
        if((m_FogInfo != none) && !m_FogInfo.m_bIsFadingOut)
        {
            m_FogInfo.FadeOut(0.5000000);
        }
        // End:0x156
        if(c_Mesh != none)
        {
            c_Mesh.FxDeactivateGroup('Generic1', 0);
            c_Mesh.FxDeactivateGroup('Generic2', 0);
        }
    }
    //return;    
}

// Export UTgDeploy_Midnight::execCreateMIC(FFrame&, void* const)
native function MaterialInstanceConstant CreateMIC(MaterialInterface pMaterialInterface);

simulated event SpawnFog()
{
    // End:0x175
    if((m_FogInfo == none) && m_FogInfoClass != none)
    {
        m_FogInfo = Spawn(m_FogInfoClass, self,, Location,,, true);
        // End:0x175
        if(m_FogInfo != none)
        {
            // End:0xEF
            if(m_FogInfo.SphericalDensityComponent != none)
            {
                m_FogInfo.SphericalDensityComponent.FogMaterial = CreateMIC(m_FogInfo.SphericalDensityComponent.FogMaterial);
            }
            m_FogInfo.Attach(self);
            m_FogInfo.SetAlpha(0.0000000);
            // End:0x175
            if(r_fPersistTime > 0.0000000)
            {
                m_FogInfo.m_fDestroyTimer = r_fPersistTime * 1.5000000;
            }
        }
    }
    //return;    
}

simulated event SetFogEnabled(bool bEnabled)
{
    // End:0x38
    if(m_FogInfo != none)
    {
        m_FogInfo.ToggleFog(bEnabled);
    }
    //return;    
}

simulated event SetFogDistance(float fDistance)
{
    // End:0x37
    if(m_FogInfo != none)
    {
        m_FogInfo.SetStartDistance(fDistance);
    }
    //return;    
}

simulated event SetFogAlpha(float fAlpha)
{
    // End:0x37
    if(m_FogInfo != none)
    {
        m_FogInfo.SetAlpha(fAlpha);
    }
    //return;    
}

simulated event SetFogOrigin(Vector vOrigin)
{
    // End:0x37
    if(m_FogInfo != none)
    {
        m_FogInfo.SetOrigin(vOrigin);
    }
    //return;    
}

defaultproperties
{
    m_FogInfoClass=Class'TgGame.TgMidnightFogVolumeDensityInfo'
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Midnight.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}