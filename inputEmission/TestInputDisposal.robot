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
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Outsourcing Waste Disposal
    Enter Outsourcing Waste Disposal Form         category=${category}    waste type=${waste type}    
    ...    treatment=${treatment}    amount=${amount}
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


