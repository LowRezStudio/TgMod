class ActorFactory extends Object
    abstract
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var Class<Actor> GameplayActorClass;
var string MenuName;
var config int MenuPriority;
var deprecated int AlternateMenuPriority;
var config string NewActorClassName;
var Class<Actor> NewActorClass;
var bool bPlaceable;
var bool bShowInEditorQuickMenu;

simulated event PostCreateActor(Actor NewActor, const optional SeqAct_ActorFactory ActorFactoryData)
{
    //return;    
}

defaultproperties
{
    MenuName="Add Actor"
    MenuPriority=10
    bPlaceable=true
}