*** Settings ***
Documentation     Common resource for Input Emission test
Resource          ../resources/EmissionFactor.resource
Resource          ../resources/Common.resource

*** Variables ***
${URL}            https://app-uat.zplify.com/
${BROWSER}        Chrome
${DELAY}          0.02s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Gideon Two
${ORG CODE}       gideon-two

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    CarbonCal Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Wait Until Element Is Visible    //button[.='Skip']
    Click Element    //button[.='Skip']
    Wait Until Element Is Not Visible    //div[@id="body"]
    Go To Emission Factors