*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Water EF Default1-01
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Water Emission Factor Form   start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EFW-001
    ...    factor type=Full Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF

Add Water EF Default1-02
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Feb 2023    end date=May 2023    publisher=EF B    cert id=EFW-002
    ...    factor type=Upstream        water type=Water B
    ...    unit=m3    filling method=Total    Total=0.2
    Confirm Add EF

Add Water EF Default1-03
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF C    cert id=EFW-003
    ...    factor type=Full Lifecycle        water type=Water C
    ...    unit=m3    filling method=Total    Total=0.3
    Confirm Add EF

Add Water EF Default1-04
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EFW-004
    ...    factor type=Upstream        water type=Water A
    ...    unit=m3    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.1
    Confirm Add EF

Add Water EF Default1-05
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF C    cert id=EFW-005
    ...    factor type=Full Lifecycle        water type=Water C
    ...    unit=m3    filling method=Total    Total=0.5
    Confirm Add EF

Add Water EF Default1-06
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EFW-006
    ...    factor type=Upstream        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.6
    Upload Evidences    ${EXECDIR}/evidences/test.pdf 
    Confirm Add EF

# Delete All EF
#     [Tags]    delete
#     ${element}    Find WebElement    //td[@data-sticky="action"]//button
#     WHILE    $element is not None
#         Click Delete EF
#         ${element}    Find WebElement    //td[@data-sticky="action"]//button
#     END