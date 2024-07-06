*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


Add & Check Emission
    [Arguments]      ${site name}    ${amount}                       
    ...    ${source}    ${asset type}=${None}   ${asset name}=${None}    ${resell}=${None}    ${unit}=kWh                   
    ...    ${scope 2}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}   Energy
    Enter Energy Form    asset type=${asset type}   asset name=${asset name}
    ...    source=${source}    unit=${unit}    amount=${amount}    resell=${resell}
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission
    ...    scope 2=${scope 2}
    ...    scope 3=${scope 3}
    ...    outside of scope=${outside of scope}
    ...    no emission=${no emission}
    IF  $delete
        Click Delete Emission
    END

*** Test Cases ***
Add Energy 01
    [Documentation]    Leased in / Site / EF Type Case 12 / Resell
    Add & Check Emission    ${SITE NAMES}[1]    
    ...    source=Electricity (MEA / PEA)    amount=100    resell=${True}
    ...    scope 3=59.86 kg

Add Energy 02
    [Documentation]    Leased out / Site / EF Type Case 12 / Resell
    Add & Check Emission    ${SITE NAMES}[2]    
    ...    source=Electricity (MEA / PEA)    amount=100    resell=${True}
    ...    scope 3=49.99 kg

Add Energy 03
    [Documentation]    Owned and used / Site / EF Type Case 13
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    source=Electricity (MEA / PEA)    amount=100    
    ...    scope 2=49.99 kg    scope 3=9.87 kg

Add Energy 04
    [Documentation]    Owned and used / Site / EF Type Case 13 / Resell
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    source=Electricity (MEA / PEA)    amount=100    resell=${True}
    ...    scope 3=59.86 kg

Add Energy 05
    [Documentation]    Owned and used / Site / EF Type Case 13 / Renew
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${SITE NAMES}[0]   Energy
    Enter Energy Form    source=รีนิว    amount=100    unit=tonne
    Field Message Should Be    Energy Source    The selected energy source is Renewable.
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Page Contains    Emission created successfully
    ${new id}    Get Last Running No
    WHILE  $new_id <= $id
        Sleep    0.2
        ${new id}    Get Last Running No
    END
    Element Should Be Visible    (//td[@data-key="emissions"]/div)[1][text()='0.00 kg']
    Click Delete Emission

Add Energy 06
    [Documentation]    Owned and used / Site / EF Type Case 13 / Resell / RE
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    source=รีนิว    amount=100    unit=tonne    resell=${True}    
    ...    no emission=${True}

Add Energy 07
    [Documentation]    Owned and used / Vehicle / EF Type Case 13
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    source=Electricity (MEA / PEA)    amount=50.55       
    ...    asset type=Vehicle    asset name=V1OU    
    ...    scope 2=25.27 kg    scope 3=4.99 kg

Add Energy 08
    [Documentation]    Leased in / Vehicle / EF Type Case 13
    Add & Check Emission    ${SITE NAMES}[1]    
    ...    source=Electricity (MEA / PEA)    amount=50.55       
    ...    asset type=Vehicle    asset name=V2LI
    ...    scope 2=25.27 kg    scope 3=4.99 kg

Add Energy 09
    [Documentation]    Owned and leased out / Vehicle / EF Type Case 13
    Add & Check Emission    ${SITE NAMES}[2]    
    ...    source=Electricity (MEA / PEA)    amount=50.55       
    ...    asset type=Vehicle    asset name=V3LO
    ...    scope 3=25.27 kg

 
 
    
           


