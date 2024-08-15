*** Settings ***
Documentation     Add Emission Factor Regression Test
Resource          ${EXECDIR}/addEF/TestAddEF.resource
Suite Setup       Setup Everything
Test Teardown     Custom EF Teardown

*** Variables ***


*** Keywords ***


*** Test Cases ***
Add EF Default  
    [Documentation]    EF Renew:Default
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jan 2021    end date=Mar 2021
    ...    publisher=Renew    cert id=TGO CFP 21-01-01    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF    unit=kWh    renewable=${True}
    Confirm Add EF 

Add EF 01
    [Documentation]    EF Renew:Default    Is Renew=No
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-01    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF    unit=kWh    
    Field Message Should Be    Energy Source    The selected energy source is Renewable.
    Element Should Be Disabled    //input[@id=//label[text()='Renewable']/@for]
    Press Keys    ${None}    ESC

Add EF 02
    [Documentation]    EF Renew:Default    Unit=GJ
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-01    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF    unit=GJ    renewable=${True}
    Confirm Add EF   

Add EF 03
    [Documentation]    EF Renew:Default    Unit=GJ    Is Renew=No    #Overlapping Effective Date!
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-02    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF    unit=GJ
    Field Message Should Be    Energy Source    The selected energy source is Renewable.
    Element Should Be Disabled    //input[@id=//label[text()='Renewable']/@for]
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Failed
    Click Close Modal

Add EF 04
    [Documentation]    EF Renew:Default    Source=Renew_EF 2    Is Renew=Yes   
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-02    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF 2    unit=kWh    renewable=${True}
    Confirm Add EF

Add EF 05
    [Documentation]    EF Renew:Default    Publisher=Renew A    Source=Renew_EF 2    Is Renew=Yes   
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew A    cert id=TGO CFP 21-04-03    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF 2    unit=kWh    renewable=${True}
    Confirm Add EF

Add EF 06
    [Documentation]    EF Renew:Default        Purchased Type=Stream    Is Renew=Yes   
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jul 2021    end date=Sep 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-04    factor type=Combustion
    ...    purchased type=Steam    source=Renew_EF    unit=kWh    renewable=${True}
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Failed
    Click Close Modal

Add EF 07
    [Documentation]    EF Renew:Default    Source=Renew_EF 3    Is Renew=No    #by gas   
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jan 2021    end date=Mar 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-05    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF 3    unit=kWh    renewable=${False}
    ...    filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.2    SF6=0.3    NF3=0.4
    ${total}    Get Value    //input[@id=//label[.='Total']/@for]
    Should Be Equal As Numbers    ${total}    1      
    Confirm Add EF
    Click Delete EF

Add EF 08
    [Documentation]    EF Renew:Default    EF type=Upstream    Is Renew=Yes   
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jan 2021    end date=Mar 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-06    factor type=Upstream
    ...    purchased type=Heat    source=Renew_EF    unit=kWh    renewable=${True}
    Confirm Add EF
    Click Delete EF

Add EF 09
    [Documentation]    EF Renew:Default    EF type=Upstream    Is Renew=Yes    # Duplicate Cert.   
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew    cert id=TGO CFP 21-01-01    factor type=Upstream
    ...    purchased type=Heat    source=Renew_EF    unit=kWh    renewable=${True}
    Confirm Add EF Expect Duplicate Cert

Add EF 10
    [Documentation]    EF Renew:Default    EF type=Combustion    Is Renew=No    #No Expire 
    ${id}    Get Last Running No  
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=${None}
    ...    publisher=PB-No Expire    cert id=TGO CFP 21-04-07    factor type=Combustion
    ...    purchased type=Cooling    source=PB-No Expire_EF    unit=kWh    renewable=${False}    
    ...    filling method=Total    Total=0.1500
    Confirm Add EF
    Wait Until New Running No Is Visible    ${id}
    Element Should Be Visible    (//td[@data-key="fromDate"])[1][text()=" - No Expiration"]

Dup EF
    Click Duplicate EF
    Wait Until Element Is Visible    //section
    Enter Energy Emission Factor Form    cert id=TGO CFP 21-04-08    factor type=Upstream
    Click Element    //button[.//span[text()='Save']]
    Wait Until Element Is Not Visible    //section 
    Wait Until Page Contains    Emission duplicated successfully

Edit EF
    Click Edit EF
    Wait Until Element Is Visible    //section
    Enter Energy Emission Factor Form     filling method=Separated by Gas    Fossil CH4=0.1    N2O=0.2    SF6=0.3    NF3=0.4
    ${total}    Get Value    //input[@id=//label[.='Total']/@for]
    Should Be Equal As Numbers    ${total}    1
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Click Element    //button[.//span[text()='Save']]
    Wait Until Element Is Not Visible    //section 
    Wait Until Page Contains    Emission edited successfully

Add EF Recal 1-01
    [Documentation]    EF Recal Combustion
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jul 2023    end date=Dec 2023
    ...    publisher=Recal_Factor    cert id=Recal_Factor1.1    factor type=Combustion
    ...    purchased type=Heat    source=Recal_Factor_01    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.2000
    Confirm Add EF

Add EF Recal 1-02
    [Documentation]    EF Recal Upstream
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jul 2023    end date=Dec 2023
    ...    publisher=Recal_Factor    cert id=Recal_Factor1.2    factor type=Upstream
    ...    purchased type=Heat    source=Recal_Factor_01    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.4000
    Confirm Add EF

Add EF Recal 1-03
    [Documentation]    Edit EF Recal Combustion
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jul 2023    end date=Dec 2023
    ...    publisher=Recal_Factor    cert id=Recal_Factor1.1    factor type=Combustion
    ...    purchased type=Heat    source=Recal_Factor_01    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.1000
    Confirm Add EF

Add EF Recal 1-04
    [Documentation]    Edit EF Recal Upstream
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jul 2023    end date=Dec 2023
    ...    publisher=Recal_Factor    cert id=Recal_Factor1.2    factor type=Upstream
    ...    purchased type=Heat    source=Recal_Factor_01    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.2000
    Confirm Add EF

Add EF Recal 2-01
    [Documentation]    EF Recal มี Combustion อย่างเดียว
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jan 2023    end date=Jun 2023
    ...    publisher=Recal_Factor    cert id=Recal_Factor2.1    factor type=Combustion
    ...    purchased type=Heat    source=Recal_Factor_02    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.4000
    Confirm Add EF

Add EF Recal 2-02
    [Documentation]    Edit EF Recal มี Combustion อย่างเดียว
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jan 2023    end date=Jun 2023
    ...    publisher=Recal_Factor    cert id=Recal_Factor2.2    factor type=Combustion
    ...    purchased type=Heat    source=Recal_Factor_02    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.7000
    Confirm Add EF

Add EF Recal 3-01
    [Documentation]    Add EF Recal มาก่อน เป็น Combustion
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Oct 2023    end date=Dec 2023
    ...    publisher=Delete_Fac    cert id=Delete_Fac01    factor type=Combustion
    ...    purchased type=Heat    source=Delete_Fac1    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.6300
    Confirm Add EF

Add EF Recal 3-02
    [Documentation]    เพิ่ม EF ที่เป็น upstream หลังจากที่ cumbustion แล้ว
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Oct 2023    end date=Dec 2023
    ...    publisher=Delete_Fac    cert id=Delete_Fac02    factor type=Upstream
    ...    purchased type=Heat    source=Delete_Fac1    unit=MMBtu    renewable=${False}
    ...    filling method=Total    Total=0.3000
    Confirm Add EF

Delete EF
    Click Delete EF
