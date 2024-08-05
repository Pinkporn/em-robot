*** Settings ***
Documentation     Common resource for Input Emission test
Resource          ../resources/InputEmission.resource
Resource          ../resources/Common.resource

*** Variables ***
${URL}            https://app-uat.zplify.com/login
${BROWSER}        Chrome
${DELAY}          0.02s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Zpliporn Test
${ORG CODE}       zpliporn-test
${SUB ORG}        Zpliporn สาขา 1
${SUB ORG ID}     5
@{SITE NAMES}     สาขา 1 ไซต์ 1    สาขา 1 ไซต์ 2    สาขา 1 ไซต์ 3

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Input Emission
    Wait Until Element Is Visible    //button//span[text()='Filter']
    Click Element    //button//span[text()='Filter']
    Select Orgs Structure Drop Down    ${None}    ${SUB ORG}
    Click Element    //button//span[text()='Apply']