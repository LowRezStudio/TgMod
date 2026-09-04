class TgSceneManager extends GFxObject within GFxMoviePlayer
    native
    config(Engine);

var GFxObject m_loadedScenes;
var private bool bMouseCaptured;

native function InitializeSceneManager();  // Export UTgSceneManager::execInitializeSceneManager(FFrame&, void* const)

native function KillScene(string SceneName);  // Export UTgSceneManager::execKillScene(FFrame&, void* const)

native function LoadScene(string SceneName);  // Export UTgSceneManager::execLoadScene(FFrame&, void* const)

native function UnloadScene(string SceneName);  // Export UTgSceneManager::execUnloadScene(FFrame&, void* const)

native function ToggleScene(string SceneName);  // Export UTgSceneManager::execToggleScene(FFrame&, void* const)

native function UnloadAllScenes(array<string> exclusionList);  // Export UTgSceneManager::execUnloadAllScenes(FFrame&, void* const)

native function ListOpenScenes();  // Export UTgSceneManager::execListOpenScenes(FFrame&, void* const)

native function bool IsSceneLoaded(string SceneName);  // Export UTgSceneManager::execIsSceneLoaded(FFrame&, void* const)

native function PushMouseCapture();  // Export UTgSceneManager::execPushMouseCapture(FFrame&, void* const)

native function PopMouseCapture();  // Export UTgSceneManager::execPopMouseCapture(FFrame&, void* const)

native function PushKeyCapture();  // Export UTgSceneManager::execPushKeyCapture(FFrame&, void* const)

native function PopKeyCapture();  // Export UTgSceneManager::execPopKeyCapture(FFrame&, void* const)

native function ShowCharacterCard(int nClassId);  // Export UTgSceneManager::execShowCharacterCard(FFrame&, void* const)

native function ToggleTwitch();  // Export UTgSceneManager::execToggleTwitch(FFrame&, void* const)
