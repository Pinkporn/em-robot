*** Settings ***
Documentation     Import Data Page
Resource          FormUtility.resource

*** Variables ***


*** Keywords ***
Go To Import Data
    VAR    ${navlink input}    //div[contains(@class, 'mantine-Flex-root')]/a[2]
    Click Element    ${navlink input}
    Wait Until Element Is Visible    ${navlink input}//span[text()='Import Data']
    Click Element    ${navlink input}//span[text()='Import Data']
    # === Zplify version ===
    # Click Element    //h3[text()='Emission']
    # Wait Until Element Is Visible    //div[@data-expanded="true"]//h3[text()='Import File']
    # Click Element    //div[@data-expanded="true"]//h3[text()='Import File']
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Upload Emission Data File
    [Documentation]
    ...    กดปุ่ม Import Data เลือก Upload File จากนั้นเลือก Organization เป็น ``org`` แล้วกดปุ่ม Next
    ...
    ...    อัปโหลด ``file_path`` ซึ่ง ``file_path`` จะต้องเป็น absolute path
    ...    แนะนำให้ใช้ builtin variable CURDIR เช่น ${CURDIR}/RobotUpload.xlsx
    ...
    ...    จะ error เมื่อเวลา ``timeout`` หมดในขณะที่กำลังอัปโหลดไฟล์
    ...
    ...    *คืนค่า* Import ID กลับมา
    [Arguments]    ${org}    ${file_path}    ${timeout}=30

    Click Button         //button[.//span[text()='Import Data']]
    Click Menu Button    Upload File
    # === Zplify version ===
    # Click Button    //button[.//span[text()='Upload File']]

    # เลือก Organization
    Wait Until Element Is Visible    //div[./form and contains(@style, 'translateX(0%)')]
    Select Drop Down    Organization    ${org}
    Click Button        //button[.//span[text()='Next']]
    # อัปโหลดไฟล์
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]
    Choose File    //input[@type='file']    ${file_path}
    Wait Until Element Is Visible        //h2[text()='Uploading']    ${timeout}
    Wait Until Element Is Not Visible    //h2[text()='Uploading']    ${timeout}
    # ดูว่าอัปโหลดสำเร็จไหมแล้วกด Import
    ${result}    Get Text    //section//td[last()]
    Should Be Equal    Success    ${result}
    Log    Upload Successful
    Wait Until Element Is Visible    //button[.//span[text()='Import']]
    Click Button                     //button[.//span[text()='Import']]
    Wait Until Element Is Visible    //button[.//span[text()='Done']]    ${timeout}
    Wait Until Element Is Visible    //section//tbody
    # มาถึงหน้า Upload Evidence
    ${import id}    Get Text    //p[contains(text(), 'IM-')]
    Log    Import ID: ${import id}
    RETURN    ${import id}

Upload Evidence By Text
    [Documentation]    อัปโหลด ``file_path`` ในแถวที่มีข้อความ ``text`` และเป็นผลลัพท์ลำดับที่ ``result no``
    [Arguments]    ${text}    ${file_path}    ${result no}=1    ${timeout}=${None}
    VAR    ${locator}    (//tr[./td[.='${text}']]//input[@type='file' and not(@accept)])[${result no}]
    # ${upload button}    Get WebElement
    Mouse Over     ${locator}/following-sibling::*
    Choose File    ${locator}    ${file_path}
    Wait Until Element Is Visible    //div[@role="status" and text()='Evidence uploaded successfully']    ${timeout}
    Mouse Out      ${locator}/following-sibling::*

Done Upload Evidence
    [Documentation]    กดปุ่ม Done แล้วกดปุ่ม Understand ถ้ามี
    Click Button    //button[.='Done']
    ${button}    Find WebElement    //td[./input[@type='file' and not(@accept)]]/button
    IF  $button is not None
        Wait Until Element Is Visible    //button[.='Understand']
        Click Button                     //button[.='Understand']
    END
    Wait Until Element Is Not Visible    //section

Click Download Template
    [Arguments]    ${org}
    Click Button         //button[.//span[text()='Import Data']]
    Click Menu Button    Download Template
    Click Menu Button    ${org}
    Wait Until Page Contains    Downloading Template... 

    
    