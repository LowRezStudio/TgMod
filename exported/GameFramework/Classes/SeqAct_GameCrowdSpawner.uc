class SeqAct_GameCrowdSpawner extends SeqAct_GameCrowdPopulationManagerToggle
    abstract
    native
    hidecategories(Object);

static event int GetObjClassVersion()
{
    return super.GetObjClassVersion() + 5;
    //return ReturnValue;    
}

defaultproperties
{
    bFillPotentialSpawnPoints=true
    bIndividualSpawner=true
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_ObjectList',LinkedVariables=none,LinkDesc="Spawned List",LinkVar="None",PropertyName="LastSpawnedList",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Spawn Points",LinkVar="None",PropertyName="PotentialSpawnPoints",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Game Scripted Crowd Spawner"
}