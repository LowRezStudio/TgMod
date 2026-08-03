class SeqEvent_HudRender extends SequenceEvent
    abstract
    native
    forcescriptorder(true)
    hidecategories(Object);

var() array<Object> Targets;
var(HUD) bool bIsActive;
var(HUD) float AuthoredGlobalScale;

event RegisterEvent()
{
    local int I;
    local GamePlayerController GPC;
    local MobileHUD TargetHud;

    I = 0;
    J0x0B:

    // End:0xC9 [Loop If]
    if(I < Targets.Length)
    {
        GPC = GamePlayerController(Targets[I]);
        // End:0xBB
        if(GPC != none)
        {
            TargetHud = MobileHUD(GPC.myHUD);
            // End:0xBB
            if(TargetHud != none)
            {
                TargetHud.AddKismetRenderEvent(self);
                // [Explicit Break]
                goto J0xC9;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    J0xC9:

    //return;    
}

function Render(Canvas TargetCanvas, HUD TargetHud)
{
    //return;    
}

defaultproperties
{
    AuthoredGlobalScale=2.0000000
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Bool',LinkedVariables=none,LinkDesc="Active",LinkVar="None",PropertyName="bIsActive",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
}