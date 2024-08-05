*** Settings ***
Documentation     Common resource for adding organization
Resource          ../resources/BusinessStructure.resource
Resource          ../resources/Common.resource

*** Variables ***
${URL}            https://app-uat.zplify.com/
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Get Start อีกครั้ง
${ORG CODE}       get-start-agian

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Business Structure