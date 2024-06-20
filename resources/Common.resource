*** Settings ***
Documentation     Common Keywords. No specific page.
Library           SeleniumLibrary
Library           String

*** Variables ***


*** Keywords ***
Open Chrome
    ${chrome_options}    Evaluate    selenium.webdriver.ChromeOptions()    selenium.webdriver
    Evaluate    $chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])
    Evaluate    $chrome_options.add_experimental_option('prefs', {"credentials_enable_service": False})
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Open browser    about:blank    Chrome    options=${chrome_options}

CarbonCal Login
    [Arguments]    ${link}    ${user}    ${pass}    ${org}=${None}
    Go To    ${link}
    Wait Until Element Is Visible    //input[@name='email']
    Wait Until Element Is Visible    //input[@name='password']
    Input Text         //input[@name='email']            ${user}
    Input Password     //input[@name='password']         ${pass}
    Click Element      //button[.//*[text() = 'Login']]
    Wait Until Page Contains    Please select organization
    IF  $org is not None
        Wait Until Element Is Visible        //p[text() = '${org}']
        Click Element                        //p[text() = '${org}']
        Wait Until Page Contains             All Organizations 
        Wait Until Element Is Not Visible    css:.mantine-Overlay-root
        ${current url}    Get Location
        @{words}    Split String    ${current url}    /
        RETURN      ${words}[3]
    END
    RETURN    ${None}