*** Settings ***
Resource          ../../library/library_app.robot
Library           AndroidLibrary

*** Keywords ***
Start ZDB
    Open Application    http://127.0.0.1:4723/wd/hub    platformName=Android    platformVersion=23    deviceName=192.168.56.101:5555    automationName=appium    appActivity=ui.splash.SplashActivity
    ...    appPackage=com.ypzdw.yaoyi    unicodeKeyboard=True    resetKeyboard=True
    Reset Application
    Swipe Page

Swipe Page
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/viewpager    8
    Swipe    690    700    40    700
    Swipe    690    700    40    700
    Swipe    690    700    40    700
    Click Element    id=com.ypzdw.yaoyi:id/btn_go
    Wait Until Page Contains    登录

ZDB Login
    [Arguments]    ${user}    ${pwd}
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/btn_login    20
    Clear Text    id=com.ypzdw.yaoyi:id/edt_mobile
    Input Text    id=com.ypzdw.yaoyi:id/edt_mobile    ${user}
    AppiumLibrary.Input Password    id=com.ypzdw.yaoyi:id/edt_password    ${pwd}
    Click Element    id=com.ypzdw.yaoyi:id/btn_login
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/iv_tab    ${WAIT_TIMEOUT}    登录失败
