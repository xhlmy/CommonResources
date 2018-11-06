*** Settings ***
Resource          ../../../library/library_web.robot

*** Keywords ***
Check Activity Goods Submit Success
    Reload Page
    Wait Until Element Is Not Visible    //table[@id="activitytable"]/tbody/tr/td//dd/p[2]    ${WAIT_TIMEOUT}    提交商品失败

Manager Creates An Activity
    [Arguments]    ${activityType}    ${activityTime}    ${activityCode}
    Switch Browser    ${MANAGE_BROWSER}
    Go To    ${M_URL}/Operate/Activity/create?plugin=Operate&return=JTJmT3BlcmF0ZSUyZkFjdGl2aXR5JTJmSW5kZXg=
    Comment    Wait Until Element Is Visible    createLink
    Comment    Click Element    createLink    #点击新增
    Wait Until Element Is Visible    Title
    ${num}=    Evaluate    random.randint(0,sys.maxint)    random,sys
    Convert To String    ${num}
    ${ACTIVITY_NAME}=    Catenate    平台活动${num}
    Set Global Variable    ${ACTIVITY_NAME}
    Input Text    Title    ${ACTIVITY_NAME}    #输入活动名称
    Select From List By Label    PromoType    ${activityType}    #选择活动类型
    List Selection Should Be    PromoType    ${activityType}
    ${time}    Get Element Attribute    //input[@id='CollectStartTime']@value    #获取征集开始时间
    ${collectEndTime}    Add Time To Date    ${time}    ${activityTime}    result_format=%Y.%m.%d %H:%M
    ${activityStartTime}    Add Time To Date    ${collectEndTime}    1 minutes    result_format=%Y.%m.%d %H:%M
    ${activityEndTime}    Add Time To Date    ${collectEndTime}    2 minutes    result_format=%Y.%m.%d %H:%M
    Execute Javascript    document.getElementById('ActivityStartTime').setAttribute('value','${activityStartTime}')    #输入活动开始时间
    Execute Javascript    document.getElementById('ActivityEndTime').setAttribute('value','${activityEndTime}')    #输入活动结束时间
    Execute Javascript    document.getElementById('CollectEndTime').setAttribute('value','${collectEndTime}')    #输入活动征集结束时间
    Click Element    //input[@value="${activityCode}"]    #选择活动区域//label[contains(.,"${BUYER_AREA_CODE}")]
    Click Element    uniform-hideRadio    #指定供应商
    Wait Until Element Is Visible    salersName    ${WAIT_TIMEOUT}    未显示搜索框
    Input Text    salersName    ${COMPANY_NAME}
    Click Button    //button[@onclick="QuerySalers()"]    #点击搜索商家按钮
    Wait Until Element Is Visible    jquery=a:contains("增加"):eq(0)    ${WAIT_TIMEOUT}    未搜索到商家
    Click Element    jquery=a:contains("增加"):eq(0)    #点击新增
    Wait Until Element Is Visible    jquery=a:contains("移除"):eq(0)    ${WAIT_TIMEOUT}    新增供应商失败
    Click Element    l_submit
    Wait Until Element Is Visible    //div[@id='search_condition']//input    ${WAIT_TIMEOUT}    #验证：提交后返回到活动管理列表
    Input Text    //div[@id='search_condition']//input    ${ACTIVITY_NAME}
    Click Element    //button[@class="btn red search_submit"]    #点击搜索活动按钮
    Wait Until Element Is Visible    //td[contains(.,"${ACTIVITY_NAME}")]
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    //td[contains(.,"${ACTIVITY_NAME}")]/parent::*/child::td/a[contains(.,"活动页面")]
    Run Keyword If    '${status}'=='True'    Get Activity Url

Saler Joined In The Activity
    [Arguments]    ${activityUrl}
    Switch Browser    ${SALER_BROWSER}
    Go To    ${activityUrl}    #去活动页面
    Wait Until Element Is Visible    //input[@name='activityName']    ${WAIT_TIMEOUT}
    Input Text    //input[@name='activityName']    ${ACTIVITY_NAME}
    Click Element    //div[@id='search_condition']//button    #搜索活动
    Wait Until Element Is Visible    //td[contains(.,"${ACTIVITY_NAME}")]    ${WAIT_TIMEOUT}
    #参加活动
    Click Element    //td[contains(.,"${ACTIVITY_NAME}")]/parent::*/child::td[7]/a
    Wait Until Element Is Visible    //a[contains(.,"同意协议参与活动")]    ${WAIT_TIMEOUT}
    Click Element    //a[contains(.,"同意协议参与活动")]
    Wait Until Element Is Visible    //input[@name="keyWords"]    ${WAIT_TIMEOUT}
    #提交商品
    Input Text    //input[@name="keyWords"]    ${ACTIVITY_GOOD_GYZZ}
    Click Element    jquery=button.search_submit
    Wait Until Element Contains    //table[@id="activitytable"]/tbody/tr/td//dd/p[2]    ${ACTIVITY_GOOD_GYZZ}    ${WAIT_TIMEOUT}
    Input Text    //table[@id="activitytable"]//input[@name="number"]    1111111
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    //table[@id="activitytable"]//input[@name="minlimit"]
    Run Keyword If    '${status}'=='True'    Input Text    //table[@id="activitytable"]//input[@name="minlimit"]    1
    Input Text    //table[@id="activitytable"]//input[@name="limit"]    ${XIANGOU_NUM}
    Input Text    //table[@id="activitytable"]//input[@name="nums"]    100
    ${priceStr}=    Get Text    //table[@id='activitytable']/tbody/tr/td[2]/p[4]
    @{goodPrice}=    Get Regexp Matches    ${priceStr}    ￥(.*)    1
    ${ORIGINAL_PRICE}=    Convert To Number    @{goodPrice}[0]
    Set Global Variable    ${ORIGINAL_PRICE}
    ${price}    Evaluate    round(${ORIGINAL_PRICE}*0.9,2)
    ${ACTIVITY_PRICE}    Convert To String    ${price}
    Set Global Variable    ${ACTIVITY_PRICE}
    Input Text    //table[@id="activitytable"]//input[@name="price"]    ${ACTIVITY_PRICE}
    Click Element    //table[@id="activitytable"]//a[@command="commit"]
    Capture Page Screenshot

Manage Terminates All Activity
    Go To    ${M_URL}/Operate/Activity/Index
    Wait Until Element Is Visible    //input[@name="Title"]    ${WAIT_TIMEOUT}
    Select From List By Value    //select[@name="Status"]    1    #选择征集中的活动
    Wait Until Element Is Visible    //div[@class="col-md-12"]    ${WAIT_TIMEOUT}    活动列表页加载失败
    : FOR    ${n}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    //tr[1]/td[9]/a[@class="alert_confirm"]
    \    Run Keyword If    '${status}'=='True'    Terminate Platform Activity
    \    ...    ELSE    Exit For Loop
    Wait Until Element Is Visible    //input[@name="Title"]    ${WAIT_TIMEOUT}
    Select From List By Value    //select[@name="Status"]    2    #选择审核中的活动
    Wait Until Element Is Visible    //div[@class="col-md-12"]    ${WAIT_TIMEOUT}    活动列表页加载失败
    : FOR    ${n}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    //tr[1]/td[9]/a[@class="alert_confirm"]
    \    Run Keyword If    '${status}'=='True'    Terminate Platform Activity
    \    ...    ELSE    Exit For Loop
    Wait Until Element Is Visible    //input[@name="Title"]    ${WAIT_TIMEOUT}
    Select From List By Value    //select[@name="Status"]    3    #选择活动中的活动
    Wait Until Element Is Visible    //div[@class="col-md-12"]    ${WAIT_TIMEOUT}    活动列表页加载失败
    : FOR    ${n}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    //tr[1]/td[9]/a[@class="alert_confirm"]
    \    Run Keyword If    '${status}'=='True'    Terminate Platform Activity
    \    ...    ELSE    Exit For Loop

Terminate Platform Activity
    Click Element    //tr[1]/td[9]/a[@class="alert_confirm"]
    Wait Until Element Is Visible    deleteOk    ${WAIT_TIMEOUT}
    Click Element    deleteOk
    Wait Until Element Is Not Visible    deleteOk    60s

Close The Ongoing Activities
    Switch Browser    ${SALER_BROWSER}
    Go To    ${SALES_URL}/promotion/tejia/Index
    Wait Until Element Is Visible    //select[@name="status"]    ${WAIT_TIMEOUT}    特价活动界面未显示
    Select From List By Value    //select[@name="status"]    1    #选择特价活动状态
    Click Element    //button[@class="btn btn-blue cond-submit search_submit"]    #点击搜索按钮
    : FOR    ${n}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    //a[@name="stopPromo"]
    \    Run Keyword If    '${status}'=='True'    Terminat Saler Tejia Activity
    \    ...    ELSE    Exit For Loop    #如果列表存在信息进行关闭操作

Terminat Saler Tejia Activity
    Click Element    //a[@name="stopPromo"]    #点击终止
    Wait Until Element Is Visible    //button[@class="btn btn-primary"]    ${WAIT_TIMEOUT}
    Click Element    //button[@class="btn btn-primary"]    #确认终止
    Reload Page    #刷新页面

Manager Approved To Verify Activity Goods
    Switch Browser    ${MANAGE_BROWSER}
    Click Element    //button[@class="btn red search_submit"]    #点击搜索活动按钮
    Wait Until Element Is Visible    //td[contains(.,"${ACTIVITY_NAME}")]/parent::*/child::td/a[contains(.,"商品审核")]    ${WAIT_TIMEOUT}
    Click Element    //td[contains(.,"${ACTIVITY_NAME}")]/parent::*/child::td/a[contains(.,"商品审核")]    #点击商品审核
    Wait Until Element Is Visible    //a[@command="pass"]    ${WAIT_TIMEOUT}    商品提交失败
    Click Element    //a[@command="pass"]    #点击通过
    Wait Until Element Is Visible    Confirm    ${WAIT_TIMEOUT}    通过审核失败
    Click Element    Confirm
    Wait Until Element Is Visible    //span[@class="green"]    ${WAIT_TIMEOUT}    审核失败
