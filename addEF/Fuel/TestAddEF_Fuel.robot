*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Fuel EF 7
    [Documentation]    ทับกับที่มี แต่คนละ Activity Type
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EF2-007
    ...    factor type=Upstream    activity type=Stationary Combustion     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 8
    [Documentation]    ไม่ทับกับที่มีและคนละ Activity Type
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Nov 2023    publisher=EF A    cert id=EF2-008
    ...    factor type=Combustion    activity type=Stationary Combustion     fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 9
    [Documentation]    ทับกับที่มี แต่คนละ Activity Type
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EF2-009
    ...    factor type=Upstream    activity type=Mobile Combustion (Off-Road)     fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 10
    [Documentation]    ไม่ทับกับที่มีและคนละ Activity Type
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Nov 2023    publisher=EF A    cert id=EF2-010
    ...    factor type=Combustion    activity type=Mobile Combustion (Off-Road)     fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 11
    [Documentation]    ทับกับที่มี แต่คนละ Unit
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EF2-0011
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)     fuel source=LPG_A
    ...    unit=litre    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 12
    [Documentation]    ไม่ทับกับที่มีและคนละ Unit
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EF2-0012
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)     fuel group=LPG    fuel source=LPG_A
    ...    unit=litre    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 13
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF A    cert id=EF2-0013
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)     fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Invalid Date

Add Fuel EF 14
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF A    cert id=EF2-0014
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 15
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF A    cert id=EF2-0015
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Invalid Date

Add Fuel EF 16
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF A    cert id=EF2-0016
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Invalid Date

Add Fuel EF 17
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF A    cert id=EF2-0017
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 18
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF A    cert id=EF2-0018
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 19
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF A    cert id=EF2-0019
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 20
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF A    cert id=EF2-0020
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 21
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF A    cert id=EF2-0021
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 22
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF A    cert id=EF2-0022
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 23
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF A    cert id=EF2-0023
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 24
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF A    cert id=EF2-0024
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 25
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=${None}    publisher=EF A    cert id=EF2-0025
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 26
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=${None}    publisher=EF A    cert id=EF2-0026
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 27
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Feb 2023    end date=${None}    publisher=EF A    cert id=EF2-0027
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 28
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF A    cert id=EF2-0028
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 29
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=May 2023    end date=Jun 2023    publisher=EF A    cert id=EF2-0029
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 30
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Jul 2023    end date=Aug 2023    publisher=EF A    cert id=EF2-0030
    ...    factor type=Combustion    activity type=Biogenic Emission    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Invalid Date

Add Fuel EF 31
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EF2-0031
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 32
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Oct 2023    end date=Nov 2023    publisher=EF A    cert id=EF2-0032
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF
    Click Delete EF

Add Fuel EF 33
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Oct 2023    end date=${None}    publisher=EF A    cert id=EF2-0033
    ...    factor type=Combustion    activity type=Mobile Combustion (On-Road)    fuel group=LPG    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Invalid Date

Add Fuel EF 34
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Sep 2023    end date=Nov 2023    publisher=EF A    cert id=EF2-0034
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 35
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Nov 2023    end date=Dec 2023    publisher=EF A    cert id=EF2-0035
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date

Add Fuel EF 36
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Fuel Emission Factor Form    start date=Dec 2023    end date=${None}    publisher=EF A    cert id=EF2-0036
    ...    factor type=Upstream    activity type=Mobile Combustion (On-Road)    fuel source=LPG_A
    ...    unit=kg    filling method=Total    Total=0.2
    Confirm Add EF Expect Overlap Date