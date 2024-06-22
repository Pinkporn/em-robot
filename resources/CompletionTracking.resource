*** Settings ***
Documentation     Completion Tracking Page
Resource          Structure.resource

*** Variables ***
@{MONTHS}    Jan    Feb    Mar    Apr    May    Jun    Jul    Aug    Sep    Oct    Nov    Dec
${SAVE_BUTTON}         (//button[.='Save'])[last()]
${DONT_SAVE_BUTTON}    (//button[.="Don't Save"])[last()]

*** Keywords ***
Go To Completion Tracking
    VAR    ${navlink input}    //div[contains(@class, 'mantine-Flex-root')]/a[6]
    Click Element    ${navlink input}
    Wait Until Element Is Visible    ${navlink input}//span[text()='Completion Tracking']
    Click Element    ${navlink input}//span[text()='Completion Tracking']
    Mouse Over    //body
    Wait Until Element Is Not Visible    css:.mantine-Overlay-root
    Wait Until Element Is Visible    //*[@data-show]

Go To Tracking Tab
    Click Element    css:.tab-ul >> xpath://li[text()='Tracking']
    Wait Until Element Is Not Visible    css:.mantine-Overlay-root
    Wait Until Element Is Visible    //*[@data-show]

Go To Settings Tab
    Click Element    css:.tab-ul >> xpath://li[text()='Settings']
    Wait Until Element Is Not Visible    css:.mantine-Overlay-root
    Wait Until Element Is Visible    //div[text()='Tracking Records']

Get Current Month
    [Documentation]    คืนค่าชื่อเดือนปัจจุบันที่ถูกเลื่อนขึ้น ``offset`` ครั้ง
    [Arguments]    ${offset}=0
    ${month_no}    Evaluate    datetime.datetime.now().month    modules=datetime
    RETURN    ${MONTHS}[${{ (($month_no - 1) + ${offset}) % 12 }}]

Get Current Year
    [Documentation]    คืนค่าปีปัจจุบันที่บวกด้วย ``offset``
    [Arguments]    ${offset}=0
    ${year_no}    Evaluate    datetime.datetime.now().year    modules=datetime
    RETURN    ${{$year_no + ${offset}}}

# ======== Keywords for Tracking ========
Click Tracker Group
    [Arguments]    ${name}
    Click Element    //div[./div[@aria-hidden] and .//p[.='${name}']]/div[1]
    Sleep    0.2

Open Tracker Group
    [Arguments]    ${name}
    ${element}    Find WebElement    //div[./div[@aria-hidden="true"] and .//p[.='${name}']]/div[1]
    IF  $element is None    RETURN
    Click Element    ${element}
    Sleep    0.2

Close Tracker Group
    [Arguments]    ${name}
    ${element}    Find WebElement    //div[./div[@aria-hidden="false"] and .//p[.='${name}']]/div[1]
    IF  $element is None    RETURN
    Click Element    ${element}
    Sleep    0.2

Get Tracker Group Status
    [Arguments]    ${name}
    ${element}    Find WebElement    //div[contains(@class, 'styles_box') and .//p[text()='${name}']]/div/div[2]/p
    IF  $element is None    RETURN    No Status
    ${status}    Get Text    ${element}
    RETURN    ${status}

Tracker Group Status Should Be Equal
    [Documentation]
    ...    Fail เมื่อ Tracker Group ชื่อ ``name`` มีสถานะไม่ตรงกับ ``expected``
    ...
    ...    ค่าที่เป็นไปได้ของ ``expected`` ได้แก่ "Complete Data", "Missing Data", "No data", "No Status"
    [Arguments]    ${name}    ${expected}
    ${status}    Get Tracker Group Status    ${name}
    Should Be Equal    ${expected}    ${status}
    ...    msg=${name} group has '${status}' instead of '${expected}'
    ...    values=${False}

Click Tracker Date
    [Documentation]    คลิก Tracker Date ตาม ``date`` ใน Tracker Group ``name``
    [Arguments]    ${name}    ${date}
    ${month}    ${year}    Split String    ${date}
    ${month}    Convert To Upper Case    ${month}
    # div ที่มี direct descendant เป็น "div ที่มี attribute aria-hidden" และมี "p ที่มีข้อความเท่ากับ name" อยู่ข้างใน
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${name}']]
    # tr ที่มี attribute data-is-collapse และมี "p ที่มีคำว่า year" อยู่ข้างใน
    VAR    ${detail tr}    //tr[@data-is-collapse and .//p[contains(., '${year}')]]
    # หา card ที่แสดงรายละเอียดของ tracker ที่โผล่ลงมาหลังกด Tracker Date
    ${card}    Find WebElement    ${tracker div}${detail tr}
    # คลิก date circle
    ${circle}    Get WebElement   ${tracker div}//tr[.//p[.='${year}']]//td[@data-key='${month}']/*
    Execute Javascript    arguments[0].click()    ARGUMENTS    ${circle}
    # ถ้าหาไม่เจอ (card ไม่ได้แสดงอยู่) ให้ sleep รอ animation เสร็จ
    IF  $card is None
        Sleep    0.5    # 0.5 เอามาจากการเปิดดู css
    END

Circle Should Only Be Visible In Range
    [Documentation]
    ...    ใน Tracker Group ``name`` ตรวจสอบว่าตั้งแต่เดือนปีที่ ``from`` จนถึงเดือนปีที่ ``to`` มีวงกลมอยู่หรือไม่
    ...    และตรวงสอบด้วยว่าไม่มีวงกลมนอกช่วงด้วย
    ...    ---
    ...    ตรวจสอบว่าใน Fuel มีวงกลมตั้งแต่ Jul 2023 ถึง Jun 2024 เท่านั้น
    ...    | Circle Should Only Be Visible In Range    Fuel    Jul 2023    Jun 2024
    [Arguments]    ${name}    ${from}    ${to}
    ${from month}    ${from year}    Split String    ${from}
    ${to month}      ${to year}      Split String    ${to}
    ${from year}    Convert To Integer    ${from year}
    ${to year}      Convert To Integer    ${to year}
    # แปลงชื่อเดือนเป็น index
    VAR    ${from month}    ${{$MONTHS.index($from_month)}}
    VAR    ${to month}      ${{$MONTHS.index($to_month)}}
    # ตรวจสอบวงกลมในช่วง
    FOR  ${i}  IN RANGE  ${{$from_year * 12 + $from_month}}  ${{$to_year * 12 + $to_month + 1}}
        VAR    ${m}    ${{$i % 12}}
        VAR    ${y}    ${{$i // 12}}
        ${data_key}    Convert To Upper Case    ${MONTHS}[${m}]
        Page Should Contain Element
        ...    locator=//div[./div[@aria-hidden] and .//p[.='${name}']]//tr[.//p[.='${y}']]//td[@data-key='${data_key}']/*
        ...    message=There is no circle in '${MONTHS}[${m}] ${y}' of ${name}
    END
    # ตรวงสอบวงกลมนองช่วงก่อน from
    FOR  ${m}  IN RANGE  0  ${from_month}
        ${data_key}    Convert To Upper Case    ${MONTHS}[${m}]
        Element Should Not Be Visible
        ...    locator=//div[./div[@aria-hidden] and .//p[.='${name}']]//tr[.//p[.='${from year}']]//td[@data-key='${data_key}']/*
        ...    message=There is a circle in '${MONTHS}[${m}] ${from year}' of ${name}
    END
    # ตรวงสอบวงกลมนองช่วงหลัง to
    FOR  ${m}  IN RANGE  ${to_month + 1}  12
        ${data_key}    Convert To Upper Case    ${MONTHS}[${m}]
        Element Should Not Be Visible
        ...    locator=//div[./div[@aria-hidden] and .//p[.='${name}']]//tr[.//p[.='${to year}']]//td[@data-key='${data_key}']/*
        ...    message=There is a circle in '${MONTHS}[${m}] ${to year}' of ${name}
    END

# Tracker Date Color Should Be Equal

# Emission Source Color Should Be Equal

# Skip Emission Source

# Undo Skipped Emission Source

# Input Emission Source Remark

# Tracking Records Should Be Equal

# Hover Tracker Date

# Dialog Tracking Records Should Be Equal

# Dialog Emission Source Color Should Be Equal

# ======== Keywords for Settings ========
Click Group Setting
    [Arguments]    ${name}
    Click Element    //ul[@data-mode="vertical-box"]//a[.='${name}']
    Wait Until Element Is Not Visible    css:.mantine-Overlay-root
    Wait Until Element Is Visible    //div[text()='Tracking Records']

Open Setting Region
    [Arguments]    ${name}
    ${element}    Find WebElement    //button[.//div[.='${name}'] and ./following-sibling::*[@aria-hidden="true"]]
    IF  $element is None    RETURN
    Click Element    ${element}
    Sleep    0.2

Close Setting Region
    [Arguments]    ${name}
    ${element}    Find WebElement    //button[.//div[.='${name}'] and ./following-sibling::*[@aria-hidden="false"]]
    IF  $element is None    RETURN
    Click Element    ${element}
    Sleep    0.2

Set Emission Source Records
    [Arguments]    ${name}    ${records}
    Input Text    //div[@data-type and ./div='${name}']//input    ${records}

Decrement Emission Source Record
    [Arguments]    ${name}    ${times}=1
    FOR  ${i}  IN RANGE  ${times}
        Click Button    //div[@data-type and ./div='${name}']//button[.='-']
    END

Increment Emission Source Record
    [Arguments]    ${name}    ${times}=1
    FOR  ${i}  IN RANGE  ${times}
        Click Button    //div[@data-type and ./div='${name}']//button[.='+']
    END

Deselect Emission Source
    [Arguments]    ${name}
    Click Button    //div[@data-type and ./div='${name}']//button[.='']
    Click Menu Button    Deselect

Save Settings
    [Documentation]    เลือกวันที่ใน modal แล้วกด apply
    ...
    ...    ต้องกดปุ่มที่ทำให้ modal ขึ้นมาด้วยตัวเอง
    [Arguments]    ${date}
    Wait Until Element Is Visible    //button[contains(@class, 'MonthPickerInput')]
    Click Button    //button[contains(@class, 'MonthPickerInput')]
    Select Date    ${date}
    Wait Until Element Is Not Visible    //div[@role="dialog"]
    Click Button    //button[.='Apply']
    Wait Until Element Is Not Visible    //section
    Wait Until Element Is Visible    //div[@role="status" and text()='Settings saved']

# ---- Select Emission Source Modal ----
Click Select Emission Source Button
    [Arguments]    ${site}    @{actions}
    Click Button    //button[.//div[.='${site}']]/following-sibling::*//button[.='Select Emission Source']
    Wait Until Element Is Visible    //section//button

Click Stack Button
    [Documentation]    ``button`` ที่เป็นไปได้คือ "Select ->", "<- Deselect", "All ->", "<- All"
    [Arguments]    ${button}
    Click Button    (//button[.='${button}'])[2]

Search Available
    [Arguments]    ${text}
    Input Text    //div[@data-type="forward"]//input[@placeholder]    ${text}

Search Selected
    [Arguments]    ${text}
    Input Text    //div[@data-type="backward"]//input[@placeholder]    ${text}

Select Available Emission Source
    [Arguments]    @{sources}
    FOR  ${s}  IN  @{sources}
        Select Checkbox    //div[@data-type="forward"]//div[./p[.='${s}']]//input
    END

Unselect Available Emission Source
    [Arguments]    @{sources}
    FOR  ${s}  IN  @{sources}
        Unselect Checkbox    //div[@data-type="forward"]//div[./p[.='${s}']]//input
    END

Select Selected Emission Source
    [Arguments]    @{sources}
    FOR  ${s}  IN  @{sources}
        Select Checkbox    //div[@data-type="backward"]//div[./p[.='${s}']]//input
    END

Unselect Selected Emission Source
    [Arguments]    @{sources}
    FOR  ${s}  IN  @{sources}
        Unselect Checkbox    //div[@data-type="backward"]//div[./p[.='${s}']]//input
    END