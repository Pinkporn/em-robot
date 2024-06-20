*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]       ${site name}    ${water type}    ${amount}=100      
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    ...    ${delete}=${True}
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Water
    Enter Water Form         water type=${water type}    amount=${amount}
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
    IF  $delete
        Click Delete Emission
    END

*** Test Cases ***
Add Water 01
    [Documentation]    Owned and used / Tap Water (MWA)
    Add & Check Emission    ${SITE NAMES}[0]
    ...    water type=Tap Water (MWA)    
    ...    scope 3=79.48 kg


Add Water 02
    [Documentation]    Owned and used / Soft water for steam boiler
    Add & Check Emission    ${SITE NAMES}[0]
    ...    water type=Soft water for steam boiler     
    ...    scope 3=103.01 kg               


Add Water 03
    [Documentation]    Leased in / Tap Water (MWA)
    Add & Check Emission    ${SITE NAMES}[1]
    ...    water type=Tap Water (MWA) 
   ...     scope 3=79.48 kg               
           


