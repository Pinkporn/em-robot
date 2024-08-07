*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
# Add Waste EF Default1-01
#     [Tags]    case 1
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Waste Disposal Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EFWD-001
#     ...    waste type=Wood    waste treatment=Landfill
#     ...    unit=tonne    filling method=Total    Total=0.1
#     Confirm Add EF

# Add Waste EF Default1-02
#     [Tags]    case 1
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Waste Disposal Emission Factor Form    start date=Feb 2023    end date=May 2023    publisher=EF B    cert id=EFWD-002
#     ...    waste type=Wood    waste treatment=Combustion
#     ...    unit=tonne    filling method=Total    Total=0.2
#     Confirm Add EF

# Add Waste EF Default1-03
#     [Tags]    case 1
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Waste Disposal Emission Factor Form    start date=Mar 2023    end date=May 2023    publisher=EF C    cert id=EFWD-003
#     ...    waste type=Glass   waste treatment=Combustion
#     ...    unit=tonne    filling method=Total    Total=0.3
#     Confirm Add EF

# Add Waste EF Default1-04
#     [Tags]    case 1
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Waste Disposal Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EFWD-004
#     ...    waste type=Wood    waste treatment=Landfill
#     ...    unit=tonne    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.1
#     Confirm Add EF

# Add Waste EF Default1-05
#     [Tags]    case 1
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Waste Disposal Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF B    cert id=EFWD-005
#     ...    waste type=Wood    waste treatment=Combustion
#     ...    unit=tonne    filling method=Total    Total=0.5
    # Confirm Add EF

Add Waste EF Default1-06
    [Tags]    case 1
    [Documentation]
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EFWD-006
    ...    waste type=Wood    waste treatment=Landfill
    ...    unit=tonne    filling method=Total    Total=0.6
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Confirm Add EF

Dup Waste EF Default1-06
    [Tags]    case 1
    [Documentation]    Duplicate
    Click Duplicate EF
    Wait Until Element Is Visible    //section
    Input Text    name:certificateId    EFWD-007
    Select Drop Down    Waste Treatment    Sanitary Landfill    
    Click Element    //button[.='Save']
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Emission duplicated successfully
    Wait Until Element Is Not Visible    //section

Edit EF Waste EF Default1-06
    Click Edit EF
    Wait Until Element Is Visible    //section
    Enter Energy Emission Factor Form     filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.2    NF3=0.2
    ${total}    Get Value    //input[@id=//label[.='Total']/@for]
    Should Be Equal As Numbers    ${total}    0.6
    Click Element    //button[.='Save']
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Emission edited successfully
    Wait Until Element Is Not Visible    //section
    Click Delete EF

# Delete All EF
#     [Tags]    delete
#     ${element}    Find WebElement    //td[@data-sticky="action"]//button
#     WHILE    $element is not None
#         Click Delete EF
#         ${element}    Find WebElement    //td[@data-sticky="action"]//button
#     END
