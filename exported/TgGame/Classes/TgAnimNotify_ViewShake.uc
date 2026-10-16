class TgAnimNotify_ViewShake extends AnimNotify_ViewShake
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var private editconst float m_fShakeRadius;
var private editconst float m_fDuration;
var private editconst float m_fAmplitude;
var() bool m_bUseLocationRadiusBasedShake;

simulated function Clear1pCameraAnim()
{
    local TgPlayerController LocalTgPC;

    LocalTgPC = Class'TgGame.TgObject'.static.ScriptGetLocalTGPlayerController();
    // End:0x60
    if(LocalTgPC != none)
    {
        LocalTgPC.ClientStopCameraShake(ShakeParams);
    }
    //return;    
}

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator)
{
    local TgWeaponMeshActor WeaponMesh;
    local TgPlayerController localPC;
    local TgPawn LocalTgP;
    local float fOldPlayRate;
    local bool bIsFirstPerson;

    // End:0x238
    if(!m_bUseLocationRadiusBasedShake)
    {
        WeaponMesh = TgWeaponMeshActor(Owner);
        // End:0x8C
        if(WeaponMesh != none)
        {
            bIsFirstPerson = WeaponMesh.IsFirstPerson();
            Owner = WeaponMesh.Owner;
        }
        // End:0x235
        if((Owner != none) && (WeaponMesh == none) || bIsFirstPerson)
        {
            localPC = TgPlayerController(Owner.GetALocalPlayerController());
            // End:0x235
            if(localPC != none)
            {
                LocalTgP = localPC.GetTgPawn();
                // End:0x235
                if(LocalTgP == Owner)
                {
                    fOldPlayRate = ShakeParams.AnimPlayRate;
                    ShakeParams.AnimPlayRate *= AnimSeqInstigator.Rate;
                    localPC.ClientPlayCameraShake(ShakeParams);
                    ShakeParams.AnimPlayRate = fOldPlayRate;
                    // End:0x233
                    if(bIsFirstPerson)
                    {
                        LocalTgP.RegisterFor3pTransitionCB(Clear1pCameraAnim);
                    }
                    return;
                }
            }
        }        
    }
    else
    {
        super.Notify(Owner, AnimSeqInstigator);
    }
    //return;    
}

defaultproperties
{
    m_fShakeRadius=4096.0000000
    m_fDuration=1.0000000
    Duration=0.0000000
    LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    ShakeRadius=0.0000000
}