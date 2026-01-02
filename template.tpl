___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "MACRO",
  "id": "absolute_value",
  "version": 1,
  "securityGroups": [],
  "displayName": "Absolute Value - Negative to Positive",
  "description": "Converts negative numbers to positive (absolute value). Useful for handling refund transactions from booking engines that send negative purchase values.",
  "containerContexts": [
    "SERVER"
  ],
  "categories": ["UTILITY"],
  "brand": {
    "id": "metryxstudio",
    "displayName": "Metryx Studio"
  }
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "inputValue",
    "displayName": "Input Value",
    "simpleValueType": true,
    "help": "The value to convert. If negative, returns positive. Use a variable like {{Event Data - value}}."
  }
]

___SANDBOXED_JS_FOR_SERVER___

const makeNumber = require('makeNumber');

const value = makeNumber(data.inputValue);

if (value < 0) {
  return value * -1;
}

return value;


___SERVER_PERMISSIONS___

[]


___TESTS___

scenarios:
- name: Negative value becomes positive
  code: |-
    const mockData = {
      inputValue: -150.50
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(150.50);
- name: Positive value stays positive
  code: |-
    const mockData = {
      inputValue: 100
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(100);
- name: Zero stays zero
  code: |-
    const mockData = {
      inputValue: 0
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(0);
- name: Negative string value
  code: |-
    const mockData = {
      inputValue: '-250.99'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(250.99);
- name: Positive string value
  code: |-
    const mockData = {
      inputValue: '199.00'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(199);
