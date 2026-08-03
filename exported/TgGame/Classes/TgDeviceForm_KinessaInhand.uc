class TgDeviceForm_KinessaInhand extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPawn_Kinessa Kinessa;

    // End:0x629
    if(PawnOwner != none)
    {
        // End:0x629
        if(PawnOwner.m_WeaponMesh != none)
        {
            // End:0x629
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                // End:0x355
                if(nFireMode == 1)
                {
                    Kinessa = TgPawn_Kinessa(PawnOwner);
                    // End:0x352
                    if(Kinessa != none)
                    {
                        // End:0x210
                        if(Kinessa.c_bHeadHunterFiring)
                        {
                            Kinessa.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('KinessaFireMode2_B');
                            Kinessa.m_WeaponMesh.m_TracerName = 'TracerBeamD';
                            Kinessa.m_WeaponMesh.m_HitTargetName = 'ProjectileExplosionHitTarget_B';
                            Kinessa.m_WeaponMesh.m_HitWallName = 'ProjectileExplosionHitWall_B';
                            Kinessa.m_WeaponMesh.m_fTracerLifetime = 2.0000000;                            
                        }
                        else
                        {
                            Kinessa.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('KinessaFireMode2');
                            Kinessa.m_WeaponMesh.m_TracerName = 'TracerBeamB';
                            Kinessa.m_WeaponMesh.m_HitTargetName = 'ProjectileExplosionHitTarget';
                            Kinessa.m_WeaponMesh.m_HitWallName = 'ProjectileExplosionHitWall';
                            Kinessa.m_WeaponMesh.m_fTracerLifetime = 2.0000000;
                        }
                    }                    
                }
                else
                {
                    Kinessa = TgPawn_Kinessa(PawnOwner);
                    // End:0x629
                    if(Kinessa != none)
                    {
                        // End:0x4E7
                        if(Kinessa.c_bHeadHunterFiring)
                        {
                            Kinessa.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('KinessaFireMode1_B');
                            Kinessa.m_WeaponMesh.m_TracerName = 'TracerBeamC';
                            Kinessa.m_WeaponMesh.m_HitTargetName = 'ProjectileExplosionHitTarget_B';
                            Kinessa.m_WeaponMesh.m_HitWallName = 'ProjectileExplosionHitWall_B';
                            Kinessa.m_WeaponMesh.m_fTracerLifetime = 2.0000000;                            
                        }
                        else
                        {
                            Kinessa.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('KinessaFireMode1');
                            Kinessa.m_WeaponMesh.m_TracerName = 'TracerBeamA';
                            Kinessa.m_WeaponMesh.m_HitTargetName = 'ProjectileExplosionHitTarget';
                            Kinessa.m_WeaponMesh.m_HitWallName = 'ProjectileExplosionHitWall';
                            Kinessa.m_WeaponMesh.m_fTracerLifetime = 2.0000000;
                        }
                    }
                }
            }
        }
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    // End:0x132
    if(PawnOwner != none)
    {
        // End:0x132
        if(PawnOwner.m_WeaponMesh != none)
        {
            // End:0x132
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                // End:0xE0
                if(nFireMode == 1)
                {
                    PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('KinessaFireMode2');                    
                }
                else
                {
                    PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('KinessaFireMode1');
                }
            }
        }
    }
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}
