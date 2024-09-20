*** Settings ***
Documentation     Input Emission Regression Test
Resource          ../resources/BusinessStructure.resource
Resource          business.resource
Variables         Orgs.py
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
${org}    TEST THE EXCISE
${suborg}    กรมสรรพสามิต (ส่วนกลาง)
${site name}    อาคารส่วนกลาง

*** Keywords ***


*** Test Cases ***
Workspace - Update
    [Documentation]    Upload Detail Organization
    Enter Organization Form    display name=บริษัท Get Start จำกัด    thai name=บริษัท เริ่มใหม่อีกครั้ง จำกัด    
    ...    website=www.getstart.test.com    industry=Industrials    sector=Automotive    
    ...    province=Chiang Mai    district=Chai Prakan    subdistrict=Mae Thalop    zip code=50320    
    ...    address=523/112 หมู่ที่ 8 ถนนชานเมือง
    Upload Evidences    ${CURDIR}/Get Start Logo.jpg
    Confirm Save Update Detail Organization

Workspace - Add Site 01
    [Documentation]    Add site
    [Tags]    add site
    Select Structure Item    TEST THE EXCISE
    Select Structure Item    ${suborg}
    Click Current Selection Kebab Button
    Click Element    //button[@role='menuitem' and .//div[text()='Add Site']]
    Wait Until Element Is Visible    //section
    Enter Site Form    site name=${site name}    org=${None}    site status=Owned and used      
    Click Element    //button[.="Create"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Site has been created successfully.

Workspace - Add SubOrg & Site
    [Documentation]    Add site
    [Tags]    add site
    FOR  ${index}    ${suborg}  IN ENUMERATE  @{structure}    start=11
        Select Structure Item    ${org}    type=Org
        Click Current Selection Kebab Button
        Click + Add Sub Org Menu Button
        Wait Until Element Is Visible    //section[contains(@style, 'transform: translateY(0px)')]
        Enter Organization Form    display name=${suborg}    english name=Excise Office ${index}    
        ...    industry=Services    sector=Commerce
        Click Element    //button[.="Create"]
        Wait Until Toast Finish Loading
        Toast Status Should Be    Successful
        Wait Until Element Is Not Visible    css:.mantine-Loader-root
        Sleep    0.1
        VAR    ${site list}    ${structure}[${suborg}]
        FOR  ${site}  IN  @{site list}
            Select Structure Item    ${suborg}    type=Org
            Click Current Selection Kebab Button
            Click + Add Site Menu Button
            Wait Until Element Is Visible    //section[contains(@style, 'transform: translateY(0px)')]
            ${drop down}    Get Element From Label    Organization
            Click Element    ${drop down}
            Scroll Element Into View    ${POPOVER_XPATH}//div[@role="option"][last()]//following-sibling::div
            Enter Site Form    site name=${site}    site status=Owned and used
            Click Element    //button[.="Create"]
            Wait Until Toast Finish Loading
            Toast Status Should Be    Successful
        END
    END

Workspace - Add Asset
    [Documentation]    Add asset
    [Tags]    add asset for big
    FOR  ${suborg}  IN    @{structure}
        Select Structure Item    ${suborg}    type=Org
        Wait Until Element Is Not Visible    css:.mantine-Loader-root
        Sleep    0.1
        VAR    ${site list}    ${structure}[${suborg}]
        FOR  ${site}  IN  @{site list}
            Select Structure Item    ${site}    type=Site
            Sleep    0.1
            Click Asset Tab
            FOR  ${assetName}    IN    @{assetData}
                Click Element    //button[.="+ New Asset"]
                Enter New Asset Form    site=${site}    asset type=${assetData}[${assetName}]    
                ...    asset name=${assetName} ${site}    asset status=Owned and used
                Click Element    //button[.="Add"]
                Wait Until Toast Finish Loading
                Toast Status Should Be    Successful
            
            END
            
        END
    END


Add Asset
    [Documentation]    Add Asset
    [Tags]    add asset
    Select Structure Item    Get Start อีกครั้ง
    Select Structure Item    Site Get 1
    Click Asset Tab
    Click Element    //button[.="+ New Asset"]
    Wait Until Element Is Visible    //section[contains(@style, 'transform: translateY(0px)')]
    Enter New Asset Form    asset type=Vehicle    asset status=Owned and used
    ...    asset name=เครื่องจักร M1
    Click Element    //button[.="Add"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Asset Added