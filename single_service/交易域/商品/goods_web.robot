*** Settings ***
Resource          ../../../library/library_web.robot

*** Keywords ***
供应商修改商品上下架状态
    [Arguments]    ${status}
    Switch Browser    ${SALER_BROWSER}
    Execute Javascript    $('ul.dropdown-menu').attr('style','display: block;')
    Click Element    //a[@name="shelfDown"]
    Wait Until Keyword Succeeds    20s    1s    Wait Until Element Contains    //div[@class="Form-list table-responsive"]/table/tbody/tr/td[8]/span    ${status}

设置店铺商品分类
    Wait Until Element Is Visible    //select[@name='CustomCategoryId']    ${WAIT_TIMEOUT}    #等待商品分类下拉框加载出来
    Select From List By Index    //select[@name='CustomCategoryId']    2    #选择商品分类

供应商进入商品编辑界面
    Click Element    //a[@class="atoe"]
