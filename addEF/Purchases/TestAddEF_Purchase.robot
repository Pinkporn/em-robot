*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add Purchase EF 7
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Jan 2023    end date=Jan 2023    publisher=EF B    cert id=EFP-007
    ...    factor type=Upstream    purchase group=Chemicals    goods and services=Good B
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Purchase EF 8
    [Documentation]    EF ไม่ต่อเนื่อง
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF A    cert id=EFP-008
    ...    factor type=Full Lifecycle    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Purchase EF 9
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Jan 2023    end date=Apr 2023    publisher=EF A    cert id=EFP-009
    ...    factor type=Full Lifecycle    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 10
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Jan 2023    end date=Feb 2023    publisher=EF B    cert id=EFP-010
    ...    factor type=Upstream    purchase group=Chemicals    goods and services=Good B
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 11
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF A    cert id=EFP-011
    ...    factor type=Full Lifecycle    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Purchase EF 12
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF C    cert id=EFP-012
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Purchase EF 13
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Feb 2023    end date=Apr 2023    publisher=EF C    cert id=EFP-013
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 14
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Feb 2023    end date=Mar 2023    publisher=EF C    cert id=EFP-014
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Purchase EF 15
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF A    cert id=EFP-015
    ...    factor type=Full Lifecycle    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 16
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Apr 2023    end date=${None}    publisher=EF C    cert id=EFP-016
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 17
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Mar 2023    end date=${None}    publisher=EF B    cert id=EFP-017
    ...    factor type=Upstream    purchase group=Chemicals    goods and services=Good B
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 18
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Jun 2023    end date=Aug 2023    publisher=EF B    cert id=EFP-018
    ...    factor type=Upstream    purchase group=Chemicals    goods and services=Good B
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Purchase EF 19
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Sep 2023    end date=Oct 2023    publisher=EF A    cert id=EFP-019
    ...    factor type=Upstream    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 20
    [Documentation]    EF ต่อเนื่องและไม่ทับ
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Oct 2023    end date=Nov 2023    publisher=EF A    cert id=EFP-020
    ...    factor type=Upstream    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF
    Click Delete EF

Add Purchase EF 21
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
    Enter Purchases Emission Factor Form    start date=Nov 2023    end date=Dec 2023    publisher=EF A    cert id=EFP-021
    ...    factor type=Full Lifecycle    purchase group=Pulp and Paper    goods and services=Good A
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Invalid Date

Add Purchase EF 22
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Sep 2023    end date=Nov 2023    publisher=EF C    cert id=EFP-022
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

Add Purchase EF 23
    [Documentation]    EF ทับกับที่มีอยู่แล้ว
    Click Add Emission Factor Button
     Enter Purchases Emission Factor Form    start date=Nov 2023    end date=${None}    publisher=EF C    cert id=EFP-023
    ...    factor type=Full Lifecycle    purchase group=Other    goods and services=Good C
    ...    unit=kg    filling method=Total    Total=0.1
    Confirm Add EF Expect Overlap Date

