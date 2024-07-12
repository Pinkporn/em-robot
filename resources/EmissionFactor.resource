*** Settings ***
Documentation     Emission Factors Page
Resource          FormUtility.resource

*** Variables ***


*** Keywords ***
Go To Emission Factors
    Click Element    //h3[text()='Data']
    Wait Until Element Is Visible    //h3[text()='Emission Factor']
    Click Element    //h3[text()='Emission Factor']
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Go To Emission Factors By Url
    [Arguments]    ${url}    ${org code}
    VAR    ${url to go}    ${url}/${org code}/data/emission-factors
    Go To    ${url to go}
    Wait Until Element Is Not Visible    //div[contains(@class, 'loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Click Add Emission Factor Button
    Wait Until Element Is Visible    //button[.//span[text()='Add Emission Factor']]
    Click Button    //button[.//span[text()='Add Emission Factor']]
    Wait Until Element Is Visible    //section

Select Effective Date
    [Documentation]
    ...    ``end date`` = ``None`` หมายถึงเลือก No Expiration Date
    [Arguments]    ${start date}    ${end date}=${None}
    Click Element    (//button[@data-dates-input="true"])[1]
    Select Date      ${start date}
    Wait Until Element Is Not Visible    //div[@role="dialog"]
    ${box}       Get WebElement    //input[@id=//label[text()='No Expiration Date']/@for]
    IF  $end_date is not None
        Unselect Checkbox    ${box}
        Click Element    (//button[@data-dates-input="true"])[2]
        Select Date    ${end date}
        Wait Until Element Is Not Visible    //div[@role="dialog"]
    ELSE
        Select Checkbox    ${box}
    END

Generic Emission Factor Form
    [Documentation]
    ...    Detail:
    ...    - หาก text field หรือ checkbox ได้ ``SKIP`` หรือ ``None`` จะเป็นการข้าม
    ...    - หาก drop down ได้ ``SKIP`` จะเป็นการข้าม ส่วน ``None`` จะเลือกตัวเลือกแรกหรือข้ามหากเลือกอยู่แล้ว
    ...    - หาก ``start date`` ถูกข้าม ``end date`` จะถูกข้ามด้วย
    ...    - ``gases`` เป็น dict โดย key ของ dict ที่เป็นไปได้มีดังนี้ CO2, CH4, Fossil CH4, N2O, SF6, NF3, HFCs, PFCs และ Total
    ...    - ประเภทข้อมูลที่ ``gases`` รับคือ dict หรือ str ในรูปแบบ dict
    ...    - ``**others`` เป็น kwargs โดยที่ key จะเป็นชื่อ label ส่วน value เป็นข้อมูลที่จะใช้
    ...    - Case-sensitive เพราะขี้เกียจดัก
    ...    ---
    ...    ตัวอย่างการใส่ argument ``gases``
    ...    | VAR        &{dict}              CH4=1    Fossil CH4=2    # robotcode: ignore
    ...    | &{dict}    Create Dictionary    CH4=1    Fossil CH4=2    # robotcode: ignore
    ...    | Generic Emission Factor Form    gases=${dict}            # robotcode: ignore
    ...    | Generic Emission Factor Form    gases={'Total': 10.25}
    ...    | Generic Emission Factor Form    gases={'CO2': 1, 'CH4': 2, 'N2O': 3}
    ...    ตัวอย่างการใส่ argument ``**others``
    ...    | Generic Emission Factor Form    Energy Source=Mana
    ...    | Generic Emission Factor Form    Renewable=${True}

    [Arguments]
    ...    ${start date}=SKIP    ${end date}=${None}
    ...    ${publisher}=SKIP     ${cert id}=SKIP
    ...    ${emission group}=SKIP
    ...    ${filling method}=SKIP
    ...    ${gases}=&{EMPTY}
    ...    &{others}

    VAR    ${gases}    ${{${gases}}}    # แปลงเป็น dict อีกรอบ เผื่อได้ str ในรูปแบบ dict

    IF  $start_date != 'SKIP' and $start_date is not None
        Select Effective Date    ${start date}    ${end date}
    END

    IF  $publisher != 'SKIP' and $publisher is not None
        Press Keys    name:vendorName    CTRL+A    BACKSPACE
        Input Text    name:vendorName    ${publisher}
    END

    IF  $cert_id != 'SKIP' and $cert_id is not None
        Input Text    name:certificateId    ${cert id}
    END
    
    IF  $emission_group != 'SKIP'
        Select Drop Down    Emission Group    ${emission group}
    END

    FOR  ${label}  IN  @{others}
        VAR    ${value}    ${others}[${label}]
        IF  $value == 'SKIP'    CONTINUE
        ${element}    Get Element From Label    ${label}
        ${strategy}    Check Input Type    ${element}
        IF  $strategy == 'TF'
            IF  $value is not None    Input Text    ${element}    ${value}
        ELSE IF  $strategy == 'DD'
            Select Drop Down By Locator    ${element}    ${value}
        ELSE  # CB
            IF  $value is not None
                IF  $element.is_selected() != $value    Click Element    ${element}
            END
        END
    END

    IF  $filling_method != 'SKIP'
        Select Drop Down    Filling Method    ${filling method}
    END

    FOR  ${gas}  IN  @{gases}
        VAR    ${value}    ${gases}[${gas}]
        ${element}    Get Element From Label    ${gas}    compare=.
        IF    $value != 'SKIP' and $value is not None    Input Text    ${element}    ${value}
    END

Enter Energy Emission Factor Form
    [Arguments]
    ...    ${start date}=SKIP    ${end date}=${None}
    ...    ${publisher}=SKIP
    ...    ${cert id}=SKIP
    ...    ${factor type}=SKIP
    ...    ${purchased type}=SKIP
    ...    ${source}=SKIP
    ...    ${unit}=SKIP
    ...    ${renewable}=SKIP
    ...    ${filling method}=${None}
    ...    &{gases}

    ${element}    Get Element From Label    Emission Group
    VAR    ${emission group}    ${{'Energy' if $element.is_enabled() else 'SKIP'}}

    Generic Emission Factor Form
    ...    ${start date}    ${end date}
    ...    ${publisher}     ${cert id}
    ...    ${emission group}
    ...    ${filling method}
    ...    ${gases}
    ...    Emission Factor Type=${factor type}
    ...    Purchased Energy Type=${purchased type}
    ...    Energy Source=${source}
    ...    Unit=${unit}
    ...    Renewable=${renewable}

Enter Fuel Emission Factor Form
    [Arguments]
    ...    ${start date}=SKIP    ${end date}=${None}
    ...    ${publisher}=SKIP
    ...    ${cert id}=SKIP
    ...    ${factor type}=SKIP
    ...    ${activity type}=SKIP
    ...    ${fuel group}=SKIP
    ...    ${fuel source}=SKIP
    ...    ${unit}=SKIP
    ...    ${filling method}=${None}
    ...    &{gases}

    ${element}    Get Element From Label    Emission Group
    VAR    ${emission group}    ${{'Fuel' if $element.is_enabled() else 'SKIP'}}

    Generic Emission Factor Form
    ...    ${start date}    ${end date}
    ...    ${publisher}     ${cert id}
    ...    ${emission group}
    ...    ${filling method}
    ...    ${gases}
    ...    Emission Factor Type=${factor type}
    ...    Activity Type=${activity type}
    ...    Fuel Group=${fuel group}
    ...    Fuel=${fuel source}
    ...    Unit=${unit}

Enter Purchases Emission Factor Form
    [Arguments]
    ...    ${start date}=SKIP    ${end date}=${None}
    ...    ${publisher}=SKIP
    ...    ${cert id}=SKIP
    ...    ${factor type}=SKIP
    ...    ${purchase group}=SKIP
    ...    ${goods and services}=SKIP
    ...    ${unit}=SKIP
    ...    ${filling method}=${None}
    ...    &{gases}

    ${element}    Get Element From Label    Emission Group
    VAR    ${emission group}    ${{'Purchases' if $element.is_enabled() else 'SKIP'}}

    Generic Emission Factor Form
    ...    ${start date}    ${end date}
    ...    ${publisher}     ${cert id}
    ...    ${emission group}
    ...    ${filling method}
    ...    ${gases}
    ...    Emission Factor Type=${factor type}
    ...    Purchase Group=${purchase group}
    ...    Goods / Services=${goods and services}
    ...    Unit=${unit}

Enter Water Emission Factor Form
    [Arguments]
    ...    ${start date}=SKIP    ${end date}=${None}
    ...    ${publisher}=SKIP
    ...    ${cert id}=SKIP
    ...    ${factor type}=SKIP
    ...    ${water type}=SKIP
    ...    ${unit}=SKIP
    ...    ${filling method}=${None}
    ...    &{gases}

    ${element}    Get Element From Label    Emission Group
    VAR    ${emission group}    ${{'Water' if $element.is_enabled() else 'SKIP'}}

    Generic Emission Factor Form
    ...    ${start date}    ${end date}
    ...    ${publisher}     ${cert id}
    ...    ${emission group}
    ...    ${filling method}
    ...    ${gases}
    ...    Emission Factor Type=${factor type}
    ...    Water Type=${water type}
    ...    Unit=${unit}

Enter Waste Disposal Emission Factor Form
    [Arguments]
    ...    ${start date}=SKIP    ${end date}=${None}
    ...    ${publisher}=SKIP
    ...    ${cert id}=SKIP
    ...    ${waste type}=SKIP
    ...    ${waste treatment}=SKIP
    ...    ${unit}=SKIP
    ...    ${filling method}=${None}
    ...    &{gases}

    ${element}    Get Element From Label    Emission Group
    VAR    ${emission group}    ${{'Outsourcing Waste Disposal' if $element.is_enabled() else 'SKIP'}}

    Generic Emission Factor Form
    ...    ${start date}    ${end date}
    ...    ${publisher}     ${cert id}
    ...    ${emission group}
    ...    ${filling method}
    ...    ${gases}
    ...    Waste Type=${waste type}
    ...    Waste Treatment=${waste treatment}
    ...    Unit=${unit}

Confirm Add EF
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Emission Factor created successfully
    Wait Until Element Is Not Visible    //section

Confirm Add EF Expect Invalid Date
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Failed
        VAR    ${invalid date message}    SEPARATOR=
    ...    Invalid Start Date or End Date for this emission factor.\n
    ...    \n Please make sure that the start date is adjacent to the end date of the previous emission factor with the same attributes.
    Toast Message Should Be    ${invalid date message}
    ...    error=Expected toast message:\n"<TEXT>"\nFound:\n"<ACTUAL_TEXT>"
    Click Close Modal

Confirm Add EF Expect Duplicate Cert.
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Failed
        VAR    ${invalid date message}    SEPARATOR=
    ...    Unable to add GHGs emission factors. Please check the certification.
    Toast Message Should Be    ${invalid date message}
    ...    error=Expected toast message:\n"<TEXT>"\nFound:\n"<ACTUAL_TEXT>"
    Click Close Modal

Confirm Add EF Expect Overlap Date
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Failed
    Wait Until Element Is Visible    //section//button[.="Understand"]
    Click Element    //section//button[.="Understand"]
    Wait Until Element Is Not Visible    //section//button[.="Understand"]
    Click Close Modal

Click Edit EF
    Click Kebab Button In Table
    Click Edit Menu Button

Click Duplicate EF
    Click Kebab Button In Table
    Click Duplicate Menu Button

Click Delete EF
    ${id}    Get Last Running No
    Click Kebab Button In Table
    Click Delete Menu Button
    Wait Until Element Is Visible    //section//button[.='Delete']
    Click Element    //section//button[.='Delete']
    Wait Until Element Is Not Visible    //section
    Wait Until Page Does Not Contain    EF-${id}

