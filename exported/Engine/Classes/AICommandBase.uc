class AICommandBase extends Object within AIController
    abstract
    native(AI);

static event int GetUtility(AIController InAI)
{
    ScriptTrace();
    return -1;
    //return ReturnValue;    
}
