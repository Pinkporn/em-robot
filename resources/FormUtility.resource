*** Settings ***
Documentation     Keywords that can be reuse. Author: Sanfong
Library           SeleniumLibrary
Library           String

*** Keywords ***
Find WebElement
    [Documentation]    Find element matching `locator`.
    ...
    ...    `locator`: Locator to use when searching the element.
    ...
    ...    `required`: Raise `ElementNotFound` if element not found when `${True}`, return `None` otherwise.
    ...
    ...    `parent`: Optional parent `WebElememt` to search child elements
    ...    
    ...    `return`: Found `WebElement` or `None` if element not found and `required` is `${False}`.
    ...
    ...    ข้างใน `Get WebElement` จริงๆแล้วมี arguments มากถึง 4 ช่องแต่ selenium ทำเป็น keyword แล้วมีให้ใส่แค่ช่องเดียว
    ...    ใช้งานได้เหมือน `Get WebElement` แต่มักจะใช้เมื่อต้องการ WebElement แต่ไม่ต้องการให้เกิด error เมื่อหาไม่เจอ
    ...    ---
    ...    Examples:
    ...    | Get WebElement  | //svg |                  | \# Fail: Element with locator '//svg' not found. |
    ...    | Find WebElement | //svg | required=${True} | \# Fail: Element with locator '//svg' not found. |
    ...    | Find WebElement | //svg |                  | \# Return: None                                  |
    [Arguments]    ${locator}    ${required}=${False}    ${parent}=${None}
    # Run Keyword And Return    Evaluate    robot.libraries.BuiltIn.BuiltIn().get_library_instance('SeleniumLibrary')._element_finder.find_element($locator, required=$required, parent=$parent)    modules=robot
    ${selenium}    Get Library Instance    SeleniumLibrary
    RETURN    ${{$selenium._element_finder.find_element($locator, required=$required, parent=$parent)}}

Blur Active Element
    [Documentation]    Removes keyboard focus from the current element.
    ${element}    Execute Javascript    return document.activeElement
    Execute Javascript    document.activeElement.blur()
    RETURN    ${element}

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

Get Id From Label In Modal Form
    [Documentation]    คืน id ของ input จาก label ที่มี `text` ที่ได้รับมา
    ...    และ `compare` คือสิ่งที่จะเอามาเทียบกับ `text`
    [Arguments]
    ...    ${text}    ${compare}=text()
    VAR    ${xpath}    (//label[(contains(@class, 'InputWrapper-label') or contains(@class, 'Checkbox-label')) and ./descendant-or-self::*[${compare}='${text}']])[last()]
    ${input id}    Get Element Attribute    ${xpath}    for
    RETURN    ${input id}

Select Date
    [Documentation]    เลือกเดือนและปีในปฏิทินตาม `month year` ด้วยรูปแบบเดือนเว้นวรรคด้วยปี เช่น `Oct 2002`
    [Arguments]    ${month year}
    # แบ่ง 'month year' ออกเป็น 'month' และ 'year'
    ${month}    ${year}    Split String    ${month year}
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
        Wait Until Element Is Enabled    //button[@data-direction="${year direction}"]
        Wait Until Element Is Visible    //button[@data-direction="${year direction}"]
        Click Element    //button[@data-direction="${year direction}"]
    END
    # เลือกเดือน
    VAR    ${month button}    //table[contains(@class, 'monthsList')]//button[text()='${month}']
    Wait Until Element Is Visible    ${month button}
    Wait Until Element Is Enabled    ${month button}
    Click Element    ${month button}

Select Drop Down
    [Documentation]
    ...    หาแล้วคลิก drop down จาก `label` ที่ได้มาแล้วเลือก `option`
    ...    หาก `option` เป็น `None` จะเป็นการกดลูกษรลงตามด้วยปุ่ม Enter
    ...
    ...    มักจะใช้ในการเลือกข้อมูลใน form
    ...    ---
    ...    Examples:
    ...    | Select Drop Down | Organization | Zpliporn Test | # เลือก org เป็น Zpliporn Test |
    ...    | Select Drop Down | Site         | Building 1    | # เลือก site เป็น Building 1   |
    [Arguments]    ${label}    ${option}=${None}
    ${drop down}    Get Id From Label In Modal Form    ${label}
    Select Drop Down By Locator    id:${drop down}    ${option}

Select Drop Down By Locator
    [Documentation]
    ...    คลิก drop down จาก `locator` ที่ได้มาแล้วเลือก `option`
    ...    โดย element ที่ได้จาก `locator` ควรเป็น tag input
    ...    และหาก `option` เป็น `None` จะเป็นการกดลูกษรลงตามด้วยปุ่ม Enter
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
        # Wait Until Element Is Visible    //div[contains(@class, 'mantine-Select')]
        Wait Until Element Is Visible    //div[@role='presentation' and not(contains(@style,'display: none'))]
        Press Keys    ${None}    ARROW_DOWN    RETURN
        RETURN
    END
    # VAR    ${option element}    //div[@role="option" and (text()='${option}' or ./span[text()='${option}'])]
    # VAR    ${option element}    (//div[@role="option" and ./descendant-or-self::*[text()='${option}']])[last()]
    VAR    ${option element}    //div[@role='presentation' and not(contains(@style,'display: none'))]//div[@role="option" and ./descendant-or-self::*[text()='${option}']]
    Click Element    ${locator}
    Wait Until Element Is Visible    ${option element}
    Click Element    ${option element}

MultiSelect Drop Down By Locator
    [Documentation]
    ...    คลิก drop down จาก `locator` ที่ได้มาแล้วเลือกข้อมูลทั้งหมดตาม `select options`
    ...    โดย element ที่ได้จาก `locator` ควรเป็น tag input
    ...    และหากไม่ใส่ `select options` จะเป็นการไม่เลือกอะไรเลย
    ...
    ...    มักจะใช้ในการเลือกข้อมูลจาก drop down หลายตัวเลือกเช่น drop down ใน Filter หรือ Report Template
    ...    ---
    ...    Examples:
    ...    | MultiSelect Drop Down By Locator | //input[@placeholder="Select Organizations To Be Included In Report"] | PC-Two | SubAAA | # คลิกปุ่มแล้วเลือก PC-Two และ SubAAA |
    ...    | MultiSelect Drop Down By Locator | //input[@placeholder="Select Organizations To Be Included In Report"] |        |        | # คลิกปุ่มแล้วยกเลิกการเลือกทั้งหมด |
    [Arguments]    ${locator}    @{select options}
    # กด drop down แล้วรอตัวเลือกแสดง
    Click Element    ${locator}
    VAR    ${popover}    //div[@role='presentation' and not(contains(@style,'display: none'))]
    Wait Until Element Is Visible    ${popover}
    # generate condition
    VAR    ${condition}    false()
    FOR  ${opt}  IN  @{select options}
        VAR    ${condition}    ${condition} or text()='${opt}'
    END
    # หา option ที่ต้องการทั้งแบบที่ถูกเลือกแล้วและยังไม่ถูกเลือก
    ${will select}    Get WebElements    ${popover}//div[@role="option" and @aria-selected="false" and ./descendant-or-self::*[${condition}]]
    ${selected}       Get WebElements    ${popover}//div[@role="option" and @aria-selected="true" and ./descendant-or-self::*[${condition}]]
    # Check ว่าจำนวนที่ option ที่ได้มากับที่จะเลือกมีค่าเท่ากัน ถ้าไม่เท่าแปลว่าได้ใส่ option ที่ไม่มีอยู่จริงเข้ามา
    VAR    ${received count}    ${{len($select_options)}}
    VAR    ${found count}    ${{len($will_select) + len($selected)}}
    Should Be Equal    ${received count}    ${found count}    msg=Receiced ${received count} items, but found only ${found count} items. Check your typo again.    values=${False}
    # คลิก option ที่ยังไม่ถูกเลือกทั้งหมด
    FOR  ${opt}  IN  @{will select}
        Click Element    ${opt}
    END
    # หา option ที่ไม่ต้องการแต่ถูกเลือกอยู่
    ${unselect}    Get WebElements    ${popover}//div[@role="option" and @aria-selected="true" and not(./descendant-or-self::*[${condition}])]
    FOR  ${opt}  IN  @{unselect}
        Click Element    ${opt}
    END
    Execute Javascript    document.activeElement.blur()    # unfocus element

Select Orgs Structure Drop Down
    [Documentation]    เลือก orgs ใน drop down ที่มักจะใช้ในการกรอง org
    ...
    ...    คลิกตาม `locator` ที่กำหนด ควรจะเป็นปุ่มที่ทำให้ drop down สำหรับกรอง orgs แสดง
    ...    จากนั้นยกเลิกการเลือกทุก orgs แล้วคลิกเลือกตาม `orgs` ที่กำหนดมา
    ...
    ...    หากใส่ `locator` เป็น `${None}` จะใช้ค่า default ให้
    ...    มีให้ใส่ `locator` เพราะเผื่อค่า default ใช้ไม่ได้
    ...    คิดอะไรไม่ออกก็ใส่ `${None}` ไปก่อน
    ...    ---
    ...    Examples:
    ...    | Select Orgs Structure Drop Down | //button | Blockfint |             | # กดปุ่มจาก `locator` ที่กำหนดแล้วเลือก Blockfint |
    ...    | Select Orgs Structure Drop Down | //button | Blockfint | Thinkerfint | # กดปุ่มจาก `locator` ที่กำหนดแล้วเลือก Blockfint จากนั้นเลือก Thinkerfint |
    ...    | Select Orgs Structure Drop Down | ${None} | All Organizations |      | # กดปุ่มจาก default `locator` ค่าแล้วเลือกทุก orgs |
    ...    | Select Orgs Structure Drop Down | //button | |                       | # กดปุ่มแล้วไม่เลือกสัก org |
    ...    | Select Orgs Structure Drop Down | ${None} | All Organizations | Blockfint | # กดปุ่มจาก default `locator` แล้วไม่เลือก Blockfint |

    [Arguments]
    ...    ${locator}=${None}
    ...    @{orgs}
    
    # ถ้า ${locator} เป็น None ให้ใส่ค่า default
    IF  $locator is None
        VAR    ${locator}   //input[@placeholder="Select Organization"]/../../..
    END
    # คลิกปุ่ม drop down จาก ${locator}
    Click Element    ${locator}
    Wait Until Element Is Visible    //div[@role='presentation' and not(contains(@style,'display: none'))]
    # ติ๊ก All Orgs แล้วติ๊กออก เพื่อล้าง orgs ที่เลือกออกทั้งหมด
    Select Checkbox    //div[./span and ./p[text()='All Organizations']]//input
    Unselect Checkbox    //div[./span and ./p[text()='All Organizations']]//input
    # วนแต่ละ org ที่ให้มา
    FOR  ${org}  IN  @{orgs}
        # วนคลิกปุ่มบวกที่เป็นของ parent org และ ancestor org
        VAR    ${div ตัวแรกที่ถูกซ่อนอยู่และมีตัวเลือกที่ต้องการ}    (//div[@aria-hidden="true" and .//div[./span and ./p[text()='${org}']]])[1]
        VAR    ${div ที่เป็นพี่}    /preceding-sibling::div
        VAR    ${plus icon}    //*[local-name()='svg' and ../div]    # //*[@d="M7.14.04v12.92M.69 6.5H13.6"]
        ${plus}    Find WebElement    ${div ตัวแรกที่ถูกซ่อนอยู่และมีตัวเลือกที่ต้องการ} ${div ที่เป็นพี่} ${plus icon}
        WHILE  $plus is not None
            Wait Until Element Is Visible    ${plus}
            Click Element    ${plus}
            ${plus}    Find WebElement    ${div ตัวแรกที่ถูกซ่อนอยู่และมีตัวเลือกที่ต้องการ} ${div ที่เป็นพี่} ${plus icon}
        END
        # คลิก org
        Wait Until Element Is Visible    //div[./span and ./p[text()='${org}']]
        Click Element    //div[./span and ./p[text()='${org}']]
    END
    # ออกเมื่อเลือกเสร็จ
    Execute Javascript    document.activeElement.blur()

