*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/EmissionFactor.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${URL}            https://emission-management-web-uat.pages.dev
${BROWSER}        Chrome
${DELAY}          0.05s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Porn Corporation
${ORG CODE}       porn-corporation

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
    Go To Emission Factors

    
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

*** Test Cases ***

Add EF Renew Default  
    [Documentation]    EF Renew:Default
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Jan 2021    end date=Mar 2021
    ...    publisher=Renew    cert id=TGO CFP 21-01-01    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF    unit=kWh    renewable=${True}
    Confirm Add EF  

Add EF Renew 01
    [Documentation]    EF Renew:Default    Is Renew=No
    Click Add Emission Factor Button
    Enter Energy Emission Factor Form    start date=Apr 2021    end date=Jun 2021
    ...    publisher=Renew    cert id=TGO CFP 21-04-01    factor type=Combustion
    ...    purchased type=Heat    source=Renew_EF    unit=kWh    
    Element Should Be Visible    //p[text()='The selected energy source is Renewable.']
    Element Should Be Disabled    //input[@id=//label[text()='Renewable']/@for]    


    

