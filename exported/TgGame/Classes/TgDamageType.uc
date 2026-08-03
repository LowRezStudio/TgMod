class TgDamageType extends DamageType
    native;

var bool m_bImpulseMesh;
var bool m_bEnableMotors;
var bool m_bShouldRagdollAfterDeathAnim;
var bool m_bCanPlayDeathSpecialFXOnDefaultDeath;
var bool m_bHarvestMaterialParameters;
var bool m_bFreezeAnimsOnDeath;
var bool m_bIgnorePersonalShields;
var bool m_bIsLatent;
var float m_bMinImpulse;
var float m_bMaxImpulse;
var float m_bMinUpKick;
var float m_bMaxUpKick;
var array<name> m_nmDeathAnimNames;
var array<name> m_nmDeathFlailAnimNames;
var float m_fMinAngularVelocity;
var float m_fMaxAngularVelocity;
var int m_nDeathSpecialFXId;
var name m_nmDeathSpecialFXSocket;
var MaterialInstanceConstant m_OverrideMaterial;
var float m_fLifeAfterDeathSeconds;
var int m_nFadeOutSpecialFXId;
var array<name> ActivateSkelControlListOnDeath;
var AkEvent m_TakeHitAkEvent;
var AkEvent m_TakeHeadShotAkEvent;
var Class<TgDamageType> m_LatentDamageType;
var TgCameraShake m_LeftCameraShake;
var TgCameraShake m_RightCameraShake;
var TgCameraShake m_ForwardCameraShake;
var TgCameraShake m_BackwardCameraShake;
var TgCameraShake m_BackwardRightCameraShake;
var TgCameraShake m_BackwardLeftCameraShake;
var TgCameraShake m_ForwardRightCameraShake;
var TgCameraShake m_ForwardLeftCameraShake;

static function name GetRandomDeathFlailAnimName()
{
    local int I;

    I = Rand(default.m_nmDeathFlailAnimNames.Length);
    // End:0x45
    if(I < default.m_nmDeathFlailAnimNames.Length)
    {
        return default.m_nmDeathFlailAnimNames[I];        
    }
    else
    {
        return 'Death_InAirFlail_01';
    }
    //return ReturnValue;    
}

static function name GetRandomDeathAnimName()
{
    local int I;

    I = Rand(default.m_nmDeathAnimNames.Length);
    // End:0x45
    if(I < default.m_nmDeathAnimNames.Length)
    {
        return default.m_nmDeathAnimNames[I];        
    }
    else
    {
        return 'Death_Generic_01';
    }
    //return ReturnValue;    
}

defaultproperties
{
    m_bImpulseMesh=true
    m_bEnableMotors=true
    m_bMinImpulse=300.0000000
    m_bMaxImpulse=400.0000000
    m_bMinUpKick=200.0000000
    m_bMaxUpKick=300.0000000
    m_nmDeathAnimNames[0]="Death_Generic_01"
    m_nmDeathAnimNames[1]="Death_Generic_02"
    m_nmDeathAnimNames[2]="Death_Generic_03"
    m_nmDeathFlailAnimNames[0]="Death_InAirFlail_01"
    m_fMinAngularVelocity=-2.5000000
    m_fMaxAngularVelocity=2.5000000
    m_nDeathSpecialFXId=-1
    ActivateSkelControlListOnDeath[0]="Prop1_SC_Lock"
    ActivateSkelControlListOnDeath[1]="Prop2_SC_Lock"
    m_LatentDamageType=Class'TgGame.TgDamageType_Latent'
    m_LeftCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitLeft'
    m_RightCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitRight'
    m_ForwardCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitForward'
    m_BackwardCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitBackward'
    m_BackwardRightCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitBackwardRight'
    m_BackwardLeftCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitBackwardLeft'
    m_ForwardRightCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitForwardRight'
    m_ForwardLeftCameraShake=TgCameraShake'PC_CommonAssets.CameraShake.CamShake_HitForwardLeft'
    KDamageImpulse=1600.0000000
}