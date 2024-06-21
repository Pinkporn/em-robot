*** Settings ***
Documentation     Create Report Template Regression Test
Resource          ../resources/ReportTemplate.resource
Resource          ../resources/Common.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${URL}            https://emission-management-web-uat.pages.dev
${BROWSER}        Chrome
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Porn Corporation


*** Keywords ***
Setup Everything
    # Register Keyword To Run On Failure    NOTHING
    Set Selenium Speed    ${DELAY}
    Open Chrome
    CarbonCal Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Report Templates
    Wait Until Element Is Visible    //li[.='Export History']
    Click Element   //li[.='Export History']

*** Test Cases ***
Download History Report
    Click Kebab Button In Table
    Click Menu Button    Download

Delete History Report
    Click Kebab Button In Table
    Click Menu Button    Delete
    Wait Until Element Is Visible    //button[.='Delete']
    Click Element    //button[.='Delete']
    Wait Until Page Contains    History Deleted Successfully
    
