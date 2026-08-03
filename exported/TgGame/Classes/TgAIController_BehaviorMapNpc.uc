class TgAIController_BehaviorMapNpc extends TgAIController_Behavior
    native(AI)
    config(Game)
    hidecategories(Navigation);

struct native ThreatEntry
{
    var TgPawn attacker;
    var float ThreatLevel;

    structdefaultproperties
    {
        attacker=none
        ThreatLevel=0.0000000
    }
};

var init transient array<init ThreatEntry> ThreatList;
var transient bool bThreatListDecays;
var transient bool bOutsideLeash;
var transient bool bHadCombatTarget;
var transient float LeashDistance;
var transient Volume LeashVolume;
var init transient array<init TgPawn> LeashActors;

// Export UTgAIController_BehaviorMapNpc::execAddThreat(FFrame&, void* const)
native function AddThreat(TgPawn attacker, float ThreatLevel);

// Export UTgAIController_BehaviorMapNpc::execClearThreatList(FFrame&, void* const)
native function ClearThreatList();

// Export UTgAIController_BehaviorMapNpc::execCanSpreadOut(FFrame&, void* const)
native function bool CanSpreadOut();

// Export UTgAIController_BehaviorMapNpc::execEvade(FFrame&, void* const)
native function Evade();

// Export UTgAIController_BehaviorMapNpc::execSquadEvade(FFrame&, void* const)
native function SquadEvade();

// Export UTgAIController_BehaviorMapNpc::execSquadTargetChanged(FFrame&, void* const)
native function SquadTargetChanged();

function NotifyKilledBy(Controller Killer)
{
    local TgPawn KillerPawn;

    // End:0x113
    if((Killer != none) && m_Squad != none)
    {
        m_Squad.MemberKilledBy(Killer);
        KillerPawn = TgPawn(Killer.Pawn);
        // End:0x113
        if(KillerPawn != none)
        {
            m_Squad.SuggestTarget(KillerPawn, self);
            // End:0x113
            if(KillerPawn.r_Owner != none)
            {
                m_Squad.SuggestTarget(KillerPawn.r_Owner, self);
            }
        }
    }
    super(TgAIController).NotifyKilledBy(Killer);
    //return;    
}

defaultproperties
{
    bThreatListDecays=true
    LeashDistance=2048.0000000
    BlackboardType=2
    ObstacleAvoidanceGridPointSize=16.0000000
    ObstacleAvoidanceGridExtents=768.0000000
}