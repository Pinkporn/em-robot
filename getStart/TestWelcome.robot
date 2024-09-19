*** Settings ***
Documentation     Welcome Regression Test
Resource          ../resources/Welcome.resource
Resource          welcome.resource
Suite Setup       Setup Everything

*** Test Cases ***
Landing To Dashboard
    Click Menu Dashboard
    Go To Welcome
    
Landing To Emission
    Click Menu Emission
    Go To Welcome

Landing To Reduction
    Click Menu Reduction
    Go To Welcome

Landing To Report
    Click Menu Report
    Go To Welcome

Landing To Data
    Click Menu Data
    Go To Welcome

Landing To Get Start
    Click Button Go To Get Started
    Go To Welcome

Landing To Release Note
    [Documentation]    Verify Version
    Click Link    //a[text()='View Full Release Notes']
