*** Settings ***
Resource          ../../../../library/library_web.robot

*** Keywords ***
Ensure The Cart Is Empty
    [Documentation]    writer:yyy
    Comment    Go To    ${CART_URL}/cart/index
    Comment    ${status}    Run Keyword And Return Status    Wait Until Page Contains    您的购物车空空的~，去看看心仪的商品吧~
    Comment    Run Keyword If    '${status}'=='False'    Clear Cart
    Comment    Go To    ${INDEX_URL}
    Go To    ${CART_URL}/shopping/emptyCart

Clear Cart
    [Documentation]    writer:yyy
    Wait Until Element Is Visible    checkAll    ${WAIT_TIMEOUT}    购物车商品未显示
    Click Element    checkAll
    Click Button    //button[@class="deleteAll"]
    Wait Until Element Is Visible    //a[@class="layui-layer-btn0"]
    Click Element    //a[@class="layui-layer-btn0"]
    Wait Until Page Contains    您的购物车空空的~，去看看心仪的商品吧~

Buyer Joined Cart From Search Reasult Page
    [Arguments]    ${searchGoodId}
    Execute Javascript    $("input[data-skuid='${searchGoodId}']").attr('value',${BUY_NUMBER})    # $("li[data-goodsid='${searchGoodId}'] div.num-operate input").attr('value',${BUY_NUMBER})
    Sleep    2s
    Wait Until Element Is Visible    //li[@data-goodsid="${searchGoodId}"]//span[@class="j_addCart goodsCard-shop-addshop "]
    Click Element    //li[@data-goodsid="${searchGoodId}"]//span[@class="j_addCart goodsCard-shop-addshop "]    #点击加入购物车    //span[@class="j_addCart goodsCard-shop-addshop"]
    #超出活动限购数量的弹窗提示是否弹出
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //a[@class="layui-layer-btn0"]    5s
    Run Keyword if    '${status}'=='True'    Click Element    //a[@class="layui-layer-btn0"]    #点击原价购买商品
    Capture Page Screenshot
    Sleep    5s
    Go To    ${CART_URL}/cart/index
    Wait Until Element Is Visible    //tr[@id="J_goodsTr_${searchGoodId}"]    5s

选择原价购买商品
    Click Element    //a[@class="layui-layer-btn0"]    #点击原价购买商品
