class TgWeaponMeshActor_LexInhand extends TgWeaponMeshActor
    native(ChampLex)
    notplaceable
    hidecategories(Navigation);

const MAX_THE_LAW_TARGETS = 5;
const THE_LAW_TARGETTING_BEAM_FX_ID = 7680;
const THE_LAW_TARGETTING_BEAM_EXECUTE_FX_ID = 7834;
const THE_LAW_HIT_BEAM_FX_ID = 7703;

enum EBeamState
{
    EBS_Hidden,                     // 0
    EBS_Targeting,                  // 1
    EBS_Hitting,                    // 2
    EBS_MAX                         // 3
};

var TgPawn_Lex m_CachedLex;
var TgBeamHelper c_Beams[5];
var TgBeamHelper c_ExecutableBeams[5];
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes1P;
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes3P;
var name c_LeftInHandSocket;
var name c_RightInHandSocket;
var bool c_bJustRenderedBeamsForUlt;
var TgWeaponMeshActor_LexInhand.EBeamState c_eBeamState;

simulated function bool HasCachedLex()
{
    // End:0x2B
    if(m_CachedLex == none)
    {
        m_CachedLex = TgPawn_Lex(m_OwningPawn);
    }
    return m_CachedLex != none;
    //return ReturnValue;    
}

simulated function ShowTargetingBeams()
{
    c_eBeamState = 1;
    ManageBeams();
    //return;    
}

simulated function ShowHitBeams()
{
    c_eBeamState = 2;
    ClearBeams();
    ManageBeams();
    //return;    
}

simulated function HideBeams()
{
    c_eBeamState = 0;
    ClearBeams();
    ManageBeams();
    //return;    
}

simulated function ClearBeams()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x3C [Loop If]
    if(I < 5)
    {
        ClearBeam(I);
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function ClearBeam(int Index)
{
    ClearNonExecutableBeam(Index);
    ClearExecutableBeam(Index);
    //return;    
}

simulated function ClearNonExecutableBeam(int Index)
{
    // End:0x58
    if(c_Beams[Index] != none)
    {
        c_Beams[Index].Deactivate(true);
        c_Beams[Index] = none;
    }
    //return;    
}

simulated function ClearExecutableBeam(int Index)
{
    // End:0x58
    if(c_ExecutableBeams[Index] != none)
    {
        c_ExecutableBeams[Index].Deactivate(true);
        c_ExecutableBeams[Index] = none;
    }
    //return;    
}

simulated function ManageBeamNonExecutable(int Index)
{
    local TgBeamHelper Beam;

    ClearExecutableBeam(Index);
    // End:0x1CD
    if(c_Beams[Index] == none)
    {
        Beam = Class'TgGame.TgBeamHelper'.static.Create(((int(c_eBeamState) == int(2)) ? GetFxOverrideFor(7703) : GetFxOverrideFor(7680)));
        Beam.AttachToMesh(((IsFirstPerson()) ? m_WeaponMesh1P : m_CachedLex.Mesh), 'WSO_Emit_05');
        Beam.AttachToTarget(m_CachedLex.r_Targets[Index]);
        Beam.Activate();
        Beam.SetVisible(true);
        Beam.EnableTangents();
        Beam.m_bRequiresTarget = true;
        c_Beams[Index] = Beam;        
    }
    else
    {
        c_Beams[Index].AttachToMesh(((IsFirstPerson()) ? m_WeaponMesh1P : m_CachedLex.Mesh), 'WSO_Emit_05');
        c_Beams[Index].AttachToTarget(m_CachedLex.r_Targets[Index]);
        c_Beams[Index].SetVisible(true);
    }
    //return;    
}

simulated function ManageBeamExecutable(int Index)
{
    local TgBeamHelper Beam;

    ClearNonExecutableBeam(Index);
    // End:0x1CD
    if(c_ExecutableBeams[Index] == none)
    {
        Beam = Class'TgGame.TgBeamHelper'.static.Create(((int(c_eBeamState) == int(2)) ? GetFxOverrideFor(7703) : GetFxOverrideFor(7834)));
        Beam.AttachToMesh(((IsFirstPerson()) ? m_WeaponMesh1P : m_CachedLex.Mesh), 'WSO_Emit_05');
        Beam.AttachToTarget(m_CachedLex.r_Targets[Index]);
        Beam.Activate();
        Beam.SetVisible(true);
        Beam.EnableTangents();
        Beam.m_bRequiresTarget = true;
        c_ExecutableBeams[Index] = Beam;        
    }
    else
    {
        c_ExecutableBeams[Index].AttachToMesh(((IsFirstPerson()) ? m_WeaponMesh1P : m_CachedLex.Mesh), 'WSO_Emit_05');
        c_ExecutableBeams[Index].AttachToTarget(m_CachedLex.r_Targets[Index]);
        c_ExecutableBeams[Index].SetVisible(true);
    }
    //return;    
}

simulated event ManageBeams()
{
    local int I;
    local float fTargetHealthPercent;

    // End:0x17E
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x17E
        if(int(c_eBeamState) != int(0))
        {
            // End:0x17E
            if(HasCachedLex())
            {
                I = 0;
                J0x55:

                // End:0x17E [Loop If]
                if(I < 5)
                {
                    // End:0x15D
                    if(m_CachedLex.r_Targets[I] != none)
                    {
                        fTargetHealthPercent = m_CachedLex.r_Targets[I].GetHealthPercent();
                        // End:0x147
                        if((fTargetHealthPercent < 65.0000000) && m_CachedLex.r_Targets[I].CanBeExecuted())
                        {
                            ManageBeamExecutable(I);                            
                        }
                        else
                        {
                            ManageBeamNonExecutable(I);
                        }                        
                    }
                    else
                    {
                        ClearBeam(I);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x55;
                }
            }
        }
    }
    //return;    
}

simulated function OverrideTracerFireLoc(out Vector fireLoc)
{
    local TgPawn_Lex pLex;
    local Rotator FireRot;

    pLex = TgPawn_Lex(Owner);
    // End:0x171
    if(pLex != none)
    {
        // End:0xD6
        if(IsFirstPerson())
        {
            // End:0x98
            if(pLex.m_bFireLeftWeapon)
            {
                m_WeaponMesh1P.GetSocketWorldLocationAndRotation(c_LeftInHandSocket, fireLoc, FireRot);                
            }
            else
            {
                m_WeaponMesh1P.GetSocketWorldLocationAndRotation(c_RightInHandSocket, fireLoc, FireRot);
            }            
        }
        else
        {
            // End:0x136
            if(pLex.m_bFireLeftWeapon)
            {
                m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_LeftInHandSocket, fireLoc, FireRot);                
            }
            else
            {
                m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_RightInHandSocket, fireLoc, FireRot);
            }
        }
    }
    //return;    
}

defaultproperties
{
    c_LeftInHandSocket="WSO_Emit_01"
    c_RightInHandSocket="WSO_Emit_02"
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_LexInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}