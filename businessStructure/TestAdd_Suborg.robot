*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/BusinessStructure.resource
Resource          business.resource
Suite Setup       Setup Everything
Test Teardown     Close Browser

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
BusinessStructure_WS_Unlimited_Add Sub org_TC001
    [Documentation]    ตรวจสอบหน้าจอของ Modal "+Add Sub Org."
    Go to modal add sub org
    Check Require Field    Sub-Organization Display Name *
    Element Should Be Visible    //section//input[@name='name']
    Check Require Field    Sub-Organization Name (in English) *
    Element Should Be Visible    //section//input[@name='nameEn']
    Check Require Field    Sub-Organization Name (in Thai)
    Element Should Be Visible    //section//input[@name='nameTh']
    Check Require Field    Organization Website
    Element Should Be Visible    //section//input[@name='website']
    Check Require Field    Industry *
    Element Should Be Visible    //section//input[@placeholder="Select an industry"]
    Check Require Field    Sector *
    Element Should Be Visible    //section//input[@placeholder="Select a sector"]
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
    Element Should Be Disabled    //section//button[.="Create"]
    Element Should Be Visible    //section//header//button

BusinessStructure_WS_Unlimited_Add Sub org_TC002
    [Documentation]    Field Display ตรวจสอบการกรอกข้อมูลเป็นภาษาอังกฤษ /ภาษาไทย / ตัวเลข และอักขระพิเศษ ความยาวไม่เกิน 30 ตัวอักษร
    Go to modal add sub org
    Input Text    //section//input[@name='name']    กีเดี้ยน - Internal@2
    ${name}    Get Element Attribute    //section//input[@name='name']    value
    ${length}    Get Length    ${name}    
    Should Be Equal As Integers	${length}    21
    Click Element    //section//input[@name='name']
    Wait Until Page Contains Element    //section//p[.='${length} / 30 Characters']

BusinessStructure_WS_Unlimited_Add Sub org_TC003
    [Documentation]    Field Display ซ้ำกับ Display ที่อยู่คนละ Workspace
    Go to modal add sub org
    Enter Organization Form    display name=Zpliporn Test    english name=Zpliporn Test2    
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Confirm Add Organization

BusinessStructure_WS_Unlimited_Add Sub org_TC004
    [Tags]    fail EM-5932
    [Documentation]    Field Display ชื่อซ้ำกับ Org. ภายใน Workspace เดียวกัน
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@1    english name=duplicate display name
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Click Element    //button[.="Create"]
    Wait Until Page Contains Element    //section//p[.='Organization display name already exists']

BusinessStructure_WS_Unlimited_Add Sub org_TC005
    [Documentation]    Field Display เกิน 30 ตัวอักษร
    Go to modal add sub org
    Input Text    //section//input[@name='name']    กีเดี้ยน - Internal@1234567891
    ${name}    Get Element Attribute    //section//input[@name='name']    value
    ${length}    Get Length    ${name}    
    Should Be Equal As Integers	${length}    30
    Wait Until Page Contains Element    //section//p[.='${length} / 30 Characters']

BusinessStructure_WS_Unlimited_Add Sub org_TC006
    [Documentation]    Field Display ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Enter Organization Form    display name=${EMPTY}    english name=Empty
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Click Element    //section//button[.="Create"]
    ${name}    Get Element Attribute    //section//input[@name='name']    value
    ${length}    Get Length    ${name}    
    Should Be Equal As Integers	${length}    0
    Wait Until Page Contains Element    //section//p[.='${length} / 30 Characters']
    Wait Until Page Contains Element      //section//p[.='Organization Display Name is required.']

BusinessStructure_WS_Unlimited_Add Sub org_TC007
    [Documentation]    Field NameEn ตรวจสอบการกรอกข้อมูลเป็นภาษาอังกฤษ / ตัวเลข และอักขระพิเศษ
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@2    english name=G1 - Internal@2
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC008
    [Documentation]    Filed Org. (in English) ชื่อซ้ำกับ Org. นอก Workspace
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@2    english name=Zpliporn Test
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Wait Until Page Contains Element    //section//p[.='This name is already taken. Try another one.']

BusinessStructure_WS_Unlimited_Add Sub org_TC009
    [Documentation]    Filed Org. (in English) กดแป้นภาษาไทยแล้วพิมพ์
    Go to modal add sub org
    Input Text    //section//input[@name='nameEn']    เทสระบบ
    Element Text Should Not Be    //section//input[@name='nameEn']    ${None}

BusinessStructure_WS_Unlimited_Add Sub org_TC010
    [Documentation]    Filed Org. (in English) ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@2    english name=${EMPTY}
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Click Element    //button[.="Create"]
    Wait Until Page Contains Element    //p[.='Organization name (is English) is required']

BusinessStructure_WS_Unlimited_Add Sub org_TC011
    [Documentation]    Filed Org. (in Thai) ตรวจสอบการกรอกข้อมูล
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@3    english name=G1 - Internal@3    thai name=กีเดี้ยน - ภายใน@3
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC012
    [Documentation]    Filed Org. (in Thai) ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@4    english name=G1 - Internal@4    thai name=${EMPTY}
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC013
    [Documentation]    Filed Org. (in Thai) กดแป้นภาษาอังกฤษแล้วพิมพ์
    Go to modal add sub org
    Input Text    //section//input[@name='nameTh']    TestTest
    Element Text Should Not Be    //section//input[@name='nameEn']    ${None}

BusinessStructure_WS_Unlimited_Add Sub org_TC014
    [Documentation]    Filed Website ตรวจสอบการกรอกข้อมูลเป็น Freetext
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@5    english name=G1 - Internal@5    website=www.g1-test@5.com
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC015
    [Documentation]    Filed Website ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@6    english name=G1 - Internal@6    website=${EMPTY}
    ...    industry=Agro & Food Industry    sector=Agribusiness
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC016
    [Documentation]    Industry เลือกข้อมูลจาก Dropdown List
    Go to modal add sub org
    Select Drop Down    Industry    Industrials
    Wait Until Element Is Enabled    //section//input[@placeholder="Select a sector"]

BusinessStructure_WS_Unlimited_Add Sub org_TC017
    [Documentation]    Industry เลือกข้อมูลจากการ Search
    Go to modal add sub org
    Input Text    //section//input[@placeholder="Select an industry"]    Re
    Wait Until Page Contains    Resources
    Click Element    (//div//span[text()='Resources'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select a sector"]

BusinessStructure_WS_Unlimited_Add Sub org_TC018
    [Documentation]    Industry ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Input Text    //section//input[@name='name']    กีเดี้ยน - Internal@7
    Input Text    //section//input[@name='nameEn']    G1 - Internal@7
    Click Element    //section//button[.="Create"]
    Wait Until Page Contains Element    //section//p[.='Please select an industry']
    Element Should Be Disabled    //section//input[@placeholder="Select a sector"]

BusinessStructure_WS_Unlimited_Add Sub org_TC019
    [Documentation]    Sector เลือกข้อมูลจาก Dropdown List
    Go to modal add sub org
    Select Drop Down    Industry    Industrials
    Wait Until Element Is Enabled    //section//input[@placeholder="Select a sector"]
    Select Drop Down    Sector    Industrial Materials & Machinery

BusinessStructure_WS_Unlimited_Add Sub org_TC020
    [Documentation]    Sector เลือกข้อมูลจากการ Search
    Go to modal add sub org
    Element Should Be Disabled    //section//input[@placeholder="Select a sector"]
    Input Text    //section//input[@placeholder="Select an industry"]    Re
    Wait Until Page Contains    Resources
    Click Element     (//div//span[text()='Resources'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select a sector"]
    Input Text    //section//input[@placeholder="Select a sector"]    Ener
    Wait Until Page Contains    Energy & Utilities
    Click Element    (//div//span[text()='Energy & Utilities'])[last()]

BusinessStructure_WS_Unlimited_Add Sub org_TC021
    [Documentation]    Sector ไม่กรอกข้อมูลใน field นี้
    Go to modal add sub org
    Input Text    //section//input[@name='name']    กีเดี้ยน - Internal@7
    Input Text    //section//input[@name='nameEn']    G1 - Internal@7
    Select Drop Down    Industry    Resources
    Click Element    //section//button[.="Create"]
    Wait Until Page Contains Element    //section//p[.='Please select a Sector']

BusinessStructure_WS_Unlimited_Add Sub org_TC022
    [Documentation]    Country เลือกข้อมูลจาก Dropdown list
    Go to modal add sub org
    Click Element    //section//input[@placeholder="Select Country"]
    Wait Until Page Contains    Thailand
    Click Element    (//div//span[text()='Thailand'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select State / Province"]

BusinessStructure_WS_Unlimited_Add Sub org_TC023
    [Documentation]    State / Province เลือกข้อมูลจาก Dropdown list
    Go to modal add sub org
    Click Element    //section//input[@placeholder="Select State / Province"]
    Wait Until Page Contains    Bangkok
    Click Element    (//div//span[text()='Bangkok'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select District"]

BusinessStructure_WS_Unlimited_Add Sub org_TC024
    [Documentation]    State / Province เลือกข้อมูลจากการ Search
    Go to modal add sub org
    Input Text    //section//input[@placeholder="Select State / Province"]    B
    Wait Until Page Contains    Bangkok
    Click Element    (//div//span[text()='Bangkok'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select District"]

BusinessStructure_WS_Unlimited_Add Sub org_TC025
    [Documentation]    District เลือกข้อมูลจาก Dropdown list
    Go to modal add sub org
    Select Drop Down    State / Province    Bangkok
    Click Element    //section//input[@placeholder="Select District"]
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]

BusinessStructure_WS_Unlimited_Add Sub org_TC026
    [Documentation]    District เลือกข้อมูลจากการ Search
    Go to modal add sub org
    Select Drop Down    State / Province    Bangkok
    Input Text    //section//input[@placeholder="Select District"]    Ch
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]

BusinessStructure_WS_Unlimited_Add Sub org_TC027
    [Documentation]    Subdistrict เลือกข้อมูลจาก Dropdown list
    Go to modal add sub org
    Select Drop Down    State / Province    Bangkok
    Click Element    //section//input[@placeholder="Select District"]
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]
    Click Element    //section//input[@placeholder="Select Subdistrict"]
    Wait Until Page Contains    Bang Mot
    Click Element    (//div//span[text()='Bang Mot'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Zip / Postal Code"]

BusinessStructure_WS_Unlimited_Add Sub org_TC028
    [Documentation]    Subdistrict เลือกข้อมูลจากการ Search
    Go to modal add sub org
    Select Drop Down    State / Province    Bangkok
    Click Element    //section//input[@placeholder="Select District"]
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]
    Input Text    //section//input[@placeholder="Select Subdistrict"]    Bang
    Wait Until Page Contains    Bang Mot
    Click Element    (//div//span[text()='Bang Mot'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Zip / Postal Code"]

BusinessStructure_WS_Unlimited_Add Sub org_TC029
    [Documentation]    Zip / Postal Code เลือกข้อมูลจาก Dropdown list
    Go to modal add sub org
    Select Drop Down    State / Province    Bangkok
    Click Element    //section//input[@placeholder="Select District"]
    Wait Until Page Contains    Chom Thong
    Click Element    (//div//span[text()='Chom Thong'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Subdistrict"]
    Click Element    //section//input[@placeholder="Select Subdistrict"]
    Wait Until Page Contains    Bang Mot
    Click Element    (//div//span[text()='Bang Mot'])[last()]
    Element Should Be Enabled    //section//input[@placeholder="Select Zip / Postal Code"]
    Scroll Element Into View    //section//input[@placeholder="Select Zip / Postal Code"]
    Click Element    //section//input[@placeholder="Select Zip / Postal Code"]
    Wait Until Page Contains    10150
    Click Element    (//div//span[text()='10150'])[last()]

BusinessStructure_WS_Unlimited_Add Sub org_TC030
    [Documentation]    Field Address เกิน 255 ตัวอักษร
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@8    english name=G1 - Internal@8
    ...    industry=Agro & Food Industry    sector=Agribusiness    
    ...    address=51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส51/412 หมู่บ้านตะบันเทส
    Click Element    //button[.="Create"]
    Wait Until Page Contains Element    //p[.='You have exceeded the maximum character of 255 in this field']

BusinessStructure_WS_Unlimited_Add Sub org_TC031
    [Documentation]    Field Address
    Go to modal add sub org
    Enter Organization Form    display name=กีเดี้ยน - Internal@8    english name=G1 - Internal@8
    ...    industry=Agro & Food Industry    sector=Agribusiness    
    ...    address=51/412 หมู่บ้านตะบันเทส
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC032
    [Documentation]    ตรวจสอบการกดปุ่ม จุด 3 จุด ที่ Sub org.
    Select Structure Item    Zpliporn Test    type=Org
    Click Current Selection Kebab Button
    Wait Until Element Is Visible    //div[@role="menu"]
    Element Should Be Visible    //div[@role="menu"]//button[.='+ Add Site']
    Element Should Be Visible    //div[@role="menu"]//button[.='+ Add Sub Org']
    Element Should Be Visible    //div[@role="menu"]//button[.='Delete']

BusinessStructure_WS_Unlimited_Add Sub org_TC033
    [Documentation]    Add Sub Org. ภายใต้ Sub org.
    Select Structure Item    กีเดี้ยน - Internal@8    type=Org
    Click Current Selection Kebab Button
    Click + Add Sub Org Menu Button
    Enter Organization Form    display name=กีเดี้ยน - Internal@9    english name=G1 - Internal@9
    ...    industry=Agro & Food Industry    sector=Agribusiness    
    Confirm Add Organization
    ${name}    Get Element Attribute    //input[@name='name']    value
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${name}']

BusinessStructure_WS_Unlimited_Add Sub org_TC034
    [Documentation]    ตรวจสอบการกดปุ่ม Create
    Go to modal add sub org
    Input Text    //section//input[@name='address']    57/33
    Click Element    //section//button[.="Create"]
    Wait Until Page Contains Element    //section//p[.='Organization Display Name is required.']
    Wait Until Page Contains Element    //section//p[.='Organization name (is English) is required']
    Wait Until Page Contains Element    //section//p[.='Please select an industry']

BusinessStructure_WS_Unlimited_Add Sub org_TC035
    [Documentation]    ตรวจสอบการแสดง Tree
    Select Structure Item    กีเดี้ยน - Internal@1    type=Org
    Select Structure Item    กีเดี้ยน - Internal@8    type=Org
    Wait Until Element Is Visible    //p[text()='กีเดี้ยน - Internal@9']





