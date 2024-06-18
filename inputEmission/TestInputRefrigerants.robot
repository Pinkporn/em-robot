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
    [Arguments]    ${site name}    ${asset name}    ${refrigerant}    ${amount}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${no emission}=${False}
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Refrigerants
    Enter Refrigerants Form     asset name=${asset name}    refrigerant=${refrigerant}    amount=${amount}
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
Add Refrigerants 01
    [Documentation]    Machinery / Case ทั่วไป / HFCs Group
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=HFC-23 (R-23)    amount=5.67
    ...    scope 1=70.31 t

Add Refrigerants 02
    [Documentation]    Machinery / Case ทั่วไป / PFCs Group
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=PFC-14 (Perfluoromethane)    amount=5.67
    ...    scope 1=37.59 t

Add Refrigerants 03
    [Documentation]    Machinery / Case ทั่วไป / Blend Group
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=R401A    amount=5.67
    ...    scope 1=6.41 t

Add Refrigerants 04
    [Documentation]    Vehicle / Case ทั่วไป / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=HFC-143a (R-143a)    amount=4.88
    ...    scope 1=23.42 t

Add Refrigerants 05
    [Documentation]    Vehicle / Case ทั่วไป / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    asset name=M2OU       refrigerant=HFC-143a (R-143a)    amount=4.88
    ...    scope 1=23.42 t

Add Refrigerants 06
    [Documentation]    Vehicle / Case ทั่วไป / Leased in
    Add & Check Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       refrigerant=HFC-143a (R-143a)    amount=4.88
    ...    scope 3=23.42 t

Add Refrigerants 07
    [Documentation]    Machinery / Case Out-of-Scope / Owned and used
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       refrigerant=CFC-11    amount=6.67
    ...    no emission=${True}

Add Refrigerants 08
    [Documentation]    Machinery / Case Out-of-Scope / Leased in
    Add & Check Emission    ${SITE NAMES}[1]
    ...    asset name=M2OU       refrigerant=CFC-11    amount=6.67
    ...    no emission=${True}

Add Refrigerants 09
    [Documentation]    Machinery / Case Out-of-Scope / Owned and leased out
    Add & Check Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       refrigerant=CFC-11    amount=6.67
    ...    no emission=${True}

Add Refrigerants 10
    [Documentation]    Vehicle / Case Out-of-Scope
    Add & Check Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       refrigerant=Halon-1301    amount=6.67
    ...    no emission=${True}