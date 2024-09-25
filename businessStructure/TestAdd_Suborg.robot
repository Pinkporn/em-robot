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
    IF  $require
        Should Be Equal    ${require}    true
    ELSE 
        Should Be Equal    ${require}     ${None}
    END

Go to modal add sub org
    Click Current Selection Kebab Button
    Click + Add Sub Org Menu Button
    Wait Until Element Is Visible    //section
    Element Should Be Visible    //h2[text()='Add New Sub-Organization']
    
*** Test Cases ***
# BusinessStructure_WS_Unlimited_Add Sub org_TC001
#     [Documentation]    ตรวจสอบหน้าจอของ Modal "+Add Sub Org."
#     Go to modal add sub org
#     Check Require Field    Sub-Organization Display Name *
#     Element Should Be Visible    //section//input[@name='name']
#     Check Require Field    Sub-Organization Name (in English) *
#     Element Should Be Visible    //section//input[@name='nameEn']
#     Check Require Field    Sub-Organization Name (in Thai)
#     Element Should Be Visible    //section//input[@name='nameTh']
#     Check Require Field    Organization Website
#     Element Should Be Visible    //section//input[@name='website']
#     Check Require Field    Industry *
#     Element Should Be Visible    //section//input[@placeholder="Select an industry"]
#     Check Require Field    Sector *
#     Element Should Be Visible    //section//input[@placeholder="Select a sector"]
#     Check Require Field    Country *
#     Element Should Be Visible    //section//input[@placeholder="Select Country"]
#     Check Require Field    State / Province
#     Element Should Be Visible    //section//input[@placeholder="Select State / Province"]
#     Check Require Field    District
#     Element Should Be Visible    //section//input[@placeholder="Select District"]
#     Check Require Field    Subdistrict
#     Element Should Be Visible    //section//input[@placeholder="Select Subdistrict"]
#     Check Require Field    Zip / Postal Code
#     Element Should Be Visible    //section//input[@placeholder="Select Zip / Postal Code"]
#     Check Require Field    Address
#     Element Should Be Disabled    //section//button[.="Create"]
#     Element Should Be Visible    //section//header//button

# BusinessStructure_WS_Unlimited_Add Sub org_TC002
#     [Documentation]    Field Display ตรวจสอบการกรอกข้อมูลเป็นภาษาอังกฤษ /ภาษาไทย / ตัวเลข และอักขระพิเศษ ความยาวไม่เกิน 30 ตัวอักษร
#     Go to modal add sub org
#     Input Text    //section//input[@name='name']    กีเดี้ยน - Internal@2
#     ${name}    Get Element Attribute    //section//input[@name='name']    value
#     ${length}    Get Length    ${name}    
#     Should Be Equal As Integers	${length}    21
#     Click Element    //section//input[@name='name']
#     Wait Until Page Contains Element    //section//p[.='${length} / 30 Characters']

# BusinessStructure_WS_Unlimited_DetailWS_TC003
#     [Documentation]    Field Display ซ้ำกับ Display ที่อยู่คนละ Workspace
#     Go to modal add sub org
#     Enter Organization Form    display name=Zpliporn Test    english name=Zpliporn Test2    
#     ...    industry=Agro & Food Industry    sector=Agribusiness
#     Confirm Add Organization

# BusinessStructure_WS_Unlimited_DetailWS_TC004
#     [Documentation]    Field Display เกิน 30 ตัวอักษร
#     Go to modal add sub org
#     Input Text    //section//input[@name='name']    กีเดี้ยน - Internal@1234567891
#     ${name}    Get Element Attribute    //section//input[@name='name']    value
#     ${length}    Get Length    ${name}    
#     Should Be Equal As Integers	${length}    30
#     Wait Until Page Contains Element    //section//p[.='${length} / 30 Characters']

BusinessStructure_WS_Unlimited_DetailWS_TC005
    [Documentation]    Field Display ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Enter Organization Form    display name=${EMPTY}    english name=Empty
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Click Element    //button[.="Create"]
    ${name}    Get Element Attribute    //section//input[@name='name']    value
    ${length}    Get Length    ${name}    
    Should Be Equal As Integers	${length}    0
    Wait Until Page Contains Element    //section//p[.='${length} / 30 Characters']
    Wait Until Page Contains      Organization Display Name is required.