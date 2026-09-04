class TgGame_Paladins_Halloween2017 extends TgGame_Paladins_Siege
    config(Game)
    hidecategories(Navigation,Movement,Collision);

event AllPlayersReady()
{
    super(TgGame_PaladinsExtended).AllPlayersReady();
    UpdateSilhouetteRendering();
    SetTimer(1.0000000, true, 'UpdateSilhouetteRendering');
    //return;    
}

function UpdateSilhouetteRendering()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;
    local array<TgRepInfo_Player> TF1PRIs, TF2PRIs;
    local TgRepInfo_Player PRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x1A6
    if(GRI != none)
    {
        Taskforce = GRI.GetTaskForce(1);
        // End:0xE8
        if(Taskforce != none)
        {
            Taskforce.GetPlayers(TF1PRIs);
            // End:0xE7
            foreach TF1PRIs(PRI)
            {
                PRI.r_bSilhouettesBlocked = true;
                PRI.r_bExtendedSilhouetteRange = false;                
            }            
        }
        Taskforce = GRI.GetTaskForce(2);
        // End:0x1A6
        if(Taskforce != none)
        {
            Taskforce.GetPlayers(TF2PRIs);
            // End:0x1A5
            foreach TF2PRIs(PRI)
            {
                PRI.r_bSilhouettesBlocked = false;
                PRI.r_bExtendedSilhouetteRange = true;                
            }            
        }
    }
    //return;    
}
