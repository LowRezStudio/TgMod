class GameCrowdAgentSM extends GameCrowdAgent
    abstract
    native
    hidecategories(Navigation,Advanced,Attachment,Collision,Object);

var(Rendering) export editinline StaticMeshComponent Mesh;
var(Rendering) MaterialInstanceConstant MeshColor;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    MeshColor = Mesh.CreateAndSetMaterialInstanceConstant(0);
    //return;    
}

simulated function InitDebugColor()
{
    super.InitDebugColor();
    ChangeDebugColor(DebugAgentColor);
    //return;    
}

simulated function ChangeDebugColor(Color InC)
{
    local LinearColor C;

    C.R = float(InC.R) / 255.0000000;
    C.G = float(InC.G) / 255.0000000;
    C.B = float(InC.B) / 255.0000000;
    MeshColor.SetVectorParameterValue('CrowdCylinderColor', C);
    //return;    
}

function ActivateBehavior(GameCrowdAgentBehavior NewBehaviorArchetype, optional Actor LookAtActor)
{
    super.ActivateBehavior(NewBehaviorArchetype, LookAtActor);
    // End:0x57
    if(CurrentBehavior != none)
    {
        ChangeDebugColor(CurrentBehavior.DebugBehaviorColor);        
    }
    else
    {
        ChangeDebugColor(DebugAgentColor);
    }
    //return;    
}

function StopBehavior()
{
    super.StopBehavior();
    // End:0x2C
    if(CurrentBehavior == none)
    {
        ChangeDebugColor(DebugAgentColor);
    }
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'GameFramework.Default__GameCrowdAgentSM.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    begin object name="StaticMeshComponent0" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        bAcceptsDynamicDecals=false
        bCastDynamicShadow=false
        BlockNonZeroExtent=false
        BlockRigidBody=false
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true)
    end object
    Mesh=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'GameFramework.Default__GameCrowdAgentSM.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'GameFramework.Default__GameCrowdAgent.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
}