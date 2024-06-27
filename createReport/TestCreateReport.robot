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
    EM Login    ${URL}    ${USER EMAIL}    ${PASSWORD}    ${ORGANIZATION}
    Go To Report Templates

*** Test Cases ***
Create Report 01
    [Documentation]    One Org. / No base year
    VAR    @{include org}    Porn Corporation   
    Add Report Template    report org=${ORGANIZATION}    include org=${include org}    
    ...    report name=One Org.-No base year    from period=Jan 2023    to period=Dec 2023
    Enter FR-01    reporting period yield=Revenue    reporting period amount=1000000
    Click Save Report

Create Report 02
    [Documentation]    One Org. / Have base year
    VAR    @{include org}    Porn Corporation   
    Add Report Template    report org=${ORGANIZATION}    include org=${include org}    
    ...    report name=One Org.-Have base year    from period=Jan 2023    to period=Dec 2023    
    ...    from base period=Jan 2022    to base period=Dec 2022
    Enter FR-01    reporting period yield=Profit    reporting period amount=1000000    base year amount=500000
    Click Save & Report

Create Report 03
    [Documentation]    Multi Org. / No base year
    VAR    @{include org}    Porn Corporation   
    Add Report Template    report org=${ORGANIZATION}    include org=${include org}    
    ...    report name=Multi Org.-No base year    from period=Jan 2023    to period=Dec 2023
    Enter FR-01    reporting period yield=Profit    reporting period amount=1000000
    Click Save Report

Create Report 04
    [Documentation]    Multi Org. / Have base year
    VAR    @{include org}    Porn Corporation   
    Add Report Template    report org=${ORGANIZATION}    include org=${include org}    
    ...    report name=Multi Org.-Have base year    from period=Jan 2023    to period=Dec 2023    
    ...    from base period=Jan 2022    to base period=Dec 2022
    Enter FR-01    reporting period yield=Revenue    reporting period amount=1000000    base year amount=500000
    Click Save & Report

Edit Report
    Click Edit Report
    Enter FR-01    reporting period yield=Amount of Goods Produced    reporting period amount=800000    base year amount=400000
    Click Save Report

Export Report
    Click Export Report

Delete Report
    Click Delete Report


