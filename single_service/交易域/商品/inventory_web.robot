*** Settings ***
Resource          ../../../library/library_web.robot

*** Keywords ***
从商品编辑页获取商品库存信息
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/Goods/GoodsManage/Edit/${SEARCH_GOOD_ID}
    Wait Until Element Is Visible    //input[@name="Inventory"]
    #获取实时库存
    ${INVENTORY}=    Get Element Attribute    //input[@name="Inventory"]@value
    Set Global Variable    ${INVENTORY}
    #获取冻结库存
    ${BLOCKED_INVENTORY}    Get Text    //div[@class="disnum"]/span[2]
    Set Global Variable    ${BLOCKED_INVENTORY}

Check The Inventory Blocked
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/Goods/GoodsManage/Edit/${SEARCH_GOOD_ID}
    Wait Until Element Is Visible    //div[@class="disnum"]/span[2]
    #验证库存冻结
    ${BLOCKED_INVENTORY_LAST}    Get Text    //div[@class="disnum"]/span[2]
    Set Global Variable    ${BLOCKED_INVENTORY_LAST}
    ${different}    Evaluate    ${BLOCKED_INVENTORY_LAST}-${BLOCKED_INVENTORY}
    Should Be Equal As Strings    ${different}    ${BUY_NUMBER}    #下单后冻结库存
    #验证实际库存减少
    ${INVENTORY_LAST}    Get Element Attribute    //input[@name="Inventory"]@value
    Set Global Variable    ${INVENTORY_LAST}
    ${difference}=    Evaluate    ${INVENTORY}-${INVENTORY_LAST}
    Should Be Equal As Strings    ${difference}    ${BUY_NUMBER}

修改库存
    [Arguments]    ${inventory}    ${minBuyNum}
    Wait Until Element Is Visible    IsCheckInventory    ${WAIT_TIMEOUT}
    Unselect Checkbox    IsCheckInventory    #取消勾选库存
    Select Checkbox    IsCheckInventory    #勾选库存
    Comment    Clear Element Text    //input[@name="Inventory"]
    Comment    Input Text    //input[@name="Inventory"]    ${inventory}
    Comment    Clear Element Text    //input[@name="MinNum"]
    Comment    Input Text    //input[@name="MinNum"]    ${minBuyNum}
    Execute Javascript    $('dd.inventory input.NumInt' ).attr('value',${inventory})    #修改商品库存
    Execute Javascript    $('dd.inventory input.NumInt' ).blur()    #修改商品库存
    Execute Javascript    $('[name=MinNum]' ).attr('value',${minBuyNum})    #修改最小采购量
    Execute Javascript    $('[name=MinNum]' ).blur
    Sleep    1s
    Wait Until Keyword Succeeds    2 times    1s    Submit Goods Information

Submit Goods Information
    Click Element    //a[@name="submit"]    #jquery=a[name='submit']
    Wait Until Element Is Visible    //table/tbody/tr[1]/td[9]
