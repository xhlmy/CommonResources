*** Settings ***
Resource          ../../library/library_web.robot

*** Variables ***

*** Keywords ***
Saler Logined Successfully
    ${SALER_BROWSER}=    Open Browser    ${PASSPORT_URL}    firefox
    Set Browser Implicit Wait    5 seconds
    Set Global Variable    ${SALER_BROWSER}
    Maximize Browser Window
    Login With Moblile    ${SALES_MOBILE}    ${SALES_PWD}

Manager Logined Successfully
    ${MANAGE_BROWSER}=    Open Browser    ${M_URL}    firefox
    Set Global Variable    ${MANAGE_BROWSER}
    Input Text    username    ${MANAGER_NAME}
    Input Password    password    ${MANAGER_PWD}
    Click Button    //div[@class="form-actions"]/button
    Wait Until Page Contains Element    autoheight

Buyer Logined Successfully
    [Arguments]    ${buyerMobile}=${BUYER_MOBILE}    ${buyerPwd}=${BUYER_PWD}
    ${BUYER_BROWSER}=    Open Browser    ${PASSPORT_URL}    chrome
    Set Global Variable    ${BUYER_BROWSER}
    Maximize Browser Window
    Login With Moblile    ${buyerMobile}    ${buyerPwd}

Close Browsers
    Delete All Cookies
    Close All Browsers
    OperatingSystem.Run    taskkill /F /M firefox.exe*32
    OperatingSystem.Run    taskkill /F /M ChromeDriver.exe

ZDB Manager Logined Successfully
    ${MANAGE_BROWSER}=    Open Browser    ${ZDB_BACKGROUND_URL}    firefox
    Set Global Variable    ${MANAGE_BROWSER}
    Input Text    id=inputName    ${ZDB_MANAGER_USERNAME}
    Input Text    id=inputPassword    ${ZDB_MANAGER_PASSWORD}
    Click Element    //button[@type="submit"]
    Maximize Browser Window
    Wait Until Page Contains    内容    ${WAIT_TIMEOUT}    药豆后台未加载成功

Login With Account
    [Arguments]    ${userName}    ${password}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    jquery=a.margin_r10    ${WAIT_TIMEOUT}
    Run Keyword If    '${status}'=='True'    Click Element    jquery=a.margin_r10    #点击登录按钮
    Wait Until Element Is Visible    J_guide_first_btn
    Click Element    J_guide_first_btn
    Wait Until Element Is Visible    J_guide_second_btn
    Click Element    J_guide_second_btn
    Click Element    J_lg_account
    Wait Until Element Is Visible    J_lg_usNm
    Input Text    J_lg_usNm    ${userName}    #输入用户名
    Input Text    J_lg_psWd    ${password}    #输入密码
    Press Key    J_login    \\13    #按回车键登录
    Wait Until Element Is Visible    //a[contains(text(),'退出')]    ${WAIT_TIMEOUT}    登录失败

Login With Moblile
    [Arguments]    ${mobile}    ${password}
    Wait Until Element Is Visible    J_guide_first_btn
    Click Element    J_guide_first_btn
    Click Element    J_guide_second_btn
    Click Element    J_lg_mobile
    Input Text    J_lg_usNm    ${mobile}    #输入用户名
    Input Text    J_lg_psWd    ${password}    #输入密码
    Press Key    J_login    \\13    #按回车键登录
    Wait Until Element Is Visible    //a[contains(text(),'退出')]    ${WAIT_TIMEOUT}    登录失败
