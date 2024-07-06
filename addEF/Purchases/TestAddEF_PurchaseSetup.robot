*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Purchase EF Default1-01
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EFP-001
    ...    factor type=Full Lifecycle    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF

Add Purchase EF Default1-02
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Feb 2023    end date=May 2023    publisher=EF B    cert id=EFP-002
    ...    factor type=Upstream    purchase group=Chemicals    goods and services=Good B
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF

Add Purchase EF Default1-03
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF C    cert id=EFP-003
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.3
    Confirm Add EF

Add Purchase EF Default1-04
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EFP-004
    ...    factor type=Upstream    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.1
    Confirm Add EF

Add Purchase EF Default1-05
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF C    cert id=EFP-005
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.5
    Confirm Add EF

Add Purchase EF Default1-06
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EFP-006
    ...    factor type=Upstream    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.6
    Confirm Add EF

Delete All EF
    [Tags]    delete
    ${element}    Find WebElement    //td[@data-sticky="action"]//button
    WHILE    $element is not None
        Click Delete EF
        ${element}    Find WebElement    //td[@data-sticky="action"]//button
    END