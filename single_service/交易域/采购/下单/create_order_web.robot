*** Settings ***
Resource          ../../../../Library/library_web.robot

*** Keywords ***
Buyer Confirm Order
    Wait Until Element Is Visible    //tr[@id='J_goodsTr_${searchGoodId}']    ${WAIT_TIMEOUT}    购物车商品未加载出来
    Click Element    //div[@class="cart-header"]//input[@id="checkAll"]
    Wait Until Element Is Visible    //button[@class="btn-submit"]
    Click Button    J_submit
    Wait Until Element Is Visible    //input[@name='rdoAddr']    ${WAIT_TIMEOUT}    确认订单页面的收货地址未显示

Buyer Submits Order
    Switch Browser    ${BUYER_BROWSER}
    Sleep    1s
    Wait Until Element Is Visible    J_submit    ${WAIT_TIMEOUT}    确认订单页面的提交订单按钮未显示
    Click Button    J_submit
    Wait Until Page Contains    订单提交成功，请您及时付款，以便尽快为您发货~    ${WAIT_TIMEOUT}    提交了订单后未跳转到付款页面
    #以下是获取页面url内的订单号
    Execute Javascript    alert(window.location.href)
    ${url}    Get Alert Message
    @{re}    Get Regexp Matches    ${url}    (DD.*)&type    1
    ${ORDERCODE}    Convert To String    @{re}[0]
    Set Global Variable    ${ORDERCODE}
