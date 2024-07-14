*** Settings ***
Documentation     Add Eco Efficiency Regression Test
Resource          ../resources/EcoEff.resource
Resource          ../resources/Common.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${URL}            https://emission-management-web-uat.pages.dev
${BROWSER}        Chrome
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Porn Corporation
${ORG CODE}       porn-corporation
@{SITES}          Building 1    Warehouse 1    Manufacturing 1

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Eco Eff

*** Test Cases ***
Create indicator
    Add Product Value Indicator    Indicator

Rename indicator
    Rename Product Value Indicator    Indicator    Indicator A

Add Eco Eff 01
    [Documentation]    
    Click Add Eco Eff    ${ORGANIZATION}    ${SITES}[0]
    Enter Eco Efficiency Form    from date=Jan 2023    to date=Dec 2023    amount=1000000
    Click Confirm Add Eco Eff

Add Eco Eff 02
    [Documentation]    
    Click Add Eco Eff    ${ORGANIZATION}    ${SITES}[1]
    Enter Eco Efficiency Form    from date=Jan 2023    to date=Dec 2023    amount=150000.36
    Click Confirm Add Eco Eff

Add Eco Eff 03
    [Documentation]    
    Click Add Eco Eff    ${ORGANIZATION}    ${SITES}[2]
    Enter Eco Efficiency Form    from date=Jan 2023    to date=Dec 2023    amount=-59000
    Click Confirm Add Eco Eff
    
Add Eco Eff 04
    [Documentation]    Check Activity Date ซ้ำ
    Click Add Eco Eff    ${ORGANIZATION}    ${SITES}[2]
    Enter Eco Efficiency Form    from date=Apr 2023    to date=Jun 2023    amount=1000000
    Field Message Should Be    Date of Activity
    ...    You've already added this eco-efficiency for this period. Please select a different period or edit the existing eco-efficiency.
    Element Should Be Disabled    //button[.='Add']
    Click Close Modal

Edit Eco Eff
    [Documentation]     Edit amout จากจำนวนติดลบ เป็นจำนวนเต็ม
    Click Kebab Button In Table
    Click Edit Menu Button
    Enter Eco Efficiency Form   amount=59000
    Click Element    //button[.//span[text()='Save']]
    Wait Until Element Is Not Visible    //section
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Eco-Efficiency edited successfully

Dup Eco Eff
    [Documentation]     Dup แล้วมา อัพโหลด evidence / Case N/A เลือกวันที่ที่ไม่มี emission มาสร้าง eco-eff
    Click Kebab Button In Table
    ${id}    Get Last Running No   
    Click Duplicate Menu Button
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]
    Enter Eco Efficiency Form    from date=Jan 2019    to date=Dec 2019    amount=1000000
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Click Element    //button[.//span[text()='Save']]
    Wait Until Element Is Not Visible    //section
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Eco-Efficiency duplicated successfully
    Wait Until New Running No Is Visible    ${id}
    ${N/A}    Get Text    //td[@data-key="ecoEfficiencyAmount"]/p
    Should Be Equal    ${N/A}    N/A

Require field
    [Documentation]    Check Require Field
    Click Add Eco Eff    ${ORGANIZATION}    ${SITES}[0]
    Click Element    //button[.='Add']
    Field Message Should Be    Date of Activity    Required
    Field Message Should Be    Product Value Indicator    Required
    Field Message Should Be    Environment Impact Indicator    Required
    Enter Eco Efficiency Form    from date=Jan 2021    to date=Dec 2021
    Click Element    //button[.='Add']
    Field Message Should Be    Amount of Product Value Indicator    Required
    Click Close Modal
    
Delete indicator 
    Delete Product Value Indicator    Indicator A

Add indicator in modal
    Click Add Eco Eff    ${ORGANIZATION}    ${SITES}[1]
    Click Element    name:bank.productValueIndicatorId
    Click Element    //p[.='Add Product Value Indicator']
    Wait Until Element Is Visible    //input[@placeholder="Product Value Indicator Name"]
    Input Text    //input[@placeholder="Product Value Indicator Name"]    Indicator B
    Wait Until Element Is Enabled    (//button[.='Add'])[last()]
    Click Button    (//button[.='Add'])[last()]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    The product value indicator was successfully created.
    Enter Eco Efficiency Form    from date=Jan 2022    to date=Dec 2022    amount=150000
    Click Confirm Add Eco Eff

Delete indicator last 
    Delete Product Value Indicator    Indicator B
    