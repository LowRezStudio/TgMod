class TgAISquad_Monster extends TgAISquad
    native(AI)
    config(Engine);

native function DropTarget(Actor TargetToDrop);  // Export UTgAISquad_Monster::execDropTarget(FFrame&, void* const)
