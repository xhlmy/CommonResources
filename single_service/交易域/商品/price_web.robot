*** Settings ***
Resource          ../../../library/library_web.robot

*** Keywords ***
修改商品省价格
    Wait Until Element Is Visible    //div[@class="price-set"]//li[1]    ${WAIT_TIMEOUT}    价格修改页面的区域还未加载出来
    Clear Element Text    //input[@code="${BUYER_AREA_CODE}"]
    ${random}    Evaluate    round(random.uniform(5,10),2)    random,sys
    ${random}    Convert To String    ${random}
    ${GOODS_NEW_PRICE}    Set Variable    ${random}
    Set Global Variable    ${GOODS_NEW_PRICE}
    Input Text    //input[@code="${BUYER_AREA_CODE}"]    ${GOODS_NEW_PRICE}
    Click Element    btnPriceSubmit
    Wait Until Element Is Visible    //table/tbody/tr[1]/td[9]    ${WAIT_TIMEOUT}    修改价格失败

进入商品详情页查看商品价格
    Go To    ${GOOD_DETAIL_URL}
    Wait Until Keyword Succeeds    5 times    1s    等待商品详情页价格显示
    Should Be Equal As Numbers    ${PRICE}    ${GOODS_NEW_PRICE}    价格同步失败

等待商品详情页价格显示
    Wait Until Element Is Visible    //b[@name="goodsPrice"]
    ${priceStr}    get text    //b[@name="goodsPrice"]
    Should Not Be Equal    ${priceStr}    ¥0.00
    @{price}    Get Regexp Matches    ${priceStr}    ¥(.*)    1
    ${PRICE}    Convert To String    @{price}[0]
    Set Suite Variable    ${PRICE}

从搜索结果页面获取商品价格
    [Arguments]    ${searchGoodId1}
    Wait Until Element Is Visible    //li[@data-goodsid="${SEARCH_GOOD_ID}"]//div[@class="goodsCard-price goodsCard-item"]//span    ${WAIT_TIMEOUT}    搜索结果页未显示出商品价格
    ${text}    Get Text    //li[@data-goodsid="${SEARCH_GOOD_ID}"]//div[@class="goodsCard-price goodsCard-item"]//span
    @{goodPrice}=    Get Regexp Matches    ${text}    ￥(.*)    1
    ${GOOD_PRICE}    Convert To String    @{goodPrice}[0]
    Set Global Variable    ${GOOD_PRICE}

从购物车获取商品价格
    Wait Until Element Is Visible    //tr[@id='J_goodsTr_${searchGoodId}']/td[4]//span    ${WAIT_TIMEOUT}    购物车商品未显示
    ${text}    Get Text    //tr[@id='J_goodsTr_${searchGoodId}']/td[4]//span
    @{goodPrice}=    Get Regexp Matches    ${text}    ￥(.*)    1
    ${GOOD_PRICE}    Convert To String    @{goodPrice}[0]
    Set Global Variable    ${GOOD_PRICE}
