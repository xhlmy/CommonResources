*** Settings ***
Resource          ../../../library/library_web.robot
Resource          ../../../single_service/交易域/商品/goods_web.robot
Resource          ../../../single_service/交易域/商品/inventory_web.robot
Resource          ../../../single_service/交易域/商品/price_web.robot
Resource          ../../../single_service/交易域/搜索/search_web.robot
Resource          ../../../single_service/交易域/商品/goods_web.robot

*** Keywords ***
确认商品已上架
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/Goods/GoodsManage/Index
    Search Text    ${SEARCH_GOOD_GYZZ}
    Wait Until Element Is Visible    jquery=div.sm-show a    ${WAIT_TIMEOUT}    商品未搜索出来
    ${state}    get text    //div[@class="Form-list table-responsive"]/table/tbody/tr/td[8]/span    #获取商品状态
    Run Keyword If    '${state}'=='下架'    供应商修改商品上下架状态    上架

商业修改价格和库存
    #修改价格
    Go To    ${SALES_URL}/Goods/GoodsManage/SetGoodsPrice/${SEARCH_GOOD_ID}
    修改商品省价格
    Comment    保存修改后的商品价格
    #修改库存
    ${INVENTORY_NEW}    Evaluate    random.randint(7000,9999)    random,sys    #设置库存为200-999之间的随机数
    Set Global Variable    ${INVENTORY_NEW}    #设置为测试集里面使用的参数
    Comment    供应商进入商品编辑界面
    Go To    ${SALES_URL}/Goods/GoodsManage/Edit/${SEARCH_GOOD_ID}
    修改库存    ${INVENTORY_NEW}    1

获取商品ID
    [Arguments]    ${goodsGyzz}
    Go To    ${SALES_URL}/Goods/GoodsManage/Index
    Search Text    ${goodsGyzz}
    Wait Until Element Is Visible    jquery=div.sm-show a    ${WAIT_TIMEOUT}
    ${goodsUrl}    Get Element Attribute    //dd/p/a@href
    @{goodsid}    Get Regexp Matches    ${goodsUrl}    /(.*)/(.*)    2
    ${GOODSID}    Evaluate    @{goodsid}[0]
    Set Suite Variable    ${GOODSID}
