*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Fuel EF Default1-01
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EF1-001
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF

Add Fuel EF Default1-02
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=May 2023    publisher=EF A    cert id=EF1-002
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF

Add Fuel EF Default1-03
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Mar 2023    end date=May 2023    publisher=EF A    cert id=EF1-003
    ...    factor type=Combustion    activity type=Biogenic Emission     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.3
    Confirm Add EF

Add Fuel EF Default1-04
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EF1-004
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)     fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.1
    Confirm Add EF

Add Fuel EF Default1-05
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF A    cert id=EF1-005
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.5
    Confirm Add EF

Add Fuel EF Default1-06
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EF1-006
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.6
    Confirm Add EF

Check Element Select EF Type : Upstream
    [Tags]    validate
    [Documentation]
    Click Add Emission Factor Button
    Select Drop Down    Emission Group    Fuel
    Select Drop Down    Emission Factor Type    Upstream
    Drop Down Should Not Contain Option    Activity Type    Biogenic Emission
    Click Close Modal

Check Element Select Activity Type : Biogenic
    [Tags]    validate
    [Documentation]
    Click Add Emission Factor Button
    Select Drop Down    Emission Group    Fuel
    Select Drop Down    Activity Type    Biogenic Emission
    Drop Down Should Not Contain Option    Emission Factor Type    Upstream
    Click Close Modal

Delete All EF
    [Tags]    delete
    ${element}    Find WebElement    //td[@data-sticky="action"]//button
    WHILE    $element is not None
        Click Delete EF
        ${element}    Find WebElement    //td[@data-sticky="action"]//button
    END

Add Fuel EF Default2-01
    [Tags]    case 2
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EF1-001
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF

Add Fuel EF Default2-02
    [Tags]    case 2
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=May 2023    end date=May 2023    publisher=EF A    cert id=EF1-002
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF

Add Fuel EF Default2-03
    [Tags]    case 2
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Aug 2023    end date=Oct 2023    publisher=EF A    cert id=EF1-003
    ...    factor type=Combustion    activity type=Biogenic Emission     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.3
    Confirm Add EF

Add Fuel EF Default2-04
    [Tags]    case 2
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EF1-004
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)     fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.1
    Confirm Add EF

Add Fuel EF Default2-05
    [Tags]    case 2
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF A    cert id=EF1-005
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.5
    Confirm Add EF

Add Fuel EF Default2-06
    [Tags]    case 2
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EF1-006
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.6
    Confirm Add EF

Add Fuel EF Default3-01
    [Tags]    case 3
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EF3-001
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF

Add Fuel EF Default3-02
    [Tags]    case 3
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Mar 2023    end date=May 2023    publisher=EF A    cert id=EF3-002
    ...    factor type=Combustion    activity type=Biogenic Emission     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.3
    Confirm Add EF

Add Fuel EF Default3-03
    [Tags]    case 3
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EF3-003
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)     fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.4
    Confirm Add EF

Add Fuel EF Default3-04
    [Tags]    case 3
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF A    cert id=EF3-004
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A
    ...    unit=kg    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.2
    Confirm Add EF

Add Fuel EF Default3-05
    [Tags]    case 3
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EF3-005
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.6
    Confirm Add EF

Add Fuel EF Default3-06
    [Tags]    case 3
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=Aug 2023    publisher=EF A    cert id=EF3-006
    ...    factor type=Combustion    activity type=Biogenic Emission     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.7
    Confirm Add EF