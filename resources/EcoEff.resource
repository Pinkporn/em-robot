*** Settings ***
Documentation     Eco Efficiency Page
Resource          FormUtility.resource

*** Variables ***


*** Keywords ***
Go To Eco Eff
    VAR    ${navlink input}    //div[contains(@class, 'mantine-Flex-root')]/a[2]
    Click Element    ${navlink input}
    Wait Until Element Is Visible    ${navlink input}//span[text()='Eco-Efficiency']
    Click Element    ${navlink input}//span[text()='Eco-Efficiency']
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Add Product Value Indicator
    [Documentation]
    ...    Add Product Value Indicator with specified name.
    ...
    ...    Click down arrow button that stay right to Add Eco-Efficiency button
    ...    then click Add Product Value Indicator button
    [Arguments]    ${name}
    Click Button    //button[@aria-haspopup and ./*[local-name()='svg']]
    Click Menu Button    Add Product Value Indicator
    Wait Until Element Is Visible    //input[@placeholder="Product Value Indicator Name"]
    Input Text    //input[@placeholder="Product Value Indicator Name"]    ${name}
    Wait Until Element Is Enabled    //button[.='Add']
    Click Button    //button[.='Add']
    Wait Until Page Contains    The product value indicator was successfully created.

Rename Product Value Indicator
    [Arguments]    ${name}    ${new name}
    Click Button    //button[@aria-haspopup and ./*[local-name()='svg']]
    Click Button    //button[.='${name}']//button
    Click Menu Button    Rename
    Wait Until Element Is Visible    //input[@value='${name}']
    Input Text    //input[@value='${name}']    ${new name}
    Click Button    //button[.='Add']
    Wait Until Element Is Visible    //button[.='Confirm']
    Click Button    //button[.='Confirm']
    Wait Until Page Contains    The product value indicator was successfully updated.

Delete Product Value Indicator
    [Arguments]    ${name}
    Click Button    //button[@aria-haspopup and ./*[local-name()='svg']]
    Click Button    //button[.='${name}']//button
    Click Menu Button    Delete
    Wait Until Element Is Visible    //button[.='Delete']
    Click Element    //button[.='Delete']
    Wait Until Page Contains     The product value indicator was successfully deleted.

Click Add Eco Eff
    [Arguments]    ${org}    ${site}
    Click Button    //button[.='Add Eco-Efficiency']
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]
    Select Drop Down    Organization    ${org}
    Select Drop Down    Site    ${site}
    Click Button    //button[.='Next']
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]