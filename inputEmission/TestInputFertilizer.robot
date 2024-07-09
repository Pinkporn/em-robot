*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***

*** Keywords ***



Add & Check Emission
    [Arguments]      ${site name}    ${fertilizer type}    ${n}=${None}    ${p}=${None}    ${k}=${None}                
    ...    ${unit}=kg    ${amount}=100           
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}   Fertilizer
    Enter Fertilizer Form    fertilizer type=${fertilizer type}    n=${n}    p=${p}    k=${k}    
    ...    unit=${unit}    amount=${amount}
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
Add Fertilizer 01
    [Documentation]    Owned and used / NPK Fertilizer / N,P,K=0%
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=NPK Fertilizer    n=0    p=0    k=0    
    ...    no emission=${True}   


Add Fertilizer 02
    [Documentation]   Owned and used / NPK Fertilizer
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=NPK Fertilizer    n=20    p=20    k=20
    ...    scope 1=83.29 kg          


Add Fertilizer 03
    [Documentation]    Owned and used / Organic Fertilizer
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=Organic Fertilizer    n=30
    ...    scope 1=124.93 kg  

Add Fertilizer 04
    [Documentation]    Owned and used / Organic Fertilizer / N=0%
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=Organic Fertilizer    n=0    
    ...    no emission=${True}   

Add Fertilizer 05
    [Documentation]    Owned and used / Urea Fertilizer
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=Urea Fertilizer    
    ...    scope 1=73.33 kg   

Add Fertilizer 06
    [Documentation]    Owned and used / Lime
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=Lime    
    ...    scope 1=44.00 kg 

Add Fertilizer 07
    [Documentation]    Owned and used / Dolomite
    Add & Check Emission    ${SITE NAMES}[0]    
    ...    fertilizer type=Dolomite    
    ...    scope 1=47.67 kg

Add Fertilizer 08
    [Documentation]    Leased in / NPK Fertilizer
    Add & Check Emission    ${SITE NAMES}[1]    
    ...    fertilizer type=NPK Fertilizer    n=15    p=10    k=5
    ...    scope 1=62.46 kg

    Add & Check Emission    ${SITE NAMES}[2]    
    ...    fertilizer type=NPK Fertilizer    n=10    p=0    k=0
    ...    scope 3=41.64 kg    
    
           


