class UIInteractable_Button_Price extends UIInteractable_Button
    native(UIComponent);

const BUTTON_PRICE_NUM_PRICES = 3;

var protected GFxObject m_mcPrices[3];
var protected string m_sPriceLoadNames[3];
var private int m_nPriceIndex;

defaultproperties
{
    m_sPriceLoadNames[0]="PriceA"
    m_sPriceLoadNames[1]="PriceB"
    m_sPriceLoadNames[2]="PriceC"
}