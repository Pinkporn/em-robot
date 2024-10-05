*** Settings ***
Documentation     Add Site Regression Test
Resource          ../resources/BusinessStructure.resource
Resource          business.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${org}    กีเดี้ยน - Internal@1

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

Go to modal add site
    Click Current Selection Kebab Button
    Click + Add Site Menu Button
    Wait Until Element Is Visible    //section
    Element Should Be Visible    //h2[text()='Add New Site']
    
*** Test Cases ***
BusinessStructure_WS_AddSite_Owned and used_TC001
    [Documentation]    ตรวจสอบการกดปุ่ม จุด 3 จุด ที่ Workspace
    Click Current Selection Kebab Button
    Wait Until Element Is Visible    //div[@role="menu"]
    Element Should Be Visible    //div[@role="menu"]//button[.='+ Add Site']
    Element Should Be Visible    //div[@role="menu"]//button[.='+ Add Sub Org']

BusinessStructure_WS_AddSite_Owned and used_TC002
    [Documentation]    ตรวจสอบหน้าจอของ Modal "+Add Site"
    [Tags]    fail    #EM-5992
    Go to modal add site
    Check Require Field    Site Name *
    Element Should Be Visible    //section//input[@name='name']
    Check Require Field    Organization *
    Element Should Be Visible    //section//input[@name='organizationId']
    ${name}    Get Element Attribute    //section//input[@name='organizationId']    value
    Should Be Equal    ${name}    ${org}
    Element Should Be Visible    //div[text()='Site Status']
    Element Should Be Visible    //section//input[@placeholder="Select Site Status"]
    Check Require Field    Country *
    Element Should Be Visible    //section//input[@placeholder="Select Country"]
    Check Require Field    State / Province
    Element Should Be Visible    //section//input[@placeholder="Select State / Province"]
    Check Require Field    District
    Element Should Be Visible    //section//input[@placeholder="Select District"]
    Check Require Field    Subdistrict
    Element Should Be Visible    //section//input[@placeholder="Select Subdistrict"]
    Check Require Field    Zip / Postal Code
    Element Should Be Visible    //section//input[@placeholder="Select Zip / Postal Code"]
    Check Require Field    Address
    # Element Should Be Disabled    //section//button[.="Create"]
    Element Should Be Enabled    //section//div[@role='presentation']/input[@type='file']
    Element Should Be Visible    //section//header//button
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC003
    [Documentation]    Field Site Name ตรวจสอบการกรอกข้อมูลเป็นภาษาอังกฤษ / ตัวเลข และอักขระพิเศษ
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC004
    [Documentation]    Field Organization ตรวจสอบการแสดง org. ทั้งหมดภายใน workspace
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@name='organizationId']
    Wait Until Page Contains    กีเดี้ยน - Internal@1
    Wait Until Page Contains    Zpliporn Test
    Wait Until Page Contains    กีเดี้ยน - Internal@2
    Wait Until Page Contains    กีเดี้ยน - Internal@3
    Wait Until Page Contains    กีเดี้ยน - Internal@4
    Wait Until Page Contains    กีเดี้ยน - Internal@5
    Wait Until Page Contains    กีเดี้ยน - Internal@6
    Wait Until Page Contains    กีเดี้ยน - Internal@8
    Wait Until Page Contains    กีเดี้ยน - Internal@9
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC005
    [Documentation]    Field Site Status ตรวจสอบการแสดง Status ทั้งหมด
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Wait Until Page Contains    Owned and used
    Wait Until Page Contains    Leased in
    Wait Until Page Contains    Owned and leased out
    Wait Until Page Contains    Inactive
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC006
    [Documentation]    Country เลือกข้อมูลจาก Dropdown list
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Click Element    //section//input[@placeholder="Select Country"]
    Click Element    (//div//span[text()='Thailand'])[last()]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC007
    [Documentation]    State / Province เลือกข้อมูลจาก Dropdown list
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Click Element    //section//input[@placeholder="Select Country"]
    Click Element    (//div//span[text()='Thailand'])[last()]
    Click Element    //section//input[@placeholder="Select State / Province"]
    Wait Until Page Contains    Bangkok
    Click Element    (//div//span[text()='Bangkok'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select District"]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC008
    [Documentation]    State / Province เลือกข้อมูลจากการ Search
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Click Element    //section//input[@placeholder="Select Country"]
    Click Element    (//div//span[text()='Thailand'])[last()]
    Input Text    //section//input[@placeholder="Select State / Province"]    B
    Wait Until Page Contains    Bangkok
    Click Element    (//div//span[text()='Bangkok'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select District"]
    Click Element    //section//header/button


BusinessStructure_WS_AddSite_Owned and used_TC009
    [Documentation]    District เลือกข้อมูลจาก Dropdown list
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Select Drop Down    State / Province    Bangkok
    Element Should Be Enabled    //section//input[@placeholder="Select District"]
    Click Element    //section//input[@placeholder="Select District"]
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC010
    [Documentation]    District เลือกข้อมูลจากการ Search
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Select Drop Down    State / Province    Bangkok
    Input Text    //section//input[@placeholder="Select District"]    Ch
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC011
    [Documentation]    Subdistrict เลือกข้อมูลจาก Dropdown list
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Select Drop Down    State / Province    Bangkok
    Select Drop Down    District    Chom Thong
    Click Element    //section//input[@placeholder="Select Subdistrict"]
    Wait Until Page Contains    Bang Mot
    Click Element    (//div//span[text()='Bang Mot'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Zip / Postal Code"]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC012
    [Documentation]    Subdistrict เลือกข้อมูลจากการ Search
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Select Drop Down    State / Province    Bangkok
    Select Drop Down    District    Chom Thong
    Input Text    //section//input[@placeholder="Select Subdistrict"]    Bang
    Wait Until Page Contains    Bang Mot
    Click Element    (//div//span[text()='Bang Mot'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Zip / Postal Code"]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC013
    [Documentation]    Zip / Postal Code เลือกข้อมูลจาก Dropdown list
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Input Text    //section//input[@name='name']    ไซต์ (ก) - Internal@1
    Click Element    //section//input[@placeholder="Select Site Status"]
    Click Element    //div[@value='Internal']
    Select Drop Down    State / Province    Bangkok
    Select Drop Down    District    Chom Thong
    Select Drop Down    Subdistrict    Bang Mot
    Click Element    //section//input[@placeholder="Select Zip / Postal Code"]
    Wait Until Page Contains    10150
    Click Element    (//div//span[text()='10150'])[last()]
    Click Element    //section//header/button

BusinessStructure_WS_AddSite_Owned and used_TC014
    [Documentation]    Field Address ตรวจสอบการกรอกข้อมูลเป็น Freetext Charactor <=255
    Select Structure Item    กีเดี้ยน - Internal@1
    Go to modal add site
    Enter Site Form    ไซต์ (ก) - Internal@1    site status=Owned and used    province=Bangkok    
    ...    district=Chom Thong    subdistrict=Bang Mot    zip code=10150    address=51/412 ซอยกำนันหมาน 1 แยก 2
    Click Element    //section//header/button
