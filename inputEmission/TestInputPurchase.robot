*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]       ${site name}    ${capital goods}
    ...    ${goods services}    ${amount}    ${name}=${None}      
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Purchases
    Enter Purchases Form         capital goods=${capital goods}    name=${name}    
    ...    goods services=${goods services}    amount=${amount}
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
Add Purchases 01
    [Documentation]    Owned and used / Waste generated in operations
    Add & Check Emission    ${SITE NAMES}[0]
    ...    capital goods=false    name=AB1234    goods services=Acrylonitrile Butadiene Styrene (ABS)    
    ...    amount=100    scope 3=415.97 kg


Add Purchases 02
    [Documentation]    Leased in / Waste generated in operations
    Add & Check Emission    ${SITE NAMES}[0]
    ...    capital goods=true    name=EF5678    goods services=Linear Low Density Polyethylene (LLDPE)    
    ...    amount=15.89    scope 3=33.93 kg               


Add Purchases 03
    [Documentation]    Owned and used / End-of-life treatment of sold products
    Add & Check Emission    ${SITE NAMES}[1]
    ...    capital goods=true    name=EF5678    goods services=organic fermented cassava    
    ...    amount=100    scope 3=8.33 kg                   
           


