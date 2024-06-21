*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***


Add & Check Emission
    [Arguments]    ${site name}    ${asset name}    ${agent}    ${amount}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Fire Extinguishing
    Enter Fire Extinguishing Form     asset name=${asset name}    agent=${agent}    amount=${amount}
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Page Contains    Emission created successfully
    ${new id}    Get Last Running No
    WHILE  $new_id <= $id
        Sleep    0.2
        ${new id}    Get Last Running No
    END
    Wait Until Page Contains Element    //td[@data-key="emissions"]/div
    Click Element    //td[@data-key="emissions"]/div
    IF  not $no_emission
        Wait Until Element Is Visible    //div[@role='dialog']
    END
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
    IF  $delete
        Click Delete Emission
    END

*** Test Cases ***
Add Fire Extinguishing 01
    [Documentation]    Machinery / GWP / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       agent=Carbon dioxide    amount=5.32
    ...    scope 1=5.32 kg

Add Fire Extinguishing 02
    [Documentation]    Machinery / GWP / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    asset name=M2LI       agent=Carbon dioxide    amount=5.32
    ...    scope 1=5.32 kg

Add Fire Extinguishing 03
    [Documentation]    Machinery / GWP / Owned and leased out
    Add & Check Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       agent=Carbon dioxide    amount=5.32
    ...    scope 3=5.32 kg

Add Fire Extinguishing 04
    [Documentation]    Machinery / Emisison Factor / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       agent=Halotron II    amount=10
    ...    scope 1=38.36 t