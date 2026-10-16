interface OnlineGameDownloadInterface extends Interface
    abstract;

enum EDownloadSpeed
{
    EDLS_Pause,                     // 0
    EDLS_Slow,                      // 1
    EDLS_Fast,                      // 2
    EDLS_MAX                        // 3
};

function bool IsGameComplete()
{
    //return ReturnValue;    
}

function bool IsChunkComplete(const int InChunkIndex, const bool bRequireFastAccess)
{
    //return ReturnValue;    
}

function bool AreChunksComplete(const array<int> ChunkIndices, const bool bRequireFastAccess)
{
    //return ReturnValue;    
}

function bool DoesGameNeedRefresh()
{
    //return ReturnValue;    
}

function RefreshGame()
{
    //return;    
}

function float GetChunkETA(const int InChunkIndex)
{
    //return ReturnValue;    
}

function float GetChunksETA(const array<int> ChunkIndices)
{
    //return ReturnValue;    
}

function float GetChunkProgress(const int InChunkIndex)
{
    //return ReturnValue;    
}

function float GetChunksProgress(const array<int> ChunkIndices)
{
    //return ReturnValue;    
}

function float GetOverallProgress()
{
    //return ReturnValue;    
}

function array<int> GetTodoList()
{
    //return ReturnValue;    
}

function SetChunksHighPriority(const array<int> ChunkIndices)
{
    //return;    
}

function SetDownloadSpeed(const OnlineGameDownloadInterface.EDownloadSpeed InSpeed)
{
    //return;    
}

delegate OnChunkComplete(const int ChunkIndex)
{
    //return;    
}

function AddOnChunkCompleteDelegate(delegate<OnChunkComplete> InDelegate)
{
    //return;    
}

function ClearOnChunkCompleteDelegate(delegate<OnChunkComplete> InDelegate)
{
    //return;    
}
