class TgCTFVolume extends PhysicsVolume
    hidecategories(Navigation,Object,Movement,Display);

var() int m_nDefenderTeamIndex;

function TimerPop(VolumeTimer T)
{
    local array<TgPawn_Character> TgPawns;
    local TgPawn_Character TgP;
    local int I;

    // End:0x10E
    if(T == PainTimer)
    {
        // End:0x28
        if(!bPainCausing)
        {
            return;
        }
        // End:0x8F
        foreach TouchingActors(Class'TgGame.TgPawn_Character', TgP)
        {
            // End:0x8E
            if((IsValidToucher(TgP)) && TgPawns.Find(TgP) == -1)
            {
                TgPawns.AddItem(TgP);
            }            
        }        
        // End:0x10E
        if(TgPawns.Length > 3)
        {
            TgPawns.Sort(SortByTimestamp);
            I = 3;
            J0xCB:

            // End:0x10E [Loop If]
            if(I < TgPawns.Length)
            {
                CausePainTo(TgPawns[I]);
                I++;
                // [Loop Continue]
                goto J0xCB;
            }
        }
    }
    //return;    
}

function bool IsValidToucher(TgPawn_Character TgP)
{
    return ((TgP.Health > 0) && int(TgP.GetTaskForceNumber()) != m_nDefenderTeamIndex) && TgP.IsHumanControlled();
    //return ReturnValue;    
}

function int SortByTimestamp(TgPawn A, TgPawn B)
{
    return ((A.m_fLastCTFVolumeTimestamp > B.m_fLastCTFVolumeTimestamp) ? -1 : 0);
    //return ReturnValue;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn_Character TgP;

    super.Touch(Other, OtherComp, HitLocation, HitNormal);
    TgP = TgPawn_Character(Other);
    // End:0xAE
    if((TgP != none) && IsValidToucher(TgP))
    {
        TgP.m_fLastCTFVolumeTimestamp = WorldInfo.TimeSeconds;
    }
    //return;    
}

defaultproperties
{
    m_nDefenderTeamIndex=1
    // Reference: BrushComponent'TgGame.Default__TgCTFVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}