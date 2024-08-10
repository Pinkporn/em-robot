*** Settings ***
Documentation     Common resource for adding organization
Resource          ../resources/Welcome.resource
Resource          ../resources/Common.resource

*** Variables ***
# ${URL}            https://app-uat.zplify.com/
${URL}            https://app.zplify.com/
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
# ${ORGANIZATION}   Get Start อีกครั้ง
# ${ORG CODE}       get-start-agian
${ORGANIZATION}   Get Start
${ORG CODE}       get-start

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    