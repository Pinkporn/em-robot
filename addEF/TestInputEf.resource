*** Settings ***
Documentation     Common resource for Input Emission for custom Emission Factor
Resource          ${EXECDIR}/resources/InputEmission.resource
Resource          ${EXECDIR}/resources/Common.resource

*** Variables ***
${URL}            https://app-uat.zplify.com/
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Gideon Two

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Input Emission

Custom Teardown
    Sleep    0.5
    IF  $TEST_STATUS == 'FAIL'
        ${modal}    Find WebElement    //section
        IF  $modal is None    RETURN
        Close Unsaved Changes Form
    END