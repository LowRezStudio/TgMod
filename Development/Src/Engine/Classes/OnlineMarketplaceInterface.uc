interface OnlineMarketplaceInterface extends Interface
    dependson(OnlineSubsystem);

function bool ReadAvailableProducts(byte LocalUserNum, string ParentId, optional OnlineSubsystem.EMediaItemType ParentMediaType=1, optional OnlineSubsystem.EMediaItemType ChildMediaType=1, optional OnlineSubsystem.ECatalogSortOrder SortOrder=0);

delegate OnReadAvailableProductsComplete(OnlineSubsystem.EMediaItemType MediaType);

function AddReadAvailableProductsCompleteDelegate(byte LocalUserNum, delegate<OnReadAvailableProductsComplete> ReadAvailableProductsCompleteDelegate);

function ClearReadAvailableProductsCompleteDelegate(byte LocalUserNum, delegate<OnReadAvailableProductsComplete> ReadAvailableProductsCompleteDelegate);

function OnlineSubsystem.EOnlineEnumerationReadState GetAvailableProducts(byte LocalUserNum, OnlineSubsystem.EMediaItemType MediaType, out array<MarketplaceProductDetails> AvailableProducts);

function ResetAvailableProducts(byte LocalUserNum, OnlineSubsystem.EMediaItemType MediaType);

function bool ReadAdditionalDetailsForProducts(byte LocalUserNum, OnlineSubsystem.EMediaItemType MediaType);

delegate OnReadAdditionalProductDetailsComplete(OnlineSubsystem.EMediaItemType MediaType);

function AddReadAdditionalProductDetailsCompleteDelegate(byte LocalUserNum, delegate<OnReadAdditionalProductDetailsComplete> ReadAdditionalProductDetailsCompleteDelegate);

function ClearReadAdditionalProductDetailsCompleteDelegate(byte LocalUserNum, delegate<OnReadAdditionalProductDetailsComplete> ReadAdditionalProductDetailsCompleteDelegate);

delegate OnReadDetailsForProductIdList(out array<MarketplaceProductDetails> ProductList);

function bool ReadDetailsForProductIdList(byte LocalUserNum, array<string> ProductIds);

function AddReadDetailsForProductIdListCompleteDelegate(byte LocalUserNum, delegate<OnReadDetailsForProductIdList> InDelegate);

function ClearReadDetailsForProductIdListCompleteDelegate(byte LocalUserNum, delegate<OnReadDetailsForProductIdList> InDelegate);

function bool ReadInventoryItems(byte LocalUserNum);

delegate OnReadInventoryItemsComplete();

function AddReadInventoryItemsCompleteDelegate(byte LocalUserNum, delegate<OnReadInventoryItemsComplete> ReadInventoryItemsCompleteDelegate);

function ClearReadInventoryItemsCompleteDelegate(byte LocalUserNum, delegate<OnReadInventoryItemsComplete> ReadInventoryItemsCompleteDelegate);

function OnlineSubsystem.EOnlineEnumerationReadState GetInventoryItems(byte LocalUserNum, out array<MarketplaceInventoryItem> InventoryItems);

function ResetInventoryItems(byte LocalUserNum);

function bool ConsumeInventoryItem(byte LocalUserNum, string ProductID, int Quantity, string TransactionId);

delegate OnConsumeInventoryItemComplete(string ProductID, bool bDidSucceed, int NewQuantity);

function AddConsumeInventoryItemCompleteDelegate(byte LocalUserNum, delegate<OnConsumeInventoryItemComplete> ConsumeInventoryItemCompleteDelegate);

function ClearConsumeInventoryItemCompleteDelegate(byte LocalUserNum, delegate<OnConsumeInventoryItemComplete> ConsumeInventoryItemCompleteDelegate);

delegate OnMarketplaceItemPurchased();

function AddMarketplaceItemPurchasedDelegate(delegate<OnMarketplaceItemPurchased> InDelegate);

function ClearMarketplaceItemPurchasedDelegate(delegate<OnMarketplaceItemPurchased> InDelegate);

function SetMarketplaceVisibility(bool Visible);
