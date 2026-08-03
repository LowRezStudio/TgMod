interface OnlineMarketplaceInterface extends Interface
    abstract;

function bool ReadAvailableProducts(byte LocalUserNum, string ParentId, optional OnlineSubsystem.EMediaItemType ParentMediaType = 1, optional OnlineSubsystem.EMediaItemType ChildMediaType = 1, optional OnlineSubsystem.ECatalogSortOrder SortOrder = 0)
{
    //return ReturnValue;    
}

delegate OnReadAvailableProductsComplete(OnlineSubsystem.EMediaItemType MediaType)
{
    //return;    
}

function AddReadAvailableProductsCompleteDelegate(byte LocalUserNum, delegate<OnReadAvailableProductsComplete> ReadAvailableProductsCompleteDelegate)
{
    //return;    
}

function ClearReadAvailableProductsCompleteDelegate(byte LocalUserNum, delegate<OnReadAvailableProductsComplete> ReadAvailableProductsCompleteDelegate)
{
    //return;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetAvailableProducts(byte LocalUserNum, OnlineSubsystem.EMediaItemType MediaType, out array<MarketplaceProductDetails> AvailableProducts)
{
    //return ReturnValue;    
}

function ResetAvailableProducts(byte LocalUserNum, OnlineSubsystem.EMediaItemType MediaType)
{
    //return;    
}

function bool ReadAdditionalDetailsForProducts(byte LocalUserNum, OnlineSubsystem.EMediaItemType MediaType)
{
    //return ReturnValue;    
}

delegate OnReadAdditionalProductDetailsComplete(OnlineSubsystem.EMediaItemType MediaType)
{
    //return;    
}

function AddReadAdditionalProductDetailsCompleteDelegate(byte LocalUserNum, delegate<OnReadAdditionalProductDetailsComplete> ReadAdditionalProductDetailsCompleteDelegate)
{
    //return;    
}

function ClearReadAdditionalProductDetailsCompleteDelegate(byte LocalUserNum, delegate<OnReadAdditionalProductDetailsComplete> ReadAdditionalProductDetailsCompleteDelegate)
{
    //return;    
}

delegate OnReadDetailsForProductIdList(out array<MarketplaceProductDetails> ProductList)
{
    //return;    
}

function bool ReadDetailsForProductIdList(byte LocalUserNum, array<string> ProductIds)
{
    //return ReturnValue;    
}

function AddReadDetailsForProductIdListCompleteDelegate(byte LocalUserNum, delegate<OnReadDetailsForProductIdList> InDelegate)
{
    //return;    
}

function ClearReadDetailsForProductIdListCompleteDelegate(byte LocalUserNum, delegate<OnReadDetailsForProductIdList> InDelegate)
{
    //return;    
}

function bool ReadInventoryItems(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnReadInventoryItemsComplete()
{
    //return;    
}

function AddReadInventoryItemsCompleteDelegate(byte LocalUserNum, delegate<OnReadInventoryItemsComplete> ReadInventoryItemsCompleteDelegate)
{
    //return;    
}

function ClearReadInventoryItemsCompleteDelegate(byte LocalUserNum, delegate<OnReadInventoryItemsComplete> ReadInventoryItemsCompleteDelegate)
{
    //return;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetInventoryItems(byte LocalUserNum, out array<MarketplaceInventoryItem> InventoryItems)
{
    //return ReturnValue;    
}

function ResetInventoryItems(byte LocalUserNum)
{
    //return;    
}

function bool ConsumeInventoryItem(byte LocalUserNum, string ProductID, int Quantity, string TransactionId)
{
    //return ReturnValue;    
}

delegate OnConsumeInventoryItemComplete(string ProductID, bool bDidSucceed, int NewQuantity)
{
    //return;    
}

function AddConsumeInventoryItemCompleteDelegate(byte LocalUserNum, delegate<OnConsumeInventoryItemComplete> ConsumeInventoryItemCompleteDelegate)
{
    //return;    
}

function ClearConsumeInventoryItemCompleteDelegate(byte LocalUserNum, delegate<OnConsumeInventoryItemComplete> ConsumeInventoryItemCompleteDelegate)
{
    //return;    
}

delegate OnMarketplaceItemPurchased()
{
    //return;    
}

function AddMarketplaceItemPurchasedDelegate(delegate<OnMarketplaceItemPurchased> InDelegate)
{
    //return;    
}

function ClearMarketplaceItemPurchasedDelegate(delegate<OnMarketplaceItemPurchased> InDelegate)
{
    //return;    
}

function SetMarketplaceVisibility(bool Visible)
{
    //return;    
}
