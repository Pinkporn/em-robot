*** Settings ***
Documentation     Input Emission Test for custom Fuel emission factor
Resource          ${EXECDIR}/addEF/TestInputEf.resource
Suite Setup       Setup Everything
Test Teardown     Custom Teardown

*** Variables ***
@{SITES}          Site OU
${FUEL}           LPG_A (On-road vehicle)
${PUBLISHER}      EF A

*** Keywords ***


*** Test Cases ***
# Add EM1-01
#     [Tags]    case 1
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Jan 2023    Jan 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM1-02
#     [Tags]    case 1
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Jan 2023    Feb 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form
    
# Add EM1-03
#     [Tags]    case 1
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Feb 2023    Feb 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM1-04
#     [Tags]    case 1
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Feb 2023    Mar 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM1-05
#     [Tags]    case 1
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Mar 2023    Mar 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM1-06
#     [Tags]    case 1
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Mar 2023    Apr 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

Add EM2-01
    [Tags]    case 2
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Select Date of Activity    Jan 2023    Jan 2023
    Select Drop Down    Asset Name    Bike OU-1
    Drop Down Should Not Contain Option    Fuel    ${FUEL}
    Close Unsaved Changes Form

Add EM2-02
    [Tags]    case 2
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Asset Name    Bike OU-1
    Drop Down Should Not Contain Option    Fuel    ${FUEL}
    Close Unsaved Changes Form
    
Add EM2-03
    [Tags]    case 2
    [Documentation]    ไม่มี EF ให้เลือก (มีแต่ Upstream ไม่ได้ ต้องมี Combustion)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Select Date of Activity    Feb 2023    Feb 2023
    Select Drop Down    Asset Name    Bike OU-1
    Drop Down Should Not Contain Option    Fuel    ${FUEL}
    Close Unsaved Changes Form

Add EM2-04
    [Tags]    case 2
    [Documentation]    ไม่มี EF ให้เลือก (เดือน FEB มีแต่ Upstream)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Select Date of Activity    Feb 2023    Mar 2023
    Select Drop Down    Asset Name    Bike OU-1
    Drop Down Should Not Contain Option    Fuel    ${FUEL}
    Close Unsaved Changes Form

Add EM2-05
    [Tags]    case 2
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Select Date of Activity    Mar 2023    Mar 2023
    Select Drop Down    Asset Name    Bike OU-1
    Drop Down Should Not Contain Option    Fuel    ${FUEL}
    Close Unsaved Changes Form

Add EM2-06
    [Tags]    case 2
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Select Date of Activity    Mar 2023    Apr 2023
    Select Drop Down    Asset Name    Bike OU-1
    Drop Down Should Not Contain Option    Fuel    ${FUEL}
    Close Unsaved Changes Form

Add EM2-07
    [Tags]    case 2
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Apr 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=10.00 kg
    Click Delete Emission

Add EM2-08
    [Tags]    case 2
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=May 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=10.00 kg    scope 3=10.16 kg
    Click Delete Emission

Add EM2-09
    [Tags]    case 2
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Jun 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=19.89 kg    scope 3=23.30 kg
    Click Delete Emission

Add EM2-10
    [Tags]    case 2
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Oct 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=40.05 kg    scope 3=38.64 kg
    Click Delete Emission

Add EM2-11
    [Tags]    case 2
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Jul 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=40.00 kg    scope 3=50.00 kg
    Click Delete Emission

Add EM2-12
    [Tags]    case 2
    [Documentation]    Scope 1 เปลี่ยนค่า EF ส่วน Scope 3 และ Out of Scope ใช้ EF ค่าเดียว    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Sep 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=50.00 kg    scope 3=50.00 kg
    Click Delete Emission

Add EM2-13
    [Tags]    case 2
    [Documentation]    เหมือน EM-12 แต่เดือน OCT Scope 1 ยังไม่มี EF ใหม่ ให้ใช้ค่าเดิมต่อจากเดือน SEP        
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Oct 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=52.03 kg    scope 3=50.00 kg    outside of scope=18.04 kg
    Click Delete Emission

Add EM2-14
    [Tags]    case 2
    [Documentation]    Scope 1,3 ใช้ค่าตามที่มี ส่วน Out of Scope ใช้ค่าเดิมจากเดือน MAY    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Aug 2023    to date=Sep 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM2-15
    [Tags]    case 2
    [Documentation]     ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Aug 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM2-16
    [Tags]    case 2
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Oct 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM2-17
    [Tags]    case 2
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Nov 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

# Add EM3-01
#     [Tags]    case 3
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Jan 2023    Jan 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM3-02
#     [Tags]    case 3
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Jan 2023    Feb 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form
    
# Add EM3-03
#     [Tags]    case 3
#     [Documentation]    ไม่มี EF ให้เลือก (มีแต่ Upstream ไม่ได้ ต้องมี Combustion)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Feb 2023    Feb 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM3-04
#     [Tags]    case 3
#     [Documentation]    ไม่มี EF ให้เลือก (เดือน FEB มีแต่ Upstream)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Feb 2023    Mar 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM3-05
#     [Tags]    case 3
#     [Documentation]    ไม่มี EF ให้เลือก (เดือน MAR มีแต่ Biogenic ไม่มี Stationary/Mobile)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Mar 2023    Mar 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM3-06
#     [Tags]    case 3
#     [Documentation]    ไม่มี EF ให้เลือก (เดือน MAR มีแต่ Biogenic ไม่มี Stationary/Mobile)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Mar 2023    Apr 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

Add EM3-07
    [Tags]    case 3
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Apr 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=10.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM3-08
    [Tags]    case 3
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=May 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=10.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM3-09
    [Tags]    case 3
    [Documentation]    Out of Scope เดือน JUN ใช้ของใหม่ตามที่มี
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Jun 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=19.89 kg        scope 3=16.48 kg    outside of scope=43.19 kg
    Click Delete Emission

Add EM3-10
    [Tags]    case 3
    [Documentation]    Out of Scope เดือน JUN - OCT ใช้ของใหม่ตามที่มี
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Oct 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=40.05 kg        scope 3=35.75 kg    outside of scope=58.60 kg
    Click Delete Emission

Add EM3-11
    [Tags]    case 3
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Jul 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=40.00 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Add EM3-12
    [Tags]    case 3
    [Documentation]    Scope 1 เปลี่ยนค่า EF ส่วน Scope 3 และ Out of Scope ใช้ EF ค่าเดียว
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Sep 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=50.00 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Add EM3-13
    [Tags]    case 3
    [Documentation]    เหมือน EM-12 แต่เดือน OCT Scope 1 ยังไม่มี EF ใหม่ ให้ใช้ค่าเดิมต่อจากเดือน SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Oct 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=52.03 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Add EM3-14
    [Tags]    case 3
    [Documentation]    Scope 1,3 ใช้ค่าตามที่มี ส่วน Out of Scope ใช้ค่าเดิมจากเดือน MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Aug 2023    to date=Sep 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Add EM3-15
    [Tags]    case 3
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Aug 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Add EM3-16
    [Tags]    case 3
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Oct 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Add EM3-17
    [Tags]    case 3
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Nov 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Save Emission As Draft
    Check Record Emission    scope 1=60.00 kg        scope 3=50.00 kg    outside of scope=70.00 kg
    Click Delete Emission

Delete All EM
    [Tags]    delete
    ${element}    Find WebElement    //td[@data-sticky="action"]//button
    WHILE    $element is not None
        Click Delete Emission
        ${element}    Find WebElement    //td[@data-sticky="action"]//button
    END