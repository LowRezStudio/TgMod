class TgMapInfo extends MapInfo
    native
    editinlinenew;

var() Actor m_EndFocusActor_TF1;
var() Actor m_EndFocusActor_TF2;
var() TgFatalityFactory m_FatalityFactory_TF1_1;
var() TgFatalityFactory m_FatalityFactory_TF1_2;
var() TgFatalityFactory m_FatalityFactory_TF1_3;
var() TgFatalityFactory m_FatalityFactory_TF2_1;
var() TgFatalityFactory m_FatalityFactory_TF2_2;
var() TgFatalityFactory m_FatalityFactory_TF2_3;
var() StaticMeshActor m_OverlayPathMesh;
var() Vector2D m_vMapCenter;
var() Vector2D m_vTaskForce1BaseLocation;
var() Vector2D m_vTaskForce2BaseLocation;
var() float m_fLockViewBufferZoneSize;
var() bool m_bSupportsGuardianThrone;
var() float m_LitParticleBrightness;

simulated function TgFatalityFactory GetEmptyFatalityFactory(byte TaskForceNumber)
{
    switch(TaskForceNumber)
    {
        // End:0x189
        case 2:
            // End:0x93
            if((m_FatalityFactory_TF1_1 != none) && (m_FatalityFactory_TF1_1.m_FatalityMeshActor == none) || m_FatalityFactory_TF1_1.m_FatalityMeshActor.IsPendingKill())
            {
                return m_FatalityFactory_TF1_1;                
            }
            else
            {
                // End:0x10E
                if((m_FatalityFactory_TF1_2 != none) && (m_FatalityFactory_TF1_2.m_FatalityMeshActor == none) || m_FatalityFactory_TF1_2.m_FatalityMeshActor.IsPendingKill())
                {
                    return m_FatalityFactory_TF1_2;                    
                }
                else
                {
                    // End:0x186
                    if((m_FatalityFactory_TF1_3 != none) && (m_FatalityFactory_TF1_3.m_FatalityMeshActor == none) || m_FatalityFactory_TF1_3.m_FatalityMeshActor.IsPendingKill())
                    {
                        return m_FatalityFactory_TF1_3;
                    }
                }
            }
            // End:0x302
            break;
        // End:0x2FF
        case 1:
            // End:0x209
            if((m_FatalityFactory_TF2_1 != none) && (m_FatalityFactory_TF2_1.m_FatalityMeshActor == none) || m_FatalityFactory_TF2_1.m_FatalityMeshActor.IsPendingKill())
            {
                return m_FatalityFactory_TF2_1;                
            }
            else
            {
                // End:0x284
                if((m_FatalityFactory_TF2_2 != none) && (m_FatalityFactory_TF2_2.m_FatalityMeshActor == none) || m_FatalityFactory_TF2_2.m_FatalityMeshActor.IsPendingKill())
                {
                    return m_FatalityFactory_TF2_2;                    
                }
                else
                {
                    // End:0x2FC
                    if((m_FatalityFactory_TF2_3 != none) && (m_FatalityFactory_TF2_3.m_FatalityMeshActor == none) || m_FatalityFactory_TF2_3.m_FatalityMeshActor.IsPendingKill())
                    {
                        return m_FatalityFactory_TF2_3;
                    }
                }
            }
            // End:0x302
            break;
        // End:0xFFFF
        default:
            break;
    }
    return none;
    //return ReturnValue;    
}

defaultproperties
{
    m_vTaskForce1BaseLocation=(X=-10500.0000000,Y=0.0000000)
    m_vTaskForce2BaseLocation=(X=10500.0000000,Y=0.0000000)
    m_fLockViewBufferZoneSize=1500.0000000
    m_LitParticleBrightness=12.0000000
}