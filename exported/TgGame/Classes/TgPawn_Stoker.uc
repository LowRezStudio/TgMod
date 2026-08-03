class TgPawn_Stoker extends TgPawn_Viktor
    native(ChampViktor)
    config(Game)
    hidecategories(Navigation);

var Vector m_vCurrentWallRunNormal;
var bool m_bIsWallRunning;
var bool r_bWantsWallRun;
var bool m_bHasDoubleJumped;
var(Stoker) float m_fWallMagnetMovePerSec;
var(Stoker) float m_fWallRunStickinessDuration;
var float m_fWallRunStickinessTimer;
var(Stoker) float m_fWallRunLockoutJumpDuration;
var float m_fWallRunLockoutJumpTimer;
var(Stoker) float m_fWallJumpZSpeed;
var(Stoker) float m_fDoubleJumpZSpeed;
var(Stoker) float m_fNewWallAllowableRunAngle;
var float m_fWallRunTime;

function bool DoJump(bool bUpdating, optional float JumpZSpeed = 0.0000000)
{
    local bool bJumpSuccessful, oldAllowHigherWallJumping, oldIgnorePhysCheckForJump, bAttemptingDoubleJump;
    local float fJumpSpeed;

    oldAllowHigherWallJumping = m_bAllowHigherWallJumping;
    oldIgnorePhysCheckForJump = m_bIgnorePhysCheckForJump;
    // End:0x8B
    if(m_bIsWallRunning)
    {
        // End:0x64
        if(m_fWallJumpZSpeed > float(0))
        {
            fJumpSpeed = m_fWallJumpZSpeed;
        }
        m_bAllowHigherWallJumping = false;
        m_bIgnorePhysCheckForJump = true;
        m_bHasDoubleJumped = false;        
    }
    else
    {
        // End:0xFB
        if((int(Physics) == int(2)) && !m_bHasDoubleJumped)
        {
            // End:0xD4
            if(m_fDoubleJumpZSpeed > float(0))
            {
                fJumpSpeed = m_fDoubleJumpZSpeed;
            }
            m_bAllowHigherWallJumping = false;
            m_bIgnorePhysCheckForJump = true;
            bAttemptingDoubleJump = true;            
        }
        else
        {
            fJumpSpeed = JumpZSpeed;
            // End:0x12E
            if(int(Physics) == int(1))
            {
                m_bHasDoubleJumped = false;
            }
        }
    }
    bJumpSuccessful = super(TgPawn_Character).DoJump(bUpdating, fJumpSpeed);
    // End:0x1B6
    if(bJumpSuccessful)
    {
        r_bIsJumping = true;
        m_bIsWallRunning = false;
        m_fWallRunLockoutJumpTimer = m_fWallRunLockoutJumpDuration;
        m_bIgnorePhysCheckForJump = false;
        // End:0x1B3
        if(bAttemptingDoubleJump)
        {
            m_bHasDoubleJumped = true;
        }        
    }
    else
    {
        m_bIgnorePhysCheckForJump = oldIgnorePhysCheckForJump;
    }
    m_bAllowHigherWallJumping = oldAllowHigherWallJumping;
    m_bIgnorePhysCheckForJump = oldIgnorePhysCheckForJump;
    return bJumpSuccessful;
    //return ReturnValue;    
}

function bool CannotJumpNow()
{
    local bool oldIgnorePhysCheck, bCannotJump;

    oldIgnorePhysCheck = m_bIgnorePhysCheckForJump;
    m_bIgnorePhysCheckForJump = m_bIsWallRunning || (int(Physics) == int(2)) && !m_bHasDoubleJumped;
    bCannotJump = super(TgPawn_Character).CannotJumpNow();
    m_bIgnorePhysCheckForJump = oldIgnorePhysCheck;
    return bCannotJump;
    //return ReturnValue;    
}

function UpdateWallRun(bool bWantsWallRun)
{
    local bool bCanWallRun;

    bCanWallRun = (!r_bIsMounted && !r_bCrippled) && int(r_CurrentPolymorph) == int(0);
    // End:0x90
    if(((r_bWantsWallRun && m_bIsWallRunning) && bCanWallRun) && !bWantsWallRun)
    {
        m_fWallRunStickinessTimer = m_fWallRunStickinessDuration;        
    }
    else
    {
        // End:0xAE
        if(!bCanWallRun)
        {
            m_fWallRunStickinessTimer = 0.0000000;
        }
    }
    r_bWantsWallRun = bWantsWallRun && bCanWallRun;
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super(TgPawn_Character).Tick(DeltaSeconds);
    m_fWallRunStickinessTimer -= DeltaSeconds;
    m_fWallRunLockoutJumpTimer -= DeltaSeconds;
    // End:0x75
    if((int(Physics) == int(2)) && m_bIsWallRunning)
    {
        m_fWallRunTime = 0.0000000;
        SetPhysics(14);        
    }
    else
    {
        // End:0xCF
        if((int(Physics) == int(14)) && (!r_bWantsWallRun && m_fWallRunStickinessTimer <= float(0)) || !m_bIsWallRunning)
        {
            m_bIsWallRunning = false;
            SetPhysics(2);
        }
    }
    //return;    
}

// Export UTgPawn_Stoker::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

defaultproperties
{
    m_fWallMagnetMovePerSec=100.0000000
    m_fWallRunStickinessDuration=0.2500000
    m_fWallRunLockoutJumpDuration=0.3000000
    m_fNewWallAllowableRunAngle=0.7000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Stoker.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Viktor.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Stoker.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Viktor.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Stoker.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Viktor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Stoker.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Viktor.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    DefaultControlModuleClass=Class'TgGame.TgControlModule_Stoker'
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Stoker.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Viktor.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Stoker.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Viktor.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Stoker.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Viktor.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_GameplayCurves=TgGameplayCurves'GP_MeleeAssassin.PawnCurves'
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Stoker.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Viktor.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Stoker.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Viktor.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}