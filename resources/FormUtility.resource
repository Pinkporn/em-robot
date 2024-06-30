*** Settings ***
Documentation     Keywords that can be reuse. Author: Sanfong
Library           SeleniumLibrary
Library           String

*** Variables ***
${POPOVER_XPATH}    (//div[contains(@class, 'Popover-dropdown') and not(contains(@style,'display: none'))])[last()]

*** Keywords ***
Find WebElement
    [Documentation]    Find element matching ``locator``.
    ...
    ...    ``locator``: Locator to use when searching the element.
    ...
    ...    ``tag``: Limit searching only to these elements.
    ...
    ...    ``required``: Raise ``ElementNotFound`` if element not found when ``True``, return ``None`` otherwise.
    ...
    ...    ``parent``: Optional parent ``WebElememt`` to search child elements
    ...    
    ...    ``return``: Found ``WebElement`` or ``None`` if element not found and ``required`` is ``False``.
    ...
    ...    ข้างใน ``Get WebElement`` จริงๆแล้วมี arguments มากถึง 4 ช่องแต่ selenium ทำเป็น keyword แล้วมีให้ใส่แค่ช่องเดียว
    ...    ใช้งานได้เหมือน ``Get WebElement`` แต่มักจะใช้เมื่อต้องการ WebElement แต่ไม่ต้องการให้เกิด error เมื่อหาไม่เจอ
    ...    ---
    ...    Examples:
    ...    | Get WebElement  | //svg |                  | \# Fail: Element with locator '//svg' not found. |
    ...    | Find WebElement | //svg | required=${True} | \# Fail: Element with locator '//svg' not found. |
    ...    | Find WebElement | //svg |                  | \# Return: None                                  |
    [Arguments]    ${locator}    ${tag}=${None}    ${required}=${False}    ${parent}=${None}
    # Run Keyword And Return    Evaluate    robot.libraries.BuiltIn.BuiltIn().get_library_instance('SeleniumLibrary')._element_finder.find_element($locator, required=$required, parent=$parent)    modules=robot
    ${selenium}    Get Library Instance    SeleniumLibrary
    RETURN    ${{$selenium._element_finder.find_element($locator, $tag, $required, $parent)}}

Click Element With Offset
    [Documentation]
    ...    เหมือน Click Element At Coordinates แต่ดีกว่า
    ...
    ...    Click Element At Coordinates จะเอาเม้าชี้ที่ element แล้วขยับเม้าตาม offset แล้วค่อยคลิก
    ...    แต่ keyword นี้จะเอาเม้าชี้ที่ offset ของ element เลยแล้วค่อยคลิก
    [Arguments]    ${locator}    ${xoffset}    ${yoffset}
    ${element}    Get WebElement    ${locator}
    ${selenium}    Get Library Instance    SeleniumLibrary
    ${action}    Evaluate
    ...    selenium.webdriver.common.action_chains.ActionChains($selenium.driver, $selenium.speed)
    ...    modules=selenium.webdriver.common.action_chains
    Evaluate    $action.move_to_element_with_offset($element, $xoffset, $yoffset).click().perform()

Check Input Type
    [Documentation]
    ...    ดูว่า element input ที่ได้มาเป็นประเภทอะไร
    ...    ค่า return ที่เป็นไปได้
    ...    `TF` (text field), `DD` (drop down), `CB` (check box), `MS` (multiselect drop down)
    [Arguments]    ${locator}
    ${class}    Get Element Attribute    ${locator}    class
    IF  'mantine-Checkbox-input' in $class  RETURN    CB
    IF  'mantine-Select-input' in $class    RETURN    DD
    IF  'mantine-MultiSelect-inputField' in $class  RETURN  MS
    RETURN    TF

Get Element From Label
    [Documentation]
    ...    คืน WebElement ที่ id ตรงกับ for attribute ของ label ที่มีข้อความ ``label``
    ...
    ...    ``compare`` เป็นวิธีในการหาข้อความ ``label``
    [Arguments]    ${label}    ${compare}=text()
    VAR    ${label_for}    (//label[./descendant-or-self::*[${compare}='${label}']]/@for)[last()]
    ${element}    Get WebElement    //*[@id=${label_for}]
    RETURN    ${element}

Select Date
    [Documentation]    เลือกเดือนและปีในปฏิทินตาม ``month year`` ด้วยรูปแบบเดือนเว้นวรรคปี เช่น ``Oct 2002``
    [Arguments]    ${month year}
    # แบ่ง 'month year' ออกเป็น 'month' และ 'year'
    ${month}    ${year}    Split String    ${month year}

    ${selenium}    Get Library Instance    SeleniumLibrary
    ${speed}    Set Selenium Speed    ${{$selenium.speed / 8}}
    # ดูปีในปฏิทิน
    Wait Until Element Is Visible   //button[contains(@class, 'calendarHeaderLevel') and text()]
    ${calendar year}    Get Text    //button[contains(@class, 'calendarHeaderLevel')]
    # หาความต่างปีปัจจุบันกับปีที่ต้องการ
    VAR    ${year diff}         ${{${year} - ${calendar year}}}
    # ดูว่าควรต้องจะเพิ่มหรือลดปี ถ้าผลต่างติดลบแปลว่าต้องลดปี
    VAR    ${year direction}    ${{'previous' if ${year diff} < 0 else 'next'}}
    # เอาเครื่องหมายลบในผลต่างออก จะได้รู้ว่าต้องกดปุ่มเปลี่ยนปีกี่ครั้ง
    VAR    ${year diff}         ${{abs(${year diff})}}
    # กดเปลี่ยนปี year diff ครั้ง
    FOR  ${i}  IN RANGE  ${year diff}
        Wait Until Element Is Visible    //button[@data-direction="${year direction}"]
        Element Should Be Enabled        //button[@data-direction="${year direction}"]
        Click Element                    //button[@data-direction="${year direction}"]
    END
    # เลือกเดือน
    VAR    ${month button}    //table[contains(@class, 'monthsList')]//button[text()='${month}']
    Wait Until Element Is Visible    ${month button}
    Element Should Be Enabled        ${month button}
    Click Element                    ${month button}
    Set Selenium Speed               ${speed}

Select Exact Date
    [Documentation]    เลือกวันเดือนและปีในปฏิทินตาม ``day month year`` ด้วยรูปแบบวันที่เว้นวรรคเดือนเว้นวรรคปี เช่น ``3 Oct 2002``
    ...
    ...    ใช้กับ Report Date ในหน้า edit report
    [Arguments]    ${day month year}

    ${day}    ${month}    ${year}    Split String    ${day month year}
    VAR    ${month year button}      //button[contains(@class, 'calendarHeaderLevel') and text()]
    Wait Until Element Is Visible    ${month year button}
    Click Button                     ${month year button}
    Select Date                      ${month} ${year}
    VAR    ${day button}    //table[contains(@class, 'DatePickerInput')]//button[text()='${day}' and not(@data-outside)]
    Wait Until Element Is Visible    ${day button}
    Click Button                     ${day button}

Select Date of Activity
    [Documentation]    เลือกช่วงเดือนปีในปฏิทิน
    ...
    ...    มักจะได้ใช้ใน form ของ add emission หรือ add eco-efficiency
    [Arguments]    ${from}=${None}    ${to}=${None}
    IF  $from is None and $to is None
        ${date button}    Get WebElements    //button[contains(@aria-label, "Date")]
        IF  $date_button
            Click Element    ${date button}[0]
            Press Keys    ${None}    TAB    TAB    RETURN    RETURN
        END
        RETURN
    END
    Click Element    //form//label[.//*[text()='Date of Activity']]
    Wait Until Element Is Visible   //button[contains(@class, 'calendarHeaderLevel')]
    Select Date    ${from}
    IF  $to is None
        Press Keys    ${None}    RETURN
        RETURN
    END
    Select Date    ${to}

Select Drop Down
    [Documentation]
    ...    หาแล้วคลิก drop down จาก ``label`` ที่ได้มาแล้วเลือก ``option``
    ...    หาก ``option`` เป็น ``None`` จะเป็นการกดลูกษรลงตามด้วยปุ่ม Enter
    ...
    ...    มักจะใช้ในการเลือกข้อมูลใน form
    ...    ---
    ...    Examples:
    ...    | Select Drop Down | Organization | Zpliporn Test | # เลือก org เป็น Zpliporn Test |
    ...    | Select Drop Down | Site         | Building 1    | # เลือก site เป็น Building 1   |
    [Arguments]    ${label}    ${option}=${None}
    ${drop down}    Get Element From Label    ${label}
    Scroll Element Into View       ${drop down}
    Select Drop Down By Locator    ${drop down}    ${option}

Select Drop Down By Locator
    [Documentation]
    ...    คลิก drop down จาก ``locator`` ที่ได้มาแล้วเลือก ``option``
    ...    โดย element ที่ได้จาก ``locator`` ควรเป็น tag input
    ...    และหาก ``option`` เป็น ``None`` จะเป็นการกดลูกษรลงตามด้วยปุ่ม Enter
    ...
    ...    มักจะใช้ในการเลือกข้อมูลจาก drop down ที่ไม่มี label เช่น drop down ใน Access Control
    ...    ---
    ...    Examples:
    ...    | Select Drop Down By Locator | //tr[.//p[text()='Mrs. Nurse Freedom']]//td[@data-idx=//th[text()='Role']/@data-idx]/div//input                 | Admin    | # เลือกให้ Mrs. Nurse Freedom เป็น Admin |
    ...    | Select Drop Down By Locator | //tr[.//p[text()='doctor.tanomporn@gmail.com']]//td[@data-idx=//th[text()='Organization']/@data-idx]/div//input | Sub-Zpli | # เลือกให้คนที่มีอีเมลนี้ไปอยู่ Sub-Zpli       |
    [Arguments]    ${locator}    ${option}=${None}
    
    IF  $option is None
        ${value}    Get Value    ${locator}
        IF    $value    RETURN
        Click Element    ${locator}
        Wait Until Element Is Visible    ${POPOVER_XPATH}
        Press Keys    ${None}    ARROW_DOWN    RETURN
        RETURN
    END
    VAR    ${option element}    ${POPOVER_XPATH}//div[@role="option" and ./descendant-or-self::*[text()='${option}']]
    Click Element    ${locator}
    Wait Until Element Is Visible    ${option element}    timeout=3
    ...    error=Option '${option}' not visible after 3 seconds. Check for case sensitivity again.
    Click Element    ${option element}

MultiSelect Drop Down By Locator
    [Documentation]
    ...    คลิก drop down จาก ``locator`` ที่ได้มาแล้วเลือกข้อมูลทั้งหมดตาม ``select options``
    ...    โดย element ที่ได้จาก ``locator`` ควรเป็น tag input
    ...    และหากไม่ใส่ ``select options`` จะเป็นการไม่เลือกอะไรเลย
    ...
    ...    มักจะใช้ในการเลือกข้อมูลจาก drop down หลายตัวเลือกเช่น drop down ใน Filter หรือ Report Template
    ...    ---
    ...    Examples:
    ...    | MultiSelect Drop Down By Locator | //input[@placeholder="Select Organizations To Be Included In Report"] | PC-Two | SubAAA | # คลิกปุ่มแล้วเลือก PC-Two และ SubAAA |
    ...    | MultiSelect Drop Down By Locator | //input[@placeholder="Select Organizations To Be Included In Report"] |        |        | # คลิกปุ่มแล้วยกเลิกการเลือกทั้งหมด |
    [Arguments]    ${locator}    @{select options}
    # กด drop down แล้วรอตัวเลือกแสดง
    Click Element    ${locator}

    Wait Until Element Is Visible    ${POPOVER_XPATH}
    # generate condition
    VAR    ${condition}    false()
    FOR  ${opt}  IN  @{select options}
        VAR    ${condition}    ${condition} or text()='${opt}'
    END
    # หา option ที่ต้องการทั้งแบบที่ถูกเลือกแล้วและยังไม่ถูกเลือก
    ${will select}    Get WebElements    ${POPOVER_XPATH}//div[@role="option" and @aria-selected="false" and ./descendant-or-self::*[${condition}]]
    ${selected}       Get WebElements    ${POPOVER_XPATH}//div[@role="option" and @aria-selected="true" and ./descendant-or-self::*[${condition}]]
    # Check ว่าจำนวนที่ option ที่ได้มากับที่จะเลือกมีค่าเท่ากัน ถ้าไม่เท่าแปลว่าได้ใส่ option ที่ไม่มีอยู่จริงเข้ามา
    VAR    ${received count}    ${{len($select_options)}}
    VAR    ${found count}       ${{len($will_select) + len($selected)}}
    Should Be Equal    ${received count}    ${found count}
    ...    msg=Receiced ${received count} items, but found only ${found count} items. Check your typo again.
    ...    values=${False}
    # คลิก option ที่ยังไม่ถูกเลือกทั้งหมด
    FOR  ${opt}  IN  @{will select}
        Click Element    ${opt}
    END
    # หา option ที่ไม่ต้องการแต่ถูกเลือกอยู่
    ${unselect}    Get WebElements    ${POPOVER_XPATH}//div[@role="option" and @aria-selected="true" and not(./descendant-or-self::*[${condition}])]
    FOR  ${opt}  IN  @{unselect}
        Click Element    ${opt}
    END
    Execute Javascript    document.activeElement.blur()    # unfocus element

Select Orgs Structure Drop Down
    [Documentation]    เลือก orgs ใน drop down ที่มักจะใช้ในการกรอง org
    ...
    ...    คลิกตาม ``locator`` ที่กำหนด ควรจะเป็นปุ่มที่ทำให้ drop down สำหรับกรอง orgs แสดง
    ...    จากนั้นยกเลิกการเลือกทุก orgs แล้วคลิกเลือกตาม ``orgs`` ที่กำหนดมา
    ...
    ...    หากใส่ ``locator`` เป็น ``${None}`` จะใช้ค่า default ให้
    ...    มีให้ใส่ ``locator`` เพราะเผื่อค่า default ใช้ไม่ได้
    ...    คิดอะไรไม่ออกก็ใส่ ``${None}`` ไปก่อน
    ...    ---
    ...    Examples:
    ...    | Select Orgs Structure Drop Down | //button | Blockfint |             | # กดปุ่มจาก locator ที่กำหนดแล้วเลือก Blockfint |
    ...    | Select Orgs Structure Drop Down | //button | Blockfint | Thinkerfint | # กดปุ่มจาก locator ที่กำหนดแล้วเลือก Blockfint จากนั้นเลือก Thinkerfint |
    ...    | Select Orgs Structure Drop Down | ${None}  | All Organizations |     | # กดปุ่มจาก default locator ค่าแล้วเลือกทุก orgs |
    ...    | Select Orgs Structure Drop Down | //button |           |             | # กดปุ่มแล้วไม่เลือกสัก org |
    ...    | Select Orgs Structure Drop Down | ${None} | All Organizations | Blockfint | # กดปุ่มจาก default locator แล้วไม่เลือก Blockfint |

    [Arguments]
    ...    ${locator}=${None}
    ...    @{orgs}
    
    # ถ้า ${locator} เป็น None ให้ใส่ค่า default
    IF  $locator is None
        VAR    ${locator}   //input[@placeholder="Select Organization"]/../..
    END
    # คลิกปุ่ม drop down จาก ${locator}
    ${element}    Get WebElement    ${locator}
    Evaluate    $element.click()
    Wait Until Element Is Visible    //div[@role='presentation' and not(contains(@style,'display: none'))]
    # ติ๊ก All Orgs แล้วติ๊กออก เพื่อล้าง orgs ที่เลือกออกทั้งหมด
    Select Checkbox      //div[./span and ./p[text()='All Organizations']]//input
    Unselect Checkbox    //div[./span and ./p[text()='All Organizations']]//input
    # วนแต่ละ org ที่ให้มา
    FOR  ${org}  IN  @{orgs}
        # วนคลิกปุ่มบวกที่เป็นของ parent org และ ancestor org
        VAR    ${div ตัวแรกที่ถูกซ่อนอยู่และมีตัวเลือกที่ต้องการ}    (//div[@aria-hidden="true" and .//div[./span and ./p[text()='${org}']]])[1]
        VAR    ${div ที่เป็นพี่}    /preceding-sibling::div
        VAR    ${plus icon}    //*[local-name()='svg' and ../div]
        ${plus}    Find WebElement    ${div ตัวแรกที่ถูกซ่อนอยู่และมีตัวเลือกที่ต้องการ} ${div ที่เป็นพี่} ${plus icon}
        WHILE  $plus is not None
            Wait Until Element Is Visible    ${plus}
            Click Element                    ${plus}
            ${plus}    Find WebElement    ${div ตัวแรกที่ถูกซ่อนอยู่และมีตัวเลือกที่ต้องการ} ${div ที่เป็นพี่} ${plus icon}
        END
        # คลิก org
        Wait Until Element Is Visible    //div[./span and ./p[text()='${org}']]
        Click Element                    //div[./span and ./p[text()='${org}']]
    END
    # ออกเมื่อเลือกเสร็จ
    Execute Javascript    document.activeElement.blur()

Click Kebab Button In Table
    [Documentation]
    ...    คลิกปุ่มสามจุดตามเงื่อนไข ``condition`` จากผลลัพท์ลำดับที่ ``result no``
    ...
    ...    ``condition`` สามารถเป็นเงื่อนไขอื่นได้ เช่น
    ...    - ``2`` หมายความว่า คลิกปุ่มสามจุดในแถวที่ 2
    ...    - ``.//*[text()='EM-999']`` หมายความว่า คลิกปุ่มสามจุดในแถวที่มีคำว่า EM-999
    ...    - ``.//*[text()='NewReport'] and position()=2`` หมายความว่า คลิกปุ่มสามจุดในแถวที่มีคำว่า NewReport และเป็นแถวที่ 2
    [Arguments]    ${condition}=1    ${result no}=1
    Wait Until Element Is Visible    (//tbody/tr[${condition}]//td[last()]//button)[${result no}]
    Click Button                     (//tbody/tr[${condition}]//td[last()]//button)[${result no}]

Click Menu Button
    [Documentation]
    ...    กดปุ่ม ``menu`` ในเมนูที่กำลังแสดงอยู่
    ...    มักจะใช้กับเมนูที่แสดงจากการปุ่มสามจุด
    [Arguments]    ${menu}
    Wait Until Element Is Visible    (//div[@role="menu"])[last()]//button[.='${menu}']
    Click Button                     (//div[@role="menu"])[last()]//button[.='${menu}']

Upload Evidences
    [Documentation]    อัปโหลดหลักฐานใน drop zone สามารถใส่ค่าสุดท้ายเป็น ``timeout`` ได้
    ...    ---
    ...    Examples:
    ...    | Upload Evidences | ${CURDIR}/test.pdf    |                     | # อัปโหลดไฟล์เดียว |
    ...    | Upload Evidences | ${CURDIR}/pic-1.png   | ${CURDIR}/pic-2.png | # อัปโหลดสองไฟล์  |
    ...    | Upload Evidences | ${CURDIR}/bigFile.pdf | 30                  | # อัปโหลดไฟล์เดียว รอนานสุด 30 วินาที |
    [Arguments]    @{files}
    TRY
        ${timeout}    Evaluate    SeleniumLibrary.utils._convert_timeout($files[-1])    modules=SeleniumLibrary.utils
        Evaluate    $files.pop()
    EXCEPT
        VAR    ${timeout}    ${None}
    END
    IF  len($files) == 0    RETURN
    ${paths}    Catenate    SEPARATOR=${\n}    @{files}
    Scroll Element Into View    //div[./input[@accept and @type='file']]
    Choose File    //div/input[@accept and @type='file']    ${paths}
    Wait Until Element Is Not Visible    css:.mantine-Dropzone-root .mantine-Loader-root    ${timeout}

Get Last Running No
    [Documentation]    คืนค่าเลข Running No. จากแถวแรกของตาราง
    ...
    ...    มักจะใช้คู่กับ Wait Until New Running No Is Visible
    ...    ---
    ...    Example:
    ...    | ${id}    Get Last Running No    # robotcode: ignore
    ...    | ...
    ...    | Wait Until New Running No Is Visible    ${id}    # robotcode: ignore
    ${element id}    Find WebElement    (//td[@data-key="runningNo"]//span)[1]
    IF  $element_id is None
        RETURN    ${0}
    END
    ${running no}    Get Text    ${element id}
    RETURN    ${{int($running_no[3:])}}

Wait Until New Running No Is Visible
    [Documentation]
    ...    รอจนกว่าจะเห็นเลข Running No. ที่มีค่าสูงกว่า ``id``
    ...    จะ error เมื่อรอนานกว่า ``timeout``
    ...
    ...    หาก ``timeout`` เป็น ``None`` จะใช้ timeout ของ Selenium
    [Arguments]    ${id}    ${timeout}=${None}
    IF  $timeout is None
        ${selenium}    Get Library Instance    SeleniumLibrary
        VAR    ${timeout}    ${selenium.timeout}
    END
    ${max_time}    Evaluate    time.time() + $timeout    modules=time
    WHILE  time.time() < $max_time
        ${new id}    Get Last Running No
        IF  $new_id > $id    RETURN
        Sleep    0.2
    END
    Fail    New running No. is not visible after ${timeout} seconds.

Click Close Modal
    [Documentation]    กดปิด modal ล่าสุดที่กำลังแสดงอยู่
    ${close}    Get WebElement    (//section//header//button)[last()]
    Click Element    ${close}
    Wait For Expected Condition    staleness_of    ${close}

Drop Down Should Not Contain Option
    [Documentation]    ตรวจสอบว่า drop down ``label`` ไม่มี ``option``
    [Arguments]    ${label}    ${option}
    ${input}    Get Element From Label    ${label}
    Scroll Element Into View    ${input}
    Click Element    ${input}
    Element Should Not Be Visible    ${POPOVER_XPATH}//span[text()='${option}']
    ...    message=There is '${option}' option in ${label}.