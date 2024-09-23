*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/BusinessStructure.resource
Resource          business.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Check Require Field
    [Arguments]    ${fieldname}
    Element Should Be Visible    //label[.='${fieldname}']
    ${require}    Get Element Attribute    //label[starts-with(., '${fieldname}')]    data-required
    IF  $require is not None
        Should Be Equal    ${require}    true
    ELSE 
        Should Be Equal    ${require}    ${None}
    END
    
*** Test Cases ***
# BusinessStructure_WS_Unlimited_TC001
#     [Documentation]    ตรวจสอบหน้าจอของ Business Structure
#     Element Should Be Visible    //h1[text()='Business Structure']
#     Element Should Be Visible    //p[.='Organizations: 1']
#     Element Should Be Visible    //p[.='Sites: 0']
#     Element Should Be Visible    //p[.='Assets: 0']
#     Element Should Be Visible    //p[.='Workspace ID:']
#     Element Should Be Disabled    //div[./p[.='Workspace ID:']]//input
#     Element Should Be Visible    //p[.='Copy']
#     Element Should Be Visible    //div[@data-selected="true"]
#     Element Should Be Visible    ${CURRENT SELECTION}
#     Element Should Be Visible    //p[.='Organization Logo']
#     Element Should Be Visible    //div[@data-with-label="true"]
#     Element Should Be Visible    //p[.='The logo will be displayed on your profile and report.']
#     Check Require Field    Organization Display Name *
#     Element Should Be Visible    //input[@name='name']
#     Element Should Be Visible    //p[text()='Organization ID']
#     Element Should Be Disabled    //div[./p[.='Organization ID:']]//input
#     Check Require Field    Organization Name (in English) *
#     Element Should Be Visible    //input[@name='nameEn']
#     Check Require Field    Organization Name (in Thai)
#     Element Should Be Visible    //input[@name='nameTh']
#     Check Require Field    Organization Website
#     Element Should Be Visible    //input[@name='website']
#     Check Require Field    Industry *
#     Element Should Be Visible    //input[@placeholder="Select an industry"]
#     Check Require Field    Sector *
#     Element Should Be Visible    //input[@placeholder="Select a sector"]
#     Check Require Field    Country *
#     Element Should Be Visible    //input[@placeholder="Select Country"]
#     Check Require Field    State / Province
#     Element Should Be Visible    //input[@placeholder="Select State / Province"]
#     Check Require Field    District
#     Element Should Be Visible    //input[@placeholder="Select District"]
#     Check Require Field    Subdistrict
#     Element Should Be Visible    //input[@placeholder="Select Subdistrict"]
#     Check Require Field    Zip / Postal Code
#     Element Should Be Visible    //input[@placeholder="Select Zip / Postal Code"]
#     Check Require Field    Address
#     Element Should Be Disabled    //button[.="Save"]

# BusinessStructure_WS_Unlimited_TC006
#     Wait Until Element Is Visible    //input[@value='49']
#     Click Element    //p[.='Copy']
#     Wait Until Element Is Visible    //p[.='Copied']

# BusinessStructure_WS_Unlimited_TC007
#     Wait Until Element Is Visible    ${CURRENT SELECTION}
#     Click Current Selection Kebab Button
#     Wait Until Element Is Visible    (//div[@role="menu"])[last()]//button[.='+ Add Site']
#     Wait Until Element Is Visible    (//div[@role="menu"])[last()]//button[.='+ Add Sub Org']

# BusinessStructure_WS_Unlimited_DetailWS_TC001
#     Upload Evidences    ${EXECDIR}/evidences//blog-22.jpg
#     Wait Until Element Is Enabled    //button[.="Save"]

# BusinessStructure_WS_Unlimited_DetailWS_TC007
#     ${name}    Get Element Attribute    //input[@name='name']    value
#     ${length}    Get Length    ${name}    
#     Should Be Equal As Integers	${length}    21
#     Click Element    //input[@name='name']
#     Wait Until Page Contains Element    //p[.='${length} / 30 Characters'] 

# BusinessStructure_WS_Unlimited_DetailWS_TC008
#     [Tags]    fail EM-5932
#     [Documentation]    Field Display ซ้ำกับ Display ที่อยู่คนละ Workspace
#     Press Keys   //input[@name='name']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='name']    Zpliporn Test
#     Confirm Save Update Detail Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC009
#     [Documentation]    เกิน 30 ตัวอักษร
#     Clear Element Text    //input[@name='name']
#     Input Text    //input[@name='name']    กีเดี้ยน - Internal@1234567891
#     ${name}    Get Element Attribute    //input[@name='name']    value
#     ${length}    Get Length    ${name}    
#     Should Be Equal As Integers	${length}    30

# BusinessStructure_WS_Unlimited_DetailWS_TC010
#     [Documentation]    Field Display Name ไม่กรอกข้อมูลใน field นี้
#     Press Keys   //input[@name='name']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='name']    ${EMPTY}
#     Click Element    //button[.="Save"]
#     ${name}    Get Element Attribute    //input[@name='name']    value
#     ${length}    Get Length    ${name}    
#     Should Be Equal As Integers	${length}    0
#     Wait Until Page Contains Element    //p[.='${length} / 30 Characters']
#     Wait Until Page Contains      Organization Display Name is required.

# BusinessStructure_WS_Unlimited_DetailWS_TC013
#     [Tags]    fail EM-5932
#     [Documentation]    Filed Org. (in English) ตรวจสอบการกรอกข้อมูล
#     Press Keys   //input[@name='nameEn']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameEn']    G1 - Internal@1
#     Confirm Save Update Detail Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC014
#     [Documentation]    Filed Org. (in English) ชื่อซ้ำกับ Org. นอก Workspace
#     Press Keys   //input[@name='nameEn']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameEn']    Zpliporn Test
#     Wait Until Page Contains Element    //p[.='This name is already taken. Try another one.']

# BusinessStructure_WS_Unlimited_DetailWS_TC015
#     [Documentation]    Filed Org. (in English) กดแป้นภาษาไทยแล้วพิมพ์
#     Press Keys   //input[@name='nameEn']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameEn']    เทสระบบ
#     Element Text Should Not Be    //input[@name='nameEn']    ${None}

# BusinessStructure_WS_Unlimited_DetailWS_TC016
#     [Documentation]    Filed Org. (in English) ไม่กรอกข้อมูลใน field นี้
#     Press Keys   //input[@name='nameEn']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameEn']    ${EMPTY}
#     Click Element    //button[.="Save"]
#     Wait Until Page Contains Element    //p[.='Organization name (is English) is required']

# BusinessStructure_WS_Unlimited_DetailWS_TC017
#     [Tags]    fail EM-5932
#     [Documentation]    Filed Org. (in Thai) ตรวจสอบการกรอกข้อมูล
#     Press Keys   //input[@name='nameTh']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameTh']    กีเดี้ยน - เทสภายใน@1
#     Confirm Save Update Detail Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC018
#     [Tags]    fail EM-5932
#     [Documentation]    Filed Org. (in Thai) ไม่หรอกข้อมูล Field นี้
#     Press Keys   //input[@name='nameTh']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameTh']    ${EMPTY}
#     Confirm Save Update Detail Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC019
#     [Documentation]    Filed Org. (in Thai) กดแป้นภาษาไทยแล้วพิมพ์
#     Press Keys   //input[@name='nameTh']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='nameTh']    TestTest
#     Element Text Should Not Be    //input[@name='nameEn']    ${None}

# BusinessStructure_WS_Unlimited_DetailWS_TC020
#     [Tags]    fail EM-5932
#     [Documentation]    Org. Website ตรวจสอบการกรอกข้อมูล
#     Press Keys   //input[@name='website']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='website']    www.g1-internaltest.com
#     Confirm Save Update Detail Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC021
#     [Tags]    fail EM-5932
#     [Documentation]    Org. Website ไม่กรอกข้อมูล Field นี้
#     Press Keys   //input[@name='website']   COMMAND+a   BACKSPACE
#     Input Text    //input[@name='website']    ${EMPTY}
#     Confirm Save Update Detail Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC022
#     [Documentation]    Industry เลือกข้อมูลจาก Dropdown List
#     Select Drop Down    Industry    Industrials
#     Wait Until Element Is Enabled    //input[@placeholder="Select a sector"]

# BusinessStructure_WS_Unlimited_DetailWS_TC023
#     [Documentation]    Industry เลือกข้อมูลจากการ Search
#     Click Element    //div[./input[@placeholder="Select an industry"]]//div/button
#     Element Should Be Disabled    //input[@placeholder="Select a sector"]
#     Input Text    //input[@placeholder="Select an industry"]    Re
#     Wait Until Page Contains    Resources
#     Click Element    //div[@value='Resources']
#     Element Should Be Enabled    //input[@placeholder="Select a sector"]

# BusinessStructure_WS_Unlimited_DetailWS_TC024
#     [Documentation]    Industry ไม่กรอกข้อมูลใน field นี้
#     Click Element    //div[./input[@placeholder="Select an industry"]]//div/button
#     Click Element    //button[.="Save"]
#     Element Should Be Disabled    //input[@placeholder="Select a sector"]
#     Wait Until Page Contains Element    //p[.='Please select an industry']

BusinessStructure_WS_Unlimited_DetailWS_TC025
    [Documentation]    Sector เลือกข้อมูลจาก Dropdown List
    Select Drop Down    Industry    Industrials
    Wait Until Element Is Enabled    //input[@placeholder="Select a sector"]
    Select Drop Down    Sector    Industrial Materials & Machinery
    Confirm Save Update Detail Organization
