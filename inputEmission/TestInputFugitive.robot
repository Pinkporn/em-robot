*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]       ${site name}        ${source}    ${amount}=15.89    
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    ...    ${delete}=${True}
    
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Other Fugitive Emission
    Enter Other Fugitive Emission Form    source=${source}    amount=${amount}
    Save Emission
    Check Record Emission
    ...    scope 1=${scope 1}
    ...    scope 3=${scope 3}
    ...    outside of scope=${outside of scope}
    ...    no emission=${no emission}
    IF  $delete
        Click Delete Emission
    END

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

