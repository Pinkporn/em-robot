*** Settings ***
Documentation     Input Emission Test for custom Outsourcing Waste Disposal emission factor
Resource          ${EXECDIR}/addEF/TestInputEf.resource
Suite Setup       Setup Everything
Test Teardown     Custom Teardown

*** Variables ***
# @{SITES}              Site OU
# @{CATEGORY}           Waste Generated in Operations    End-of-Life Treatment of Sold Products
# @{WASTE TYPE}         Wood    Glass
# @{TREATMENT}          Landfill    Combustion
# @{PUBLISHER}          EF A    EF B    EF C
# ${UNIT}               tonne

@{SITES}              Site G2-OU
@{CATEGORY}           Waste Generated in Operations    End-of-Life Treatment of Sold Products
@{WASTE TYPE}         Wood    Glass
@{TREATMENT}          Landfill    Combustion
@{PUBLISHER}          EF A    EF B    EF C
${UNIT}               tonne

*** Keywords ***


*** Test Cases ***
Add EM1-01
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Jan 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[0]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[0]
    Close Unsaved Changes Form

Add EM1-02
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM1-03
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=May 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM1-04
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=19.89 kg
    Click Delete Emission

Add EM1-05
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Mar 2023    Oct 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[0]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[0]
    Close Unsaved Changes Form


Add EM1-06
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=40.00 kg
    Click Delete Emission

Add EM1-07
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-08
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=52.03 kg
    Click Delete Emission

Add EM1-09
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM1-10
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM1-11
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM1-12
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM1-13
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[1]
    Close Unsaved Changes Form

Add EM1-14
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Mar 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM1-15
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM1-16
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=May 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM1-17
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=27.38 kg
    Click Delete Emission

Add EM1-18
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=38.73 kg
    Click Delete Emission

Add EM1-19
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-20
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-21
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-22
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-23
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-24
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-25
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM1-26
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ FEB ไม่มี EF C)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[1]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[2]
    Close Unsaved Changes Form

Add EM1-27
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ FEB ไม่มี EF C)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    Waste Generated in Operations
    Select Drop Down     Waste Type    ${WASTE TYPE}[1]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[2]
    Close Unsaved Changes Form

Add EM1-28
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Mar 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-29
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-30
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=May 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-31
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-32
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-OCT ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-33
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-JUL ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-34
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-SEP ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-35
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    JUN-OCT ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-36
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    AUG-SEP ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-37
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    AUG-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-38
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM1-39
    [Tags]    cat1    #Waste Generated in Operations
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[0]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-01
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Jan 2023
    Select Drop Down    Category    End-of-Life Treatment of Sold Products
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[0]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[0]
    Close Unsaved Changes Form

Add EM2-02
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM2-03
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=May 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=10.00 kg
    Click Delete Emission

Add EM2-04
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Apr 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=19.89 kg
    Click Delete Emission

Add EM2-05
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Mar 2023    Oct 2023
    Select Drop Down    Category    End-of-Life Treatment of Sold Products
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[0]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[0]
    Close Unsaved Changes Form


Add EM2-06
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=40.00 kg
    Click Delete Emission

Add EM2-07
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-08
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    OCT ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=52.03 kg
    Click Delete Emission

Add EM2-09
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM2-10
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM2-11
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM2-12
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก SEP
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[0]
    ...    publisher=${PUBLISHER}[0]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=60.00 kg
    Click Delete Emission

Add EM2-13
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ Date เกิน EF ที่มี)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    End-of-Life Treatment of Sold Products
    Select Drop Down     Waste Type    ${WASTE TYPE}[0]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[1]
    Close Unsaved Changes Form

Add EM2-14
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Mar 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM2-15
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM2-16
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=May 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=20.00 kg
    Click Delete Emission

Add EM2-17
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=27.38 kg
    Click Delete Emission

Add EM2-18
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=38.73 kg
    Click Delete Emission

Add EM2-19
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-20
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-21
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-22
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-23
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-24
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-25
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก OCT
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[0]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[1]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=50.00 kg
    Click Delete Emission

Add EM2-26
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ FEB ไม่มี EF C)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    End-of-Life Treatment of Sold Products
    Select Drop Down     Waste Type    ${WASTE TYPE}[1]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[2]
    Close Unsaved Changes Form

Add EM2-27
    [Documentation]    ไม่มี EF ให้เลือก (เพราะ FEB ไม่มี EF C)
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Select Date of Activity    Jan 2023    Feb 2023
    Select Drop Down    Category    End-of-Life Treatment of Sold Products
    Select Drop Down     Waste Type    ${WASTE TYPE}[1]
    Select Drop Down     Waste Treatment    ${TREATMENT}[1]
    Drop Down Should Not Contain Option    Emission Factor Publisher    ${PUBLISHER}[2]
    Close Unsaved Changes Form

Add EM2-28
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Mar 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-29
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Apr 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-30
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=May 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-31
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    JUN ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Jun 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-32
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    JUN-OCT ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Mar 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-33
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    JUN-JUL ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Jul 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-34
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    JUN-SEP ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-35
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    JUN-OCT ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Jun 2023    to date=Oct 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-36
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    AUG-SEP ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Sep 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-37
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    AUG-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Aug 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-38
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    OCT-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Oct 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Add EM2-39
    [Tags]    cat2    #End-of-Life Treatment of Sold Products
    [Documentation]    NOV-DEC ใช้ EF ต่อจาก MAY
    Add Emission Page 1 2    ${ORGANIZATION}    ${SITES}[0]    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form    from date=Nov 2023    to date=Dec 2023    
    ...    category=${CATEGORY}[1]    waste type=${WASTE TYPE}[1]    treatment=${TREATMENT}[1]
    ...    publisher=${PUBLISHER}[2]    unit=${UNIT}    amount=100
    Save Emission
    Check Record Emission    scope 3=30.00 kg
    Click Delete Emission

Delete All EM
    [Tags]    delete
    ${element}    Find WebElement    //td[@data-sticky="action"]//button
    WHILE    $element is not None
        Click Delete Emission
        ${element}    Find WebElement    //td[@data-sticky="action"]//button
    END