*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/InputEmission.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


Add & Check Emission
    [Arguments]       ${site name}        ${source}    ${amount}=15.89    
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Other Fugitive Emission
    Enter Other Fugitive Emission Form         source=${source}    amount=${amount}
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
Add Other Fugitive Emission 01
    [Documentation]    GWP / Case ทั่วไป / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    source=Perfluorocyclopropane        
    ...    scope 1=146.19 t

Add Other Fugitive Emission 02
    [Documentation]    GWP / Case ทั่วไป / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    source=Perfluorocyclopropane        
    ...    scope 1=146.19 t

Add Other Fugitive Emission 03
    [Documentation]    GWP / Case ทั่วไป / Owned and leased out
    Add & Check Emission    ${SITE NAMES}[2]
    ...    source=Perfluorocyclopropane        
    ...    scope 3=146.19 t

Add Other Fugitive Emission 04
    [Documentation]    GWP / Case Out-of-Scope / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    source=CFC-11    
    ...    no emission=${True}

Add Other Fugitive Emission 05
    [Documentation]    GWP / Case Out-of-Scope / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    source=CFC-11        
    ...    no emission=${True}

Add Other Fugitive Emission 06
    [Documentation]    GWP / Case Out-of-Scope / Owned and leased out
    Add & Check Emission    ${SITE NAMES}[2]
    ...    source=CFC-11        
    ...    no emission=${True}

