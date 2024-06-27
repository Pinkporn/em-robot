*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


*** Test Cases ***
# Add Fuel EF 01
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Fuel Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF A    cert id=EF1-001    
#     ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A    
#     ...    unit=kg    filling method=Total    Total=0.1
#     Confirm Add EF

# Add Fuel EF 02
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Fuel Emission Factor Form    start date=Feb 2023    end date=May 2023    publisher=EF A    cert id=EF1-002   
#     ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A    
#     ...    unit=kg    filling method=Total    Total=0.2
#     Confirm Add EF

# Add Fuel EF 03
#     [Documentation]
#     Click Add Emission Factor Button
#     Enter Fuel Emission Factor Form    start date=Mar 2023    end date=May 2023    publisher=EF A    cert id=EF1-003   
#     ...    factor type=Combustion    activity type=Biogenic Emission     fuel source=LPG_A    
#     ...    unit=kg    filling method=Total    Total=0.3
#     Confirm Add EF

Add Fuel EF 04
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=Jul 2023    publisher=EF A    cert id=EF1-004
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)     fuel group=LPG    fuel source=LPG_A    
    ...    unit=kg    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.1    SF6=0.1    NF3=0.1
    Confirm Add EF

Add Fuel EF 05
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF A    cert id=EF1-005   
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A    
    ...    unit=kg    filling method=Total    Total=0.5
    Confirm Add EF

Add Fuel EF 06
    [Documentation]
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EF1-006   
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A    
    ...    unit=kg    filling method=Total    Total=0.6
    Confirm Add EF