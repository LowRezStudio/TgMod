class TgSeqAct_SpawnProjectile extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

var() Class<Projectile> ProjectileClass;

event Activated()
{
    local Controller InstigatorController;
    local Vector SpawnLoc, TargetLoc;
    local Projectile Proj;

    // End:0x11A
    if(VariableLinks[2].LinkedVariables.Length > 0)
    {
        InstigatorController = Controller(SeqVar_Object(VariableLinks[2].LinkedVariables[0]).GetObjectValue());
        // End:0x11A
        if((InstigatorController == none) && SeqVar_Object(VariableLinks[2].LinkedVariables[0]).GetObjectValue() != none)
        {
            ScriptLog(("WARNING: Instigator specified for" @ string(self)) @ "is not a Controller");
        }
    }
    SpawnLoc = SeqVar_Vector(VariableLinks[0].LinkedVariables[0]).VectValue;
    TargetLoc = SeqVar_Vector(VariableLinks[1].LinkedVariables[0]).VectValue;
    Proj = GetWorldInfo().Spawn(ProjectileClass,,, SpawnLoc);
    // End:0x25F
    if(InstigatorController != none)
    {
        Proj.Instigator = InstigatorController.Pawn;
        Proj.InstigatorController = InstigatorController;
    }
    Proj.Init(Normal(TargetLoc - SpawnLoc));
    //return;    
}

defaultproperties
{
    bCallHandler=false
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Spawn Location",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Target Location",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=0,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Spawn Projectile"
}