*** Settings ***
Documentation     Input Emission Test for custom Fuel emission factor
Resource          ${EXECDIR}/addEF/TestInputEf.resource
Suite Setup       Setup Everything
Test Teardown     Custom Teardown

*** Variables ***
@{SITES}          Site OU
@{GOODS}          Good A    Good B    Good C
@{PUBLISHER}      EF A    EF B    EF C
${UNIT}           kg

*** Keywords ***


*** Test Cases ***
Add EM-1
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Select Date of Activity    Feb 2023    Feb 2023
    Drop Down Should Not Contain Option    Goods / Services    ${GOODS}[0]
    Close Unsaved Changes Form

Add EM-2
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Select Date of Activity    Mar 2023    Apr 2023
    Drop Down Should Not Contain Option    Goods / Services    ${GOODS}[0]
    Close Unsaved Changes Form

Add EM-3
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=Apr 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM-4
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=May 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM-5
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=Jun 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=19.89 kg
    Click Delete Emission

Add EM-6
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าล่าสุดต่อไป
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=Oct 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=40.05 kg
    Click Delete Emission

Add EM-7
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Jun 2023    to date=Jul 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=40.00 kg
    Click Delete Emission

Add EM-8
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Jun 2023    to date=Oct 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=52.03 kg
    Click Delete Emission

Add EM-9
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Aug 2023    to date=Sep 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-10
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าล่าสุดต่อไป
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Aug 2023    to date=Dec 2023    goods services=${GOODS}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-11
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าล่าสุดต่อไป / capital goods=true / name=ขวด 1.5 ลิตร
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Oct 2023    to date=Dec 2023    goods services=${GOODS}[0]    vendor=Purchase Thailand
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100    capital goods=true    name=ขวด 1.5 ลิตร    remark=3 เดือนสุดท้ายของปี
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-12
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Select Date of Activity    Jan 2023    Jan 2023
    Drop Down Should Not Contain Option    Goods / Services    ${GOODS}[1]
    Close Unsaved Changes Form

Add EM-13
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Select Date of Activity    Jan 2023    Feb 2023
    Drop Down Should Not Contain Option    Goods / Services    ${GOODS}[1]
    Close Unsaved Changes Form

Add EM-14
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Oct 2023    to date=Dec 2023    goods services=${GOODS}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM-15
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Feb 2023    to date=Mar 2023    goods services=${GOODS}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM-16
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าล่าสุดต่อไป
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Feb 2023    to date=May 2023    goods services=${GOODS}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM-17
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Select Date of Activity    Mar 2023    Mar 2023
    Drop Down Should Not Contain Option    Goods / Services    ${GOODS}[2]
    Close Unsaved Changes Form

Add EM-18
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Select Date of Activity    Mar 2023    Apr 2023
    Drop Down Should Not Contain Option    Goods / Services    ${GOODS}[2]
    Close Unsaved Changes Form

Add EM-19
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=Apr 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-20
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=May 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-21
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=Jun 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=36.59 kg
    Click Delete Emission

Add EM-22
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Apr 2023    to date=Oct 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=44.30 kg
    Click Delete Emission

Add EM-23
    [Documentation]
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Jun 2023    to date=Oct 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-24
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าล่าสุดต่อไป
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Aug 2023    to date=Dec 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-25
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าล่าสุดต่อไป
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Purchases
    Enter Purchases Form    from date=Oct 2023    to date=Dec 2023    goods services=${GOODS}[2]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Click Element    //button[.='Add']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Delete All EM
    [Tags]    delete
    ${element}    Find WebElement    //td[@data-sticky="action"]//button
    WHILE    $element is not None
        Click Delete Emission
        ${element}    Find WebElement    //td[@data-sticky="action"]//button
    END