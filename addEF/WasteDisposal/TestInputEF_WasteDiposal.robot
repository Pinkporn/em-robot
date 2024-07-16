*** Settings ***
Documentation     Input Emission Test for custom Outsourcing Waste Disposal emission factor
Resource          ${EXECDIR}/addEF/TestInputEf.resource
Suite Setup       Setup Everything
Test Teardown     Custom Teardown

*** Variables ***
@{SITES}              Site OU
@{CATEGORY}           Waste Generated in Operations    End-of-Life Treatment of Sold Products
@{WASTE TYPE}         Wood    Glass
@{TREATMENT}          Landfill    Combustion
@{PUBLISHER}          EF A    EF B    EF C
${UNIT}               tonne

*** Keywords ***


*** Test Cases ***
Add EM-01
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Jan 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[0]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[0]
    Close Unsaved Changes Form

Add EM-02
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM-03
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=May 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM-04
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=19.89 kg
    Click Delete Emission

Add EM-05
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=40.05 kg
    Click Delete Emission

Add EM-06
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=40.00 kg
    Click Delete Emission

Add EM-07
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-08
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=52.03 kg
    Click Delete Emission

Add EM-09
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-10
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-11
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-12
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM-13
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[1]
    Close Unsaved Changes Form

Add EM-14
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Mar 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM-15
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM-16
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=May 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM-17
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=27.38 kg
    Click Delete Emission

Add EM-18
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=38.73 kg
    Click Delete Emission

Add EM-19
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-20
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-21
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-22
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-23
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-24
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-25
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM-26
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ FEB ไม่มี EF C)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[1]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[2]
    Close Unsaved Changes Form

Add EM-27
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ FEB ไม่มี EF C)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[1]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[2]
    Close Unsaved Changes Form

Add EM-28
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Mar 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-29
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-30
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=May 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-31
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-32
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-OCT ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-33
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-JUL ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-34
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-SEP ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-35
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-OCT ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-36
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    AUG-SEP ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-37
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    AUG-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-38
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM-39
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

# Delete All EM
#     [Tags]    delete
#     ${element}    Find WebElement    //td[@data-sticky="action"]//button
#     WHILE    $element is not None
#         Click Delete Emission
#         ${element}    Find WebElement    //td[@data-sticky="action"]//button
#     END