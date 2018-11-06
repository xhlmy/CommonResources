*** Settings ***
Resource          ../../../library/library_web.robot
Resource          ../../../single_service/交易域/搜索/search_web.robot

*** Keywords ***
Saler Confirm Order
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/Order/Order/Index    #进入所有订单列表
    Search Text    ${ORDERCODE}
    Wait Until Element Is Visible    //a[@class="oper click_confirm_order"]    ${WAIT_TIMEOUT}    无法确认订单
    Click Element    //a[@class="oper click_confirm_order"]    #点击确认订单
    Wait Until Element Is Visible    confirmModalYes    #等待确认订单的“是”按钮加载出来
    Click Element    confirmModalYes    #点击确认订单的“是”按钮
    Wait Until Keyword Succeeds    3s    1s    Wait Until Element Contains    jquery=div.Form-list table tbody tr td:eq(7) span    等待出库    ${WAIT_TIMEOUT}
    ...    确认订单失败

Saler Confirms The Unreceipted Goods
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/Order/Red/Index    #进入冲红查询界面
    Search Text    ${ORDERCODE}
    Wait Until Element Is Visible    jquery=a.oper    ${WAIT_TIMEOUT}
    Click Element    jquery=a.oper    #点击查看按钮
    Wait Until Element Is Visible    jquery=a.btn-xxs    ${WAIT_TIMEOUT}
    Click Element    jquery=a.btn-xxs    #确认冲红按钮
    Wait Until Element Is Visible    confirmModalYes    ${WAIT_TIMEOUT}
    Click Element    confirmModalYes    #确认冲红
    Search Text    ${ORDERCODE}
    Wait Until Element Contains    //span[@class="c-green"]    已完成    ${WAIT_TIMEOUT}    确认冲红失败

Buyer Closes Order
    Switch Browser    ${BUYER_BROWSER}
    Go To    ${PUR_URL}/Order/Home/Detail?id=${ORDER_CODE}
    Wait Until Element Is Visible    //a[@href="/Order/Home/Close?id=${ORDER_CODE}"]
    Click Element    //a[@href="/Order/Home/Close?id=${ORDER_CODE}"]
    Wait Until Element Is Visible    confirmModalYes    ${WAIT_TIMEOUT}    未弹出确认关闭订单的提示
    Click Element    confirmModalYes
    Wait Until Element Is Visible    jquery=span:contains("已关闭")    ${WAIT_TIMEOUT}    关闭订单后订单状态未改变

Saler Closes Order
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/Order/Order/Index
    Search Text    ${ORDERCODE}
    Wait Until Element Contains    //table/tbody/tr/td/a    ${ORDERCODE}
    Click Element    //a[@onclick="order.close('${ORDERCODE}')"]
    Wait Until Element Is Visible    //input[@value="买家要求关闭订单"]
    Click Element    //input[@value="买家要求关闭订单"]
    Click Element    //button[@name="submit"]
    Sleep    5s
    Wait Until Element Contains    jquery=span:contains("已关闭")    已关闭    ${WAIT_TIMEOUT}
