*** Variables ***

${STANDARDS_BASE_URI}                     https://standards.oftrust.net/v2/

### CONTEXT Data Products
${CONTEXT_POT_Output_Data_Product}         ${STANDARDS_BASE_URI}Context/DataProductOutput/
${CONTEXT_POT_Output_Document}             ${STANDARDS_BASE_URI}Context/DataProductOutput/Document/
${CONTEXT_POT_Output_DocumentSigning}      ${STANDARDS_BASE_URI}Context/DataProductOutput/Document/Signing/
${CONTEXT_POT_Output_SignSpace}            ${STANDARDS_BASE_URI}Context/DataProductOutput/Document/Signing/SignSpace/
${CONTEXT_POT_Output_Forecast}             ${STANDARDS_BASE_URI}Context/DataProductOutput/Forecast/
${CONTEXT_POT_Output_PriceForecast}        ${STANDARDS_BASE_URI}Context/DataProductOutput/Forecast/Price/
${CONTEXT_POT_Output_ElectricityPriceForecast}
...                                        ${STANDARDS_BASE_URI}Context/DataProductOutput/Forecast/Price/Electricity/
${CONTEXT_POT_Output_WeatherForecast}      ${STANDARDS_BASE_URI}Context/DataProductOutput/Forecast/Weather/
${CONTEXT_POT_Output_AccuWeatherForecast}  ${STANDARDS_BASE_URI}Context/DataProductOutput/Forecast/Weather/AccuWeather/
${CONTEXT_POT_Output_Ltif}                 ${STANDARDS_BASE_URI}Context/DataProductOutput/Ltif/
${CONTEXT_POT_Output_Sensor}               ${STANDARDS_BASE_URI}Context/DataProductOutput/Sensor/
${CONTEXT_POT_Output_Company}              ${STANDARDS_BASE_URI}Context/DataProductOutput/Company/
${CONTEXT_POT_Output_Product}              ${STANDARDS_BASE_URI}Context/DataProductOutput/Product/
${CONTEXT_POT_Output_Timetable}            ${STANDARDS_BASE_URI}Context/DataProductOutput/Timetable/
${CONTEXT_POT_Output_Position}             ${STANDARDS_BASE_URI}Context/DataProductOutput/Position/
${CONTEXT_POT_Output_Vehicle}              ${STANDARDS_BASE_URI}Context/DataProductOutput/Vehicle/

${CONTEXT_POT_Parameters_DataProduct}      ${STANDARDS_BASE_URI}Context/DataProductParameters/
${CONTEXT_POT_Parameters_AccuWeatherForecast}
...                                        ${STANDARDS_BASE_URI}Context/DataProductParameters/Forecast/Weather/AccuWeather/
${CONTEXT_POT_Parameters_Sensor}           ${STANDARDS_BASE_URI}Context/DataProductParameters/Sensor/

### SCHEMA Data products
${SCHEMA_PARAMETERS_POT_Data_Product}
...                                        ${STANDARDS_BASE_URI}Schema/DataProductParameters
${SCHEMA_PARAMETERS_POT_Document}          ${STANDARDS_BASE_URI}Schema/DataProductParameters/Document
${SCHEMA_PARAMETERS_POT_DocumentSigning}   ${STANDARDS_BASE_URI}Schema/DataProductParameters/Document/Signing
${SCHEMA_PARAMETERS_POT_SignSpace}         ${STANDARDS_BASE_URI}Schema/DataProductParameters/Document/Signing/SignSpace
${SCHEMA_PARAMETERS_POT_Forecast}          ${STANDARDS_BASE_URI}Schema/DataProductParameters/Forecast
${SCHEMA_PARAMETERS_POT_PriceForecast}     ${STANDARDS_BASE_URI}Schema/DataProductParameters/Forecast/Price
${SCHEMA_PARAMETERS_POT_ElectricityPriceForecast}
...                                        ${STANDARDS_BASE_URI}Schema/DataProductParameters/Forecast/Price/Electricity
${SCHEMA_PARAMETERS_POT_WeatherForecast}   ${STANDARDS_BASE_URI}Schema/DataProductParameters/Forecast/Weather
${SCHEMA_PARAMETERS_POT_AccuWeatherForecast}
...                                        ${STANDARDS_BASE_URI}Schema/DataProductParameters/Forecast/Weather/AccuWeather
${SCHEMA_PARAMETERS_POT_Ltif}              ${STANDARDS_BASE_URI}Schema/DataProductParameters/Ltif
${SCHEMA_PARAMETERS_POT_Sensor}            ${STANDARDS_BASE_URI}Schema/DataProductParameters/Sensor


### CONTEXT IDENTITIES
${CONTEXT_POT_IDENTITY_V2_Case}            ${STANDARDS_BASE_URI}Context/Identity/Case/
${CONTEXT_POT_IDENTITY_V2_Digital}         ${STANDARDS_BASE_URI}Context/Identity/Digital/
${CONTEXT_POT_IDENTITY_V2_Data}            ${STANDARDS_BASE_URI}Context/Identity/Digital/Data/
${CONTEXT_POT_IDENTITY_V2_DigitalIdentity}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Digital/DigitalIdentity/
${CONTEXT_POT_IDENTITY_V2_Software}        ${STANDARDS_BASE_URI}Context/Identity/Digital/Software/
${CONTEXT_POT_IDENTITY_V2_App}             ${STANDARDS_BASE_URI}Context/Identity/Digital/Software/App/
${CONTEXT_POT_IDENTITY_V2_Platform}        ${STANDARDS_BASE_URI}Context/Identity/Digital/Software/Platform/
${CONTEXT_POT_IDENTITY_V2_Document}        ${STANDARDS_BASE_URI}Context/Identity/Document/
${CONTEXT_POT_IDENTITY_V2_Element}         ${STANDARDS_BASE_URI}Context/Identity/Element/
${CONTEXT_POT_IDENTITY_V2_BuildingElement}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/
${CONTEXT_POT_IDENTITY_V2_Beam}            ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Beam/
${CONTEXT_POT_IDENTITY_V2_Column}          ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Column/
${CONTEXT_POT_IDENTITY_V2_Curtain_Wall}    ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/CurtainWall/
${CONTEXT_POT_IDENTITY_V2_Door}            ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Door/
${CONTEXT_POT_IDENTITY_V2_Floor}           ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Floor/
${CONTEXT_POT_IDENTITY_V2_Roof}            ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Roof/
${CONTEXT_POT_IDENTITY_V2_Slab}            ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Slab/
${CONTEXT_POT_IDENTITY_V2_Stair}           ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Stair/
${CONTEXT_POT_IDENTITY_V2_Storey}          ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Storey/
${CONTEXT_POT_IDENTITY_V2_Wall}            ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Wall/
${CONTEXT_POT_IDENTITY_V2_Window}          ${STANDARDS_BASE_URI}Context/Identity/Element/BuildingElement/Window/
${CONTEXT_POT_IDENTITY_V2_Equipment}       ${STANDARDS_BASE_URI}Context/Identity/Equipment/
${CONTEXT_POT_IDENTITY_V2_Device}          ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/
${CONTEXT_POT_IDENTITY_V2_Cabel}           ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Cabel/
${CONTEXT_POT_IDENTITY_V2_CableTray}       ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/CableTray/
${CONTEXT_POT_IDENTITY_V2_Camera}          ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Camera/
${CONTEXT_POT_IDENTITY_V2_Display}         ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Display/
${CONTEXT_POT_IDENTITY_V2_DistributionBoard}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/DistributionBoard/
${CONTEXT_POT_IDENTITY_V2_DistributionBox}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/DistributionBox/
${CONTEXT_POT_IDENTITY_V2_Luminaire}       ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Luminaire/
${CONTEXT_POT_IDENTITY_V2_Meter}           ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Meter/
${CONTEXT_POT_IDENTITY_V2_Radiator}        ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Radiator/
${CONTEXT_POT_IDENTITY_V2_Sensor}          ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Sensor/
${CONTEXT_POT_IDENTITY_V2_CarbonDioxideSensor}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Sensor/CarbonDioxideSensor/
${CONTEXT_POT_IDENTITY_V2_HumiditySensor}  ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Sensor/HumiditySensor/
${CONTEXT_POT_IDENTITY_V2_TemperatureSensor}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Sensor/TemperatureSensor/
${CONTEXT_POT_IDENTITY_V2_SocketOutlet}    ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/SocketOutlet/
${CONTEXT_POT_IDENTITY_V2_Switch}          ${STANDARDS_BASE_URI}Context/Identity/Equipment/Device/Switch/
${CONTEXT_POT_IDENTITY_V2_Event}           ${STANDARDS_BASE_URI}Context/Identity/Event/
${CONTEXT_POT_IDENTITY_V2_Group}           ${STANDARDS_BASE_URI}Context/Identity/Group/
${CONTEXT_POT_IDENTITY_V2_System}          ${STANDARDS_BASE_URI}Context/Identity/Group/System/
${CONTEXT_POT_IDENTITY_V2_LegalParty}      ${STANDARDS_BASE_URI}Context/Identity/LegalParty/
${CONTEXT_POT_IDENTITY_V2_Organization}    ${STANDARDS_BASE_URI}Context/Identity/LegalParty/Organization/
${CONTEXT_POT_IDENTITY_V2_LimitedCompany}  ${STANDARDS_BASE_URI}Context/Identity/LegalParty/Organization/LimitedCompany/
${CONTEXT_POT_IDENTITY_V2_HousingCompany}  ${STANDARDS_BASE_URI}Context/Identity/LegalParty/Organization/LimitedCompany/HousingCompany/
${CONTEXT_POT_IDENTITY_V2_Person}          ${STANDARDS_BASE_URI}Context/Identity/LegalParty/Person/
${CONTEXT_POT_IDENTITY_V2_Process}         ${STANDARDS_BASE_URI}Context/Identity/Process/
${CONTEXT_POT_IDENTITY_V2_Calculate}       ${STANDARDS_BASE_URI}Context/Identity/Process/Calculate/
${CONTEXT_POT_IDENTITY_V2_CalculateLtifr}  ${STANDARDS_BASE_URI}Context/Identity/Process/Calculate/CalculateLtifr/
${CONTEXT_POT_IDENTITY_V2_Forecast}        ${STANDARDS_BASE_URI}Context/Identity/Process/Forecast/
${CONTEXT_POT_IDENTITY_V2_ForecastElectricityPriceMWH}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Forecast/ForecastElectricityPriceMWH/
${CONTEXT_POT_IDENTITY_V2_Measure}         ${STANDARDS_BASE_URI}Context/Identity/Process/Measure/
${CONTEXT_POT_IDENTITY_V2_MeasureAirCO2Level}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Measure/MeasureAirCO2Level/
${CONTEXT_POT_IDENTITY_V2_MeasureAirCO2LevelPPM}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Measure/MeasureAirCO2Level/MeasureAirCO2LevelPPM/
${CONTEXT_POT_IDENTITY_V2_MeasureAirTemperature}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Measure/MeasureAirTemperature/
${CONTEXT_POT_IDENTITY_V2_MeasureAirTemperatureCelsiusDegree}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Measure/MeasureAirTemperature/MeasureAirTemperatureCelsiusDegree/
${CONTEXT_POT_IDENTITY_V2_MeasureDistance}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Measure/MeasureDistance/
${CONTEXT_POT_IDENTITY_V2_Signing}         ${STANDARDS_BASE_URI}Context/Identity/Process/Signing/
${CONTEXT_POT_IDENTITY_V2_DigitalSignature}
...                                        ${STANDARDS_BASE_URI}Context/Identity/Process/Signing/DigitalSignature/
${CONTEXT_POT_IDENTITY_V2_Product}         ${STANDARDS_BASE_URI}Context/Identity/Product/
${CONTEXT_POT_IDENTITY_V2_DataProduct}     ${STANDARDS_BASE_URI}Context/Identity/Product/DataProduct/
${CONTEXT_POT_IDENTITY_V2_Project}         ${STANDARDS_BASE_URI}Context/Identity/Project/
${CONTEXT_POT_IDENTITY_V2_Space}           ${STANDARDS_BASE_URI}Context/Identity/Space/
${CONTEXT_POT_IDENTITY_V2_Apartment}       ${STANDARDS_BASE_URI}Context/Identity/Space/Apartment/
${CONTEXT_POT_IDENTITY_V2_RealEstate}      ${STANDARDS_BASE_URI}Context/Identity/Space/RealEstate/
${CONTEXT_POT_IDENTITY_V2_Room}            ${STANDARDS_BASE_URI}Context/Identity/Space/Room/
${CONTEXT_POT_IDENTITY_V2_Zone}            ${STANDARDS_BASE_URI}Context/Identity/Space/Zone/
${CONTEXT_POT_IDENTITY_V2_Structure}       ${STANDARDS_BASE_URI}Context/Identity/Structure/
${CONTEXT_POT_IDENTITY_V2_Bridge}          ${STANDARDS_BASE_URI}Context/Identity/Structure/
${CONTEXT_POT_IDENTITY_V2_Building}        ${STANDARDS_BASE_URI}Context/Identity/Structure/Building/

### CONTEXT LINKS
${CONTEXT_POT_LINK_V2}                     ${STANDARDS_BASE_URI}Context/Link/
${CONTEXT_POT_LINK_V2_AtDataProduct}       ${STANDARDS_BASE_URI}Context/Link/AtDataProduct/
${CONTEXT_POT_LINK_V2_BelongsTo}           ${STANDARDS_BASE_URI}Context/Link/BelongsTo/
${CONTEXT_POT_LINK_V2_LocatedAt}           ${STANDARDS_BASE_URI}Context/Link/LocatedAt/
${CONTEXT_POT_LINK_V2_PublishedOn}         ${STANDARDS_BASE_URI}Context/Link/PublishedOn/
${CONTEXT_POT_LINK_V2_Role}                ${STANDARDS_BASE_URI}Context/Link/Role/
${CONTEXT_POT_LINK_V2_Contractor}          ${STANDARDS_BASE_URI}Context/Link/Role/Contractor/
${CONTEXT_POT_LINK_V2_DeveloperAt}         ${STANDARDS_BASE_URI}Context/Link/Role/DeveloperAt/
${CONTEXT_POT_LINK_V2_DeveloperOf}         ${STANDARDS_BASE_URI}Context/Link/Role/DeveloperOf/
${CONTEXT_POT_LINK_V2_ManagerAt}           ${STANDARDS_BASE_URI}Context/Link/Role/ManagerAt/
${CONTEXT_POT_LINK_V2_MemberOf}            ${STANDARDS_BASE_URI}Context/Link/Role/MemberOf/
${CONTEXT_POT_LINK_V2_OwnerAt}             ${STANDARDS_BASE_URI}Context/Link/Role/OwnerAt/
${CONTEXT_POT_LINK_V2_Participant}         ${STANDARDS_BASE_URI}Context/Link/Role/Participant/
${CONTEXT_POT_LINK_V2_Payer}               ${STANDARDS_BASE_URI}Context/Link/Role/Payer/
${CONTEXT_POT_LINK_V2_Recipient}           ${STANDARDS_BASE_URI}Context/Link/Role/Recipient/
${CONTEXT_POT_LINK_V2_Sender}              ${STANDARDS_BASE_URI}Context/Link/Role/Sender/
${CONTEXT_POT_LINK_V2_TenantAt}            ${STANDARDS_BASE_URI}Context/Link/Role/TenantAt/
${CONTEXT_POT_LINK_V2_UserOf}              ${STANDARDS_BASE_URI}Context/Link/Role/UserOf/


### VOCABULARY ANNOTATION LINKS
${VOCABULARY_POT_LINK_V2_Categorization}    ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization
${VOCABULARY_POT_LINK_V2_SystemRole}        ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole
${VOCABULARY_POT_LINK_V2_Control}           ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/Control
${VOCABULARY_POT_LINK_V2_Detector}          ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/Detector
${VOCABULARY_POT_LINK_V2_Distribution}      ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/Distribution
${VOCABULARY_POT_LINK_V2_EndDevice}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/EndDevice
${VOCABULARY_POT_LINK_V2_Insulator}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/Insulator
${VOCABULARY_POT_LINK_V2_Protector}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/Protector
${VOCABULARY_POT_LINK_V2_Transmit}          ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/SystemRole/Transmit
${VOCABULARY_POT_LINK_V2_UsageArea}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea
${VOCABULARY_POT_LINK_V2_Electricity}       ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Electricity
${VOCABULARY_POT_LINK_V2_Fire}              ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Fire
${VOCABULARY_POT_LINK_V2_Heating}           ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Heating
${VOCABULARY_POT_LINK_V2_Lightning}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Lightning
${VOCABULARY_POT_LINK_V2_Movement}          ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Movement
${VOCABULARY_POT_LINK_V2_Security}          ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Security
${VOCABULARY_POT_LINK_V2_Sound}             ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Sound
${VOCABULARY_POT_LINK_V2_Telecommunications}
...                                         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Telecommunications
${VOCABULARY_POT_LINK_V2_Water}             ${STANDARDS_BASE_URI}Vocabulary/Annotation/Categorization/UsageArea/Water
${VOCABULARY_POT_LINK_V2_Condition}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/Condition
${VOCABULARY_POT_LINK_V2_Material}          ${STANDARDS_BASE_URI}Vocabulary/Annotation/Material
${VOCABULARY_POT_LINK_V2_Air}               ${STANDARDS_BASE_URI}Vocabulary/Annotation/Material/Air
${VOCABULARY_POT_LINK_V2_CarbonDioxide}     ${STANDARDS_BASE_URI}Vocabulary/Annotation/Material/CarbonDioxide
${VOCABULARY_POT_LINK_V2_PricePlan}         ${STANDARDS_BASE_URI}Vocabulary/Annotation/PricePlan
${VOCABULARY_POT_LINK_V2_Quality}           ${STANDARDS_BASE_URI}Vocabulary/Annotation/Quality
${VOCABULARY_POT_LINK_V2_Time}              ${STANDARDS_BASE_URI}Vocabulary/Annotation/Time
${VOCABULARY_POT_LINK_V2_Period}            ${STANDARDS_BASE_URI}Vocabulary/Annotation/Time/Period
${VOCABULARY_POT_LINK_V2_Location}          ${STANDARDS_BASE_URI}Vocabulary/Annotation/Location
${VOCABULARY_POT_LINK_V2_Service}           ${STANDARDS_BASE_URI}Vocabulary/Annotation/Service