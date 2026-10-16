class McpUserInventoryManager extends McpUserInventoryBase
    config(Engine);

struct SaveSlotRequestState
{
    var string McpId;
    var string SaveSlotId;
    var HttpRequestInterface Request;

    structdefaultproperties
    {
        McpId=""
        SaveSlotId=""
        Request=none
    }
};

struct InventoryItemRequestState extends SaveSlotRequestState
{
    var string ItemId;
};

var config string CreateSaveSlotUrl;
var config string DeleteSaveSlotUrl;
var config string ListSaveSlotUrl;
var config string ListItemsUrl;
var config string PurchaseItemUrl;
var config string SellItemUrl;
var config string EarnItemUrl;
var config string ConsumeItemUrl;
var config string DeleteItemUrl;
var config string IapRecordUrl;
var array<McpInventorySaveSlot> SaveSlots;
var array<SaveSlotRequestState> SaveSlotRequests;
var array<SaveSlotRequestState> ListSaveSlotRequests;
var array<SaveSlotRequestState> ListItemsRequests;
var array<InventoryItemRequestState> ItemRequests;

function CreateSaveSlot(string McpId, string SaveSlotId, optional string ParentSaveSlotId)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindSaveSlotRequest(McpId, SaveSlotId, SaveSlotRequests);
    // End:0x297
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x294
        if(Request != none)
        {
            URL = (((((((GetBaseURL()) $ CreateSaveSlotUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId;
            // End:0x138
            if(Len(ParentSaveSlotId) > 0)
            {                
                URL $= ("&parentSaveSlotId=" $ ParentSaveSlotId);
            }
            Request.SetURL(URL);
            Request.SetVerb("POST");
            Request.__OnProcessRequestComplete__Delegate = OnCreateSaveSlotRequestComplete;
            AddAt = SaveSlotRequests.Length;
            SaveSlotRequests.Length = AddAt + 1;
            SaveSlotRequests[AddAt].McpId = McpId;
            SaveSlotRequests[AddAt].SaveSlotId = SaveSlotId;
            SaveSlotRequests[AddAt].Request = Request;
            // End:0x294
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnCreateSaveSlotRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, SaveSlotIndex, ResponseCode;
    local string ResponseString;

    Index = SaveSlotRequests.Find('Request', Request);
    // End:0x26D
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x1D0
        if(bWasSuccessful)
        {
            SaveSlotIndex = FindSaveSlotIndex(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId);
            // End:0x13F
            if(SaveSlotIndex != -1)
            {
                SaveSlots.Remove(SaveSlotIndex, 1);
            }
            ResponseString = Response.GetContentAsString();            
            ParseInventoryForSaveSlot(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId, ResponseString);
        }
        OnCreateSaveSlotComplete(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId, bWasSuccessful, Response.GetContentAsString());
        SaveSlotRequests.Remove(Index, 1);
    }
    //return;    
}

function DeleteSaveSlot(string McpId, string SaveSlotId)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindSaveSlotRequest(McpId, SaveSlotId, SaveSlotRequests);
    // End:0x253
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x250
        if(Request != none)
        {
            URL = (((((((GetBaseURL()) $ DeleteSaveSlotUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId;
            Request.SetURL(URL);
            Request.SetVerb("DELETE");
            Request.__OnProcessRequestComplete__Delegate = OnDeleteSaveSlotRequestComplete;
            AddAt = SaveSlotRequests.Length;
            SaveSlotRequests.Length = AddAt + 1;
            SaveSlotRequests[AddAt].McpId = McpId;
            SaveSlotRequests[AddAt].SaveSlotId = SaveSlotId;
            SaveSlotRequests[AddAt].Request = Request;
            // End:0x250
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnDeleteSaveSlotRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, SaveSlotIndex, ResponseCode;

    Index = SaveSlotRequests.Find('Request', Request);
    // End:0x1DC
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x13F
        if(bWasSuccessful)
        {
            SaveSlotIndex = FindSaveSlotIndex(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId);
            // End:0x13F
            if(SaveSlotIndex != -1)
            {
                SaveSlots.Remove(SaveSlotIndex, 1);
            }
        }
        OnDeleteSaveSlotComplete(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId, bWasSuccessful, Response.GetContentAsString());
        SaveSlotRequests.Remove(Index, 1);
    }
    //return;    
}

function QuerySaveSlotList(string McpId)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = ListSaveSlotRequests.Find('McpId', McpId);
    // End:0x1FF
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x1FC
        if(Request != none)
        {
            URL = (((((GetBaseURL()) $ ListSaveSlotUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId;
            Request.SetURL(URL);
            Request.SetVerb("GET");
            Request.__OnProcessRequestComplete__Delegate = OnQuerySaveSlotListRequestComplete;
            AddAt = ListSaveSlotRequests.Length;
            ListSaveSlotRequests.Length = AddAt + 1;
            ListSaveSlotRequests[AddAt].McpId = McpId;
            ListSaveSlotRequests[AddAt].Request = Request;
            // End:0x1FC
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnQuerySaveSlotListRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, ResponseCode;
    local string ResponseString;

    Index = ListSaveSlotRequests.Find('Request', Request);
    // End:0x190
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x119
        if(bWasSuccessful)
        {
            ResponseString = Response.GetContentAsString();
            ParseSaveSlotList(ListSaveSlotRequests[Index].McpId, ResponseString);
        }
        OnQuerySaveSlotListComplete(ListSaveSlotRequests[Index].McpId, bWasSuccessful, Response.GetContentAsString());
        ListSaveSlotRequests.Remove(Index, 1);
    }
    //return;    
}

function array<string> GetSaveSlotList(string McpId)
{
    local array<string> OutSaveSlots;
    local int SaveSlotIndex;

    OutSaveSlots.Length = SaveSlots.Length;
    SaveSlotIndex = 0;
    J0x20:

    // End:0x80 [Loop If]
    if(SaveSlotIndex < SaveSlots.Length)
    {
        OutSaveSlots[SaveSlotIndex] = SaveSlots[SaveSlotIndex].SaveSlotId;
        SaveSlotIndex++;
        // [Loop Continue]
        goto J0x20;
    }
    return OutSaveSlots;
    //return ReturnValue;    
}

function QueryInventoryItems(string McpId, string SaveSlotId)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindSaveSlotRequest(McpId, SaveSlotId, ListItemsRequests);
    // End:0x250
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x24D
        if(Request != none)
        {
            URL = (((((((GetBaseURL()) $ ListItemsUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId;
            Request.SetURL(URL);
            Request.SetVerb("GET");
            Request.__OnProcessRequestComplete__Delegate = OnQueryInventoryItemsRequestComplete;
            AddAt = ListItemsRequests.Length;
            ListItemsRequests.Length = AddAt + 1;
            ListItemsRequests[AddAt].McpId = McpId;
            ListItemsRequests[AddAt].SaveSlotId = SaveSlotId;
            ListItemsRequests[AddAt].Request = Request;
            // End:0x24D
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnQueryInventoryItemsRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, SaveSlotIndex, ResponseCode;
    local string ResponseString;

    Index = ListItemsRequests.Find('Request', Request);
    // End:0x281
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x1E4
        if(bWasSuccessful)
        {
            SaveSlotIndex = FindSaveSlotIndex(ListItemsRequests[Index].McpId, ListItemsRequests[Index].SaveSlotId);
            // End:0x153
            if(SaveSlotIndex != -1)
            {
                SaveSlots[SaveSlotIndex].Items.Length = 0;
            }
            ResponseString = Response.GetContentAsString();            
            ParseInventoryForSaveSlot(ListItemsRequests[Index].McpId, ListItemsRequests[Index].SaveSlotId, ResponseString);
        }
        OnQueryInventoryItemsComplete(ListItemsRequests[Index].McpId, ListItemsRequests[Index].SaveSlotId, bWasSuccessful, Response.GetContentAsString());
        ListItemsRequests.Remove(Index, 1);
    }
    //return;    
}

function GetInventoryItems(string McpId, string SaveSlotId, out array<McpInventoryItem> OutInventoryItems)
{
    local int SaveSlotIndex;

    OutInventoryItems.Length = 0;
    SaveSlotIndex = FindSaveSlotIndex(McpId, SaveSlotId);
    // End:0x78
    if(SaveSlotIndex != -1)
    {
        OutInventoryItems = SaveSlots[SaveSlotIndex].Items;        
    }
    //return;    
}

function bool GetInventoryItem(string McpId, string SaveSlotId, string InstanceItemId, out McpInventoryItem OutInventoryItem)
{
    local int SaveSlotIndex, ItemIndex;

    SaveSlotIndex = FindSaveSlotIndex(McpId, SaveSlotId);
    // End:0xD4
    if(SaveSlotIndex != -1)
    {
        ItemIndex = SaveSlots[SaveSlotIndex].Items.Find('InstanceItemId', InstanceItemId);
        // End:0xD1
        if(ItemIndex != -1)
        {
            OutInventoryItem = SaveSlots[SaveSlotIndex].Items[ItemIndex];
            return true;            
        }        
    }
    return false;
    //return ReturnValue;    
}

function array<string> ParseInventoryForSaveSlot(string McpId, string SaveSlotId, string JsonPayload)
{
    local JsonObject ParsedJson, ParsedJsonAttrs;
    local int JsonIndex, SaveSlotIndex, ItemIndex, JsonAttrsIndex;
    local string GlobalItemId, InstanceItemId;
    local array<string> UpdatedItemIds;
    local array<JsonObject> ObjectArray;

    SaveSlotIndex = FindSaveSlotIndex(McpId, SaveSlotId);
    // End:0xC4
    if(SaveSlotIndex == -1)
    {
        SaveSlotIndex = SaveSlots.Length;
        SaveSlots.Length = SaveSlotIndex + 1;
        SaveSlots[SaveSlotIndex].OwningMcpId = McpId;
        SaveSlots[SaveSlotIndex].SaveSlotId = SaveSlotId;
    }
    ParsedJson = Class'Engine.JsonObject'.static.DecodeJson(JsonPayload);
    ObjectArray = ParsedJson.ObjectArray;
    // End:0x144
    if(ObjectArray.Length == 0)
    {
        ObjectArray.AddItem(ParsedJson);
    }
    JsonIndex = 0;
    J0x14F:

    // End:0x7E4 [Loop If]
    if(JsonIndex < ObjectArray.Length)
    {
        InstanceItemId = ObjectArray[JsonIndex].GetStringValue("instance_item_id");
        GlobalItemId = ObjectArray[JsonIndex].GetStringValue("global_item_id");
        // End:0x7D6
        if(Len(InstanceItemId) > 0)
        {
            UpdatedItemIds.AddItem(InstanceItemId);
            ItemIndex = SaveSlots[SaveSlotIndex].Items.Find('InstanceItemId', InstanceItemId);
            // End:0x36E
            if(ItemIndex == -1)
            {
                ItemIndex = SaveSlots[SaveSlotIndex].Items.Length;
                SaveSlots[SaveSlotIndex].Items.Length = ItemIndex + 1;
                SaveSlots[SaveSlotIndex].Items[ItemIndex].GlobalItemId = GlobalItemId;
                SaveSlots[SaveSlotIndex].Items[ItemIndex].InstanceItemId = InstanceItemId;
            }
            SaveSlots[SaveSlotIndex].Items[ItemIndex].Quantity = ObjectArray[JsonIndex].GetIntValue("quantity");
            SaveSlots[SaveSlotIndex].Items[ItemIndex].QuantityIAP = ObjectArray[JsonIndex].GetIntValue("iap_quantity");
            SaveSlots[SaveSlotIndex].Items[ItemIndex].Scalar = ObjectArray[JsonIndex].GetFloatValue("scalar");
            SaveSlots[SaveSlotIndex].Items[ItemIndex].LastUpdateTime = ObjectArray[JsonIndex].GetStringValue("last_update_time");
            SaveSlots[SaveSlotIndex].Items[ItemIndex].Attributes.Length = 0;
            ParsedJsonAttrs = ObjectArray[JsonIndex].GetObject("attributes");
            SaveSlots[SaveSlotIndex].Items[ItemIndex].Attributes.Length = ParsedJsonAttrs.ObjectArray.Length;
            JsonAttrsIndex = 0;
            J0x648:

            // End:0x7D6 [Loop If]
            if(JsonAttrsIndex < ParsedJsonAttrs.ObjectArray.Length)
            {
                SaveSlots[SaveSlotIndex].Items[ItemIndex].Attributes[JsonAttrsIndex].AttributeId = ParsedJsonAttrs.ObjectArray[JsonAttrsIndex].GetStringValue("attribute_id");
                SaveSlots[SaveSlotIndex].Items[ItemIndex].Attributes[JsonAttrsIndex].Value = ParsedJsonAttrs.ObjectArray[JsonAttrsIndex].GetIntValue("value");
                JsonAttrsIndex++;
                // [Loop Continue]
                goto J0x648;
            }
        }
        JsonIndex++;
        // [Loop Continue]
        goto J0x14F;
    }
    return UpdatedItemIds;
    //return ReturnValue;    
}

function ParseSaveSlotList(string McpId, string JsonPayload)
{
    local JsonObject ParsedJson;
    local int JsonIndex, SaveSlotIndex;
    local string SaveSlotId;

    ParsedJson = Class'Engine.JsonObject'.static.DecodeJson(JsonPayload);
    JsonIndex = 0;
    J0x3D:

    // End:0x192 [Loop If]
    if(JsonIndex < ParsedJson.ObjectArray.Length)
    {
        SaveSlotId = ParsedJson.ObjectArray[JsonIndex].GetStringValue("save_slot_id");
        SaveSlotIndex = FindSaveSlotIndex(McpId, SaveSlotId);
        // End:0x184
        if(SaveSlotIndex == -1)
        {
            SaveSlotIndex = SaveSlots.Length;
            SaveSlots.Length = SaveSlotIndex + 1;
            SaveSlots[SaveSlotIndex].OwningMcpId = McpId;
            SaveSlots[SaveSlotIndex].SaveSlotId = SaveSlotId;
        }
        JsonIndex++;
        // [Loop Continue]
        goto J0x3D;
    }
    //return;    
}

function int FindSaveSlotIndex(string McpId, string SaveSlotId)
{
    local int SaveSlotIndex;

    SaveSlotIndex = 0;
    J0x0B:

    // End:0xA5 [Loop If]
    if(SaveSlotIndex < SaveSlots.Length)
    {
        // End:0x97
        if((SaveSlots[SaveSlotIndex].OwningMcpId == McpId) && SaveSlots[SaveSlotIndex].SaveSlotId == SaveSlotId)
        {
            return SaveSlotIndex;
        }
        SaveSlotIndex++;
        // [Loop Continue]
        goto J0x0B;
    }
    return -1;
    //return ReturnValue;    
}

function int FindSaveSlotRequest(string McpId, string SaveSlotId, const out array<SaveSlotRequestState> InSaveSlotRequests)
{
    local int Index;

    Index = 0;
    J0x0B:

    // End:0xA5 [Loop If]
    if(Index < InSaveSlotRequests.Length)
    {
        // End:0x97
        if((InSaveSlotRequests[Index].McpId == McpId) && InSaveSlotRequests[Index].SaveSlotId == SaveSlotId)
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

function int FindItemRequest(string McpId, string SaveSlotId, string ItemId, const out array<InventoryItemRequestState> InItemRequests)
{
    local int Index;

    Index = 0;
    J0x0B:

    // End:0xDB [Loop If]
    if(Index < InItemRequests.Length)
    {
        // End:0xCD
        if(((InItemRequests[Index].McpId == McpId) && InItemRequests[Index].SaveSlotId == SaveSlotId) && InItemRequests[Index].ItemId == ItemId)
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

function PurchaseItem(string McpId, string SaveSlotId, string GlobalItemId, array<string> PurchaseItemIds, int Quantity, int StoreVersion, float Scalar)
{
    local string URL, paymentItemsJson;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex, Index;

    ExistingIndex = FindItemRequest(McpId, SaveSlotId, GlobalItemId, ItemRequests);
    // End:0x3FB
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x3F8
        if(Request != none)
        {
            URL = (((((((((((((((GetBaseURL()) $ PurchaseItemUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId) $ "&globalItemId=") $ GlobalItemId) $ "&quantity=") $ string(Quantity)) $ "&storeVersion=") $ string(StoreVersion)) $ "&scalar=") $ string(Scalar);
            // End:0x26C
            if(PurchaseItemIds.Length > 0)
            {
                paymentItemsJson = "[ ";
                Index = 0;
                J0x194:

                // End:0x21F [Loop If]
                if(Index < PurchaseItemIds.Length)
                {                    
                    paymentItemsJson $= (("\"" $ PurchaseItemIds[Index]) $ "\"");
                    // End:0x211
                    if((Index + 1) < PurchaseItemIds.Length)
                    {                        
                        paymentItemsJson $= ",";
                    }
                    Index++;
                    // [Loop Continue]
                    goto J0x194;
                }                
                paymentItemsJson $= " ]";                
                URL $= ("&paymentItemsJson=" $ paymentItemsJson);
            }
            Request.SetURL(URL);
            Request.SetVerb("POST");
            Request.__OnProcessRequestComplete__Delegate = OnPurchaseItemRequestComplete;
            AddAt = ItemRequests.Length;
            ItemRequests.Length = AddAt + 1;
            ItemRequests[AddAt].McpId = McpId;
            ItemRequests[AddAt].SaveSlotId = SaveSlotId;
            ItemRequests[AddAt].ItemId = GlobalItemId;
            ItemRequests[AddAt].Request = Request;
            // End:0x3F8
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnPurchaseItemRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, SaveSlotIndex, UpdatedItemIdIndex, FoundItemIndex, ResponseCode;

    local string ResponseString;
    local array<string> UpdatedItemIds;

    Index = ItemRequests.Find('Request', Request);
    // End:0x3E4
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x318
        if(bWasSuccessful)
        {
            ResponseString = Response.GetContentAsString();
            UpdatedItemIds = ParseInventoryForSaveSlot(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ResponseString);
            SaveSlotIndex = FindSaveSlotIndex(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId);
            // End:0x318
            if(SaveSlotIndex != -1)
            {
                UpdatedItemIdIndex = 0;
                J0x1C7:

                // End:0x318 [Loop If]
                if(UpdatedItemIdIndex < UpdatedItemIds.Length)
                {
                    FoundItemIndex = SaveSlots[SaveSlotIndex].Items.Find('InstanceItemId', UpdatedItemIds[UpdatedItemIdIndex]);
                    // End:0x30A
                    if(((FoundItemIndex != -1) && SaveSlots[SaveSlotIndex].Items[FoundItemIndex].Quantity == 0) && SaveSlots[SaveSlotIndex].Items[FoundItemIndex].QuantityIAP == 0)
                    {
                        SaveSlots[SaveSlotIndex].Items.Remove(FoundItemIndex, 1);
                    }
                    UpdatedItemIdIndex++;
                    // [Loop Continue]
                    goto J0x1C7;
                }
            }
        }
        OnPurchaseItemComplete(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ItemRequests[Index].ItemId, UpdatedItemIds, bWasSuccessful, Response.GetContentAsString());
        ItemRequests.Remove(Index, 1);
    }
    //return;    
}

function SellItem(string McpId, string SaveSlotId, string InstanceItemId, int Quantity, int StoreVersion, const optional out array<McpInventoryItemContainer> ExpectedResultItems)
{
    local string URL, expectedResultsItemsJson;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex, Index;

    ExistingIndex = FindItemRequest(McpId, SaveSlotId, InstanceItemId, ItemRequests);
    // End:0x4C0
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x4BD
        if(Request != none)
        {
            URL = (((((((((((((GetBaseURL()) $ SellItemUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId) $ "&instanceItemId=") $ InstanceItemId) $ "&quantity=") $ string(Quantity)) $ "&storeVersion=") $ string(StoreVersion);
            // End:0x2C7
            if(ExpectedResultItems.Length > 0)
            {
                expectedResultsItemsJson = "[ ";
                Index = 0;
                J0x17E:

                // End:0x2AE [Loop If]
                if(Index < ExpectedResultItems.Length)
                {                    
                    expectedResultsItemsJson $= "{";                    
                    expectedResultsItemsJson $= ((("\"global_item_id\":" $ "\"") $ ExpectedResultItems[Index].GlobalItemId) $ "\",");                    
                    expectedResultsItemsJson $= ("\"quantity\":" $ string(ExpectedResultItems[Index].Quantity));                    
                    expectedResultsItemsJson $= "}";
                    // End:0x2A0
                    if((Index + 1) < ExpectedResultItems.Length)
                    {                        
                        expectedResultsItemsJson $= ",";
                    }
                    Index++;
                    // [Loop Continue]
                    goto J0x17E;
                }                
                expectedResultsItemsJson $= " ]";
            }
            Request.SetURL(URL);
            Request.SetVerb("POST");
            Request.SetContentAsString(expectedResultsItemsJson);
            Request.SetHeader("Content-Type", "multipart/form-data");
            Request.__OnProcessRequestComplete__Delegate = OnSellItemRequestComplete;
            AddAt = ItemRequests.Length;
            ItemRequests.Length = AddAt + 1;
            ItemRequests[AddAt].McpId = McpId;
            ItemRequests[AddAt].SaveSlotId = SaveSlotId;
            ItemRequests[AddAt].ItemId = InstanceItemId;
            ItemRequests[AddAt].Request = Request;
            // End:0x4BD
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnSellItemRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, SaveSlotIndex, UpdatedItemIdIndex, FoundItemIndex, ResponseCode;

    local string ResponseString;
    local array<string> UpdatedItemIds;

    Index = ItemRequests.Find('Request', Request);
    // End:0x3E4
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x318
        if(bWasSuccessful)
        {
            ResponseString = Response.GetContentAsString();
            UpdatedItemIds = ParseInventoryForSaveSlot(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ResponseString);
            SaveSlotIndex = FindSaveSlotIndex(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId);
            // End:0x318
            if(SaveSlotIndex != -1)
            {
                UpdatedItemIdIndex = 0;
                J0x1C7:

                // End:0x318 [Loop If]
                if(UpdatedItemIdIndex < UpdatedItemIds.Length)
                {
                    FoundItemIndex = SaveSlots[SaveSlotIndex].Items.Find('InstanceItemId', UpdatedItemIds[UpdatedItemIdIndex]);
                    // End:0x30A
                    if(((FoundItemIndex != -1) && SaveSlots[SaveSlotIndex].Items[FoundItemIndex].Quantity == 0) && SaveSlots[SaveSlotIndex].Items[FoundItemIndex].QuantityIAP == 0)
                    {
                        SaveSlots[SaveSlotIndex].Items.Remove(FoundItemIndex, 1);
                    }
                    UpdatedItemIdIndex++;
                    // [Loop Continue]
                    goto J0x1C7;
                }
            }
        }
        OnSellItemComplete(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ItemRequests[Index].ItemId, UpdatedItemIds, bWasSuccessful, Response.GetContentAsString());
        ItemRequests.Remove(Index, 1);
    }
    //return;    
}

function EarnItem(string McpId, string SaveSlotId, string GlobalItemId, int Quantity, int StoreVersion)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindItemRequest(McpId, SaveSlotId, GlobalItemId, ItemRequests);
    // End:0x2E1
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x2DE
        if(Request != none)
        {
            URL = (((((((((((((GetBaseURL()) $ EarnItemUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId) $ "&globalItemId=") $ GlobalItemId) $ "&quantity=") $ string(Quantity)) $ "&storeVersion=") $ string(StoreVersion);
            Request.SetURL(URL);
            Request.SetVerb("POST");
            Request.__OnProcessRequestComplete__Delegate = OnEarnItemRequestComplete;
            AddAt = ItemRequests.Length;
            ItemRequests.Length = AddAt + 1;
            ItemRequests[AddAt].McpId = McpId;
            ItemRequests[AddAt].SaveSlotId = SaveSlotId;
            ItemRequests[AddAt].ItemId = GlobalItemId;
            ItemRequests[AddAt].Request = Request;
            // End:0x2DE
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnEarnItemRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, ResponseCode;
    local string ResponseString;
    local array<string> UpdatedItemIds;

    Index = ItemRequests.Find('Request', Request);
    // End:0x215
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x149
        if(bWasSuccessful)
        {
            ResponseString = Response.GetContentAsString();
            UpdatedItemIds = ParseInventoryForSaveSlot(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ResponseString);
        }
        OnEarnItemComplete(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ItemRequests[Index].ItemId, UpdatedItemIds, bWasSuccessful, Response.GetContentAsString());
        ItemRequests.Remove(Index, 1);
    }
    //return;    
}

function ConsumeItem(string McpId, string SaveSlotId, string InstanceItemId, int Quantity, int StoreVersion)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindItemRequest(McpId, SaveSlotId, InstanceItemId, ItemRequests);
    // End:0x2E3
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x2E0
        if(Request != none)
        {
            URL = (((((((((((((GetBaseURL()) $ ConsumeItemUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId) $ "&instanceItemId=") $ InstanceItemId) $ "&quantity=") $ string(Quantity)) $ "&storeVersion=") $ string(StoreVersion);
            Request.SetURL(URL);
            Request.SetVerb("POST");
            Request.__OnProcessRequestComplete__Delegate = OnConsumeItemRequestComplete;
            AddAt = ItemRequests.Length;
            ItemRequests.Length = AddAt + 1;
            ItemRequests[AddAt].McpId = McpId;
            ItemRequests[AddAt].SaveSlotId = SaveSlotId;
            ItemRequests[AddAt].ItemId = InstanceItemId;
            ItemRequests[AddAt].Request = Request;
            // End:0x2E0
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnConsumeItemRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, ResponseCode;
    local string ResponseString;
    local array<string> UpdatedItemIds;

    Index = ItemRequests.Find('Request', Request);
    // End:0x215
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x149
        if(bWasSuccessful)
        {
            ResponseString = Response.GetContentAsString();
            UpdatedItemIds = ParseInventoryForSaveSlot(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ResponseString);
        }
        OnConsumeItemComplete(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ItemRequests[Index].ItemId, UpdatedItemIds, bWasSuccessful, Response.GetContentAsString());
        ItemRequests.Remove(Index, 1);
    }
    //return;    
}

function DeleteItem(string McpId, string SaveSlotId, string InstanceItemId, int StoreVersion)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindItemRequest(McpId, SaveSlotId, InstanceItemId, ItemRequests);
    // End:0x2CA
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x2C7
        if(Request != none)
        {
            URL = (((((((((((GetBaseURL()) $ DeleteItemUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId) $ "&instanceItemId=") $ InstanceItemId) $ "&storeVersion=") $ string(StoreVersion);
            Request.SetURL(URL);
            Request.SetVerb("DELETE");
            Request.__OnProcessRequestComplete__Delegate = OnDeleteItemRequestComplete;
            AddAt = ItemRequests.Length;
            ItemRequests.Length = AddAt + 1;
            ItemRequests[AddAt].McpId = McpId;
            ItemRequests[AddAt].SaveSlotId = SaveSlotId;
            ItemRequests[AddAt].ItemId = InstanceItemId;
            ItemRequests[AddAt].Request = Request;
            // End:0x2C7
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnDeleteItemRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, SaveSlotIndex, ItemIndex, ResponseCode;

    Index = ItemRequests.Find('Request', Request);
    // End:0x295
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x1D2
        if(bWasSuccessful)
        {
            SaveSlotIndex = FindSaveSlotIndex(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId);
            // End:0x1D2
            if(SaveSlotIndex != -1)
            {
                ItemIndex = SaveSlots[SaveSlotIndex].Items.Find('InstanceItemId', ItemRequests[Index].ItemId);
                // End:0x1D2
                if(ItemIndex != -1)
                {
                    SaveSlots[SaveSlotIndex].Items.Remove(ItemIndex, 1);
                }
            }
        }
        OnDeleteItemComplete(ItemRequests[Index].McpId, ItemRequests[Index].SaveSlotId, ItemRequests[Index].ItemId, bWasSuccessful, Response.GetContentAsString());
        ItemRequests.Remove(Index, 1);
    }
    //return;    
}

function RecordIap(string McpId, string SaveSlotId, string Receipt)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt, ExistingIndex;

    ExistingIndex = FindSaveSlotRequest(McpId, SaveSlotId, SaveSlotRequests);
    // End:0x2BB
    if(ExistingIndex == -1)
    {
        Request = Class'Engine.HttpFactory'.static.CreateRequest();
        // End:0x2B8
        if(Request != none)
        {
            URL = (((((((GetBaseURL()) $ IapRecordUrl) $ (GetAppAccessURL())) $ (GetUserAuthURL(McpId))) $ "&uniqueUserId=") $ McpId) $ "&saveSlotId=") $ SaveSlotId;
            Request.SetURL(URL);
            Request.SetVerb("POST");
            Request.__OnProcessRequestComplete__Delegate = OnRecordIapRequestComplete;
            Request.SetContentAsString(Receipt);
            Request.SetHeader("Content-Type", "multipart/form-data");
            AddAt = SaveSlotRequests.Length;
            SaveSlotRequests.Length = AddAt + 1;
            SaveSlotRequests[AddAt].McpId = McpId;
            SaveSlotRequests[AddAt].SaveSlotId = SaveSlotId;
            SaveSlotRequests[AddAt].Request = Request;
            // End:0x2B8
            if(!Request.ProcessRequest())
            {
            }
        }        
    }
    //return;    
}

function OnRecordIapRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, ResponseCode;
    local string ResponseString;
    local array<string> UpdatedItemIds;

    Index = SaveSlotRequests.Find('Request', Request);
    // End:0x1EF
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x149
        if(bWasSuccessful)
        {
            ResponseString = Response.GetContentAsString();
            UpdatedItemIds = ParseInventoryForSaveSlot(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId, ResponseString);
        }
        OnRecordIapComplete(SaveSlotRequests[Index].McpId, SaveSlotRequests[Index].SaveSlotId, UpdatedItemIds, bWasSuccessful, Response.GetContentAsString());
        SaveSlotRequests.Remove(Index, 1);
    }
    //return;    
}

defaultproperties
{
    CreateSaveSlotUrl="/createsaveslot"
    DeleteSaveSlotUrl="/deletesaveslot"
    ListSaveSlotUrl="/listsaveslot"
    ListItemsUrl="/listitems"
    PurchaseItemUrl="/purchaseitem"
    SellItemUrl="/sellitem"
    EarnItemUrl="/earnitem"
    ConsumeItemUrl="/consumeitem"
    DeleteItemUrl="/deleteitem"
    IapRecordUrl="/recordiap"
}