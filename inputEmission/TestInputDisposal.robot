*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]       ${site name}    ${category}    
    ...    ${waste type}=Aggregates    ${treatment}=Recycle (Open-loop)    ${amount}=15.89        
    ...    ${scope 1}=${None}    ${scope 3}=15.65 kg    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    ...    ${delete}=${True}
    
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form         category=${category}    waste type=${waste type}    
    ...    treatment=${treatment}    amount=${amount}
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
Add Outsourcing Waste Disposal 01
    [Documentation]    Owned and used / Waste generated in operations
    Add & Check Emission    ${SITE NAMES}[0]
    ...    category=Waste Generated in Operations                


Add Outsourcing Waste Disposal 02
    [Documentation]    Leased in / Waste generated in operations
    Add & Check Emission    ${SITE NAMES}[1]
    ...    category=Waste Generated in Operations               


Add Outsourcing Waste Disposal 03
    [Documentation]    Owned and used / End-of-life treatment of sold products
    Add & Check Emission    ${SITE NAMES}[0]
    ...    category=End-of-Life Treatment of Sold Products                 


Add Other Fugitive EmissionOutsourcing Waste Disposal 04
    [Documentation]    GWP / Case Out-of-Scope / Owned and used
    Add & Check Emission    ${SITE NAMES}[1]
    ...    category=End-of-Life Treatment of Sold Products                 


