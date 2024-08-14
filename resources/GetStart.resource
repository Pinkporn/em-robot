*** Settings ***
Documentation     Get Start Page
Resource          FormUtility.resource

*** Variables ***
      

*** Keywords ***

Click Go To Access Control
    Wait Until Element Is Visible    //a/p[text()='Access Control']
    Click Element    //a/p[text()='Access Control']

Click Go To Emission Factor
    Wait Until Element Is Visible    //a/p[text()='Emission Factor']
    Click Element    //a/p[text()='Emission Factor']

Click Go To Data Completion
    Wait Until Element Is Visible    //a/p[text()='Data Completion']
    Click Element    //a/p[text()='Data Completion']

Click Go To Reduction
    Wait Until Element Is Visible    //a/p[text()='Reduction']
    Click Element    //a/p[text()='Reduction']

Click Task Go
    [Arguments]    ${text}
    Click Element    //div[./div/div[@aria-hidden] and .//h1[text()='${text}']]//a[.='Go']

Task Status Should Be Completed
    [Arguments]    ${text}
    ${status}    Get Text    //div[./div/div[@aria-hidden] and .//h1[text()='${text}']]//span/p
    Should Be Equal As Strings    ${status}    Completed