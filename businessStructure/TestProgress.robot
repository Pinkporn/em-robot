*** Settings ***
Documentation     Get Start Progress Regression Test
Resource          getstart.resource
Suite Setup       Setup Everything

*** Variables ***
@{SITE STATUS}    Owned and used    Leased in    Owned and leased out  

*** Test Cases ***
Step 1 : Create Your Site
    # ${value}    Get Element Attribute    //div[@role='progressbar']    aria-valuenow
    Click Task Go    Step 1 : Create Your Site
    Switch Window    New
    Wait Until Element Is Visible    //section
    Enter Site Form    Get 1    site status=${SITE STATUS}[0]    province=Bangkok    
    ...    district=Taling Chan    subdistrict=Bang Ramat    zip code=10170    address=58/12 ถ.ลำพังกูด
    Click Button    //button[.='Create']
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Switch Window    Main
    Task Status Should Be Completed    Step 1 : Create Your Site
