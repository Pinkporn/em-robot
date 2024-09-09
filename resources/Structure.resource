*** Settings ***
Documentation     Parent Resource of Business Structure and Completion Tracking
Resource          FormUtility.resource

*** Variables ***
${SITE ICON}    //*[@d="M10 1.67a6.67 6.67 0 0 0-6.67 6.66c0 4.5 5.88 9.59 6.13 9.8a.83.83 0 0 0 1.08 0c.3-.21 6.13-5.3 6.13-9.8A6.67 6.67 0 0 0 10 1.67m0 14.7c-1.78-1.66-5-5.25-5-8.04a5 5 0 0 1 10 0c0 2.79-3.22 6.39-5 8.04M10 5a3.33 3.33 0 1 0 0 6.67A3.33 3.33 0 0 0 10 5m0 5a1.67 1.67 0 1 1 0-3.33A1.67 1.67 0 0 1 10 10"]
${CURRENT SELECTION}    //div[@data-selected="true"]
${COLLAPSED ICON}    //*[local-name()='svg' and @data-show="true" and @data-opened="false"]
${EXPANDED ICON}     //*[local-name()='svg' and @data-show="true" and @data-opened="true"]

*** Keywords ***
Select Structure Item
    [Documentation]
    ...    เลือก item จากชื่อ ``name`` ใน business structure
    ...    สามารถกำหนดประเภท ``type`` เพื่อเลือกเฉพาะ org หรือ site ได้
    ...
    ...    `type` มีค่าที่เป็นไปได้คือ `Any`, `Site`, `Org`
    [Arguments]    ${name}    ${type}=Any
    VAR    &{extra condition}    Any=${{''}}    Site=and .${SITE ICON}    Org=and not(.${SITE ICON})
    VAR    ${target}    //li[@role="listitem"]/div[1][.//p[text()='${name}'] ${extra condition}[${type}]]
    WHILE  True
        ${item}    Find WebElement    ${target}
        IF  $item is not None
            ${icon}    Get WebElement    ${target}//*[local-name()='svg' and ./following-sibling::div[.='${name}']]
            ${icon_data_opened}    Get Element Attribute    ${icon}    data-opened
            Click Element    ${item}
            Execute Javascript    arrow_icon = arguments[0]    ARGUMENTS    ${icon}
            Wait For Condition    return arrow_icon.getAttribute('data-opened') != '${icon_data_opened}'
            Execute Javascript    delete arrow_icon
            Wait Until Element Is Not Visible    css:.mantine-Overlay-root
            RETURN
        END
        ${icon}    Find WebElement    ${COLLAPSED ICON}
        IF  $icon is None
            Fail    Item '${name}' not found. What a waste of time.
        END
        Click Element    ${icon}
        Execute Javascript    arrow_icon = arguments[0]    ARGUMENTS    ${icon}
        Wait For Condition    return arrow_icon.getAttribute('data-opened') == 'true'
        Execute Javascript    delete arrow_icon
        Wait Until Element Is Not Visible    css:.mantine-Overlay-root
    END

Is Structure Item A Site
    [Documentation]    คืนค่า ``True`` ถ้า item ชื่อ ``name`` เป็น site ไม่งั้นคืนค่า ``False``
    [Arguments]    ${name}=CURRENT
    IF  $name == 'CURRENT'
        VAR    ${xpath}    ${CURRENT SELECTION}${SITE ICON}
    ELSE
        VAR    ${xpath}    //div[./p[text()='${name}']]${SITE ICON}
    END
    ${element}    Find WebElement    ${xpath}
    RETURN    ${{True if $element else False}}

Is Structure Item Expanded
    [Documentation]
    ...    คืนค่า True ถ้า item ชื่อ ``name`` เปิดอยู่แล้วไม่งั้น False
    ...    และคืนค่า ``None`` หากเป็น item ที่ไม่สามารถเปิดปิดได้ เช่น site หรือ org เปล่า
    [Arguments]    ${name}=CURRENT
    IF  $name == 'CURRENT'
        VAR    ${xpath}    ${CURRENT SELECTION}//*[local-name()='svg' and @data-opened]
    ELSE
        VAR    ${xpath}    //*[local-name()='svg' and ./following-sibling::div[.='${name}']]
    END
    ${icon}    Get WebElement    ${xpath}
    ${icon_data_opened}    Get Element Attribute    ${icon}    data-opened
    RETURN    ${{True if $icon_data_opened == 'true' else False}}

Expand Structure Item
    [Documentation]
    ...    คืนค่า True ถ้า item ชื่อ ``name`` เปิดอยู่แล้วไม่งั้น False
    ...    และคืนค่า ``None`` หากเป็น item ที่ไม่สามารถเปิดปิดได้ เช่น site หรือ org เปล่า
    [Arguments]    ${name}=CURRENT
    IF  $name == 'CURRENT'
        ${name}    Get Text   //div[@data-selected="true"]//p
    END
    ${is expanded}    Is Structure Item Expanded    ${name}
    IF  $is_expanded is False
        Select Structure Item    ${name}
    END