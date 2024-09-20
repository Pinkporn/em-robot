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

Check Disable Element
    [Arguments]    ${element}
    Element Should Be Visible    ${element}
    ${disable}    Get Element Attribute    ${element}    data-disabled
    IF  $disable is not None
        Should Be Equal    ${disable}    true
    ELSE 
        Should Be Equal    ${disable}    ${None}
    END
    
*** Test Cases ***
# BusinessStructure_WS_Unlimited_TC001
#     [Documentation]    ตรวจสอบหน้าจอของ Business Structure
#     Element Should Be Visible    //h1[text()='Business Structure']
#     Element Should Be Visible    //p[.='Organizations: 1']
#     Element Should Be Visible    //p[.='Sites: 0']
#     Element Should Be Visible    //p[.='Assets: 0']
#     Element Should Be Visible    //p[.='Workspace ID:']
#     Check Disable Element        //input[@value='49']
#     Element Should Be Visible    //p[.='Copy']
#     Element Should Be Visible    //div[@data-selected="true"]
#     Element Should Be Visible    ${CURRENT SELECTION}
#     Element Should Be Visible    //p[.='Organization Logo']
#     Element Should Be Visible    //div[@data-with-label="true"]
#     Element Should Be Visible    //p[.='The logo will be displayed on your profile and report.']
#     Check Require Field    Organization Display Name *
#     Element Should Be Visible    //input[@name='name']
#     Element Should Be Visible    //p[text()='Organization ID']
#     Check Disable Element    //input[@value='71']
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
#     Check Disable Element    //button[.="Save"]

# BusinessStructure_WS_Unlimited_TC006
#     Wait Until Element Is Visible    //input[@value='49']
#     Click Element    //p[.='Copy']
#     Wait Until Element Is Visible    //p[.='Copied']

# BusinessStructure_WS_Unlimited_TC007
#     Wait Until Element Is Visible    ${CURRENT SELECTION}
#     Click Current Selection Kebab Button
#     Wait Until Element Is Visible    (//div[@role="menu"])[last()]//button[.='+ Add Site']
#     Wait Until Element Is Visible    (//div[@role="menu"])[last()]//button[.='+ Add Sub Org']

BusinessStructure_WS_Unlimited_DetailWS_TC001
    Upload Evidences    ${EXECDIR}/evidences//blog-22.jpg
    Wait Until Element Is Enabled    //button[.="Save"]
