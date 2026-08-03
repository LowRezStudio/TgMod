class TgDevice_BombKingInhand extends TgDevice_DualWield
    native(ChampBombKing)
    hidecategories(Navigation);

struct native StickyBombPendingDetonate
{
    var int nProjID;
    var int nDeployID;
    var Vector vExplodeLocation;

    structdefaultproperties
    {
        nProjID=0
        nDeployID=0
        vExplodeLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var bool r_bHasActiveProjectile;
var bool m_bInDetonationMode;
var array<StickyBombPendingDetonate> m_PendingDetonations;
var array<TgProjectile> m_PendingProjectileConversions;
var const float m_fValidationTolerance;
//var delegate<DetonatorFiringDelegate> __DetonatorFiringDelegate__Delegate;

replication
{
    // Pos:0x000
    if(((int(Role) == int(ROLE_Authority)) && bNetDirty) && !bNetInitial)
        r_bHasActiveProjectile;
}

// Export UTgDevice_BombKingInhand::execValidateStickyBombExplosion(FFrame&, void* const)
native function bool ValidateStickyBombExplosion(TgProj_BombKingStickyBomb Proj, TgDeploy_BombKingStickyBomb dep, Vector vExplodeLocation, Vector vVelocity);

simulated function RemovePendingConversion(TgProjectile Proj, int deployID)
{
    local int I, J, K;
    local TgPawn PawnOwner;
    local TgProj_BombKingStickyBomb StickyBombProj;
    local TgRepInfo_Player PRI;
    local TgDeploy_BombKingStickyBomb StickyBombDeployable;

    PawnOwner = TgPawn(Owner);
    // End:0x377
    if(PawnOwner != none)
    {
        I = m_PendingProjectileConversions.Length - 1;
        J0x42:

        // End:0x377 [Loop If]
        if(I >= 0)
        {
            // End:0x85
            if(m_PendingProjectileConversions[I] == none)
            {
                m_PendingProjectileConversions.Remove(I, 1);
                goto J0x369;                
            }
            else
            {
                // End:0x369
                if(m_PendingProjectileConversions[I] == Proj)
                {
                    StickyBombProj = TgProj_BombKingStickyBomb(Proj);
                    J = m_PendingDetonations.Length - 1;
                    J0xD9:

                    // End:0x323 [Loop If]
                    if(J >= 0)
                    {
                        // End:0x315
                        if((StickyBombProj != none) && m_PendingDetonations[J].nProjID == StickyBombProj.m_nClientFireRequestId)
                        {
                            m_PendingDetonations[J].nDeployID = deployID;
                            PRI = PawnOwner.GetPRI();
                            // End:0x315
                            if(PRI != none)
                            {
                                K = 0;
                                J0x1B5:

                                // End:0x315 [Loop If]
                                if(K < PRI.m_DRIArray.Length)
                                {
                                    // End:0x307
                                    if((PRI.m_DRIArray[K].r_DeployableOwner != none) && PRI.m_DRIArray[K].r_DeployableOwner.r_nDeployableId == deployID)
                                    {
                                        StickyBombDeployable = TgDeploy_BombKingStickyBomb(PRI.m_DRIArray[I].r_DeployableOwner);
                                        // End:0x307
                                        if(StickyBombDeployable != none)
                                        {
                                            StickyBombDeployable.c_bSuppressExplosion = true;
                                        }
                                    }
                                    K++;
                                    // [Loop Continue]
                                    goto J0x1B5;
                                }
                            }
                        }
                        J--;
                        // [Loop Continue]
                        goto J0xD9;
                    }
                    // End:0x351
                    if(StickyBombProj != none)
                    {
                        StickyBombProj.SpecialHideProjectile();
                    }
                    m_PendingProjectileConversions.Remove(I, 1);                    
                }
            }
            J0x369:

            I--;
            // [Loop Continue]
            goto J0x42;
        }
    }
    //return;    
}

simulated function ClientProcessBombDetonation(TgProj_BombKingStickyBomb stickyBomb)
{
    local int I;
    local StickyBombPendingDetonate newPendingDetonation;
    local bool bNeedsNewRecord;

    // End:0x2B
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        return;
    }
    // End:0x20D
    if(stickyBomb != none)
    {
        bNeedsNewRecord = true;
        I = m_PendingDetonations.Length - 1;
        J0x5D:

        // End:0xD2 [Loop If]
        if(I >= 0)
        {
            // End:0xC4
            if(m_PendingDetonations[I].nProjID == stickyBomb.m_nClientFireRequestId)
            {
                bNeedsNewRecord = false;
                // [Explicit Break]
                goto J0xD2;
            }
            I--;
            // [Loop Continue]
            goto J0x5D;
        }
        J0xD2:

        // End:0x189
        if(bNeedsNewRecord)
        {
            newPendingDetonation.nProjID = stickyBomb.m_nClientFireRequestId;
            newPendingDetonation.nDeployID = 0;
            newPendingDetonation.vExplodeLocation = stickyBomb.Location;
            m_PendingDetonations.AddItem(newPendingDetonation);
        }
        stickyBomb.AltFireDetonate();
        ServerExplodeAtLocation(stickyBomb.m_nClientFireRequestId, 0, stickyBomb.Location, stickyBomb.Velocity);
    }
    //return;    
}

simulated function ClientTriggerBombDetonation()
{
    local int I;
    local TgPawn PawnOwner;
    local TgRepInfo_Player PRI;
    local TgProj_BombKingStickyBomb StickyBombProj;
    local TgDeploy_BombKingStickyBomb StickyBombDeployable;

    PawnOwner = TgPawn(Owner);
    // End:0x378
    if(PawnOwner != none)
    {
        I = m_FiredProjectiles.Length - 1;
        J0x42:

        // End:0xCD [Loop If]
        if(I >= 0)
        {
            StickyBombProj = TgProj_BombKingStickyBomb(m_FiredProjectiles[I]);
            // End:0xBF
            if((StickyBombProj != none) && !StickyBombProj.m_bSuppressDeployableSpawn)
            {
                ClientProcessBombDetonation(StickyBombProj);
            }
            I--;
            // [Loop Continue]
            goto J0x42;
        }
        I = m_PendingProjectileConversions.Length - 1;
        J0xE4:

        // End:0x184 [Loop If]
        if(I >= 0)
        {
            StickyBombProj = TgProj_BombKingStickyBomb(m_PendingProjectileConversions[I]);
            // End:0x176
            if((StickyBombProj != none) && !StickyBombProj.m_bSuppressDeployableSpawn)
            {
                m_PendingProjectileConversions.Remove(I, 1);
                ClientProcessBombDetonation(StickyBombProj);
            }
            I--;
            // [Loop Continue]
            goto J0xE4;
        }
        UpdateActiveProjectiles();
        PRI = PawnOwner.GetPRI();
        // End:0x378
        if(PRI != none)
        {
            I = 0;
            J0x1D2:

            // End:0x378 [Loop If]
            if(I < PRI.m_DRIArray.Length)
            {
                StickyBombDeployable = TgDeploy_BombKingStickyBomb(PRI.m_DRIArray[I].r_DeployableOwner);
                // End:0x36A
                if(StickyBombDeployable != none)
                {
                    // End:0x36A
                    if(!StickyBombDeployable.m_bInDestroyedState)
                    {
                        ServerExplodeAtLocation(0, PRI.m_DRIArray[I].r_nUniqueDeployableId, StickyBombDeployable.Location, StickyBombDeployable.Velocity);
                        // End:0x36A
                        if(StickyBombDeployable.c_Mesh != none)
                        {
                            StickyBombDeployable.c_Mesh.FxDeactivateGroup('AlwaysOn', 0);
                        }
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x1D2;
            }
        }
    }
    //return;    
}

function ServerTriggerBombDetonation()
{
    local int I, J;
    local TgPawn PawnOwner;
    local TgRepInfo_Player PRI;
    local TgProj_BombKingStickyBomb StickyBombProj;
    local TgDeploy_BombKingStickyBomb StickyBombDep;

    m_bInDetonationMode = true;
    PawnOwner = TgPawn(Owner);
    // End:0x60
    if(PawnOwner != none)
    {
        PRI = PawnOwner.GetPRI();
    }
    I = m_PendingDetonations.Length - 1;
    J0x77:

    // End:0x3DF [Loop If]
    if(I >= 0)
    {
        // End:0x28D
        if((m_PendingDetonations[I].nDeployID > 0) && PRI != none)
        {
            J = 0;
            J0xCE:

            // End:0x28A [Loop If]
            if(J < PRI.m_DRIArray.Length)
            {
                StickyBombDep = TgDeploy_BombKingStickyBomb(PRI.m_DRIArray[J].r_DeployableOwner);
                // End:0x27C
                if(((StickyBombDep != none) && !StickyBombDep.m_bInDestroyedState) && m_PendingDetonations[I].nDeployID == PRI.m_DRIArray[J].r_nUniqueDeployableId)
                {
                    SpecialInstantFire(m_PendingDetonations[I].vExplodeLocation);
                    StickyBombDep.r_bDetonated = true;
                    StickyBombDep.bNetDirty = true;
                    StickyBombDep.DestroyIt();
                }
                J++;
                // [Loop Continue]
                goto J0xCE;
            }            
        }
        else
        {
            // End:0x3BC
            if(m_PendingDetonations[I].nProjID > 0)
            {
                J = m_FiredProjectiles.Length - 1;
                J0x2D0:

                // End:0x3BC [Loop If]
                if(J >= 0)
                {
                    StickyBombProj = TgProj_BombKingStickyBomb(m_FiredProjectiles[J]);
                    // End:0x3AE
                    if((StickyBombProj != none) && StickyBombProj.m_nClientFireRequestId == m_PendingDetonations[I].nProjID)
                    {
                        SpecialInstantFire(m_PendingDetonations[I].vExplodeLocation);
                        StickyBombProj.AltFireDetonate();
                    }
                    J--;
                    // [Loop Continue]
                    goto J0x2D0;
                }
            }
        }
        m_PendingDetonations.Remove(I, 1);
        I--;
        // [Loop Continue]
        goto J0x77;
    }
    UpdateActiveProjectiles();
    //return;    
}

reliable server function ServerExplodeAtLocation(int projID, int deployID, Vector explodeLocation, Vector vVelocity)
{
    local int I, J;
    local TgPawn PawnOwner;
    local TgDevice detonatorDev;
    local TgRepInfo_Player PRI;
    local TgProj_BombKingStickyBomb StickyBombProj;
    local TgDeploy_BombKingStickyBomb StickyBombDeployable;
    local StickyBombPendingDetonate newPendingDetonation;
    local bool bNeedsNewRecord, bFoundProjectileRecord;

    PawnOwner = TgPawn(Owner);
    bFoundProjectileRecord = false;
    // End:0x660
    if((deployID > 0) || projID > 0)
    {
        // End:0x660
        if(PawnOwner != none)
        {
            PRI = PawnOwner.GetPRI();
            // End:0x660
            if(PRI != none)
            {
                I = 0;
                J0x9A:

                // End:0x660 [Loop If]
                if(I < PRI.m_DRIArray.Length)
                {
                    StickyBombDeployable = TgDeploy_BombKingStickyBomb(PRI.m_DRIArray[I].r_DeployableOwner);
                    // End:0x652
                    if((StickyBombDeployable != none) && !StickyBombDeployable.m_bInDestroyedState)
                    {
                        // End:0x37A
                        if(deployID > 0)
                        {
                            // End:0x377
                            if(PRI.m_DRIArray[I].r_nUniqueDeployableId == deployID)
                            {
                                bNeedsNewRecord = true;
                                J = m_PendingDetonations.Length - 1;
                                J0x1C9:

                                // End:0x229 [Loop If]
                                if(J >= 0)
                                {
                                    // End:0x21B
                                    if(m_PendingDetonations[J].nDeployID == deployID)
                                    {
                                        bNeedsNewRecord = false;
                                        // [Explicit Break]
                                        goto J0x229;
                                    }
                                    J--;
                                    // [Loop Continue]
                                    goto J0x1C9;
                                }
                                J0x229:

                                // End:0x377
                                if(bNeedsNewRecord)
                                {
                                    newPendingDetonation.nProjID = 0;
                                    newPendingDetonation.nDeployID = PRI.m_DRIArray[I].r_nUniqueDeployableId;
                                    // End:0x300
                                    if(ValidateStickyBombExplosion(none, StickyBombDeployable, explodeLocation, vVelocity))
                                    {
                                        newPendingDetonation.vExplodeLocation = explodeLocation;                                        
                                    }
                                    else
                                    {
                                        newPendingDetonation.vExplodeLocation = StickyBombDeployable.Location;
                                    }
                                    newPendingDetonation.vExplodeLocation = explodeLocation;
                                    m_PendingDetonations.AddItem(newPendingDetonation);
                                }
                            }                            
                        }
                        else
                        {
                            // End:0x652
                            if(projID > 0)
                            {
                                // End:0x652
                                if(StickyBombDeployable.r_nOriginalProjectileID == projID)
                                {
                                    bFoundProjectileRecord = true;
                                    bNeedsNewRecord = true;
                                    J = m_PendingDetonations.Length - 1;
                                    J0x3E4:

                                    // End:0x522 [Loop If]
                                    if(J >= 0)
                                    {
                                        // End:0x46D
                                        if(m_PendingDetonations[J].nDeployID == PRI.m_DRIArray[I].r_nUniqueDeployableId)
                                        {
                                            bNeedsNewRecord = false;
                                            // [Explicit Break]
                                            goto J0x522;                                            
                                        }
                                        else
                                        {
                                            // End:0x514
                                            if(m_PendingDetonations[J].nProjID == projID)
                                            {
                                                m_PendingDetonations[J].nDeployID = PRI.m_DRIArray[I].r_nUniqueDeployableId;
                                                bNeedsNewRecord = false;
                                                // [Explicit Break]
                                                goto J0x522;
                                            }
                                        }
                                        J--;
                                        // [Loop Continue]
                                        goto J0x3E4;
                                    }
                                    J0x522:

                                    // End:0x652
                                    if(bNeedsNewRecord)
                                    {
                                        newPendingDetonation.nProjID = projID;
                                        newPendingDetonation.nDeployID = PRI.m_DRIArray[I].r_nUniqueDeployableId;
                                        // End:0x601
                                        if(ValidateStickyBombExplosion(none, StickyBombDeployable, explodeLocation, vVelocity))
                                        {
                                            newPendingDetonation.vExplodeLocation = explodeLocation;                                            
                                        }
                                        else
                                        {
                                            newPendingDetonation.vExplodeLocation = StickyBombDeployable.Location;
                                        }
                                        m_PendingDetonations.AddItem(newPendingDetonation);
                                    }
                                }
                            }
                        }
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x9A;
                }
            }
        }
    }
    // End:0x8A6
    if((projID > 0) && !bFoundProjectileRecord)
    {
        I = m_FiredProjectiles.Length - 1;
        J0x697:

        // End:0x8A6 [Loop If]
        if(I >= 0)
        {
            StickyBombProj = TgProj_BombKingStickyBomb(m_FiredProjectiles[I]);
            // End:0x898
            if((StickyBombProj != none) && StickyBombProj.m_nClientFireRequestId == projID)
            {
                bNeedsNewRecord = true;
                J = m_PendingDetonations.Length - 1;
                J0x72C:

                // End:0x798 [Loop If]
                if(J >= 0)
                {
                    // End:0x78A
                    if(m_PendingDetonations[J].nProjID == projID)
                    {
                        bNeedsNewRecord = false;
                        bFoundProjectileRecord = true;
                        // [Explicit Break]
                        goto J0x798;
                    }
                    J--;
                    // [Loop Continue]
                    goto J0x72C;
                }
                J0x798:

                // End:0x898
                if(bNeedsNewRecord)
                {
                    newPendingDetonation.nProjID = projID;
                    newPendingDetonation.nDeployID = 0;
                    // End:0x83B
                    if(ValidateStickyBombExplosion(StickyBombProj, none, explodeLocation, vVelocity))
                    {
                        newPendingDetonation.vExplodeLocation = explodeLocation;                        
                    }
                    else
                    {
                        newPendingDetonation.vExplodeLocation = StickyBombProj.Location;
                    }
                    m_PendingDetonations.AddItem(newPendingDetonation);
                    bFoundProjectileRecord = true;
                }
            }
            I--;
            // [Loop Continue]
            goto J0x697;
        }
    }
    // End:0x92C
    if(PawnOwner != none)
    {
        detonatorDev = PawnOwner.GetDeviceByEqPoint(16);
        // End:0x92C
        if(m_bInDetonationMode || (detonatorDev != none) && detonatorDev.IsFiring())
        {
            ServerTriggerBombDetonation();
        }
    }
    //return;    
}

simulated event SpecialInstantFire(Vector explodeLocation)
{
    local AimData Aim;
    local TgDeviceFire currDevFire;
    local TgRepInfo_Game GRI;
    local int I;

    PendingImpactList.Length = 0;
    Aim.StartTrace = explodeLocation;
    Aim.EndTrace = explodeLocation;
    currDevFire = m_FireMode[1];
    // End:0x132
    if(currDevFire != none)
    {
        GRI = TgRepInfo_Game(WorldInfo.GRI);        
        currDevFire.CalcWeaponModeFire(Instigator, Aim, PendingImpactList, false, ((GRI != none) && GRI.r_bUseInstantFireMeshTrace) && m_bDoNotAllowHeadShots);
    }
    I = 0;
    J0x13D:

    // End:0x1CA [Loop If]
    if(I < PendingImpactList.Length)
    {
        // End:0x1BC
        if(PendingImpactList[I].HitActor != none)
        {
            currDevFire.ApplyHit(PendingImpactList[I], Instigator);
        }
        I++;
        // [Loop Continue]
        goto J0x13D;
    }
    UpdateIndex();
    //return;    
}

reliable client simulated function ClientRestoreBombs()
{
    local TgPawn PawnOwner;
    local TgRepInfo_Player PRI;
    local TgProj_BombKingStickyBomb StickyBombProj;
    local TgDeploy_BombKingStickyBomb StickyBombDeployable;
    local int I, J;

    // End:0x461
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        I = m_PendingDetonations.Length - 1;
        J0x40:

        // End:0x461 [Loop If]
        if(I >= 0)
        {
            J = m_FiredProjectiles.Length - 1;
            J0x66:

            // End:0x1D4 [Loop If]
            if(J >= 0)
            {
                StickyBombProj = TgProj_BombKingStickyBomb(m_FiredProjectiles[J]);
                // End:0x1C6
                if(((StickyBombProj != none) && !StickyBombProj.m_bIsShutDown) && StickyBombProj.m_nClientFireRequestId == m_PendingDetonations[I].nProjID)
                {
                    // End:0x1C6
                    if((StickyBombProj.c_Mesh != none) && StickyBombProj.m_bSuppressDeployableSpawn)
                    {
                        StickyBombProj.m_bSuppressDeployableSpawn = false;
                        StickyBombProj.c_Mesh.FxActivateGroup('AlwaysOn', 0);
                    }
                }
                J--;
                // [Loop Continue]
                goto J0x66;
            }
            PawnOwner = TgPawn(Owner);
            // End:0x43E
            if(PawnOwner != none)
            {
                PRI = PawnOwner.GetPRI();
                // End:0x43E
                if(PRI != none)
                {
                    J = 0;
                    J0x242:

                    // End:0x43E [Loop If]
                    if(J < PRI.m_DRIArray.Length)
                    {
                        StickyBombDeployable = TgDeploy_BombKingStickyBomb(PRI.m_DRIArray[J].r_DeployableOwner);
                        // End:0x430
                        if(((StickyBombDeployable != none) && !StickyBombDeployable.m_bInDestroyedState) && StickyBombDeployable.c_Mesh != none)
                        {
                            // End:0x430
                            if((PRI.m_DRIArray[J].r_nUniqueDeployableId == m_PendingDetonations[I].nDeployID) || StickyBombDeployable.r_nOriginalProjectileID == m_PendingDetonations[I].nProjID)
                            {
                                StickyBombDeployable.c_bSuppressExplosion = false;
                                StickyBombDeployable.c_Mesh.FxActivateGroup('AlwaysOn', 0);
                            }
                        }
                        J++;
                        // [Loop Continue]
                        goto J0x242;
                    }
                }
            }
            m_PendingDetonations.Remove(I, 1);
            I--;
            // [Loop Continue]
            goto J0x40;
        }
    }
    //return;    
}

function ServerRestoreBombs()
{
    ClientRestoreBombs();
    J0x0A:

    // End:0x2A [Loop If]
    if(m_PendingDetonations.Length > 0)
    {
        m_PendingDetonations.Remove(0, 1);
        // [Loop Continue]
        goto J0x0A;
    }
    m_bInDetonationMode = false;
    //return;    
}

simulated function AddProjectileWaitingForDeployable(TgProj_BombKingStickyBomb stickyBomb)
{
    // End:0x96
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        // End:0x96
        if(((stickyBomb != none) && !stickyBomb.c_bReadyToHide) && m_PendingProjectileConversions.Find(stickyBomb) == -1)
        {
            m_PendingProjectileConversions.AddItem(stickyBomb);
        }
    }
    //return;    
}

simulated function UpdateActiveProjectiles(optional TgProjectile Proj)
{
    local int I, J;
    local TgProj_BombKingStickyBomb stickyBomb;

    m_FiredProjectiles.AddItem(Proj);
    I = 0;
    J0x22:

    // End:0x220 [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        // End:0x212
        if((((m_FiredProjectiles[I] == none) || m_FiredProjectiles[I].m_bHasExploded) || m_FiredProjectiles[I].bDeleteMe) || m_FiredProjectiles[I].m_bIsShutDown)
        {
            // End:0x1FB
            if(int(WorldInfo.NetMode) == int(NM_Client))
            {
                stickyBomb = TgProj_BombKingStickyBomb(m_FiredProjectiles[I]);
                // End:0x1FB
                if(stickyBomb != none)
                {
                    J = m_PendingDetonations.Length - 1;
                    J0x152:

                    // End:0x1FB [Loop If]
                    if(J >= 0)
                    {
                        // End:0x1ED
                        if((m_PendingDetonations[J].nDeployID == 0) && stickyBomb.m_nClientFireRequestId == m_PendingDetonations[J].nProjID)
                        {
                            m_PendingDetonations.Remove(J, 1);
                        }
                        J--;
                        // [Loop Continue]
                        goto J0x152;
                    }
                }
            }
            m_FiredProjectiles.Remove(I--, 1);
        }
        I++;
        // [Loop Continue]
        goto J0x22;
    }
    // End:0x25A
    if(m_FiredProjectiles.Length > 0)
    {
        // End:0x257
        if(!r_bHasActiveProjectile)
        {
            r_bHasActiveProjectile = true;
            bNetDirty = true;
        }        
    }
    else
    {
        // End:0x27F
        if(r_bHasActiveProjectile)
        {
            r_bHasActiveProjectile = false;
            bNetDirty = true;
        }
    }
    //return;    
}

simulated delegate DetonatorFiringDelegate()
{
    // End:0x36
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        ClientTriggerBombDetonation();        
    }
    else
    {
        // End:0x6C
        if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
        {
            ServerTriggerBombDetonation();            
        }
        else
        {
            m_bInDetonationMode = true;
            ClientTriggerBombDetonation();
        }
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x89
        case 14309:
            Dev.RegisterDelegate(2, DetonatorFiringDelegate);
            // End:0x8C
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceUnequipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x89
        case 14309:
            Dev.UnregisterDelegate(2, DetonatorFiringDelegate);
            // End:0x8C
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        m_bInDetonationMode = false;
        super.StartFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fValidationTolerance=48.0000000
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-9.0000000,Z=-10.0000000)
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_bUseDeviceMeshWhenTargeting=true
    m_bPlayPutAway=true
    m_bLogServerFireFailures=true
    m_fWeaponBob=0.0000000
    m_fMeshFOV=65.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_BombKingInhand'
    m_nLinkedDeviceIDs[0]=14309
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_BombKing.DeviceStickyBomb'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.BasicForceFeedback'
}