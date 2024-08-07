*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]      ${site name}    ${mode}    ${haul}     ${flight class}                 
    ...    ${distance}    ${unit}=km per passenger     ${amount}=${None}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    ...    ${delete}=${True}
    
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Business Travel
    Enter Employee Commuting or Business Travel Form   mode=${mode}    haul=${haul}    
    ...    flight class=${flight class}    distance=${distance}    unit=${unit}    amount=${amount}    
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
Add Business 01
    [Documentation]    Owned and used / Flights / Average passenger / Domestic
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    mode=Flights    haul=Domestic    
    ...    flight class=Average passenger    
    ...    amount=5    distance=18
    ...    scope 3=22.13 kg

Add Business 02
    [Documentation]   Owned and used / Flights / Average passenger / Short-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Short-haul, to/from the country    
    ...    flight class=Average passenger    
    ...    amount=5    distance=18
    ...    scope 3=13.82 kg

Add Business 03
    [Documentation]    Owned and used / Flights / Average passenger / Long-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Long-haul, to/from the country
    ...    flight class=Average passenger
    ...    amount=5    distance=18
    ...    scope 3=17.38 kg

Add Business 04
    [Documentation]    Owned and used / Flights / Average passenger / Abroad
    Add & Check Emission    ${SITE NAMES}[1]
    ...    mode=Flights    haul=International, to/from abroad
    ...    flight class=Average passenger
    ...    amount=5    distance=18
    ...    scope 3=16.53 kg

Add Business 05
    [Documentation]    Owned and used / Flights / Economy class / Short-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Short-haul, to/from the country
    ...    flight class=Economy class
    ...    amount=10    distance=15
    ...    scope 3=22.65 kg

Add Business 06
    [Documentation]    Owned and used / Flights / Economy class / Long-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Long-haul, to/from the country
    ...    flight class=Economy class
    ...    amount=10    distance=15
    ...    scope 3=22.18 kg

Add Business 07
    [Documentation]    Owned and used / Flights / Economy class / Abroad
    Add & Check Emission    ${SITE NAMES}[1]
    ...    mode=Flights    haul=International, to/from abroad
    ...    flight class=Economy class
    ...    amount=10    distance=15
    ...    scope 3=21.09 kg

Add Business 08
    [Documentation]    Owned and used / Flights / Premium economy class / Long-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Long-haul, to/from the country
    ...    flight class=Premium economy class
    ...    amount=5    distance=20
    ...    scope 3=23.66 kg

Add Business 09
    [Documentation]    Owned and used / Flights / Premium economy class / Abroad
    Add & Check Emission    ${SITE NAMES}[1]
    ...    mode=Flights    haul=International, to/from abroad
    ...    flight class=Premium economy class
    ...    amount=5    distance=20
    ...    scope 3=22.50 kg

Add Business 10
    [Documentation]    Owned and used / Flights / Business class / Short-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Short-haul, to/from the country
    ...    flight class=Business class
    ...    amount=10    distance=15
    ...    scope 3=33.98 kg

Add Business 11
    [Documentation]    Owned and used / Flights / Business class / Long-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Long-haul, to/from the country
    ...    flight class=Business class
    ...    amount=10    distance=15
    ...    scope 3=64.32 kg

Add Business 12
    [Documentation]    Owned and used / Flights / First class / Long-haul
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Flights    haul=Long-haul, to/from the country
    ...    flight class=First class
    ...    amount=5    distance=20
    ...    scope 3=59.15 kg

Add Business 13
    [Documentation]    Leased in / Flights / Average passenger / Long-haul
    Add & Check Emission    ${SITE NAMES}[1]
    ...    mode=Flights    haul=Short-haul, to/from the country
    ...    flight class=Average passenger
    ...    amount=1    distance=100.59
    ...    scope 3=15.44 kg
           


