*** Settings ***
Resource          ../../../library/library_web.robot

*** Keywords ***
Search Text
    [Arguments]    ${text}
    Wait Until Element Is Visible    //input[@class="form-control serach"]    ${WAIT_TIMEOUT}    未显示搜索框
    Input Text    //input[@class="form-control serach"]    ${text}    #输入订单编号进行搜索
    Click Button    jquery=button.search_submit    #点击搜索按钮

Buyer Search Good From Index Page
    [Arguments]    ${searchGoodGyzz}    ${searchGoodId}    ${goodName}
    Switch Browser    ${BUYER_BROWSER}
    输入商品进行搜索    ${searchGoodGyzz}
    搜索到对应商品    ${searchGoodId}    ${goodName}

质管审核时搜索新品
    [Arguments]    ${goodsName}
    Wait Until Element Is Visible    KeyWords    ${WAIT_TIMEOUT}    #等待搜索框显示
    Input Text    KeyWords    ${goodsName}    #输入搜索新品
    Wait Until Element Is Visible    search    ${WAIT_TIMEOUT}
    Click Element    search    #点击搜索按钮

输入商品进行搜索
    [Arguments]    ${searchGoodGyzz}
    Go To    ${INDEX_URL}
    Wait Until Element Is Visible    hotKeyword    ${WAIT_TIMEOUT}    首页搜索未加载出来
    Input Text    searchInput    ${searchGoodGyzz}
    Click Button    btnSearch

搜索到对应商品
    [Arguments]    ${searchGoodId}    ${goodName}
    Wait Until Element Is Visible    //div[@class="item-title"]/a[@title="${goodName}"]    ${WAIT_TIMEOUT}    品种图片未显示
    Click Element    //div[@class="item-title"]/a[@title="${goodName}"]    #进入品种详情页
    Sleep    2s
    Select Window    title=${goodName}
    Wait Until Element Is Visible    //li[@data-shopdomain="${SALES_NAME}"]    ${WAIT_TIMEOUT}    未显示当前商品在售的商业数据
    ${searchGoodId}    Get Element Attribute    //li[@data-shopdomain="${SALES_NAME}"]@data-goodsid
    Set Suite Variable    ${searchGoodId}

关闭搜索引导蒙层
    Wait Until Element Is Visible    yBtnClose    ${WAIT_TIMEOUT}    搜索失败，未搜索到商品
    Click Element    yBtnClose
