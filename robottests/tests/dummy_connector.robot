*** Settings ***
Documentation     Set of tests to validate response when fetch data Product created with Dummy connector
Library           Collections
Library           DateTime
Resource          brokercommon.robot
Resource          dummy_variables.robot
Resource          standards_ontology.robot
Suite Setup       Create All DataProducts
Suite Teardown    Delete All DataProducts

*** Test Cases ***
fetch, 200, when request data Product created with dummy connector temperature endpoint
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY}  timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY}
    Integer     response status                                     200
    Verify Data Product Context Links and Type
    Array       response body data sensors                                    minItems=3
    String      response body data sensors 0 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 0 measurements 0 value             23.5
    String      response body data sensors 0 measurements 0 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 0 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 0 measurements 1 value             22.5
    String      response body data sensors 0 measurements 1 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 0 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 0 measurements 2 value             21.5
    String      response body data sensors 0 measurements 2 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 1 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 1 measurements 0 value             19.0
    String      response body data sensors 1 measurements 0 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 1 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 1 measurements 1 value             18.0
    String      response body data sensors 1 measurements 1 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 1 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 1 measurements 2 value             17.0
    String      response body data sensors 1 measurements 2 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 2 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 2 measurements 0 value             19.5
    String      response body data sensors 2 measurements 0 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 2 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 2 measurements 1 value             18.5
    String      response body data sensors 2 measurements 1 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 2 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 2 measurements 2 value             17.5
    String      response body data sensors 2 measurements 2 @type             MeasureAirTemperatureCelsiusDegree
    Verify Signature From Response

fetch, 422, when header has x-pot-signature without value
    Set Headers    {"x-pot-signature": "", "x-app-token": "${ACCESS_TOKENS["app3"]}"}
    POST       /broker/v1/fetch-data-product                        ${BROKER_BODY}
    Integer    response status                                      422
    Integer    response body error status                           422
    String     response body error message                          Signature validation failed

fetch, 422, when body is empty
    Fetch Data Product    {}
    Integer    response status                                      422
    Integer    response body error status                           422
    String     response body error message productCode 0            Missing data for required field.
    String     response body error message timestamp 0              Missing data for required field.

fetch, 502, when object parameters is missing connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITHOUT_PARAMETERS}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITHOUT_PARAMETERS}
    Verify handle of translator unsuccessful response
    String     response body error translator_response data error message parameters dataTypes 0
    ...                                                             Missing data for required field.
    String     response body error translator_response data error message parameters ids 0
    ...                                                             Missing data for required field.

fetch, 200, when optional parameters startTime & endTime are missing
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITHOUT_TIME}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITHOUT_TIME}
    Integer     response status                                     200
    Verify Data Product Context Links and Type

fetch, 502, when required parameter ids is missing connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITHOUT_IDS}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITHOUT_IDS}
    Verify handle of translator unsuccessful response
    String     response body error translator_response data error message parameters ids 0
    ...                                                             Missing data for required field.

fetch, 502, when required parameter dataTypes is missing connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITHOUT_DATA_TYPES}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITHOUT_DATA_TYPES}
    Verify handle of translator unsuccessful response
    String     response body error translator_response data error message parameters dataTypes 0
    ...                                                             Missing data for required field.

fetch, 200, when parameter ids is an empty array
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_EMPTY}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_EMPTY}
    Integer     response status                                     200
    Verify Data Product Context Links and Type
    Array       response body data sensors                          maxItems=0
    Verify Signature From Response

fetch, 502, when ids parameter has invalid type connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_INVALID_TYPE}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_INVALID_TYPE}
    Verify handle of translator unsuccessful response
    Object     response body error translator_response data error message parameters ids
    ...                                                             minProperties=1      maxProperties=1
    Object     $.error.translator_response.data.error.message.parameters.ids
    ...                                                             {"0": {"_schema": ["Invalid input type."]}}

fetch, 502, when ids parameter has no data connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_WITHOUT_DATA}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_WITHOUT_DATA}
    Verify handle of translator unsuccessful response
    Object     $.error.translator_response.data.error.message.parameters.ids
    ...                                                             {"0": {"id": ["Missing data for required field."]}}

fetch, 502, when ids parameter has data for one item and no data for other item connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_WITH_INCONSISTENT_DATA}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_WITH_INCONSISTENT_DATA}
    Verify handle of translator unsuccessful response
    Object     $.error.translator_response.data.error.message.parameters.ids
    ...                                                             {"1": {"id": ["Missing data for required field."]}}

fetch, 200, when id parameter from ids has no value
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_WITH_ID}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_WITH_ID}
    Integer    response status                                      200
    Verify Data Product Context Links and Type
    Array       response body data sensors                                    maxItems=1
    String      response body data sensors 0 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 0 measurements 0 value             19.0
    String      response body data sensors 0 measurements 0 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 0 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 0 measurements 1 value             18.0
    String      response body data sensors 0 measurements 1 @type             MeasureAirTemperatureCelsiusDegree
    String      response body data sensors 0 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 0 measurements 2 value             17.0
    String      response body data sensors 0 measurements 2 @type             MeasureAirTemperatureCelsiusDegree
    Verify Signature From Response

fetch, 502, when id parameter from ids has invalid value type connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_WITH_ID_INVALID_TYPE}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_WITH_ID_INVALID_TYPE}
    Verify handle of translator unsuccessful response
    Object     $.error.translator_response.data.error.message.parameters.ids
    ...                                                             {"0": {"id": ["Not a valid string."]}}

fetch, 502, when ids parameter have invalid type of data connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_WITH_INVALID_TYPE}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_WITH_INVALID_TYPE}
    Verify handle of translator unsuccessful response
    String     response body error translator_response data error message parameters ids 0
    ...                                                             Not a valid list.

fetch, 502, when startTime & endTime have invalid values connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_INVALID_TIME}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_INVALID_TIME}
    Verify handle of translator unsuccessful response
    String     response body error translator_response data error message parameters startTime 0
    ...                                                             Date must follow RFC3339 standard
    String     response body error translator_response data error message parameters endTime 0
    ...                                                             Date must follow RFC3339 standard

fetch, 502, when ids parameter has null as value connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_IDS_NULL}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_IDS_NULL}
    Verify handle of translator unsuccessful response
    Object     $.error.translator_response.data.error.message.parameters.ids
    ...                                                             {"0": ["Field may not be null."]}

fetch, 502, when dataTypes parameter has null as value connector returns 422
    [Tags]      bug-3998
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_DATA_TYPES_NULL}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_DATA_TYPES_NULL}
    Verify handle of translator unsuccessful response
    Object     $.error.translator_response.data.error.message.parameters.dataTypes
    ...                                                             {"0": ["Field may not be null."]}

fetch, 502, when dataTypes parameter has invalid type connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_DATA_TYPES_WITH_INVALID_TYPE}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITH_DATA_TYPES_WITH_INVALID_TYPE}
    Verify handle of translator unsuccessful response
    String     response body error translator_response data error message parameters dataTypes 0
    ...                                                             Not a valid list.

fetch, 502, when dataTypes parameter has invalid value type connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_DATA_TYPES_INVALID_VALUE}  timestamp   ${timestamp}
    ${resp}     Fetch Data Product with return    ${BODY_WITH_DATA_TYPES_INVALID_VALUE}
    Verify handle of translator unsuccessful response
    Should Contain      ${resp['body']['error']['translator_response']['data']['error']['message']['parameters']['dataTypes']['0'][0]}
    ...                                                             Invalid data type "{}"

fetch, 502, when required dataTypes parameter has no value connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITH_DATA_TYPES_WITHOUT_VALUE}  timestamp   ${timestamp}
    ${resp}     Fetch Data Product with return    ${BODY_WITH_DATA_TYPES_WITHOUT_VALUE}
    Verify handle of translator unsuccessful response
    Should Contain      ${resp['body']['error']['translator_response']['data']['error']['message']['parameters']['dataTypes']['0'][0]}
    ...                                                             Invalid data type ""

fetch, 502, when required parameter @context is missing connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_WITHOUT_CONTEXT}  timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_WITHOUT_CONTEXT}
    Integer    response status                                  502
    Integer    response body error status                       502
    String     response body error translator_response data error message @context 0
    ...                                                             Missing data for required field.

fetch, 502, when required parameter @context has invalid URL value
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_CONTEXT_INVALID}  timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_CONTEXT_INVALID}
    Integer    response status                                  502
    Integer    response body error status                       502
    String     response body error translator_response data error message @context 0
    ...                                                             Must start with ${CONTEXT_POT_Parameters_Sensor}.

fetch, 422, when required parameter @context has invalid value
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_CONTEXT_NOT_URL}  timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_CONTEXT_NOT_URL}
    Integer    response status                                  422
    Integer    response body error status                       422
    String     response body error message @context 0           Not a valid URL.

fetch, 502, when start time has value without timezone connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_START_WITHOUT_TIMEZONE}  timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_START_WITHOUT_TIMEZONE}
    Integer    response status                                  502
    Integer    response body error status                       502
    String     response body error translator_response data error message parameters startTime 0
    ...                                                             Date must contain timezone info

fetch, 502, when end time has value without timezone connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_END_WITHOUT_TIMEZONE}  timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_END_WITHOUT_TIMEZONE}
    Integer    response status                                  502
    Integer    response body error status                       502
    String     response body error translator_response data error message parameters endTime 0
    ...                                                             Date must contain timezone info

fetch, 422, when required parameter timestamp is missing
    Fetch Data Product    ${BROKER_BODY_CO2}
    Integer    response body error status                           422
    String     response body error message timestamp 0              Missing data for required field.

fetch, 200, when request data Product created with dummy connector humidity endpoint
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_HUMIDITY}     timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_HUMIDITY}
    Integer     response status                                     200
    Verify Data Product Context Links and Type
    Array       response body data sensors                                    minItems=3
    String      response body data sensors 0 id id                            1
    String      response body data sensors 0 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 0 measurements 0 value             61.5
    String      response body data sensors 0 measurements 0 @type             MeasureHumidity
    String      response body data sensors 0 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 0 measurements 1 value             60.5
    String      response body data sensors 0 measurements 1 @type             MeasureHumidity
    String      response body data sensors 0 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 0 measurements 2 value             59.5
    String      response body data sensors 0 measurements 2 @type             MeasureHumidity
    String      response body data sensors 1 id id                            2
    String      response body data sensors 1 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 1 measurements 0 value             57.0
    String      response body data sensors 1 measurements 0 @type             MeasureHumidity
    String      response body data sensors 1 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 1 measurements 1 value             56.0
    String      response body data sensors 1 measurements 1 @type             MeasureHumidity
    String      response body data sensors 1 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 1 measurements 2 value             55.0
    String      response body data sensors 1 measurements 2 @type             MeasureHumidity
    String      response body data sensors 2 id id                            3
    String      response body data sensors 2 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 2 measurements 0 value             57.5
    String      response body data sensors 2 measurements 0 @type             MeasureHumidity
    String      response body data sensors 2 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 2 measurements 1 value             56.5
    String      response body data sensors 2 measurements 1 @type             MeasureHumidity
    String      response body data sensors 2 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 2 measurements 2 value             55.5
    String      response body data sensors 2 measurements 2 @type             MeasureHumidity

fetch, 200, when request data Product created with dummy connector CO2 endpoint
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BROKER_BODY_CO2}     timestamp   ${timestamp}
    Fetch Data Product    ${BROKER_BODY_CO2}
    Integer     response status                                     200
    Verify Data Product Context Links and Type
    Array       response body data sensors                                    minItems=3
    String      response body data sensors 0 id id                            1
    String      response body data sensors 0 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 0 measurements 0 value             424.0
    String      response body data sensors 0 measurements 0 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 0 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 0 measurements 1 value             408.0
    String      response body data sensors 0 measurements 1 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 0 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 0 measurements 2 value             392.0
    String      response body data sensors 0 measurements 2 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 1 id id                            2
    String      response body data sensors 1 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 1 measurements 0 value             352.0
    String      response body data sensors 1 measurements 0 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 1 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 1 measurements 1 value             336.0
    String      response body data sensors 1 measurements 1 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 1 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 1 measurements 2 value             320.0
    String      response body data sensors 1 measurements 2 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 2 id id                            3
    String      response body data sensors 2 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 2 measurements 0 value             360.0
    String      response body data sensors 2 measurements 0 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 2 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 2 measurements 1 value             344.0
    String      response body data sensors 2 measurements 1 @type             MeasureAirCO2LevelPPM
    String      response body data sensors 2 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 2 measurements 2 value             328.0
    String      response body data sensors 2 measurements 2 @type             MeasureAirCO2LevelPPM

fetch, 200, when request has 2 items as data types for data Product created with dummy connector humidity endpoint
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_DATA_TYPES_LIST}     timestamp   ${timestamp}
    Fetch Data Product    ${BODY_DATA_TYPES_LIST}
    Integer     response status                                     200
    Verify Data Product Context Links and Type
    Array       response body data sensors                                    minItems=3
     String      response body data sensors 0 id id                            1
    String      response body data sensors 0 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 0 measurements 0 value             61.5
    String      response body data sensors 0 measurements 0 @type             MeasureHumidity
    String      response body data sensors 0 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 0 measurements 1 value             60.5
    String      response body data sensors 0 measurements 1 @type             MeasureHumidity
    String      response body data sensors 0 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 0 measurements 2 value             59.5
    String      response body data sensors 0 measurements 2 @type             MeasureHumidity
    String      response body data sensors 1 id id                            2
    String      response body data sensors 1 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 1 measurements 0 value             57.0
    String      response body data sensors 1 measurements 0 @type             MeasureHumidity
    String      response body data sensors 1 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 1 measurements 1 value             56.0
    String      response body data sensors 1 measurements 1 @type             MeasureHumidity
    String      response body data sensors 1 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 1 measurements 2 value             55.0
    String      response body data sensors 1 measurements 2 @type             MeasureHumidity
    String      response body data sensors 2 id id                            3
    String      response body data sensors 2 measurements 0 timestamp         2020-04-20T13:30:00+00:00
    Number      response body data sensors 2 measurements 0 value             57.5
    String      response body data sensors 2 measurements 0 @type             MeasureHumidity
    String      response body data sensors 2 measurements 1 timestamp         2020-04-20T14:00:00+00:00
    Number      response body data sensors 2 measurements 1 value             56.5
    String      response body data sensors 2 measurements 1 @type             MeasureHumidity
    String      response body data sensors 2 measurements 2 timestamp         2020-04-20T14:30:00+00:00
    Number      response body data sensors 2 measurements 2 value             55.5
    String      response body data sensors 2 measurements 2 @type             MeasureHumidity

fetch, 502, when dataTypes parameter has invalid value connector returns 422
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_INVALID_DATA_TYPES_VALUE}  timestamp   ${timestamp}
    ${resp}     Fetch Data Product with return    ${BODY_INVALID_DATA_TYPES_VALUE}
    Integer    response status                                  502
    Integer    response body error status                       502
    Should Contain      ${resp['body']['error']['translator_response']['data']['error']['message']['parameters']['dataTypes']['0'][0]}
    ...                                                             Invalid data type "MeasureAirCO2Level"

fetch, 422, when required parameter productCode is missing
    ${timestamp}    Run Keyword    Get Timestamp
    Set To Dictionary   ${BODY_WITHOUT_PRODUCT_CODE}  timestamp   ${timestamp}
    Fetch Data Product    ${BODY_WITHOUT_PRODUCT_CODE}
    Integer    response body error status                           422
    String     response body error message productCode 0            Missing data for required field.