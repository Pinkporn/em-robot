*** Settings ***
Documentation     Input Emission from Fuel custom factor test
Resource          ../resources/InputEmission.resource
Resource          ../resources/Common.resource
Suite Setup       Setup Everything
Test Teardown     Custom Teardown

*** Variables ***
${URL}            https://app-uat.zplify.com/
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Gideon Two
@{SITES}          Site OU
${FUEL}           LPG_A (On-Road vehicle)
${PUBLISHER}      EF A

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Input Emission

Custom Teardown
    Sleep    0.5
    Run Keyword If Test Failed    Close Unsaved Changes Form

Close Unsaved Changes Form
    ${modal}    Find WebElement    //section
    IF  $modal is None    RETURN
    Click Element    (//section//header//button)[last()]
    Wait Until Element Is Visible    //button[.='Confirm']
    Click Element    //button[.='Confirm']
    Wait Until Element Is Not Visible    //section

*** Test Cases ***
# Add EM 01
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Jan 2023    Jan 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM 02
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Jan 2023    Feb 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form
    
# Add EM 03
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Feb 2023    Feb 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM 04
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Feb 2023    Mar 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM 05
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Mar 2023    Mar 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

# Add EM 06
#     [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
#     Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
#     Select Date of Activity    Mar 2023    Apr 2023
#     Select Drop Down    Asset Name    Bike OU-1
#     Drop Down Should Not Contain Option    Fuel    ${FUEL}
#     Close Unsaved Changes Form

Add EM 07
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Apr 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=10.00 kg
    Click Delete Emission

Add EM 08
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=May 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=10.00 kg    scope 3=10.16 kg
    Click Delete Emission

Add EM 09
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Jun 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=19.89 kg    scope 3=23.30 kg
    Click Delete Emission

Add EM 10
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Apr 2023    to date=Oct 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=40.05 kg    scope 3=38.64 kg
    Click Delete Emission

Add EM 11
    [Documentation]    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Jul 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=40.00 kg    scope 3=50.00 kg
    Click Delete Emission

Add EM 12
    [Documentation]    Scope 1 เปลี่ยนค่า EF ส่วน Scope 3 และ Out of Scope ใช้ EF ค่าเดียว    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Sep 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=50.00 kg    scope 3=50.00 kg
    Click Delete Emission

Add EM 13
    [Documentation]    เหมือน EM-12 แต่เดือน OCT Scope 1 ยังไม่มี EF ใหม่ ให้ใช้ค่าเดิมต่อจากเดือน SEP        
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Jun 2023    to date=Oct 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=52.03 kg    scope 3=50.00 kg    outside of scope=18.04 kg
    Click Delete Emission

Add EM 14
    [Documentation]    Scope 1,3 ใช้ค่าตามที่มี ส่วน Out of Scope ใช้ค่าเดิมจากเดือน MAY    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Aug 2023    to date=Sep 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM 15
    [Documentation]     ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Aug 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM 16
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Oct 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

Add EM 17
    [Documentation]    ช่วงที่เกินจาก Effective Date ให้ใช้ค่าเดิมต่อไป    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Fuel
    Enter Fuel Form    from date=Nov 2023    to date=Dec 2023    asset name=Bike OU-1    
    ...    fuel=${FUEL}    publisher=${PUBLISHER}    amount=100
    Click Element    //button[.='Save as Draft']
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission    scope 1=60.00 kg    scope 3=50.00 kg    outside of scope=30.00 kg
    Click Delete Emission

