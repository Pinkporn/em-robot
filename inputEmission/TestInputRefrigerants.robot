*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/InputEmission.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


Add & Check Emission
    [Arguments]    ${site name}    ${asset name}    ${refrigerant}    ${amount}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Refrigerants
    Enter Refrigerants Form     asset name=${asset name}    refrigerant=${refrigerant}    amount=${amount}
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Page Contains    Emission created successfully
    ${new id}    Get Last ID Emission
    WHILE  $new_id <= $id
        Sleep    0.2
        ${new id}    Get Last ID Emission
    END
    Wait Until Page Contains Element    //td[@data-key="emissions"]/div
    Click Element    //td[@data-key="emissions"]/div
    Wait Until Element Is Visible    //div[@role='dialog']
    IF  $scope_1 is not None    
        Element Should Be Visible    //p[text()='Scope 1: ' and text()='${scope 1}']
    END
    IF  $scope_3 is not None
        Element Should Be Visible    //p[text()='Scope 3: ' and text()='${scope 3}']
    END
    IF  $outside_of_scope is not None
        Element Should Be Visible    //p[text()='Outside of Scope: ' and text()='${outside of scope}']
    END
    IF  ${no emission}
        Element Should Be Visible    (//td[@data-key="emissions"]/div)[1][text()='0.00 kg']
    END
    Click Button    (//td[@data-idx="12"]/button)[1]
    Press Keys    ${None}    ARROW_DOWN  ARROW_DOWN  ARROW_DOWN  RETURN
    Wait Until Element Is Visible    //section
    Press Keys    ${None}    TAB  RETURN

*** Test Cases ***
Add Refrigerants 01
    [Documentation]    Machinery / Case ทั่วไป / HFCs Group
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=HFC-23 (R-23)    amount=5.67
    ...    scope 1=70.31 t

Add Refrigerants 02
    [Documentation]    Machinery / Case ทั่วไป / PFCs Group
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=PFC-14 (Perfluoromethane)    amount=5.67
    ...    scope 1=37.59 t

Add Refrigerants 03
    [Documentation]    Machinery / Case ทั่วไป / Blend Group
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=R401A    amount=5.67
    ...    scope 1=6.41 t

Add Refrigerants 04
    [Documentation]    Vehicle / Case ทั่วไป / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=HFC-143a (R-143a)    amount=4.88
    ...    scope 1=23.42 t

Add Refrigerants 05
    [Documentation]    Vehicle / Case ทั่วไป / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    asset name=M2OU       refrigerant=HFC-143a (R-143a)    amount=4.88
    ...    scope 1=23.42 t

Add Refrigerants 06
    [Documentation]    Vehicle / Case ทั่วไป / Leased in
    Add & Check Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       refrigerant=HFC-143a (R-143a)    amount=4.88
    ...    scope 3=23.42 t

Add Refrigerants 07
    [Documentation]    Machinery / Case Out-of-Scope / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=CFC-11    amount=6.67
    ...    no emission=${True}

Add Refrigerants 08
    [Documentation]    Machinery / Case Out-of-Scope / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    asset name=M2OU       refrigerant=CFC-11    amount=6.67
    ...    no emission=${True}

Add Refrigerants 09
    [Documentation]    Machinery / Case Out-of-Scope / Owned and leased out
    Add & Check Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       refrigerant=CFC-11    amount=6.67
    ...    no emission=${True}

Add Refrigerants 10
    [Documentation]    Vehicle / Case Out-of-Scope
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       refrigerant=Halon-1301    amount=6.67
    ...    no emission=${True}