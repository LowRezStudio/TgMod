class UIDataStore_OnlineGameSearch extends UIDataStore_Remote
    abstract
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

struct native GameSearchCfg
{
    var Class<OnlineGameSearch> GameSearchClass;
    var Class<OnlineGameSettings> DefaultGameSettingsClass;
    var Class<UIDataProvider_Settings> SearchResultsProviderClass;
    var UIDataProvider_Settings DesiredSettingsProvider;
    var OnlineGameSearch Search;
    var name SearchName;

    structdefaultproperties
    {
        GameSearchClass=none
        DefaultGameSettingsClass=none
        SearchResultsProviderClass=none
        DesiredSettingsProvider=none
        Search=none
        SearchName="None"
    }
};

var const name SearchResultsName;
var OnlineSubsystem OnlineSub;
var OnlineGameInterface GameInterface;
var const array<GameSearchCfg> GameSearchCfgList;
var int SelectedIndex;
var int ActiveSearchIndex;

event Init()
{
    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xB1
    if(OnlineSub != none)
    {
        GameInterface = OnlineSub.GameInterface;
        // End:0xB1
        if(NotEqual_InterfaceInterface(GameInterface, OnlineGameInterface(none)))
        {
            GameInterface.AddFindOnlineGamesCompleteDelegate(OnSearchComplete);
        }
    }
    //return;    
}

function bool InvalidateCurrentSearchResults()
{
    local OnlineGameSearch ActiveSearch;
    local bool bResult;

    ActiveSearch = GetActiveGameSearch();
    // End:0x96
    if(ActiveSearch != none)
    {
        // End:0x96
        if(GameInterface.FreeSearchResults(ActiveSearch))
        {
            RefreshSubscribers(SearchResultsName, true, GameSearchCfgList[SelectedIndex].DesiredSettingsProvider);
            bResult = true;
        }
    }
    return bResult;
    //return ReturnValue;    
}

event bool SubmitGameSearch(byte ControllerIndex, optional bool bInvalidateExistingSearchResults = true)
{
    // End:0x16B
    if(OnlineSub != none)
    {
        // End:0x168
        if(NotEqual_InterfaceInterface(GameInterface, OnlineGameInterface(none)))
        {
            // End:0x64
            if(bInvalidateExistingSearchResults || ActiveSearchIndex == SelectedIndex)
            {
                InvalidateCurrentSearchResults();
            }
            // End:0xCD
            if((ActiveSearchIndex == -1) || !GameSearchCfgList[ActiveSearchIndex].Search.bIsSearchInProgress)
            {
                ActiveSearchIndex = SelectedIndex;
            }
            // End:0x10B
            if(OverrideQuerySubmission(ControllerIndex, GameSearchCfgList[ActiveSearchIndex].Search))
            {
                return true;
            }
            InvalidateCurrentSearchResults();
            return GameInterface.FindOnlineGames(ControllerIndex, GameSearchCfgList[ActiveSearchIndex].Search);            
        }        
    }
    return false;
    //return ReturnValue;    
}

protected function bool OverrideQuerySubmission(byte ControllerId, OnlineGameSearch Search)
{
    return false;
    //return ReturnValue;    
}

function OnSearchComplete(bool bWasSuccessful)
{
    // End:0x4E
    if(bWasSuccessful == true)
    {
        RefreshSubscribers(SearchResultsName, false, GameSearchCfgList[ActiveSearchIndex].DesiredSettingsProvider);        
    }
    //return;    
}

event bool GetSearchResultFromIndex(int ListIndex, out OnlineGameSearchResult Result)
{
    // End:0xAC
    if((ListIndex >= 0) && ListIndex < GameSearchCfgList[SelectedIndex].Search.Results.Length)
    {
        Result = GameSearchCfgList[SelectedIndex].Search.Results[ListIndex];
        return true;
    }
    return false;
    //return ReturnValue;    
}

event bool ShowHostGamercard(byte ControllerIndex, int ListIndex)
{
    local OnlinePlayerInterfaceEx PlayerExt;
    local OnlineGameSettings Game;

    // End:0x165
    if((ListIndex >= 0) && ListIndex < GameSearchCfgList[SelectedIndex].Search.Results.Length)
    {
        // End:0x162
        if(OnlineSub != none)
        {
            PlayerExt = OnlineSub.PlayerInterfaceEx;
            // End:0x15F
            if(NotEqual_InterfaceInterface(PlayerExt, OnlinePlayerInterfaceEx(none)))
            {
                Game = GameSearchCfgList[SelectedIndex].Search.Results[ListIndex].GameSettings;
                return PlayerExt.ShowGamerCardUI(ControllerIndex, Game.OwningPlayerId);                
            }            
        }        
    }
    //return ReturnValue;    
}

event OnlineGameSearch GetCurrentGameSearch()
{
    // End:0x50
    if((SelectedIndex >= 0) && SelectedIndex < GameSearchCfgList.Length)
    {
        return GameSearchCfgList[SelectedIndex].Search;
    }
    return none;
    //return ReturnValue;    
}

event OnlineGameSearch GetActiveGameSearch()
{
    // End:0x50
    if((ActiveSearchIndex >= 0) && ActiveSearchIndex < GameSearchCfgList.Length)
    {
        return GameSearchCfgList[ActiveSearchIndex].Search;
    }
    return none;
    //return ReturnValue;    
}

function int FindSearchConfigurationIndex(name SearchTag)
{
    local int Index;

    Index = 0;
    J0x0B:

    // End:0x6F [Loop If]
    if(Index < GameSearchCfgList.Length)
    {
        // End:0x61
        if(GameSearchCfgList[Index].SearchName == SearchTag)
        {
            return Index;
        }
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    return -1;
    //return ReturnValue;    
}

event SetCurrentByIndex(int NewIndex, optional bool bInvalidateExistingSearchResults = true)
{
    // End:0x9F
    if((NewIndex >= 0) && NewIndex < GameSearchCfgList.Length)
    {
        SelectedIndex = NewIndex;
        // End:0x9C
        if(!bInvalidateExistingSearchResults || !InvalidateCurrentSearchResults())
        {
            RefreshSubscribers(SearchResultsName, true, GameSearchCfgList[SelectedIndex].DesiredSettingsProvider);
        }        
    }
    //return;    
}

event SetCurrentByName(name SearchName, optional bool bInvalidateExistingSearchResults = true)
{
    local int Index;

    Index = FindSearchConfigurationIndex(SearchName);
    // End:0xA6
    if(Index != -1)
    {
        SelectedIndex = Index;
        // End:0xA3
        if(!bInvalidateExistingSearchResults || !InvalidateCurrentSearchResults())
        {
            RefreshSubscribers(SearchResultsName, true, GameSearchCfgList[SelectedIndex].DesiredSettingsProvider);
        }        
    }
    //return;    
}

event MoveToNext(optional bool bInvalidateExistingSearchResults = true)
{
    SelectedIndex = Min(SelectedIndex + 1, GameSearchCfgList.Length - 1);
    // End:0x85
    if(!bInvalidateExistingSearchResults || !InvalidateCurrentSearchResults())
    {
        RefreshSubscribers(SearchResultsName, true, GameSearchCfgList[SelectedIndex].DesiredSettingsProvider);
    }
    //return;    
}

event MoveToPrevious(optional bool bInvalidateExistingSearchResults = true)
{
    SelectedIndex = Max(SelectedIndex - 1, 0);
    // End:0x79
    if(!bInvalidateExistingSearchResults || !InvalidateCurrentSearchResults())
    {
        RefreshSubscribers(SearchResultsName, true, GameSearchCfgList[SelectedIndex].DesiredSettingsProvider);
    }
    //return;    
}

function ClearAllSearchResults()
{
    local int OriginalActiveIndex, GameTypeIndex;

    OriginalActiveIndex = ActiveSearchIndex;
    // End:0xC2
    if(NotEqual_InterfaceInterface(GameInterface, OnlineGameInterface(none)))
    {
        GameTypeIndex = 0;
        J0x3E:

        // End:0xC2 [Loop If]
        if(GameTypeIndex < GameSearchCfgList.Length)
        {
            ActiveSearchIndex = GameTypeIndex;
            // End:0xB4
            if(!GameInterface.FreeSearchResults(GameSearchCfgList[GameTypeIndex].Search))
            {
            }
            GameTypeIndex++;
            // [Loop Continue]
            goto J0x3E;
        }
    }
    ActiveSearchIndex = OriginalActiveIndex;
    //return;    
}

defaultproperties
{
    SearchResultsName="SearchResults"
    ActiveSearchIndex=-1
    Tag="OnlineGameSearch"
}