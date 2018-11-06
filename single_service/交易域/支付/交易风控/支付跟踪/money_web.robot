*** Settings ***
Resource          ../../../../../library/library_web.robot

*** Keywords ***
Get Account Balance From Pur Page
    Switch Browser    ${BUYER_BROWSER}
    Go To    ${PUR_URL}
    Wait Until Element Is Visible    //div[@class="right-module"]/p[1]    ${WAIT_TIMEOUT}    显示账户余额
    ${text}=    Get Text    //div[@class="right-module"]/p[1]    #获取账户余额
    @{ACCOUNT_BALANCE}=    Get Regexp Matches    ${text}    账户余额：(.*)元    1
    ${ACCOUNT_BALANCE}    Convert To String    @{ACCOUNT_BALANCE}[0]
    Set Global Variable    ${ACCOUNT_BALANCE}
    Go Back
