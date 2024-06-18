*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/InputEmission.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${URL}            https://emission-management-web-uat.pages.dev
${BROWSER}        Chrome
${DELAY}          0.07s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Porn Corporation
${ORG CODE}       porn-corporation
${SUB ORG}        InputEmissionTest
${SUB ORG ID}     1663
@{SITE NAMES}     Test-Site-1    Test-Site-2    Test-Site-3

*** Keywords ***
Setup Everything
    # Register Keyword To Run On Failure    NOTHING
    Set Selenium Speed    ${DELAY}
    ${chrome_options}    Evaluate    selenium.webdriver.ChromeOptions()    selenium.webdriver
    Evaluate    '${chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])}'
    Evaluate    '${chrome_options.add_experimental_option('prefs', {"credentials_enable_service": False})}'
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Open browser    about:blank      ${BROWSER}     options=${chrome_options}
    CarbonCal Login    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Input Emission
    Select Orgs Structure Drop Down    ${None}    ${SUB ORG}
    # Go To Input Emission By Url    ${URL}    ${ORG CODE}    filter org id=${SUB ORG ID}

CarbonCal Login
    [Arguments]        ${user}    ${pass}    ${org}=${None}
    Go To              ${URL}
    Wait Until Element Is Visible            //*[text() = 'Login']
    ${page title} =    Get Title
    Should Contain     ${page title}                CARBONCAL
    Input Text         //input[@name='email']       ${user}
    Input Password     //input[@name='password']    ${pass}
    Click Element      //button[.//*[text() = 'Login']]
    Wait Until Page Contains    Please select organization
    IF  $org is not None
        Click Element               //p[text() = '${org}']
        Wait Until Page Contains    All Organizations 
        ${current url}              Get Location
        @{words}    Split String    ${current url}    /
        RETURN      ${words}[3]
    END
    RETURN    ${None}

Add & Check Emission
    [Arguments]      ${site name}    ${mode}    ${haul}     ${flight class}                 
    ...    ${distance}    ${unit}=km per passenger     ${amount}=${None}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Business Travel
    Enter Employee Commuting or Business Travel Form   mode=${mode}    haul=${haul}    
    ...    flight class=${flight class}    distance=${distance}    unit=${unit}    amount=${amount}    
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
    Click Button    (//td[@data-idx="12"]/button)[1]
    Press Keys    ${None}    ARROW_DOWN  ARROW_DOWN  ARROW_DOWN  RETURN
    Wait Until Element Is Visible    //section
    Press Keys    ${None}    TAB  RETURN

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
           


