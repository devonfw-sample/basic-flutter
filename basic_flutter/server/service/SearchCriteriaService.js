'use strict';


/**
 *
 * body EmployeeListRequestDtoSchema 
 * returns EmployeeListResponseDtoSchema
 **/
exports.employeemanagementV1EmployeeSearchPOST = function(body) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = {
  "pageable" : [ {
    "pageNumber" : 5,
    "pageSize" : 5,
    "sort" : [ {
      "property" : "property",
      "direction" : "direction"
    }, {
      "property" : "property",
      "direction" : "direction"
    } ]
  }, {
    "pageNumber" : 5,
    "pageSize" : 5,
    "sort" : [ {
      "property" : "property",
      "direction" : "direction"
    }, {
      "property" : "property",
      "direction" : "direction"
    } ]
  } ],
  "content" : [ {
    "surname" : "surname",
    "modificationCounter" : 0,
    "name" : "name",
    "employeeId" : 1,
    "id" : 6,
    "email" : "email"
  }, {
    "surname" : "surname",
    "modificationCounter" : 0,
    "name" : "name",
    "employeeId" : 1,
    "id" : 6,
    "email" : "email"
  } ],
  "totalElements" : 2
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

