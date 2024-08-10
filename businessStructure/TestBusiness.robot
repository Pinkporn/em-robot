*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/BusinessStructure.resource
Resource          business.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


*** Test Cases ***
Workspace - Update
    [Documentation]    Upload Detail Organization
    Enter Organization Form    display name=บริษัท Get Start จำกัด    thai name=บริษัท เริ่มใหม่อีกครั้ง จำกัด    
    ...    website=www.getstart.test.com    industry=Industrials    sector=Automotive    
    ...    province=Chiang Mai    district=Chai Prakan    subdistrict=Mae Thalop    zip code=50320    
    ...    address=523/112 หมู่ที่ 8 ถนนชานเมือง
    Upload Evidences    ${CURDIR}/Get Start Logo.jpg
    Confirm Save Update Detail Organization

# Workspace - Add Site 01
#     [Documentation]    Add site owned and used
#     Click Current Selection Kebab Button
#     Click Element    //button[@role='menuitem' and .//div[text()='Add Site']]
#     Wait Until Element Is Visible    //section
#     Enter Site Form