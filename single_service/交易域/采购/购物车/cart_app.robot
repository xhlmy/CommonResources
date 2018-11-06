*** Settings ***
Resource          ../../../../library/library_app.robot

*** Keywords ***
Clear Cart
    Click Element    //android.view.View[@content-desc='编辑']
    Wait Until Page Does Not Contain    总价    30
    Click Element    //android.view.View[@content-desc="全选"]
    Sleep    2    #等待元素被选中
    Swipe    650    1250    650    1251    100
    Wait Until Page Contains    搜索购
    Click Element    //android.view.View[@content-desc='cart']

Buyer Joins Goods To Cart
    Wait Until Page Contains Element    name=加入购物车
    Click Element    name=加入购物车
    Wait Until Page Contains Element    //android.view.View[@content-desc='确认']
    Click Element    //android.view.View[@content-desc='确认']
    Wait Until Page Does Not Contain Element    //android.view.View[@content-desc='确认']    ${WAIT_TIMEOUT}
    Swipe    65    1187    65    1187
    Wait Until Page Contains    去结算    ${WAIT_TIMEOUT}
    Click Element    name=+
    Click Element    name=+
    Click Element    name=+
    Click Element    name=+
    Click Element    name=+
    Click Element    name=+

Buyer`s Cart Is Empty
    Click Element    id=com.ypzdw.yaoyi:id/tab_buy
    Wait Until Page Contains Element    //android.webkit.WebView    ${WAIT_TIMEOUT}
    Click Element At Coordinates    668    75
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    搜索购    ${WAIT_TIMEOUT}
    Run Keyword If    '${status}'=='False'    Clear Cart
    ...    ELSE    Go Back
