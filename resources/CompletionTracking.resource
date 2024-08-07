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

Tracker Group Status Should Be
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
    [Documentation]    คลิก Tracker Date ตาม ``date`` ใน Tracker Group ``group``
    [Arguments]    ${group}    ${date}
    ${month}    ${year}    Split String    ${date}
    ${month}    Convert To Upper Case    ${month}
    # div ที่มี direct descendant เป็น "div ที่มี attribute aria-hidden" และมี "p ที่มีข้อความเท่ากับ group" อยู่ข้างใน
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    # tr ที่มี attribute data-is-collapse และมี "p ที่มีคำว่า year" อยู่ข้างใน
    VAR    ${detail tr}    //tr[@data-is-collapse and .//p[contains(., '${year}')]]
    # หา card ที่แสดงรายละเอียดของ tracker ที่โผล่ลงมาหลังกด Tracker Date
    ${card}    Find WebElement    ${tracker div}${detail tr}
    # คลิก date circle
    # Execute Javascript    arguments[0].click()    ARGUMENTS    ${circle}
    ${circle}    Get WebElement    ${tracker div}//tr[.//p[.='${year}']]//td[@data-key='${month}']/*
    # ${width}    ${height}    Get Element Size    ${tracker div}//tr[.//p[.='${year}']]//td[@data-key='${month}']
    # คลิกนอกวงกลมเพื่อไม่ให้ dialog โผล่
    Click Element With Offset    ${circle}    0    ${circle.size["height"] // 2 - 1}
    # ถ้าหาไม่เจอ (card ไม่ได้แสดงอยู่) ให้ sleep รอ animation เสร็จ
    IF  $card is None
        Sleep    0.5    # 0.5 เอามาจากการเปิดดู css
    END

Hover Tracker Date
    [Arguments]    ${group}    ${date}
    ${month}    ${year}    Split String    ${date}
    ${month}    Convert To Upper Case    ${month}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    Mouse Over    ${tracker div}//tr[.//p[.='${year}']]//td[@data-key='${month}']

Mouse Out Dialog
    ${element}    Find WebElement    //div[@role='dialog']
    IF  $element is None    RETURN
    Mouse Out    ${element}

Circle Should Only Be Visible In Range
    [Documentation]
    ...    ใน Tracker Group ``name`` ตรวจสอบว่าตั้งแต่เดือนปีที่ ``from`` จนถึงเดือนปีที่ ``to`` มีวงกลมอยู่หรือไม่
    ...    และตรวงสอบด้วยว่าไม่มีวงกลมนอกช่วงด้วย
    ...    ---
    ...    ตรวจสอบว่าใน Fuel มีวงกลมตั้งแต่ Jul 2023 ถึง Jun 2024 เท่านั้น
    ...    | Circle Should Only Be Visible In Range    Fuel    Jul 2023    Jun 2024
    [Arguments]    ${group}    ${from}    ${to}
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
        ...    locator=//div[./div[@aria-hidden] and .//p[.='${group}']]//tr[.//p[.='${y}']]//td[@data-key='${data_key}']/*
        ...    message=There is no circle in '${MONTHS}[${m}] ${y}' of ${group}
    END
    # ตรวงสอบวงกลมนองช่วงก่อน from
    FOR  ${m}  IN RANGE  0  ${from_month}
        ${data_key}    Convert To Upper Case    ${MONTHS}[${m}]
        Element Should Not Be Visible
        ...    locator=//div[./div[@aria-hidden] and .//p[.='${group}']]//tr[.//p[.='${from year}']]//td[@data-key='${data_key}']/*
        ...    message=There is a circle in '${MONTHS}[${m}] ${from year}' of ${group}
    END
    # ตรวงสอบวงกลมนองช่วงหลัง to
    FOR  ${m}  IN RANGE  ${to_month + 1}  12
        ${data_key}    Convert To Upper Case    ${MONTHS}[${m}]
        Element Should Not Be Visible
        ...    locator=//div[./div[@aria-hidden] and .//p[.='${group}']]//tr[.//p[.='${to year}']]//td[@data-key='${data_key}']/*
        ...    message=There is a circle in '${MONTHS}[${m}] ${to year}' of ${group}
    END

Tracker Date Color Should Be
    [Documentation]
    ...    ตรวจสอบสีของวงกลมใน Tracker Date
    ...
    ...    สีที่เป็นไปได้คือ 'green', 'yellow', 'red'
    [Arguments]    ${group}    ${date}    ${color}
    ${month}    ${year}    Split String    ${date}
    ${month}    Convert To Upper Case    ${month}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    ${circle}    Get WebElement    ${tracker div}//tr[.//p[.='${year}']]//td[@data-key='${month}']//div[@aria-haspopup]
    ${style}    Get Element Attribute    ${circle}    style
    IF  $color not in $style    Fail    '${date}' circle in ${group} is not ${color}.

Item Color Should Be
    [Documentation]
    ...    ตรวจสอบสีของ ``items`` ใน Tracker Group ``group``
    ...
    ...    ``sources`` ใส่ค่าแบบ ``ชื่อ=สี`` สามารถใส่ข้อมูลได้มากกว่า 1 ชุด
    ...
    ...    สีที่เป็นไปได้คือ 'green', 'yellow', 'red', 'gray'
    ...    ---
    ...    Examples:
    ...    | Item Color Should Be | Fuel   | Machine 101=yellow |
    ...    | Item Color Should Be | Energy | Electricity (MEA / PEA)=green | MayaElec=gray |
    [Arguments]    ${group}    &{items}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    VAR    ${card div}    //div[contains(@class, 'Card')]
    FOR  ${s}  IN  @{items}
        VAR    ${color}    ${items}[${s}]
        ${circle}    Get WebElement    ${tracker div}${card div}//div[./p[.='${s}']]//div[@aria-haspopup]
        ${style}    Get Element Attribute    ${circle}    style
        IF  $color not in $style    Fail    '${s}' circle in ${group} is not ${color}.
    END

Skip Item
    [Documentation]
    ...    กด skip ``items`` ใน Tracker Group ``group``
    ...
    ...    สามารถใส่ชื่อ ``sources`` ได้มากกว่า 1 ค่า
    ...    ---
    ...    Examples:
    ...    | Skip Item | Fuel   | Machine 101 |
    ...    | Skip Item | Energy | Electricity (MEA / PEA) | MayaElec |
    [Arguments]    ${group}    @{items}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    VAR    ${card div}    //div[contains(@class, 'Card')]
    FOR  ${i}  IN  @{items}
        VAR    ${button xpath}    ${tracker div}${card div}//div[./div[.='${i}']]//button
        Click Button    ${button xpath}\[.='Skip']
        Wait Until Element Is Visible    ${button xpath}\[.='Undo']
    END

Undo Skipped Item
    [Documentation]
    ...    กด undo ``items`` ใน Tracker Group ``group``
    ...
    ...    สามารถใส่ชื่อ ``items`` ได้มากกว่า 1 ค่า
    ...    ---
    ...    Examples:
    ...    | Undo Skipped Item | Fuel   | Machine 101 |
    ...    | Undo Skipped Item | Energy | Electricity (MEA / PEA) | MayaElec |
    [Arguments]    ${group}    @{items}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    VAR    ${card div}    //div[contains(@class, 'Card')]
    FOR  ${i}  IN  @{items}
        VAR    ${button xpath}    ${tracker div}${card div}//div[./div[.='${i}']]//button
        Click Button    ${button xpath}\[.='Undo']
        Wait Until Element Is Visible    ${button xpath}\[.='Skip']
    END

Input Item Remark
    [Documentation]
    ...    กดรูปดินสอแล้วใส่ ``remark`` ให้กับ ``items`` ใน Tracker Group ``group``
    ...    ---
    ...    Examples:
    ...    | Input Item Remark | Energy | Electricity (MEA / PEA) | Hello |
    [Arguments]    ${group}    ${items}    ${remark}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    VAR    ${card div}    //div[contains(@class, 'Card')]
    VAR    ${pencil}    ${tracker div}${card div}//div[./div[.='${items}']]//*[local-name()='svg']
    Click Element    ${pencil}
    ${input element}    Execute Javascript    return document.activeElement
    Press Keys    ${None}    CTRL+A    BACKSPACE
    Input Text    ${input element}    ${remark}
    Press Keys    ${None}    RETURN
    Wait Until Element Is Visible    ${pencil}

Tracking Records Should Be
    [Documentation]
    ...    ตรวจสอบ Tracking Records ของ ``items`` ใน Tracker Group ``group``
    ...
    ...    ``items`` ใส่ค่าแบบ ``ชื่อ=ข้อความ`` สามารถใส่ข้อมูลได้มากกว่า 1 ชุด
    ...    ---
    ...    Examples:
    ...    | Tracking Records Should Be | Fuel   | Machine 101=(1/2) |
    ...    | Tracking Records Should Be | Energy | Electricity (MEA / PEA)=(1/1) | MayaElec=(0/1) |
    [Arguments]    ${group}    &{items}
    VAR    ${tracker div}    //div[./div[@aria-hidden] and .//p[.='${group}']]
    VAR    ${card div}    //div[contains(@class, 'Card')]
    FOR  ${i}  IN  @{items}
        VAR    ${expected}    ${items}[${i}]
        ${records}    Get Text    ${tracker div}${card div}//div[./div[.='${i}']]/div[@id='tracking-records']/p
        Should Be Equal    ${records}    ${expected}
        ...    msg=Tracking records of '${i}' in ${group} has '${records}' instead of '${expected}'
        ...    values=${False}
    END

Dialog Tracking Records Should Be
    [Documentation]
    ...    ตรวจสอบ Tracking Records ของ ``items`` ใน hover card (dialog)
    ...
    ...    ``items`` ใส่ค่าแบบ ``ชื่อ=ข้อความ`` สามารถใส่ข้อมูลได้มากกว่า 1 ชุด
    ...    ---
    ...    Examples:
    ...    | Dialog Tracking Records Should Be | Machine 101=(1/2) |
    ...    | Dialog Tracking Records Should Be | Electricity (MEA / PEA)=(1/1) | MayaElec=(0/1) |
    [Arguments]    &{items}
    FOR  ${i}  IN  @{items}
        VAR    ${expected}    ${items}[${i}]
        ${records}    Get Text    //div[@role="dialog"]//div[./div[.='${i}']]/p
        Should Be Equal    ${records}    ${expected}
        ...    msg=Tracking records of '${i}' in dialog has '${records}' instead of '${expected}'
        ...    values=${False}
    END

Dialog Item Color Should Be
    [Documentation]
    ...    ตรวจสอบสีของ ``items`` ใน hover card (dialog)
    ...    
    ...    ``items`` ใส่ค่าแบบ ``ชื่อ=สี`` สามารถใส่ข้อมูลได้มากกว่า 1 ชุด
    ...    
    ...    สีที่เป็นไปได้คือ 'green', 'yellow', 'red', 'gray'
    ...    ---
    ...    Examples:
    ...    | Dialog Item Color Should Be | Machine 101=yellow |
    ...    | Dialog Item Color Should Be | Electricity (MEA / PEA)=green | MayaElec=gray |
    [Arguments]    &{items}
    FOR  ${i}  IN  @{items}
        VAR    ${color}    ${items}[${i}]
        ${circle}    Get WebElement    //div[@role="dialog"]//div[./p[.='${i}']]//div[@aria-haspopup]
        ${style}    Get Element Attribute    ${circle}    style
        IF  $color not in $style    Fail    '${i}' circle in dialog is not ${color}.
    END

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

Set Item Records
    [Arguments]    ${name}    ${records}
    Input Text    //div[@data-type and ./div='${name}']//input    ${records}

Decrement Item Record
    [Arguments]    ${name}    ${times}=1
    FOR  ${i}  IN RANGE  ${times}
        Click Button    //div[@data-type and ./div='${name}']//button[.='-']
    END

Increment Item Record
    [Arguments]    ${name}    ${times}=1
    FOR  ${i}  IN RANGE  ${times}
        Click Button    //div[@data-type and ./div='${name}']//button[.='+']
    END

Deselect Item
    [Arguments]    ${name}
    Click Button    //div[@data-type and ./div='${name}']//button[.='']
    Click Deselect Menu Button

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
Click Select Item Button
    [Arguments]    ${site}
    Click Button    //button[.//div[.='${site}']]/following-sibling::*//button[contains(., 'Select')]
    Wait Until Element Is Visible    //section//button

Click Stack Button
    [Documentation]    ``button`` ที่เป็นไปได้คือ "Select ->", "<- Deselect", "All ->", "<- All"
    [Arguments]    ${button}
    Click Button    (//button[.='${button}'])[2]

Search Available
    [Arguments]    ${text}
    Press Keys    //div[@data-type="forward"]//input[@placeholder]    CTRL+A    BACKSPACE
    Input Text    //div[@data-type="forward"]//input[@placeholder]    ${text}

Search Selected
    [Arguments]    ${text}
    Press Keys    //div[@data-type="backward"]//input[@placeholder]    CTRL+A    BACKSPACE
    Input Text    //div[@data-type="backward"]//input[@placeholder]    ${text}

Select Available Item
    [Arguments]    @{items}
    FOR  ${i}  IN  @{items}
        ${checkbox}    Get WebElement    //div[@data-type="forward"]//div[./p[.='${i}']]//input
        IF  not $checkbox.is_selected()
            Click Element    //div[@data-type="forward"]//div[@role="option" and @value='${i}']
        END
    END

Unselect Available Item
    [Arguments]    @{items}
    FOR  ${i}  IN  @{items}
        ${checkbox}    Get WebElement    //div[@data-type="forward"]//div[./p[.='${i}']]//input
        IF  $checkbox.is_selected()
            Click Element    //div[@data-type="forward"]//div[@role="option" and @value='${i}']
        END
    END

Select Selected Item
    [Arguments]    @{items}
    FOR  ${i}  IN  @{items}
        ${checkbox}    Get WebElement    //div[@data-type="backward"]//div[./p[.='${i}']]//input
        IF  not $checkbox.is_selected()
            Click Element    //div[@data-type="backward"]//div[@role="option" and @value='${i}']
        END
    END

Unselect Selected Item
    [Arguments]    @{items}
    FOR  ${i}  IN  @{items}
        ${checkbox}    Get WebElement    //div[@data-type="backward"]//div[./p[.='${i}']]//input
        IF  $checkbox.is_selected()
            Click Element    //div[@data-type="backward"]//div[@role="option" and @value='${i}']
        END
    END