*** Settings ***
Documentation     Common resource for adding Emission Factor
Resource          ../resources/EmissionFactor.resource
Resource          ../resources/Common.resource

*** Variables ***
${URL}            https://app-uat.zplify.com/
${DELAY}          0s
${USER EMAIL}     tanomporn.p@gideon-one.com
${PASSWORD}       P@ssw0rd
${ORGANIZATION}   Gideon Two
# ${ORGANIZATION}   Gideon Three
${ORG CODE}       gideon-two
# ${ORG CODE}       gideon-three

*** Keywords ***
Setup Everything
    Set Selenium Speed    ${DELAY}
    Open Chrome
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Emission Factors

Custom EF Teardown
    Sleep    0.5
    IF  $TEST_STATUS == 'FAIL'
        ${modal}    Find WebElement    //section
        IF  $modal is None    RETURN
        Click Close Modal
        # Close again if there is more than one modal
        ${modal}    Find WebElement    //section
        IF  $modal is None    RETURN
        Click Close Modal
    END