*** Settings ***
Resource          ../../../../library/library_web.robot
Resource          ../../../../single_service/交易域/搜索/search_web.robot

*** Keywords ***
Buyer Pay Order
    Switch Browser    ${BUYER_BROWSER}
    Select Window    title= 支付订单 - 支付平台 - 药品终端网
    Click Button    btnSubmit    #点击立即支付
    Wait Until Element Is Visible    //div[@class="pay_succeed"]    ${WAIT_TIMEOUT}    支付失败
    Comment    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //a[@id='J_getCoupon']    3s
    Comment    Run Keyword If    '${status}'=='True'    Go To    ${PUR_URL}/Order/Home
    Comment    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //div[@class="btn-content"]    3s
    Comment    Run Keyword If    '${status}'=='True'    Reload Page
    Comment    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //bottom[@class="btnstyle setlocalStorage"]    3s    #存在邮寄资质的提示
    Comment    Run Keyword If    '${status}'=='True'    选择已经邮寄，不再提示
    Go To    ${PUR_URL}/Order/Home
    Wait Until Element Is Visible    jquery=input.serach    3s    支付成功没有跳到订单列表页面
    Search Text    ${ORDERCODE}    #搜索订单
    Wait Until Element Contains    //div[@class="Form-list"]/table/tbody/tr/td[7]/span    等待出库    3s    #验证订单状态是否是等待出库

选择已经邮寄，不再提示
    Wait Until Element Is Visible    //bottom[@class="btnstyle setlocalStorage"]    3s    邮寄三证合一的提示框未显示
    Click Element    //bottom[@class="btnstyle setlocalStorage"]
