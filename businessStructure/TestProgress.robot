*** Settings ***
Documentation     Get Start Progress Regression Test
Resource          getstart.resource
Resource          ../resources/InputEmission.resource
Suite Setup       Setup Everything

*** Variables ***
${SITE NAME}    Site Get 1
${ASSET NAME}    เครื่องจักร M1
@{SITE STATUS}    Owned and used    Leased in    Owned and leased out
@{ASSET STATUS}    Owned and used    Leased in    Owned and leased out
@{ASSET TYPE}    Vehicle    Machinery / Equipment

*** Test Cases ***
Step 1 : Create Your Site
    # ${value}    Get Element Attribute    //div[@role='progressbar']    aria-valuenow
    Click Task Go    Step 1 : Create Your Site
    Switch Window    New
    Wait Until Element Is Visible    //section
    Enter Site Form    site name=Site Get 1    site status=${SITE STATUS}[0]    province=Bangkok    
    ...    district=Taling Chan    subdistrict=Bang Ramat    zip code=10170    address=58/12 ถ.ลำพังกูด
    Click Button    //button[.='Create']
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Switch Window    Main
    Task Status Should Be Completed    Step 1 : Create Your Site

Step 2 : Step 2 : Create Your Asset
    Click Task Go    Step 2 : Create Your Asset
    Switch Window    New
    Wait Until Element Is Visible    //section
    Enter New Asset Form    site=${SITE NAME}    asset type=${ASSET TYPE}[0]
    ...    asset name=${ASSET NAME}    asset status=${ASSET STATUS}[0]
    Click Button    //button[.='Add']
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Switch Window    Main
    Task Status Should Be Completed    Step 2 : Create Your Asset

Step 3 : Add Your Emissions
    Click Task Go    Step 3 : Add Your Emissions
    Switch Window    New
    Wait Until Element Is Visible    //section
    Add Emission Page 1 2 From Get Start    ${ORGANIZATION}        ${SITE NAME}    Fuel
    Enter Fuel Form    from date=Jan 2023    to date=Dec 2023    asset type=${ASSET TYPE}[0]    asset name=${ASSET NAME}  
    ...    fuel=LPG (On-road vehicle)    amount=100
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Click Button    //button[.='Add']
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Switch Window    Main
    Task Status Should Be Completed    Step 3 : Add Your Emissions
