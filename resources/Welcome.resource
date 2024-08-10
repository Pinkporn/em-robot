*** Settings ***
Documentation     Get Start Page
Resource          FormUtility.resource

*** Variables ***
      

*** Keywords ***

Go To Welcome
    Click Element    //*[local-name() = 'svg' and ./*[@fill="#11D073"]]
    Wait Until Page Contains    Welcome To Zplify! 🎉
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Click Menu Dashboard
    Wait Until Element Is Visible    //p[text()='Dashboard']
    Click Element    //p[text()='Dashboard']
    Wait Until Page Contains    Emissions by Assets

Click Menu Emission
    Wait Until Element Is Visible    //p[text()='Emission']
    Click Element    //p[text()='Emission']
    Wait Until Element Is Visible    //button//p[text()='Add Emission']

Click Menu Report
    Wait Until Element Is Visible    //p[text()='Report']
    Click Element    //p[text()='Report']
    Wait Until Element Is Visible    //button//span[text()='Report Template']

Click Menu Data
    Wait Until Element Is Visible    //p[text()='Data']
    Click Element    //p[text()='Data']
    Wait Until Element Is Visible    //button//span[text()='Add Emission Factor']

Click Menu Reduction
    Wait Until Element Is Visible    //p[text()='Reduction']
    Click Element    //p[text()='Reduction']
    Wait Until Element Is Visible    //button[@data-variant="subtle"]
    Click Element    //button[@data-variant="subtle"]

Click Button Go To Get Started
    Wait Until Element Is Visible    //button//span[text()='Get Started']
    Click Element    //button//span[text()='Get Started']
    Wait Until Page Contains    Get Started

