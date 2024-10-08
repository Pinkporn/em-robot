*** Settings ***
Documentation     Business Structure Page
Resource          Structure.resource

*** Variables ***
      

*** Keywords ***
Go To Business Structure
    Click Element    //div[@data-testid="menu-organization"]
    Wait Until Element Is Visible    //button[@role='menuitem' and .//h4[text()='Business Structure']]
    Click Element    //button[@role='menuitem' and .//h4[text()='Business Structure']]
    Wait Until Element Is Visible    //li//button[contains(@class, 'mantine-ActionIcon-root')]
    Wait Until Element Is Not Visible    css:.mantine-Overlay-root

Go To Business Structure By Url
    [Arguments]    ${url}    ${org code}
    Go To    ${url}/${org code}/organization/business-structure
    Wait Until Element Is Visible    //li//button[contains(@class, 'mantine-ActionIcon-root')]
    Wait Until Element Is Not Visible    css:.mantine-Overlay-root

Click Current Selection Kebab Button
    Click Button    ${CURRENT SELECTION}//button
    Wait Until Element Is Visible    //div[@role="menu"]

Enter Site Form
    [Arguments]
    ...    ${site name}=${None}    ${org}=${None}
    ...    ${site status}=${None}  ${country}=${None}
    ...    ${province}=${None}     ${district}=${None}
    ...    ${subdistrict}=${None}    ${zip code}=${None}
    ...    ${address}=${None}
    
    IF  $site_name is not None
        Input Text    (//input[@name='name'])[last()]    ${site name}
    END
    IF  $org is not None
        Press Keys    (//input[@name='organizationId'])[last()]    CTRL+A    BACKSPACE
    END    
    Select Drop Down    Organization    ${org}
    Select Drop Down    Site Status    ${site status}
    Select Drop Down    Country        ${country}
    IF  $province is not None
        Select Drop Down    State / Province    ${province}
    END
    IF  $district is not None
        Select Drop Down    District    ${district}
    END
    IF  $subdistrict is not None
        Select Drop Down    Subdistrict    ${subdistrict}
    END
    IF  $zip_code is not None
        Select Drop Down    Zip / Postal Code    ${zip code}
    END
    IF  $address is not None
        Input Text    (//input[@name='address'])[last()]    ${address}
    END

Enter Organization Form
    [Arguments]
    ...    ${display name}=${None}
    ...    ${english name}=${None}    ${thai name}=${None}
    ...    ${website}=${None}
    ...    ${industry}=${None}    ${sector}=${None}
    ...    ${country}=${None}    ${province}=${None}
    ...    ${district}=${None}    ${subdistrict}=${None}
    ...    ${zip code}=${None}
    ...    ${address}=${None}

    IF  $display_name is not None
        VAR    ${name}    (//input[@name='name'])[last()]
        Press Keys    ${name}    CTRL+A+BACKSPACE
        Input Text    ${name}    ${display name}
    END
    IF  $english_name is not None
        VAR    ${nameEn}    (//input[@name='nameEn'])[last()]
        Press Keys    ${nameEn}    CTRL+A+BACKSPACE
        Input Text    ${nameEn}    ${english name}
    END
    IF  $thai_name is not None
        VAR    ${nameTh}    (//input[@name='nameTh'])[last()]
        Press Keys    ${nameTh}    CTRL+A+BACKSPACE
        Input Text    ${nameTh}    ${thai name}
    END
    IF  $website is not None
        Input Text    (//input[@name='website'])[last()]    ${website}
    END
    Select Drop Down    Industry    ${industry}
    Select Drop Down    Sector    ${sector}
    Select Drop Down    Country    ${country}
    IF  $province is not None
        Select Drop Down    State / Province    ${province}
    END
    IF  $district is not None
        Select Drop Down    District    ${district}
    END
        IF  $subdistrict is not None
        Select Drop Down    Subdistrict    ${subdistrict}
    END
    IF  $zip_code is not None
        Select Drop Down    Zip / Postal Code    ${zip code}
    END
    IF  $address is not None
        Input Text    (//input[@name='address'])[last()]    ${address}
    END

Click Profile Tab
    [Tags]
    Click Element    //div[contains(@class, 'SegmentedControl-control') and .='asset']
    Wait Until Element Is Visible    //form

Click Asset Tab
    [Tags]
    [Documentation]    Click `Asset` or `Asset Group` tab
    Click Element    //span[text()='asset']
    Wait Until Element Is Visible    //table

Enter New Asset Form
    [Arguments]    ${site}=${None}    ${asset type}=${None}    ${asset name}=${None}    ${asset status}=${None}
    Select Drop Down    Site    ${site}
    Select Drop Down    Asset Type    ${asset type}
    Wait Until Element Is Visible    (//input[@name='name'])[last()]
    Input Text    (//input[@name='name'])[last()]    ${asset name}
    Select Drop Down    Asset Status    ${asset status}


Confirm Save Update Detail Organization
    Click Element    //button[.="Save"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Organization profile has been updated successfully.
    Wait Until Element Is Not Visible    //section

Confirm Add Organization
    Click Element    //button[.="Create"]
    Wait Until Toast Finish Loading
    Toast Status Should Be    Successful
    Toast Message Should Be    Organization has been created successfully.
    Wait Until Element Is Not Visible    //section