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
    Click Add Product Value Indicator Menu Button
    Wait Until Element Is Visible    //input[@placeholder="Product Value Indicator Name"]
    Input Text    //input[@placeholder="Product Value Indicator Name"]    ${name}
    Wait Until Element Is Enabled    (//button[.='Add'])[last()]
    Click Button    (//button[.='Add'])[last()]
    Wait Until Page Contains    The product value indicator was successfully created.

Rename Product Value Indicator
    [Arguments]    ${name}    ${new name}
    Click Button    //button[@aria-haspopup and ./*[local-name()='svg']]
    Click Button    //button[.='${name}']//button
    Click Rename Menu Button
    Wait Until Element Is Visible    //input[@value='${name}']
    Input Text    //input[@value='${name}']    ${new name}
    Click Button    //button[.='Save']
    Wait Until Element Is Visible    //button[.='Confirm']
    Click Button    //button[.='Confirm']
    Wait Until Page Contains    The product value indicator was successfully updated.

Delete Product Value Indicator
    [Arguments]    ${name}
    Click Button    //button[@aria-haspopup and ./*[local-name()='svg']]
    Click Button    //button[.='${name}']//button
    Click Delete Menu Button
    Wait Until Element Is Visible    //section//button[.='Delete']
    Click Element    //section//button[.='Delete']
    Wait Until Page Contains     The product value indicator was successfully deleted.

Click Add Eco Eff
    [Arguments]    ${org}    ${site}
    Click Button    //button[.='Add Eco-Efficiency']
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]
    Select Drop Down    Organization    ${org}
    Select Drop Down    Site    ${site}
    Click Button    //button[.='Next']
    Wait Until Element Is Visible    //div[contains(@style, 'translateX(0%)')]

Enter Eco Efficiency Form
    [Arguments]        
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${value indicator}=${None}
    ...    ${impact indicator}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}
    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Product Value Indicator    ${value indicator}
    Select Drop Down    Environment Impact Indicator    ${impact indicator}
    IF  $amount is not None    Input Text    name:bank.defaultProductValueAmount.amount    ${amount}   
    IF  $remark is not None    Input Text    name:remark    ${remark}

Click Confirm Add Eco Eff
    Click Element    //button[.='Add']
    Wait Until Page Contains    Eco-Efficiency created successfully    error=Add eco eff fail
    Wait Until Element Is Not Visible    //section