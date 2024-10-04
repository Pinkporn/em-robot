*** Settings ***
Documentation     Add Suborg. Regression Test
Resource          ../resources/BusinessStructure.resource
Resource          business.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${org}    กีเดี้ยน - Internal@1
${suborg}    Zpliporn Test

*** Keywords ***

Go to modal delete sub org
    Select Structure Item        ${suborg}    Org
    Click Current Selection Kebab Button
    Click Delete Menu Button
    Wait Until Element Is Visible    //section//header/h2/div[text()='Delete Sub-Organization']
    
*** Test Cases ***
BusinessStructure_WS_DeleteSub Org._TC001
    [Documentation]    ตรวจสอบหน้าจอ Modal Delete Sub Org.
    Select Structure Item        ${suborg}    Org
    Click Current Selection Kebab Button
    Click Delete Menu Button
    Wait Until Element Is Visible    //section//header/h2/div[text()='Delete Sub-Organization']
    Element Should Be Visible        //section//p[text()='Are you sure you want to delete']/span[text()='${suborg}']
    Element Should Be Visible        //section//p[text()='Deleting this Sub-Organization will remove all associated data, including: ']
    Element Should Be Visible        //section//ul/li[text()='Sites and Assets']
    Element Should Be Visible        //section//ul/li[text()='Emission records for this organization']
    Element Should Be Visible        //section//ul/li[text()='Involved automatic connections']
    Element Should Be Visible        //section//p[text()=' This action cannot be undone.']
    Element Should Be Visible        //section//p[text()=' This action cannot be undone.']
    Element Should Be Visible        //section//h2[text()='You can change the user assigned to a sub-organization in the ']
    Page Should Contain Link         //section//h2//a[//*[contains(text(),'Access Control')]]
    Element Should Be Visible        //section//button[.="Access Control"]
    Element Should Be Visible        //section//button[.="Delete"]
    Element Should Be Visible        //section//header//button
    Click Element    //section//header//button

BusinessStructure_WS_DeleteSub Org._TC002
    [Documentation]    กด Hyperlink ที่ Modal Delete Sub-Organization
    Go to modal delete sub org
    Click Link    //section//h2//a[//*[contains(text(),'Access Control')]]
    Switch Window    New
    Wait Until Page Contains    Access Control
    Close Window
    Switch Window    MAIN
    Click Element    //section//header//button

BusinessStructure_WS_DeleteSub Org._TC003
    [Documentation]    กดปุ่ม Access Control ที่ Modal Delete Sub-Organization
    Go to modal delete sub org
    Click Element    //section//button[.="Access Control"]
    Switch Window    New
    Wait Until Page Contains    Access Control
    Close Window
    Switch Window    MAIN
    Click Element    //section//header//button

BusinessStructure_WS_DeleteSub Org._TC004
    [Documentation]    กด X ที่ Modal Delete Sub-Organization
    Go to modal delete sub org
    Click Element    //section//header//button
    Wait Until Element Is Not Visible    //section//header/h2/div[text()='Delete Sub-Organization']

BusinessStructure_WS_DeleteSub Org._TC005
    [Documentation]    กดปุ่ม Delete ที่ Modal Delete Sub-Organization
    Go to modal delete sub org
    Click Element    //section//button[.="Delete"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    The sub-organization has been deleted successfully.
    Element Should Be Visible    //div[@data-selected="true"]//p[.='${org}']