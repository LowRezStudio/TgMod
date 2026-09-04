class TgKismetTestActor extends DynamicSMActor
    hidecategories(Navigation);

var() int m_nTestCount;
var() repnotify int r_nCurrentTest;
var repnotify int r_nPassCount;
var repnotify int r_nFailCount;
var() array<Texture2D> c_aTextures;
var() SoundCue c_PassSound;
var() SoundCue c_FailSound;
var() array<InterpActor> c_aResultActors;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_nCurrentTest, r_nFailCount, 
        r_nPassCount;
}

simulated function OnTestResult(TgSeqAct_TestResult Action)
{
    // End:0x97
    if(Action.InputLinks[0].bHasImpulse)
    {
        r_nCurrentTest = SeqVar_Int(Action.VariableLinks[1].LinkedVariables[0]).IntValue;        
    }
    else
    {
        // End:0xDC
        if(Action.InputLinks[1].bHasImpulse)
        {
            r_nPassCount++;            
        }
        else
        {
            // End:0x11F
            if(Action.InputLinks[2].bHasImpulse)
            {
                r_nFailCount++;
            }
        }
    }
    //return;    
}

simulated function PlayerController GetLocalPlayer()
{
    local PlayerController PC;

    // End:0x2B
    foreach LocalPlayerControllers(Class'Engine.PlayerController', PC)
    {        
        return PC;        
    }    
    //return ReturnValue;    
}

unreliable client simulated function SetTestColor(int Num, LinearColor Col)
{
    local InterpActor act;
    local MaterialInstanceConstant MI, MIC;

    act = c_aResultActors[Num];
    // End:0x2E
    if(act == none)
    {
        return;
    }
    MI = MaterialInstanceConstant(act.StaticMeshComponent.Materials[0]);
    // End:0x134
    if(MI != none)
    {
        MIC = new (none) Class'Engine.MaterialInstanceConstant';
        MIC.SetVectorParameterValue('TestColor', Col);
        MIC.SetParent(MI);
        act.StaticMeshComponent.SetMaterial(0, MIC);
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local int I;

    I = 1;
    J0x0B:

    // End:0x62 [Loop If]
    if(I <= c_aResultActors.Length)
    {
        SetTestColor(I, MakeLinearColor(0.1000000, 0.1000000, 0.1000000, 1.0000000));
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

unreliable client simulated function PassTest(int Num)
{
    GetLocalPlayer().ClientPlaySound(c_PassSound);
    SetTestColor(Num, MakeLinearColor(0.0000000, 0.8000000, 0.0000000, 1.0000000));
    //return;    
}

unreliable client simulated function FailTest(int Num)
{
    GetLocalPlayer().ClientPlaySound(c_FailSound);
    SetTestColor(Num, MakeLinearColor(0.8000000, 0.0000000, 0.0000000, 1.0000000));
    //return;    
}

unreliable client simulated function StartTest(int Num)
{
    local MaterialInstanceConstant MIC;

    MIC = MaterialInstanceConstant(StaticMeshComponent.Materials[0]);
    MIC.SetTextureParameterValue('TestBillboard', c_aTextures[r_nCurrentTest]);
    SetTestColor(Num, MakeLinearColor(0.0000000, 0.0000000, 1.0000000, 1.0000000));
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2D
    if(VarName == 'r_nPassCount')
    {
        PassTest(r_nCurrentTest);        
    }
    else
    {
        // End:0x5A
        if(VarName == 'r_nFailCount')
        {
            FailTest(r_nCurrentTest);            
        }
        else
        {
            // End:0x87
            if(VarName == 'r_nCurrentTest')
            {
                StartTest(r_nCurrentTest);                
            }
            else
            {
                super.ReplicatedEvent(VarName);
            }
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'TgGame.Default__TgKismetTestActor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__DynamicSMActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        WireframeColor=(R=255,G=0,B=255,A=255)
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgKismetTestActor.MyLightEnvironment'
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgKismetTestActor.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
    bNoDelete=true
    bAlwaysRelevant=true
    NetPriority=1.4000000
    CollisionComponent=StaticMeshComponent0
}