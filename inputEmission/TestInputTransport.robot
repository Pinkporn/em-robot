*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Emission
    [Arguments]      ${site name}    ${goods type}    ${source}                     
    ...    ${distance}=100    ${loading}=200            
    ...    ${distance unit}=km    ${loading unit}=tonne
    ...    ${goods name}=${None}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Outsourcing Transport
    Enter Outsourcing Transport Form   goods type=${goods type}    goods name=${goods name}    source=${source}
    ...    distance=${distance}    distance unit=${distance unit}     loading=${loading}    loading unit=${loading unit}   
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
Add Transport 01
    [Documentation]    Owned and used / Car 0% Loading
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    goods type=Goods Purchased        goods name=กฮ 5362    
    ...    source=4-wheel truck, small size, normal running 0% Loading   
    ...    loading unit=${None}    loading=${None}    
    ...    scope 3=24.15 kg   


Add Transport 02
    [Documentation]   Owned and used / Car 100% Loading
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    goods type=Goods Purchased    source=Small 4-wheel truck, normal running 100% Loading    
    ...    scope 3=4.31 t          


Add Transport 03
    [Documentation]    Owned and used / Goods Purchased / Ship
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    goods type=Goods Purchased    source=bulk ship        
    ...    scope 3=112.00 kg  

Add Transport 04
    [Documentation]    Owned and used / Product Sold / Ship
    Add & Check Emission    ${SITE NAMES}[0]
    ...    goods type=Product Sold    source=container ship      
    ...    scope 3=214.00 kg 

Add Transport 05
    [Documentation]    Owned and used / Waste / boat
    Add & Check Emission    ${SITE NAMES}[0]
    ...    goods type=Waste    source=Boat transport along the river       
    ...    scope 3=892.00 kg  

Add Transport 06
    [Documentation]    Leased in / Waste / Boat
    Add & Check Emission    ${SITE NAMES}[1]
    ...    goods type=Waste    source=Boat transport along the river       
    ...    scope 3=892.00 kg  

    
           


