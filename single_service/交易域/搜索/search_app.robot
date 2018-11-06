*** Settings ***
Resource          ../../../library/library_app.robot

*** Keywords ***
Buyer Searches Goods
    进入采购页进行搜索
    Wait Until Page Contains    ${COMPANY_NAME}    ${WAIT_TIMEOUT}    未搜索出商品

采购商无法搜索到商品
    进入采购页进行搜索
    Wait Until Page Does Not Contain    ${COMPANY_NAME}    ${WAIT_TIMEOUT}    已下架商品依然搜索出

New Buyer Searches Goods
    Reset Application
    Swipe Page
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    进入采购页进行搜索
    Wait Until Page Contains    ${COMPANY_NAME}    ${WAIT_TIMEOUT}    未搜索出商品

进入采购页进行搜索
    ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_buy
    Run Keyword If    '${status}'=='True'    Click Element    id=com.ypzdw.yaoyi:id/tab_buy
    Wait Until Page Contains Element    //android.view.View[@content-desc="请输入商品名称"]    ${WAIT_TIMEOUT}    搜索购框未加载出现
    Click Element    //android.view.View[@content-desc="请输入商品名称"]
    Wait Until Page Contains Element    //android.widget.EditText    ${WAIT_TIMEOUT}    搜索商品框未加载出
    Switch To Context    WEBVIEW
    Click Element    id=searchInput
    input text    id=searchInput    ${SEARCH_GOOD_GYZZ}
    Switch To Context    NATIVE_APP
    Press Keycode    66
