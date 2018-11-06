*** Settings ***
Resource          ../../../library/library_web.robot

*** Keywords ***
质管审核产品通过
    Wait Until Element Is Visible    jquery=span.select2-arrow    ${WAIT_TIMEOUT}    #等待下拉框显示
    Click Element    jquery=span.select2-arrow    #点击下拉框
    Click Element    //div[@id='select2-drop']/ul/li[2]/ul/li/div    #选择一级分类
    Wait Until Element Is Visible    xpath=//select[@class='form-control select2me']    ${WAIT_TIMEOUT}    #等待二级分类下拉框显示
    Select From List By Label    xpath=//select[@class='form-control select2me']    青霉素类    #选择二级分类
    ${legth}    Get Element Attribute    AllowNo@value
    ${status}    Run Keyword And Return Status    Should Be Equal    ${legth}    ${EMPTY}
    ${goodsGyzz}=    Run Keyword If    '${status}'=='True'    输入批准文号
    Wait Until Element Is Visible    flag0    ${WAIT_TIMEOUT}
    Select From List By Label    flag0    处方药
    Select From List By Label    flag1    流浸膏剂
    Select From List By Label    flag2    抗生素制剂
    Select From List By Label    flag3    口服
    Select From List By Label    flag4    否
    ${status1}    Run Keyword And Return Status    Wait Until Element Is Visible    //div[@id="product_img"]/div[1]/p/a[1]    #判断是否有产品图片，无图片就上传
    Run Keyword If    '${status1}'=='False'    上传产品图片
    Input Text    //textarea[@name='Efficacy']    产品功效
    Click Element    subdata    #点击审核通过按钮
    [Return]    ${goodsGyzz}

输入批准文号
    ${text}    Evaluate    random.randint(10000000,90000000)    random    #设置准字号H后面+8位随机数
    ${erpNewGoodsGyzz}    Set Variable    国药准字H${text}
    Execute Javascript    $('#AllowNo').val("${erpNewGoodsGyzz}")    #准字号
    [Return]    ${erpNewGoodsGyzz}

上传产品图片
    Choose File    xpath=//input[@id="upFile"]    ${EXECDIR}\\Resources\\Image\\61.jpg    #上传图片
    Wait Until Element Is Visible    //div[@id="product_img"]/div[1]/p/a[1]    ${WAIT_TIMEOUT}    图片未显示
