*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/InputEmission.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${URL}            https://emission-management-web-uat.pages.dev
${BROWSER}        Chrome
${DELAY}          0.1s
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
    [Arguments]      ${site name}    ${from date}    ${to date}        ${amount}=20         
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}    &{days}
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Septic Tank
    Enter Septic Tank Form   ${from date}    ${to date}     amount=${amount}    &{days}
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
           


