*** Keywords ***
Fetch Data Product
    [Arguments]     ${body}
    ...             ${app_token}=${ACCESS_TOKENS["app3"]}
    ...             ${auth_header}={"Authorization": ""}
    ${signature}    Calculate PoT Signature          ${body}    ${CLIENT_SECRETS["world"]}
    Set Headers     {"x-pot-signature": "${signature}", "x-app-token": "${app_token}"}
    Set Headers     ${auth_header}
    POST            /broker/v1/fetch-data-product    ${body}

Fetch Data Product with return
    [Arguments]     ${body}
    ...             ${app_token}=${ACCESS_TOKENS["app3"]}
    ...             ${auth_header}={"Authorization": ""}
    ${signature}    Calculate PoT Signature          ${body}    ${CLIENT_SECRETS["world"]}
    Set Headers     {"x-pot-signature": "${signature}", "x-app-token": "${app_token}"}
    Set Headers     ${auth_header}
    ${response}     POST            /broker/v1/fetch-data-product    ${body}
    [Return]        ${response}

Get Body
    [Arguments]     &{kwargs}
    ${body}         Copy Dictionary     ${BROKER_BODY}    deepcopy=True
    Set To Dictionary    ${body}    &{kwargs}
    [Return]        ${body}

Verify Signature From Response
    String      response body signature type                        RsaSignature2018
    String      response body signature created
    String      response body signature creator                     ${TRANSLATOR_PUBLIC_KEY}
    String      response body signature signatureValue
    String      response headers X-Product-Signature-Verified       True

Verify Data Product Context Links and Type
    String      response body @context                              ${CONTEXT_POT_Output_Sensor}
    Array       response body data sensors                          minItems=0

Verify handle of translator unsuccessful response
    Integer    response status                                      502
    Integer    response body error status                           502
    String     response body error message                          External translator returns an invalid response.
    Integer    response body error translator_response status       422
    Integer    response body error translator_response data error status
    ...                                                             422
    String     response headers X-Product-Signature-Verified        False
