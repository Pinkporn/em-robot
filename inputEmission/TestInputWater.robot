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
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Water
    Enter Water Form         water type=${water type}    amount=${amount}
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Check Record Emission
    ...    scope 1=${scope 1}
    ...    scope 3=${scope 3}
    ...    outside of scope=${outside of scope}
    ...    no emission=${no emission}
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
           


