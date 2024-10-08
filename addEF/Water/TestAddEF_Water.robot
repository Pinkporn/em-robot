*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Water EF 7
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF B    cert id=EFW-007
    ...    factor type=Upstream        water type=Water B
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Water EF 8
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF A    cert id=EFW-008
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Water EF 9
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Jan 2023    end date=Apr 2023    publisher=EF A    cert id=EFW-009
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 10
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF B    cert id=EFW-010
    ...    factor type=Upstream        water type=Water B
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 11
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF A    cert id=EFW-011
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Water EF 12
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF C    cert id=EFW-012
    ...    factor type=Lifecycle    water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Water EF 13
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Feb 2023    end date=Apr 2023    publisher=EF C    cert id=EFW-013
    ...    factor type=Lifecycle    water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 14
    [Tags]    bug
    [Documentation]    EF ต่อเนื่องและไม่ทับ EM-5759
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Apr 2023    end date=May 2023    publisher=EF C    cert id=EFW-014
    ...    factor type=Lifecycle    water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 15
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF A    cert id=EFW-015
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 16
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF C    cert id=EFW-016
    ...    factor type=Lifecycle    water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 17
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Mar 2023    end date=${None}    publisher=EF B    cert id=EFW-017
    ...    factor type=Upstream        water type=Water B
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 18
    [Tags]    bug
    [Documentation]    EF ทับกับที่มีอยู่แล้ว EM-5761
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Mar 2023    end date=Jun 2023    publisher=EF A    cert id=EFW-018
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 19
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Jun 2023    end date=Aug 2023    publisher=EF C    cert id=EFW-019
    ...    factor type=Upstream        water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 20
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EFW-020
    ...    factor type=Upstream        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 21
    [Tags]    bug
    [Documentation]    EF ต่อเนื่องและไม่ทับ EM-5765
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Oct 2023    end date=Nov 2023    publisher=EF A    cert id=EFW-021
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Water EF 22
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Nov 2023    end date=Dec 2023    publisher=EF A    cert id=EFW-022
    ...    factor type=Lifecycle        water type=Water A
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Water EF 23
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Sep 2023    end date=Nov 2023    publisher=EF C    cert id=EFW-023
    ...    factor type=Lifecycle        water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 24
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Water Emission Factor Form    start date=Nov 2023    end date=${None}    publisher=EF C    cert id=EFW-023
    ...    factor type=Lifecycle        water type=Water C
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Water EF 25
    [Documentation]    ช่วงเวลาเดียวกัน คนละ EF Type
    Click Add Emission Factor Button
    Enter Water Emission Factor Form    start date=Feb 2023    end date=May 2023    publisher=EF B    cert id=EFW-007
    ...    factor type=Lifecycle        water type=Water B
    ...    unit=m3    filling method=Total    Total=0.1
    Confirm Add EF Expect Different EF Type