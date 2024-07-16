*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Waste Disposal EF 16
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF B    cert id=EFWD-016
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Waste Disposal EF 17
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF C    cert id=EFWD-017
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Waste Disposal EF 18
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jan 2023    end date=Apr 2023    publisher=EF A    cert id=EFWD-018
    ...    waste type=Wood    waste treatment=Landfil
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 19
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF B    cert id=EFWD-019
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 20
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF C    cert id=EFWD-20
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Waste Disposal EF 21
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF A    cert id=EFWD-021
    ...    waste type=Wood    waste treatment=Landfil
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Waste Disposal EF 22
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF B    cert id=EFWD-022
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 23
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF C    cert id=EFWD-023
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 24
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF A    cert id=EFWD-024
    ...    waste type=Wood    waste treatment=Landfil
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 25
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF B    cert id=EFWD-025
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 26
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Mar 2023    end date=${None}    publisher=EF C    cert id=EFWD-026
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 27
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Mar 2023    end date=${None}    publisher=EF A    cert id=EFWD-027
    ...    waste type=Wood    waste treatment=Landfil
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 28
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Mar 2023    end date=${None}    publisher=EF B    cert id=EFWD-028
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 29
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Feb 2023    end date=${None}    publisher=EF C    cert id=EFWD-029
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 30
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jun 2023    end date=${None}    publisher=EF C    cert id=EFWD-030
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Waste Disposal EF 31
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=May 2023    end date=Jun 2023    publisher=EF C    cert id=EFWD-031
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 32
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Jul 2023    end date=Aug 2023    publisher=EF C    cert id=EFWD32
    ...    waste type=Glass    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Waste Disposal EF 33
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EFWD-033
    ...    waste type=Wood    waste treatment=Landfill
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 34
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Oct 2023    end date=Nov 2023    publisher=EF A    cert id=EFWD-034
    ...    waste type=Wood    waste treatment=Landfill
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Waste Disposal EF 35
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Oct 2023    end date=${None}    publisher=EF A    cert id=EFWD35
    ...    waste type=Wood    waste treatment=Landfill
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Waste Disposal EF 36
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Sep 2023    end date=Nov 2023    publisher=EF B    cert id=EFWD-036
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 37
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Nov 2023    end date=Dec 2023    publisher=EF B    cert id=EFWD-037
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 38
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Dec 2023    end date=${None}    publisher=EF B    cert id=EFWD36
    ...    waste type=Wood    waste treatment=Combustion
    ...    unit=tonne    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Waste Disposal EF 39
    [Documentation]    Cert. ซ้ำ
    Click Add Emission Factor Button
    Enter Waste Disposal Emission Factor Form    start date=Aug 2023    end date=Sep 2023    publisher=EF A    cert id=EFWD-006
    ...    waste type=Wood    waste treatment=Landfill
    ...    unit=tonne    filling method=Total    Total=0.6
    Confirm Add EF Expect Duplicate Cert
