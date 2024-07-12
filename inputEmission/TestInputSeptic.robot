*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]      ${site name}    ${from date}    ${to date}    ${amount}=20         
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    ${delete}=${True}
    ...    &{days}
    
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Septic Tank
    Enter Septic Tank Form   ${from date}    ${to date}     amount=${amount}    &{days}
    Save Emission As Draft
    Check Record Emission
    ...    scope 1=${scope 1}
    ...    scope 3=${scope 3}
    ...    outside of scope=${outside of scope}
    ...    no emission=${no emission}
    IF  $delete
        Click Delete Emission
    END

*** Test Cases ***
Add Septic 01
    [Documentation]    Owned and used / 1 month period / 5 day on-site per week
    Add & Check Emission    ${SITE NAMES}[0]    from date=Jan 2023    to date=Jan 2023
    ...    scope 1=147.84 kg    All Days=${True}     Sat=${False}    Sun=${False}      


Add Septic 02
    [Documentation]    Owned and used / 2 months period / 6 day on-site per week
    Add & Check Emission    ${SITE NAMES}[0]    from date=Feb 2023    to date=Mar 2023
    ...    scope 1=342.72 kg    All Days=${True}     Sun=${False}               


Add Septic 03
    [Documentation]    Leased in / 1 month period / 5 day on-site per week
    Add & Check Emission    ${SITE NAMES}[1]    from date=Jan 2023    to date=Jan 2023
    ...    scope 1=147.84 kg    All Days=${True}     Sat=${False}    Sun=${False} 

Add Septic 04
    [Documentation]    Owned and leased out / 1 month period / 5 day on-site per week
    Add & Check Emission    ${SITE NAMES}[2]    from date=Jan 2023    to date=Jan 2023
    ...    scope 3=147.84 kg    All Days=${True}     Sat=${False}    Sun=${False}

Add Septic 05
    [Documentation]    Owned and leased out / 1 month period / 5 day on-site per week
    Add & Check Emission    ${SITE NAMES}[2]    from date=Jan 2023    to date=Jan 2023
    ...    scope 3=147.84 kg    All Days=${True}     Sat=${False}    Sun=${False}                 
           


