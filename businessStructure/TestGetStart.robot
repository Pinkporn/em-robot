*** Settings ***
Documentation     Get Start Regression Test
Resource          getstart.resource
Suite Setup       Setup Everything

*** Test Cases ***
Landing To Access Control
    Click Go To Access Control
    Switch Window    New
    Wait Until Element Is Not Visible    css:.mantine-Loader-root
    Wait Until Page Contains       Access Control
    Switch Window    Main

Landing To Emission Factor
    Click Go To Emission Factor
    Switch Window    New
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]
    Wait Until Element Is Visible    //button[.//span[text()='Add Emission Factor']]
    Switch Window    Main

Landing To Data Completion
    Click Go To Data Completion
    Switch Window    New
    Wait Until Element Is Not Visible    css:.mantine-Loader-root
    Wait Until Element Is Visible    //label//span[text()='trackers']
    Switch Window    Main

Landing To Reduction
    Click Go To Reduction
    Switch Window    New
    Wait Until Element Is Visible    //input[@placeholder='Select Target']
    ${value}    Get Value    //input[@placeholder='Select Target']
    IF  $value is not None
        Wait Until Element Is Visible    //button[@data-variant="subtle"]
        Click Element    //button[@data-variant="subtle"]
    ELSE
        Element Should Not Be Visible    //section
    END
    Switch Window    Main
