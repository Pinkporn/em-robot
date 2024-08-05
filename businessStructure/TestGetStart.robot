*** Settings ***
Documentation     Get Start Regression Test
Library           SeleniumLibrary
Resource          ../resources/GetStart.resource
Resource          getstart.resource
Suite Setup       Setup Everything

*** Test Cases ***
Landing To Get Start Page
    Click Button Go To Get Started

Landing To Access Control
    Click Go To Access Control
    ${handles}=    Get Window Handles
    Switch Window    New
    Wait Until Page Contains       Access Control
    Switch Window    ${handles}[0]

Landing To Emission Factor
    Click Go To Emission Factor
    ${handles}=    Get Window Handles
    Switch Window    New
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]
    Wait Until Element Is Visible    //button[.//span[text()='Add Emission Factor']]
    Switch Window    ${handles}[0]

Landing To Data Completion
    Click Go To Data Completion
    ${handles}=    Get Window Handles
    Switch Window    New
    Wait Until Element Is Visible    //label//span[text()='trackers']
    Switch Window    ${handles}[0]

Landing To Reduction
    Click Go To Reduction
    ${handles}=    Get Window Handles
    Switch Window    New
    Wait Until Element Is Visible    //button[@data-variant="subtle"]
    Click Element    //button[@data-variant="subtle"]
    Switch Window    ${handles}[0]
