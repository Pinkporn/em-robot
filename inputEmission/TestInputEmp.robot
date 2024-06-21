*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]      ${site name}    ${mode}    ${vehicle type}                      
    ...    ${distance}    ${unit}    ${fuel type}=${None}    ${amount}=${None}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Employee Commuting
    Enter Employee Commuting or Business Travel Form   mode=${mode}    vehicle type=${vehicle type}    
    ...    fuel type=${fuel type}    distance=${distance}    unit=${unit}    amount=${amount}    
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
Add Employee 01
    [Documentation]    Owned and used / Car / Unknown
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    mode=Car    vehicle type=Car    
    ...    fuel type=Unknown    distance=100.59
    ...    unit=km    scope 3=17.17 kg   


Add Employee 02
    [Documentation]   Owned and used / Car / Hybrid
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Car    vehicle type=Car    
    ...    fuel type=Hybrid    distance=100.59
    ...    unit=km    scope 3=12.07 kg              


Add Employee 03
    [Documentation]    Owned and used / Motorbike
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Motorbike    vehicle type=Motorbike    
    ...    distance=200
    ...    unit=mile    scope 3=36.55 kg  

Add Employee 04
    [Documentation]    Owned and used / Taxis
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Taxis    vehicle type=Taxis    
    ...    distance=18    amount=5
    ...    unit=km per passenger    scope 3=13.39 kg  

Add Employee 05
    [Documentation]    Owned and used / Bus
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Bus    vehicle type=Bus    
    ...    distance=18    amount=5
    ...    unit=km per passenger    scope 3=8.69 kg

Add Employee 06
    [Documentation]    Owned and used / Rail
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Rail    vehicle type=Underground/Skytrain (MRT/BTS)    
    ...    distance=20    amount=10
    ...    unit=km per passenger    scope 3=5.56 kg       

Add Employee 07
    [Documentation]    Owned and used / Ferry
    Add & Check Emission    ${SITE NAMES}[0]
    ...    mode=Ferry    vehicle type=Ferry carried average passenger    
    ...    distance=20    amount=10
    ...    unit=km per passenger    scope 3=22.57 kg      

Add Employee 08
    [Documentation]    Owned and used / Ferry
    Add & Check Emission    ${SITE NAMES}[1]
    ...    mode=Ferry    vehicle type=Ferry carried average passenger    
    ...    distance=20    amount=10
    ...    unit=km per passenger    scope 3=22.57 kg          
           


