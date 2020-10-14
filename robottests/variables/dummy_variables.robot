*** Settings ***
Library        OperatingSystem
Library        PoTLib
Library        REST         ${POT_API_URL}

*** Variables ***
${TESTENV}                              test
${POT_API_URL}                          https://api-${TESTENV}.oftrust.net

# OS variables setup on machine
${demo_token}                           %{POT_ACCESS_TOKEN}
${ACCESS_TOKENS["app3"]}                %{POT_ACCESS_TOKEN_APP3}
${CLIENT_SECRETS["world"]}              %{CLIENT_SECRET_WORLD}
${GROUP_ID}                             %{POT_GROUP_ID_TEST}

# Setup of tests is to create a dataProduct with this body
&{PRODUCT_BODY}                         dataContext=${CONTEXT_POT_Output_Data_Product}
...                                     parameterContext=${CONTEXT_POT_Parameters_DataProduct}
...                                     groupId=${GROUP_ID}
...                                     name=Data Product Test
...                                     organizationPublicKeys=@{PUBLIC_KEYS}
...                                     imageUrl=${null}
...                                     description=data product description
@{PUBLIC_KEYS}                          &{PUBLIC_KEY}
&{PUBLIC_KEY}                           type=RsaSignature2018

# TRANSLATOR SPECIFIC VARIABLES:
${PRODUCT_CODE}                         dummyrobot-temperature-test
${PRODUCT_CODE_HUMIDITY}                dummyrobot-humidity-test
${PRODUCT_CODE_CO2}                     dummyrobot-co2-test

${TRANSLATOR_URL}                       https://api-external-${TESTENV}.oftrust.net/dummy-translator/v1/fetch
${TRANSLATOR_URL_HUMIDITY}              https://api-external-${TESTENV}.oftrust.net/dummy-translator/v1/data/humidity/fetch
${TRANSLATOR_URL_CO2}                   https://api-external-${TESTENV}.oftrust.net/dummy-translator/v1/data/co2/fetch
${TRANSLATOR_PUBLIC_KEY}                https://api-external-${TESTENV}.oftrust.net/dummy-translator/v1/public.key

&{BROKER_BODY}                          productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${BROKER_BODY_PARAMETERS}
&{BROKER_BODY_PARAMETERS}               ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES}
@{IDS}                                  &{first}   &{second}   &{third}
&{first}                                id=1
&{second}                               id=2
&{third}                                id=3
${START_TIME}                           2020-04-20T13:06:40+00:00
${END_TIME}                             2020-04-20T14:53:54+00:00
@{DATA_TYPES}                           MeasureAirTemperatureCelsiusDegree

&{BROKER_BODY_WITHOUT_CONTEXT}          productCode=${PRODUCT_CODE}
...                                     parameters=${BROKER_BODY_PARAMETERS}

&{BODY_WITHOUT_PARAMETERS}              productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}

&{BODY_WITHOUT_TIME}                    productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITHOUT_TIME}
&{PARAMETERS_WITHOUT_TIME}              ids=@{IDS}
...                                     dataTypes=@{DATA_TYPES}

&{BODY_WITHOUT_IDS}                     productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITHOUT_IDS}
&{PARAMETERS_WITHOUT_IDS}               dataTypes=@{DATA_TYPES}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}

&{BODY_WITHOUT_DATA_TYPES}              productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITHOUT_DATA_TYPES}
&{PARAMETERS_WITHOUT_DATA_TYPES}        ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}

&{BODY_WITH_IDS_EMPTY}                  productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITH_IDS_EMPTY}
&{PARAMETERS_WITH_IDS_EMPTY}            ids=@{EMPTY}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES}

&{BODY_WITH_IDS_INVALID_TYPE}           productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITH_IDS_INVALID_TYPE}
&{PARAMETERS_WITH_IDS_INVALID_TYPE}     ids=@{first}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES}

&{BODY_WITH_IDS_WITHOUT_DATA}           productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITH_IDS_WITHOUT_DATA}
&{PARAMETERS_WITH_IDS_WITHOUT_DATA}     ids=@{IDS_EMPTY}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES}
@{IDS_EMPTY}                            &{EMPTY}

&{BODY_WITH_IDS_WITH_INCONSISTENT_DATA}
...                                     productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_IDS_INCONSISTENT_DATA}
&{PARAMETERS_IDS_INCONSISTENT_DATA}
...                                     ids=@{IDS_INCONSISTENT_DATA}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
@{IDS_INCONSISTENT_DATA}                ${first}    &{EMPTY}

&{BODY_WITH_IDS_WITH_ID}                productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITH_IDS_WITH_ID}
&{PARAMETERS_WITH_IDS_WITH_ID}          ids=@{IDS_WITHOUT_VALUE}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES}
@{IDS_WITHOUT_VALUE}                    &{origin}
&{origin}                               id=

&{BODY_WITH_IDS_WITH_ID_INVALID_TYPE}
...                                     productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_WITH_IDS_WITH_ID_INVALID_TYPE}
&{PARAMETERS_WITH_IDS_WITH_ID_INVALID_TYPE}
...                                     ids=@{IDS_INVALID_TYPE}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
@{IDS_INVALID_TYPE}                     &{ID_INVALID_VALUE_TYPE}
&{ID_INVALID_VALUE_TYPE}                id=@{EMPTY}

&{BODY_WITH_IDS_WITH_INVALID_TYPE}      productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_INVALID_IDS}
&{PARAMETERS_INVALID_IDS}               ids=&{INVALID_IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
&{INVALID_IDS}                          id=1

&{BODY_WITH_INVALID_TIME}               productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_INVALID_TIME}
&{PARAMETERS_INVALID_TIME}              ids=@{IDS}
...                                     startTime=invalidTime
...                                     endTime=2021-04-32 13:06:40

&{BODY_WITH_IDS_NULL}                   productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_IDS_NULL}
&{PARAMETERS_IDS_NULL}                  ids=@{IDS_NULL}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
@{IDS_NULL}                             ${null}

&{BODY_WITH_DATA_TYPES_NULL}            productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_DATA_TYPES_NULL}
&{PARAMETERS_DATA_TYPES_NULL}           ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_NULL}
@{DATA_TYPES_NULL}                      ${null}

&{BODY_WITH_DATA_TYPES_WITH_INVALID_TYPE}
...                                     productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_DATA_TYPES_INVALID}
&{PARAMETERS_DATA_TYPES_INVALID}        ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=&{EMPTY}

&{BODY_WITH_DATA_TYPES_INVALID_VALUE}   productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_DATA_TYPES_INVALID_VALUE}
&{PARAMETERS_DATA_TYPES_INVALID_VALUE}  ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_INVALID_VALUE}
@{DATA_TYPES_INVALID_VALUE}             &{EMPTY}

&{BODY_WITH_DATA_TYPES_WITHOUT_VALUE}   productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_DATA_TYPES_WITHOUT_VALUE}
&{PARAMETERS_DATA_TYPES_WITHOUT_VALUE}  ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_WITHOUT_VALUE}
@{DATA_TYPES_WITHOUT_VALUE}             ${EMPTY}

&{BROKER_BODY_CONTEXT_INVALID}          productCode=${PRODUCT_CODE}
...                                     @context=https://standards.oftrust.net/v2/
...                                     parameters=${BROKER_BODY_PARAMETERS}

&{BROKER_BODY_CONTEXT_NOT_URL}          productCode=${PRODUCT_CODE}
...                                     @context=ontology context
...                                     parameters=${BROKER_BODY_PARAMETERS}

&{BROKER_BODY_START_WITHOUT_TIMEZONE}   productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_START_WITHOUT_TIMEZONE}
&{PARAMETERS_START_WITHOUT_TIMEZONE}    ids=@{IDS}
...                                     startTime=2020-04-20 13:06:40
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES}

&{BROKER_BODY_END_WITHOUT_TIMEZONE}     productCode=${PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_END_WITHOUT_TIMEZONE}
&{PARAMETERS_END_WITHOUT_TIMEZONE}      ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=2020-04-20 14:53:40
...                                     dataTypes=@{DATA_TYPES}

&{BROKER_BODY_HUMIDITY}                 productCode=${PRODUCT_CODE_HUMIDITY}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${BROKER_BODY_PARAMETERS_HUMIDITY}
&{BROKER_BODY_PARAMETERS_HUMIDITY}      ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_HUMIDITY}
@{DATA_TYPES_HUMIDITY}                  MeasureHumidity

&{BROKER_BODY_CO2}                      productCode=${PRODUCT_CODE_CO2}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${BROKER_BODY_PARAMETERS_CO2}
&{BROKER_BODY_PARAMETERS_CO2}           ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_CO2}
@{DATA_TYPES_CO2}                       MeasureAirCO2LevelPPM

&{BODY_DATA_TYPES_LIST}                 productCode=${PRODUCT_CODE_HUMIDITY}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_DATA_TYPES_LIST}
&{PARAMETERS_DATA_TYPES_LIST}           ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_LIST}
@{DATA_TYPES_LIST}                      MeasureAirCO2LevelPPM   MeasureAirTemperatureCelsiusDegree

&{BODY_INVALID_DATA_TYPES_VALUE}        productCode=${PRODUCT_CODE_CO2}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${PARAMETERS_INVALID_DATA_TYPES_VALUE}
&{PARAMETERS_INVALID_DATA_TYPES_VALUE}  ids=@{IDS}
...                                     startTime=${START_TIME}
...                                     endTime=${END_TIME}
...                                     dataTypes=@{DATA_TYPES_INVALID_DATA_TYPES_VALUE}
@{DATA_TYPES_INVALID_DATA_TYPES_VALUE}  MeasureAirCO2Level

&{BODY_WITHOUT_PRODUCT_CODE}
...                                     @context=${CONTEXT_POT_Parameters_Sensor}
...                                     parameters=${BROKER_BODY_PARAMETERS_HUMIDITY}

*** Keywords ***
Create DataProduct With Arguments
    [Arguments]     ${PRODUCT_CODE}     ${TRANSLATOR_URL_FETCH}     ${TRANSLATOR_PUBLIC_KEY}
    Set Authorization token in header
    Set To Dictionary       ${PRODUCT_BODY}     productCode         ${PRODUCT_CODE}
    Set To Dictionary       ${PRODUCT_BODY}     translatorUrl       ${TRANSLATOR_URL_FETCH}
    Set To Dictionary       ${PRODUCT_BODY.organizationPublicKeys[0]}      url     ${TRANSLATOR_PUBLIC_KEY}
    POST            /products/v1                            ${PRODUCT_BODY}
    Integer         response status                         201

Create All DataProducts
    Create DataProduct With Arguments   ${PRODUCT_CODE}     ${TRANSLATOR_URL}       ${TRANSLATOR_PUBLIC_KEY}
    Create DataProduct With Arguments   ${PRODUCT_CODE_HUMIDITY}        ${TRANSLATOR_URL_HUMIDITY}      ${TRANSLATOR_PUBLIC_KEY}
    Create DataProduct With Arguments   ${PRODUCT_CODE_CO2}     ${TRANSLATOR_URL_CO2}       ${TRANSLATOR_PUBLIC_KEY}

Delete DataProduct By ProductCode
    [Arguments]     ${PRODUCT_CODE}
    Set Authorization token in header
    DELETE          /products/v1/${PRODUCT_CODE}
    Integer         response status                         204

Delete All DataProducts
    Delete DataProduct By ProductCode       ${PRODUCT_CODE}
    Delete DataProduct By ProductCode       ${PRODUCT_CODE_HUMIDITY}
    Delete DataProduct By ProductCode       ${PRODUCT_CODE_CO2}

Get Timestamp
    ${timestamp}   Get Current Date   time_zone=UTC    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    [Return]    ${timestamp}

Set Authorization token in header
    Set Headers    {"Authorization": "Bearer ${demo_token}"}