class TgChaosCapturePoint_ParticleStorm extends TgChaosCapturePoint
    native(Game)
    placeable
    hidecategories(Navigation);

var(ParticleStorm) Emitter m_FrontEffect;
var(ParticleStorm) Emitter m_SwirlEffect;
var(Survival) float m_fFogStartDistance;
var(Survival) float m_fFogConvergeSpeed;
var(Survival) float m_fSecondsBeforeFogConverge;
var(Survival) float m_fFogMapDistance;
var(Survival) float m_fFogRadiusRatio;
var(Survival) float m_fFogAlphaRatio;
var(SurvivalAudio) AkAmbientSound m_2DSoundActor;
var(SurvivalAudio) int m_nNumMobileSoundActors;
var array<TgMobileAmbientSound> m_MobileSoundActors;
var(SurvivalAudio) AkEvent m_MobileSoundActorAkEvent;
var(SurvivalAudio) AkEvent m_MobileSoundActorAkEvent_Alt;
var array<Vector> m_vPerimeterAnchors;
var float m_fTargetStartDistance;
var float m_fPreviousStartDistance;
var float m_fFogUpdateTimestamp;
var float m_fSoundActorConvergeLimit;

simulated event SetInitialState()
{
    local TgMobileAmbientSound SoundActor;
    local int I;

    // End:0x1F9
    if((int(Role) != int(ROLE_Authority)) && m_MobileSoundActors.Length == 0)
    {
        I = 0;
        J0x31:

        // End:0x1F9 [Loop If]
        if(I < m_nNumMobileSoundActors)
        {
            m_vPerimeterAnchors.AddItem(vect(0.0000000, 0.0000000, 0.0000000));
            m_vPerimeterAnchors[I].X = Sin(((float(I) / float(m_nNumMobileSoundActors)) * float(2)) * 3.1415930);
            m_vPerimeterAnchors[I].Y = Cos(((float(I) / float(m_nNumMobileSoundActors)) * float(2)) * 3.1415930);
            m_vPerimeterAnchors[I] *= m_fFogStartDistance;
            m_vPerimeterAnchors[I] += Location;
            SoundActor = Spawn(Class'TgGame.TgMobileAmbientSound',,, m_vPerimeterAnchors[I]);
            // End:0x1AD
            if((I % 2) == 0)
            {
                SoundActor.PlayEvent = m_MobileSoundActorAkEvent;                
            }
            else
            {
                SoundActor.PlayEvent = m_MobileSoundActorAkEvent_Alt;
            }
            m_MobileSoundActors.AddItem(SoundActor);
            I++;
            // [Loop Continue]
            goto J0x31;
        }
    }
    //return;    
}

simulated event Tick(float DeltaTime)
{
    local TgRepInfo_Game GRI;
    local float fFogDist;
    local Vector vParam;
    local TgMobileAmbientSound SoundActor;
    local int I;

    super.Tick(DeltaTime);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x505
    if(GRI != none)
    {
        // End:0xE2
        if(m_fTargetStartDistance != GRI.r_fConvergeDistance)
        {
            m_fPreviousStartDistance = m_fTargetStartDistance;
            m_fTargetStartDistance = GRI.r_fConvergeDistance;
            m_fFogUpdateTimestamp = WorldInfo.TimeSeconds;
        }
        fFogDist = Lerp(m_fPreviousStartDistance, m_fTargetStartDistance, FClamp((WorldInfo.TimeSeconds - m_fFogUpdateTimestamp) / GRI.r_fFogConvergeInterval, 0.0000000, 1.0000000));
        vParam = vect(0.0000000, 0.0000000, 1.0000000);
        vParam.X = fFogDist * m_fFogRadiusRatio;
        vParam.Y = fFogDist * m_fFogRadiusRatio;
        // End:0x226
        if(m_SwirlEffect != none)
        {
            m_SwirlEffect.SetFloatParameter('Alpha', (1.0000000 - (fFogDist * m_fFogAlphaRatio)) ** float(2));
        }
        // End:0x2AF
        if(m_FrontEffect != none)
        {
            m_FrontEffect.SetFloatParameter('Alpha', (1.0000000 - (fFogDist * m_fFogAlphaRatio)) * float(2));
            m_FrontEffect.SetVectorParameter('Radius', vParam);
        }
        // End:0x307
        if(m_2DSoundActor != none)
        {
            m_2DSoundActor.SetRTPCValue('ENV_FogProgress', 100.0000000 - ((fFogDist / m_fFogStartDistance) * float(100)));
        }
        // End:0x42C
        if(GRI.r_bRoundEnding)
        {
            m_fTargetStartDistance = m_fFogStartDistance;
            m_fPreviousStartDistance = m_fFogStartDistance;
            I = 0;
            J0x35A:

            // End:0x429 [Loop If]
            if(I < m_MobileSoundActors.Length)
            {
                SoundActor = m_MobileSoundActors[I];
                // End:0x41B
                if(((SoundActor != none) && I < m_vPerimeterAnchors.Length) && SoundActor.Location != m_vPerimeterAnchors[I])
                {
                    SoundActor.SetLocation(m_vPerimeterAnchors[I]);
                }
                I++;
                // [Loop Continue]
                goto J0x35A;
            }            
        }
        else
        {
            I = 0;
            J0x437:

            // End:0x505 [Loop If]
            if(I < m_MobileSoundActors.Length)
            {
                SoundActor = m_MobileSoundActors[I];
                // End:0x4F7
                if((SoundActor != none) && fFogDist > m_fSoundActorConvergeLimit)
                {
                    SoundActor.Move((Normal(m_vPerimeterAnchors[I] - Location) * fFogDist) - SoundActor.Location);
                }
                I++;
                // [Loop Continue]
                goto J0x437;
            }
        }
    }
    //return;    
}

function ResetFog()
{
    local TgRepInfo_Game GRI;
    local Vector vParam;

    vParam = vect(0.0000000, 0.0000000, 1.0000000);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xA0
    if(GRI != none)
    {
        GRI.r_fConvergeDistance = m_fFogStartDistance;
        GRI.r_bFogEnded = false;
    }
    // End:0x142
    if(m_FrontEffect != none)
    {
        vParam.X = m_fFogStartDistance * m_fFogRadiusRatio;
        vParam.Y = m_fFogStartDistance * m_fFogRadiusRatio;
        m_FrontEffect.SetVectorParameter('Radius', vParam);
    }
    // End:0x17E
    if(m_SwirlEffect != none)
    {
        m_SwirlEffect.SetFloatParameter('Alpha', 0.0000000);
    }
    m_fTargetStartDistance = m_fFogStartDistance;
    m_fPreviousStartDistance = m_fFogStartDistance;
    // End:0x1E0
    if(m_2DSoundActor != none)
    {
        m_2DSoundActor.SetRTPCValue('ENV_FogProgress', 0.0000000);
    }
    //return;    
}

defaultproperties
{
    m_fFogStartDistance=10000.0000000
    m_fFogConvergeSpeed=200.0000000
    m_fSecondsBeforeFogConverge=10.0000000
    m_fFogMapDistance=7000.0000000
    m_fFogRadiusRatio=0.0640000
    m_fFogAlphaRatio=0.0001280
    m_nNumMobileSoundActors=8
    m_fSoundActorConvergeLimit=400.0000000
    Components[0]=none
    Components[1]=none
    // Reference: CylinderComponent'TgGame.Default__TgChaosCapturePoint_ParticleStorm.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgChaosCapturePoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    Components[2]=CollisionCylinder
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgChaosCapturePoint_ParticleStorm.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgChaosCapturePoint.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    Components[3]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}