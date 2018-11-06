*** Settings ***
Resource          ../../../library/library_web.robot
Resource          ../../../single_service/交易域/搜索/search_web.robot
Resource          ../../../single_service/交易域/商品/goods_web.robot

*** Keywords ***
Check The Blocked Inventory Released
    Go To    ${SALES_URL}/Goods/GoodsManage/Index
    Search Text    ${SEARCH_GOOD_GYZZ}
    Wait Until Element Is Visible    //a[@class="atoe"]    ${WAIT_TIMEOUT}    商品未搜索出来
    供应商进入商品编辑界面
    Wait Until Element Is Visible    //div[@class="disnum"]/span[2]
    ${blockedInventoryNew}    Get Text    //div[@class="disnum"]/span[2]
    ${different}    Evaluate    ${BLOCKED_INVENTORY_LAST}-${blockedInventoryNew}
    Should Be Equal As Strings    ${different}    ${BUY_NUMBER}    #出库后释放冻结库存
