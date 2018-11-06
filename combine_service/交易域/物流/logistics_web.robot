*** Settings ***
Resource          ../../../library/library_web.robot
Resource          ../../../single_service/交易域/搜索/search_web.robot

*** Keywords ***
Registration Logistics Information
    Comment    Select Radio Button    optionsRadios    1    #选择“快递”配送方式
    Comment    Wait Until Element Is Enabled    s2id_SLName
    Comment    Click Element    s2id_SLName    #点击配送公司下拉框
    Comment    Wait Until Element Is Visible    //ul[@class="select2-results"]/li[5]/div    ${WAIT_TIMEOUT}    #等待配送公司显示出来
    Comment    Click Element    //ul[@class="select2-results"]/li[5]/div    #选择配送公司：韵达快递
    Comment    Wait Until Element Is Visible    //ul[@class="select2-results"]/li[5]/div    ${WAIT_TIMEOUT}
    Comment    Wait Until Element Is Visible    //input[@name="ExpressNumber"]    ${WAIT_TIMEOUT}
    Comment    Execute Javascript    $('input[name="ExpressNumber"]:eq(0)').attr("value", 12345);    #填写快递单号
    Comment    Execute Javascript    $('input[name="ExpressNumber"]:eq(0)').blur()
    Comment    Click Button    l_submit2    #点击确认提交按钮
    Go To    ${SALES_URL}/Order/Order/Index
    Search Text    ${ORDERCODE}
    Wait Until Element Contains    jquery=div.Form-list table tbody tr td:eq(7) span    等待收货    ${WAIT_TIMEOUT}    出库失败
