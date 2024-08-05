*** Settings ***
Documentation     Get Start Page
Resource          FormUtility.resource
Resource          ../resources/EmissionFactor.resource

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