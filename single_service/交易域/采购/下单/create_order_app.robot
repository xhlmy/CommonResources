*** Settings ***
Resource          ../../../../library/library_app.robot

*** Keywords ***
Buyer Submits Order
    Wait Until Page Contains Element    name=提交订单    ${WAIT_TIMEOUT}    #提交订单按钮未显示
    Click Element    name=提交订单
    Wait Until Page Contains    支付    ${WAIT_TIMEOUT}

Buyer Confirms Order Messages
    ${BUY_NUMBER}    Get Element Attribute    //android.widget.EditText    name
    Set Global Variable    ${BUY_NUMBER}
    Click Element    //android.view.View[@content-desc="去结算 (0)"]
    Wait Until Page Contains    提交订单    ${WAIT_TIMEOUT}
