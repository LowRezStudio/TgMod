interface OnlineGameDownloadInterface extends Interface;

enum EDownloadSpeed {
    EDLS_Pause,  // 0
    EDLS_Slow,  // 1
    EDLS_Fast,  // 2
};

function bool IsGameComplete();

function bool IsChunkComplete(const int InChunkIndex, const bool bRequireFastAccess);

function bool AreChunksComplete(const array<int> ChunkIndices, const bool bRequireFastAccess);

function bool DoesGameNeedRefresh();

function RefreshGame();

function float GetChunkETA(const int InChunkIndex);

function float GetChunksETA(const array<int> ChunkIndices);

function float GetChunkProgress(const int InChunkIndex);

function float GetChunksProgress(const array<int> ChunkIndices);

function float GetOverallProgress();

function array<int> GetTodoList();

function SetChunksHighPriority(const array<int> ChunkIndices);

function SetDownloadSpeed(const OnlineGameDownloadInterface.EDownloadSpeed InSpeed);

delegate OnChunkComplete(const int ChunkIndex);

function AddOnChunkCompleteDelegate(delegate<OnChunkComplete> InDelegate);

function ClearOnChunkCompleteDelegate(delegate<OnChunkComplete> InDelegate);
