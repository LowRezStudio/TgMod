class TgSplineActor_Payload extends TgSplineActor
    hidecategories(Navigation);

var bool m_bReached;
var(Payload) float m_fSecondsToAdd;

simulated event OnSplineActorReached(TgPawn_LanePusherBase Payload)
{
    local TgGame_PaladinsExtended Gamemode;

    super.OnSplineActorReached(Payload);
    // End:0xE2
    if(!m_bReached)
    {
        m_bReached = true;
        // End:0xE2
        if(((int(m_ActionPoint) == int(4)) || int(m_ActionPoint) == int(5)) || int(m_ActionPoint) == int(7))
        {
            // End:0xE2
            if(int(Role) == int(ROLE_Authority))
            {
                Gamemode = TgGame_PaladinsExtended(WorldInfo.Game);
                // End:0xE2
                if(Gamemode != none)
                {
                    Gamemode.PayloadCheckpointReached(self);
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_fSecondsToAdd=120.0000000
}