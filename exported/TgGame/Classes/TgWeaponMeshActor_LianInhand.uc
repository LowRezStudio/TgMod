class TgWeaponMeshActor_LianInhand extends TgWeaponMeshActor
    native(ChampPrincess)
    notplaceable
    hidecategories(Navigation);

const GRACE_TRACER_FX_ID = 8105;
const GRACE_TRACER_DURATION = 1.0f;

var TgPawn_Princess m_CachedLian;
var TgBeamHelper c_GraceTracers[15];
var bool c_bTracersVisible;

simulated function bool HasCachedLian()
{
    // End:0x2B
    if(m_CachedLian == none)
    {
        m_CachedLian = TgPawn_Princess(m_OwningPawn);
    }
    return m_CachedLian != none;
    //return ReturnValue;    
}

simulated function ShowGraceTracers()
{
    c_bTracersVisible = true;
    ManageGraceTracers();
    SetTimer(1.0000000, false, 'HideGraceTracers');
    //return;    
}

simulated function HideGraceTracers()
{
    c_bTracersVisible = false;
    ClearGraceTracers();
    ManageGraceTracers();
    //return;    
}

simulated function ClearGraceTracers()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x3C [Loop If]
    if(I < 15)
    {
        ClearGraceTracer(I);
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function ClearGraceTracer(int Index)
{
    // End:0x58
    if(c_GraceTracers[Index] != none)
    {
        c_GraceTracers[Index].Deactivate(true);
        c_GraceTracers[Index] = none;
    }
    //return;    
}

simulated event ManageGraceTracer(int Index)
{
    local TgBeamHelper Beam;

    return;
    // End:0x29D
    if(NotEqual_InterfaceInterface(m_CachedLian.r_GraceTargets[Index], TgCombatActor(none)))
    {
        // End:0x1A3
        if(c_GraceTracers[Index] == none)
        {
            Beam = Class'TgGame.TgBeamHelper'.static.Create(8105);
            Beam.AttachToMesh(((IsFirstPerson()) ? m_WeaponMesh1P : m_CachedLian.Mesh), 'WSO_Emit_01');
            Beam.SetEndPoint(m_CachedLian.r_GraceTargets[Index].GetLocation());
            Beam.Activate();
            Beam.SetVisible(true);
            c_GraceTracers[Index] = Beam;            
        }
        else
        {
            c_GraceTracers[Index].AttachToMesh(((IsFirstPerson()) ? m_WeaponMesh1P : m_CachedLian.Mesh), 'WSO_Emit_01');
            c_GraceTracers[Index].SetEndPoint(m_CachedLian.r_GraceTargets[Index].GetLocation());
            c_GraceTracers[Index].SetVisible(true);
        }
    }
    //return;    
}

simulated event ManageGraceTracers()
{
    local int I;

    // End:0xD4
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0xD4
        if(c_bTracersVisible)
        {
            // End:0xD4
            if(HasCachedLian())
            {
                I = 0;
                J0x4E:

                // End:0xD4 [Loop If]
                if(I < 15)
                {
                    // End:0xB3
                    if(NotEqual_InterfaceInterface(m_CachedLian.r_GraceTargets[I], TgCombatActor(none)))
                    {
                        ManageGraceTracer(I);                        
                    }
                    else
                    {
                        ClearGraceTracer(I);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x4E;
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_LianInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}