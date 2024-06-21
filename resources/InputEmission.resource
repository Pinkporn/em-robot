*** Settings ***
Documentation     Input Emission Page
Resource          FormUtility.resource

*** Variables ***


*** Keywords ***
Go To Input Emission
    VAR    ${navlink input}    //div[contains(@class, 'mantine-Flex-root')]/a[2]
    Click Element    ${navlink input}
    Wait Until Element Is Visible    ${navlink input}//span[text()='Emissions']
    Click Element    ${navlink input}//span[text()='Emissions']
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Go To Input Emission By Url
    [Arguments]    ${url}    ${org code}    ${filter org id}=${None}    ${filter emission}=${None}
    VAR    ${url to go}    ${url}/${org code}/input/emission?
    IF  ${filter org id} != ${None}
        VAR    ${url to go}    ${url to go}&organizationIds=${filter org id}
    END
    IF  ${filter emission} != ${None}
        VAR    ${url to go}    ${url to go}&emissionGroups=${filter emission}
    END
    Go To    ${url to go}
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Add Emission Page 1 2
    [Arguments]    ${org name}    ${site name}    ${group}
    Click Element    //span[text()='Add Emission']
    VAR    ${org input}    //input[@id=//form//label[text()='Organization']/@for]
    Wait For Expected Condition    element_to_be_clickable    ${{('xpath', $org_input)}}
    Click Element    ${org input}
    Wait Until Element Is Visible    //div[@role="option" and ./span[text()='${org name}']]
    Click Element                    //div[@role="option" and ./span[text()='${org name}']]
    Click Element    //form[@id="add-emission-form"]//label[.//div[text()='Site']]
    Wait Until Element Is Visible    //div[@role="option"]//p[text()='${site name}']
    Click Element                    //div[@role="option"]//p[text()='${site name}']
    Press Keys    ${None}    TAB    RETURN
    Wait Until Element Is Visible    //div[./form and contains(@style, 'translateX(0%)')]
    Click Element                    //form//button[.='${group}']
    Wait Until Element Is Visible    //div[./form and contains(@style, 'translateX(0%)')]

Select Date of Activity
    [Arguments]    ${from}=${None}    ${to}=${None}
    IF  $from is None and $to is None
        ${date button}    Get WebElements    //button[contains(@aria-label, "Date")]
        IF  $date_button
            Click Element    ${date button}[0]
            Press Keys    ${None}    TAB    TAB    RETURN    RETURN
        END
        RETURN
    END
    Click Element    //form//label[.//*[text()='Date of Activity']]
    Wait Until Element Is Visible   //button[contains(@class, 'calendarHeaderLevel')]
    Select Date    ${from}
    IF  $to is None
        Press Keys    ${None}    RETURN
        RETURN
    END
    Select Date    ${to}

Input Text With Default
    [Arguments]    ${locator}    ${text}    ${default}
    IF  $text is None
        ${value}    Get Value    ${locator}
        VAR    ${text}    ${{$value if $value else $default}}
    END
    Input Text    ${locator}    ${text}

Click Edit Emission
    Click Kebab Button In Table
    Click Menu Button    Edit

Click Duplicate Emission
    Click Kebab Button In Table
    Click Menu Button    Duplicate

Click View Emission
    Click Kebab Button In Table
    Click Menu Button    View

Click Delete Emission
    Click Kebab Button In Table
    Click Menu Button    Delete
    Wait Until Element Is Visible    //section
    Click Button    //button[.='Delete']
    Wait Until Page Contains    The emission was successfully deleted.

# ======== Enter Emission Form ========
Enter Energy Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${asset type}=${None}
    ...    ${asset name}=${None}
    ...    ${source}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${amount}=${None}
    ...    ${resell}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    IF  $asset_type is not None and $asset_name is not None
        Select Drop Down    Asset Type    ${asset type}
        Select Drop Down    Asset Name    ${asset name}
    END
    Select Drop Down    Energy Source    ${source}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:energy.vendor    ${vendor}
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    name:energy.amount    ${amount}    100
    ${resell box}    Get WebElement    //input[@value="isResell"]
    IF  $resell_box.is_selected() != $resell and $resell is not None
        Click Element    ${resell box}
    END
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END
    
Enter Fuel Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${asset type}=${None}
    ...    ${asset name}=${None}
    ...    ${fuel}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    IF  $asset_type is not None
        Select Drop Down    Asset Type    ${asset type}
    END
    Select Drop Down    Asset Name    ${asset name}
    Select Drop Down    Fuel          ${fuel}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:combustion.vendor    ${vendor}
    END
    IF  $unit is not None
        Clear Element Text    //input[@id=//label[.//div[text()='Unit']]/@for]
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    name:combustion.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Refrigerants Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${asset type}=${None}
    ...    ${asset name}=${None}
    ...    ${refrigerant}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    IF  $asset_type is not None
        Select Drop Down    Asset Type    ${asset type}
    END
    Select Drop Down    Asset Name    ${asset name}
    Select Drop Down    Refrigerant   ${refrigerant}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:refrigerants.vendor    ${vendor}
    END
    Input Text With Default    name:refrigerants.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Fire Extinguishing Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${asset type}=${None}
    ...    ${asset name}=${None}
    ...    ${agent}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    IF  $asset_type is not None
        Select Drop Down    Asset Type    ${asset type}
    END
    Select Drop Down    Asset Name    ${asset name}
    Select Drop Down    Fire Extinguishing Agent     ${agent}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:fireExtinguisher.vendor    ${vendor}
    END
    Input Text With Default    name:fireExtinguisher.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Other Fugitive Emission Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${source}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Emission Source     ${source}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:otherFugitiveEmission.vendor    ${vendor}
    END
    Input Text With Default    name:otherFugitiveEmission.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Wastewater Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${wastewater type}=${None}
    ...    ${value}=${None}
    ...    ${known cod value}=${None}    ${industry type}=${None}
    ...    ${treatment}=${None}
    ...    ${wastewater amount}=${None}
    ...    ${sludge amount}=${None}
    ...    ${methane amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Wastewater Type    ${wastewater type}
    ${wastewater type}    Get Value    //input[@placeholder="Select Wastewater Type"]
    IF  $wastewater_type == 'Domestic Wastewater'
        IF  $value is not None
            Input Text    name:wasteWaterTreatment.cod    ${value}
        END
    ELSE    # Industrial Wastewater
        IF  $known_cod_value is not None
            Select Radio Button    wasteWaterTreatment.knownCOD    ${known cod value}
            Select Drop Down    Industry Type    ${industry type}
            IF  $value is not None and $known_cod_value == 'true'
                Input Text    name:wasteWaterTreatment.cod    ${value}
            END
        END
    END
    Select Drop Down    Wastewater Treatment    ${treatment}
    Input Text With Default    name:wasteWaterTreatment.wi    ${wastewater amount}    100
    Input Text With Default    name:wasteWaterTreatment.sludge    ${sludge amount}    0
    IF  $wastewater_type == 'Domestic Wastewater' and $methane_amount is not None
        Input Text    wasteWaterTreatment.methaneRecovery    ${methane amount}
    END
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Outsourcing Waste Disposal Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${category}=${None}
    ...    ${waste type}=${None}
    ...    ${treatment}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Category    ${category}
    Select Drop Down    Waste Type    ${waste type}
    Select Drop Down    Waste Treatment    ${treatment}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:wasteDisposal.vendor    ${vendor}
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    name:wasteDisposal.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Purchases Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${capital goods}=${None}
    ...    ${name}=${None}
    ...    ${goods services}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    IF  $capital_goods is not None
        Select Radio Button    purchasedGoodsAndServices.isCapitalGoods    ${capital goods}
    END
    IF  $name is not None
        Input Text    name:purchasedGoodsAndServices.name    ${name}
    END
    Select Drop Down    Goods / Services    ${goods services}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:purchasedGoodsAndServices.vendor    ${vendor}
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    name:purchasedGoodsAndServices.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Water Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${water type}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Water Type    ${water type}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:purchaseWater.vendor    ${vendor}
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    name:purchaseWater.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Septic Tank Checkbox
    [Arguments]    ${day}    ${select}=${None}
    ${box id}    Get Element Attribute    //label[contains(@class,'Checkbox-label') and text()='${day}']    for
    ${box}    Get WebElement    id:${box id}
    IF  $box.is_selected() != $select and $select is not None
        Click Element    ${box}
    END

Enter Septic Tank Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}
    ...    &{days}

    Select Date of Activity    ${from date}    ${to date}
    Input Text With Default    name:septicTank.amountOfPersons    ${amount}    100
    FOR  ${d}  IN  @{days}
        Septic Tank Checkbox    ${d}    ${days}[${d}]
    END
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Employee Commuting or Business Travel Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${mode}=${None}
    ...    ${vehicle type}=${None}    ${fuel type}=${None}
    ...    ${haul}=${None}    ${flight class}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${distance}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}
    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Mode of Transport    ${mode}
    ${mode}    Get Value    //input[@placeholder="Select Mode Of Transport"]
    IF  $mode != 'Flights'
        Select Drop Down    Vehicle Type    ${vehicle type}
        IF  $mode == 'Car'
            Select Drop Down    Fuel Type    ${fuel type}
        END
    ELSE
        Select Drop Down    Haul    ${haul}
        Select Drop Down    Flight Class    ${flight class}
    END
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        VAR    ${xpath}    //label[contains(@class, 'InputWrapper-label') and .//*[text()='Vendor (Optional)']]
        ${vendor field}    Get Element Attribute    ${xpath}    for
        Input Text    id:${vendor field}    ${vendor}
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    //input[@placeholder="Distance"]    ${distance}    100
    IF  $amount is not None
        Input Text    //input[@id=//form//label[./div[text()='Amount of Employees']]/@for]    ${amount}
    END
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Outsourcing Transport Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${goods type}=${None}
    ...    ${goods name}=${None}
    ...    ${source}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${distance unit}=${None}
    ...    ${distance}=${None}
    ...    ${loading unit}=${None}
    ...    ${loading}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Goods Type    ${goods type}
    IF  $goods_name is not None
        Input Text    name:outsourcingTransport.goodsName    ${goods name}
    END
    Select Drop Down    Emission Source    ${source}
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:outsourcingTransport.vendor    ${vendor}
    END
    Select Drop Down    Distance Unit    ${distance unit}
    Input Text With Default    name:outsourcingTransport.distance    ${distance}    100
    Select Drop Down    Loading Unit    ${loading unit}
    ${loading field}    Get WebElement    name:outsourcingTransport.loading
    IF  $loading_field.is_enabled()
        Input Text With Default    ${loading field}    ${loading}    100
    END
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END

Enter Fertilizer Form
    [Arguments]
    ...    ${from date}=${None}    ${to date}=${None}
    ...    ${fertilizer type}=${None}
    ...    ${n}=${None}    ${p}=${None}    ${k}=${None}
    ...    ${publisher}=${None}
    ...    ${vendor}=${None}
    ...    ${unit}=${None}
    ...    ${amount}=${None}
    ...    ${remark}=${None}

    Select Date of Activity    ${from date}    ${to date}
    Select Drop Down    Fertilizer Type    ${fertilizer type}
    IF  $n is not None
        Input Text    name:fertilizer.percentageOfNitrogen    ${n}
    END
    IF  $p is not None
        Input Text    name:fertilizer.percentageOfPhosphorus    ${p}
    END
    IF  $k is not None
        Input Text    name:fertilizer.percentageOfPotassium    ${k}
    END
    Select Drop Down    Emission Factor Publisher    ${publisher}
    IF  $vendor is not None
        Input Text    name:fertilizer.vendor    ${vendor}
    END
    Select Drop Down    Unit    ${unit}
    Input Text With Default    name:fertilizer.amount    ${amount}    100
    IF  $remark is not None
        Input Text    name:remark    ${remark}
    END
