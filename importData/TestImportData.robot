*** Settings ***
Documentation     Create Report Template Regression Test
Resource          ../resources/ImportData.resource
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


*** Keywords ***
Setup Everything
    # Register Keyword To Run On Failure    NOTHING
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Import Data

*** Test Cases ***
Import Data 01
    [Documentation]    Workspace / Drag & Drop แบบมีครบทุก evidence ในไฟล์
    ${id}    Upload Emission Data File    ${ORGANIZATION}    ${CURDIR}/Robot_Bulk_1.xlsx
    Upload Evidences    ${CURDIR}/test.pdf
    Wait Until Element Is Visible    //div[text()='Uploaded']
    Done Upload Evidence
    Element Should Be Visible    //td[@data-key="runningNo" and .="${id}"]

Import Data 02
    [Documentation]    Workspace / ใส่เองแบบราย evidence จนครบทั้งไฟล์ 
    ${id}    Upload Emission Data File    ${ORGANIZATION}    ${CURDIR}/Robot_Bulk_2.xlsx
    
    ${element}    Find WebElement    //tr[./td[.='No file name specified']]
    WHILE    $element is not None
        Upload Evidence By Text    No file name specified        ${CURDIR}/test.pdf
        ${element}    Find WebElement    //tr[./td[.='No file name specified']]
    END
    Wait Until Element Is Visible    //div[text()='Uploaded']  #เช็คว่ามันอัพโหลดไฟล์แล้วหรือยัง
    Click Element    //p[contains(text(), 'IM-')]
    Wait Until Element Is Not Visible    //div[@role="status" and text()='Evidence uploaded successfully']    20s
    Done Upload Evidence
    Element Should Be Visible    //td[@data-key="runningNo" and .="${id}"]

Import Data 03
    [Documentation]    Sub org. / Drag & Drop แบบมีครบทุก evidence ในไฟล์
    ${id}    Upload Emission Data File    InputEmissionTest    ${CURDIR}/Robot_Bulk_3.xlsx
    Upload Evidences    ${CURDIR}/test.pdf
    Wait Until Element Is Visible    //div[text()='Uploaded']
    Done Upload Evidence
    Element Should Be Visible    //td[@data-key="runningNo" and .="${id}"]

Import Data 04
    [Documentation]    Sub org. / Drag & Drop ครบทุก evidence มากกว่า 1 ชื่อในไฟล์เดียว
    ${id}    Upload Emission Data File    InputEmissionTest    ${CURDIR}/Robot_Bulk_4.xlsx
    Upload Evidences    ${CURDIR}/test.pdf    ${CURDIR}/One Test.pdf
    Wait Until Element Is Visible    //div[text()='Uploaded']
    Done Upload Evidence
    Element Should Be Visible    //td[@data-key="runningNo" and .="${id}"]

Import Data 05
    [Documentation]    Workspace / Drag & Drop ไม่ครบทุก evidence ในไฟล์ เพื่อเช็ค modal understand
    ${id}    Upload Emission Data File    ${ORGANIZATION}    ${CURDIR}/Robot_Bulk_5.xlsx
    Upload Evidences    ${CURDIR}/test.pdf
    Wait Until Element Is Visible    //div[text()='Uploaded']
    Done Upload Evidence
    Element Should Be Visible    //td[@data-key="runningNo" and .="${id}"]

Import Data 06
    [Documentation]    Upload file fail เพื่อเช็ค Modal Try Again #ชื่อ Org. ผิด
    Click Button         //button[.//span[text()='Import Data']]
    Click Menu Button    Upload File
    Wait Until Element Is Visible    //div[./form and contains(@style, 'translateX(0%)')]
    Select Drop Down    Organization    InputEmissionTest    
    Click Button        //button[.//span[text()='Next']]
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]
    Choose File    //input[@type='file']   ${CURDIR}/Robot_Bulk_5.xlsx
    Wait Until Element Is Visible        //h2[text()='Uploading']    30s
    Wait Until Element Is Not Visible    //h2[text()='Uploading']    30s
    Page Should Contain    Upload Fail !
    Click Element    //button[.='Try Again']
    Press Keys    ${None}    ESC

Import Data 07
    [Documentation]    Edit / Replace file
    Click Kebab Button In Table
    Click Menu Button    Upload Evidence
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]
    ${name}    Get Text    //td[contains(@class, 'evidenceName')]
    Upload Evidence By Text    ${name}    ${CURDIR}/BKK-Rayong.pdf
    ${new name}    Get Text    //td[contains(@class, 'evidenceName')]
    Should Not Be Equal    ${new name}    ${name}               
    Should Be Equal    ${new name}    BKK-Rayong.pdf
    Done Upload Evidence

Import Data 08
    [Documentation]    Download excel
    Click Kebab Button In Table
    Click Menu Button    Download Excel

Import Data 09
    [Documentation]    Delete excel
    Click Kebab Button In Table
    Click Menu Button    Delete
    Wait Until Element Is Visible    //section
    ${file name}    Get Text    //p/span[contains(@class, 'focus')]
    Click Element    //button[.='Delete']
    Wait Until Page Contains     Deleted ${file name} Successfully 