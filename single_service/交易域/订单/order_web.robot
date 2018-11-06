*** Settings ***
Resource          ../../../library/library_web.robot

*** Variables ***

*** Keywords ***
Out Cargo
    Click Element    //a[@class="oper"]    #点击出库按钮
    Wait Until Element Is Visible    jquery=input.checkGoodsBatch    ${WAIT_TIMEOUT}    #等待批次号输入框加载出来
    Input Text    jquery=input.checkGoodsBatch    001    #输入批次号
    ${OUT_NUMBER}    Evaluate    ${BUY_NUMBER}-1
    Set Global Variable    ${OUT_NUMBER}
    Input Text    jquery=input.checkGoodsNum    ${OUT_NUMBER}    #输入出库的商品数量
    Click Button    jquery=button.btn-md    #点击确认提交按钮
    ${message}    Confirm Action
    Should Be Equal    ${message}    订单商品未全部出库，系统会将差价退还给采购商，您确认出库吗？
    Choose Ok On Next Confirmation    #点击确认出库
    Wait Until Element Is Visible    //h2[@class="margin-b20"]    ${WAIT_TIMEOUT}    #等待物流登记界面加载出来

采购商检查生成的订单
    Go To    ${PUR_URL}/Order/Home
    Wait Until Page Contains    ${ORDERCODE}    ${WAIT_TIMEOUT}

供应商检查生成的订单
    Go To    ${SALES_URL}/Order/Order/Index
    Wait Until Page Contains    ${ORDERCODE}    ${WAIT_TIMEOUT}

Manager Closes An Order
    Go To    ${M_URL}/Order/Order/Index
    Wait Until Element Is Visible    //input[@placeholder="订单号"]    ${WAIT_TIMEOUT}
    Input Text    //input[@placeholder="订单号"]    ${ORDERCODE}
    Click Element    //span[@class="input-group-btn"]
    Wait Until Element Contains    //table/tbody/tr/td/a[1]    ${ORDERCODE}
    Click Element    //a[@data-original-title="关闭订单"]
    Wait Until Element Is Visible    CloseRemark
    Input Text    CloseRemark    管理员关闭订单
    Click Element    //button[@type="submit"]
    Wait Until Element Is Not Visible    //table/tbody/tr/td/a[1]    ${WAIT_TIMEOUT}    管理员关闭订单后未跳转

出库全部商品
    Click Element    //a[@class="oper"]
    Wait Until Element Is Visible    jquery=input.checkGoodsBatch    ${WAIT_TIMEOUT}
    Input Text    jquery=input.checkGoodsBatch    001
    Click Button    jquery=button.btn-md
    Wait Until Element Is Visible    //h2[@class="margin-b20"]    ${WAIT_TIMEOUT}    提交出库时加载失败
