class TgPawn_Pip extends TgPawn_Character
    native(ChampPip)
    config(Game)
    hidecategories(Navigation);

var bool r_bWeightless;
var bool m_bWeightlessDurationEnded;
var bool r_bAcrobaticsActive;
var bool r_bHasMegaPotion;
var float m_fWeightlessMaxSpeedModifier;
var float m_fWeightlessJumpZModifier;
var float r_fRadiusForHealingPotionFX;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && !bNetOwner || bDemoRecording)
        r_bWeightless;

    // Pos:0x031
    if(int(Role) == int(ROLE_Authority))
        r_bAcrobaticsActive, r_bHasMegaPotion, 
        r_fRadiusForHealingPotionFX;
}

simulated event PlayJumpSound()
{
    local array<Object> JumpFxList;
    local TgSpecialFx JumpFx;
    local int I;

    // End:0x11
    if(Mesh == none)
    {
        return;
    }
    // End:0xFC
    if(r_bWeightless)
    {
        JumpFxList = Mesh.FxGetAll('Jump_Special', 0);
        I = 0;
        J0x5F:

        // End:0xF9 [Loop If]
        if(I < JumpFxList.Length)
        {
            JumpFx = TgSpecialFx(JumpFxList[I]);
            // End:0xEB
            if(JumpFx != none)
            {
                JumpFx.c_Owner = self;
                JumpFx.PlaySound();
            }
            I++;
            // [Loop Continue]
            goto J0x5F;
        }        
    }
    else
    {
        super(TgPawn).PlayJumpSound();
    }
    //return;    
}

function StartWeightless(float fMaxSpeedMultiplier, float fJumpZMultiplier)
{
    r_bWeightless = true;
    m_bWeightlessDurationEnded = false;
    m_fWeightlessMaxSpeedModifier = fMaxSpeedMultiplier;
    m_fWeightlessJumpZModifier = fJumpZMultiplier;
    bNetDirty = true;
    DoJump(true);
    //return;    
}

singular function EndWeightless()
{
    // End:0x2C
    if(int(Physics) != int(2))
    {
        r_bWeightless = false;
        bNetDirty = true;
    }
    m_bWeightlessDurationEnded = true;
    //return;    
}

simulated function float GetJumpSpeedMultiplier()
{
    // End:0x1A
    if(r_bWeightless)
    {
        return m_fWeightlessJumpZModifier;        
    }
    else
    {
        return 1.0000000;
    }
    //return ReturnValue;    
}

function bool DoJump(bool bUpdating, optional float JumpZSpeed = 0.0000000)
{
    local Vector AccelDir, HorizontalVelocity;
    local float fWeightlessMaxSpeed;

    // End:0x1A5
    if((r_bWeightless && bJumpCapable) && CheckPhysicsStateForJumping())
    {
        // End:0x17F
        if(!IsZero(Acceleration))
        {
            AccelDir = Normal2D(Acceleration);
            fWeightlessMaxSpeed = GroundSpeed * m_fWeightlessMaxSpeedModifier;
            HorizontalVelocity = Velocity;
            HorizontalVelocity.Z = 0.0000000;
            HorizontalVelocity += (AccelDir * fWeightlessMaxSpeed);
            // End:0x10D
            if(VSize2D(HorizontalVelocity) > fWeightlessMaxSpeed)
            {
                HorizontalVelocity = Normal2D(HorizontalVelocity) * fWeightlessMaxSpeed;
            }
            Velocity.X = HorizontalVelocity.X;
            Velocity.Y = HorizontalVelocity.Y;
        }
        // End:0x1A5
        if(JumpZSpeed == 0.0000000)
        {
            JumpZSpeed = JumpZ;
        }
    }
    return super.DoJump(bUpdating, JumpZSpeed);
    //return ReturnValue;    
}

event Landed(Vector HitNormal, Actor FloorActor)
{
    super(TgPawn_Biped).Landed(HitNormal, FloorActor);
    // End:0x35
    if(m_bWeightlessDurationEnded)
    {
        r_bWeightless = false;
    }
    //return;    
}

simulated function SetPipGlowEnabled(bool bEnabled)
{
    local MaterialInstance theMaterialInstance;
    local float fPipGlowValue;

    fPipGlowValue = ((bEnabled) ? 1.0000000 : 0.0000000);
    // End:0xA5
    if(Mesh != none)
    {
        theMaterialInstance = MaterialInstance(Mesh.GetMaterial(0));
        // End:0xA5
        if(theMaterialInstance != none)
        {
            theMaterialInstance.SetScalarParameterValue('PipGlow', fPipGlowValue);
        }
    }
    // End:0x20C
    if(m_WeaponMesh != none)
    {
        // End:0x160
        if(m_WeaponMesh.m_WeaponMesh1P != none)
        {
            theMaterialInstance = MaterialInstance(m_WeaponMesh.m_WeaponMesh1P.GetMaterial(0));
            // End:0x160
            if(theMaterialInstance != none)
            {
                theMaterialInstance.SetScalarParameterValue('PipGlow', fPipGlowValue);
            }
        }
        // End:0x20C
        if(m_WeaponMesh.m_WeaponMesh3P != none)
        {
            theMaterialInstance = MaterialInstance(m_WeaponMesh.m_WeaponMesh3P.GetMaterial(0));
            // End:0x20C
            if(theMaterialInstance != none)
            {
                theMaterialInstance.SetScalarParameterValue('PipGlow', fPipGlowValue);
            }
        }
    }
    //return;    
}

simulated function TickScale(float DeltaSeconds)
{
    local float fCurrentScale;

    fCurrentScale = GetPropCurrentValue(118);
    // End:0x47
    if(m_fScaleMesh != fCurrentScale)
    {
        SetPipGlowEnabled(fCurrentScale > 1.1000000);
    }
    super(TgPawn).TickScale(DeltaSeconds);
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x4C
        case 1:
            return "PC_Alchemist.Anims.AS_PC_Alchemist_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    m_bWeightlessDurationEnded=true
    m_fWeightlessMaxSpeedModifier=1.0000000
    r_fRadiusForHealingPotionFX=25.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Pip.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Pip.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Pip"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Pip.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=1.1000000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Pip.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Pip.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Pip.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Pip.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fScaleMeshChangePerSecond=1.5000000
    m_fScaleCollisionHeightChangePerSecond=1.5000000
    BaseEyeHeight=30.0000000
    EyeHeight=30.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Pip.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Pip.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}