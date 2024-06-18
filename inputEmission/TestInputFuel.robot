*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/InputEmission.resource
Resource          InputEmission.resource
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

Add & Check Fuel Emission
    [Arguments]    ${site name}    ${asset name}    ${fuel name}    ${amount}
    ...    ${unit}=litre    ${asset type}=Machinery / Equipment
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    
    ${id}    Get Last ID Emission
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Fuel
    Enter Fuel Form    asset name=${asset name}    fuel=${fuel name}    
    ...    unit=${unit}    amount=${amount}    asset type=${asset type}
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
    Click Button    (//td[@data-idx="12"]/button)[1]
    Press Keys    ${None}    ARROW_DOWN  ARROW_DOWN  ARROW_DOWN  RETURN
    Wait Until Element Is Visible    //section     #Modal Confirm Delete
    Press Keys    ${None}    TAB  RETURN

*** Test Cases ***
Add Fuel 01
    [Documentation]    Site: Owned and used - Asset: Owned and used (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 02
    [Documentation]    Site: Owned and used - Asset: Leased in (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1LI       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 03
    [Documentation]    Site: Owned and used - Asset: Leased out (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1LO       fuel name=Jet Kerosene    amount=100
    ...                          scope 3=247.75 kg

Add Fuel 04
    [Documentation]    Site: Leased in - Asset: Owned and used (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[1]
    ...    asset name=M2OU       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 05
    [Documentation]    Site: Leased in - Asset: Leased in (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[1]
    ...    asset name=M2LI       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 06
    [Documentation]    Site: Leased out - Asset: Leased out (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       fuel name=Jet Kerosene    amount=100
    ...                          scope 3=247.75 kg

Add Fuel 07
    [Documentation]    Site: Owned and used - Asset: Owned and used (Vehicle)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       fuel name=Gasoline/Petrol (On-road vehicle)    amount=100
    ...    scope 1=227.19 kg     scope 3=30.38 kg    asset type=Vehicle

Add Fuel 08
    [Documentation]    Site: Owned and used - Asset: Owned and used (Vehicle)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       fuel name=LPG (On-road vehicle)    amount=100
    ...    scope 1=173.06 kg     scope 3=42.91 kg    asset type=Vehicle

Add Fuel 09
    [Documentation]    Site: Owned and used - Asset: Machinery, Biogenic fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=FUEL WOOD    amount=100    unit=kg
    ...    scope 1=3.04 kg                              outside of scope=179.09 kg

Add Fuel 10
    [Documentation]    Site: Owned and used - Asset: Machinery, Mixed fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=Gasohol 91    amount=100
    ...    scope 1=197.05 kg     scope 3=27.34 kg        outside of scope=15.20 kg

Add Fuel 11
    [Documentation]    Site: Owned and used - Asset: Vehicle, Mixed fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       fuel name=Diesel B7 (On-road vehicle)    amount=100
    ...    scope 1=254.88 kg     scope 3=27.62 kg        outside of scope=16.52 kg    asset type=Vehicle

# Temp
#     Add Emission Page 1 2    ${SUB ORG}    ${SITE NAMES}[0]    Energy
#     Enter Energy Form    from date=Jun 2020    to date=Dec 2022    source=Electricity (MEA / PEA)    amount=100    resell=${True}
#     Enter Energy Form    resell=${False}
#     Sleep    10