'use strict';


/**
 *
 * id Long 
 * returns EmployeeDetailResponseDtoSchema
 **/
exports.employeemanagementV1EmployeeIdGET = function(id) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = {
  "surname" : "surname",
  "modificationCounter" : 0,
  "name" : "name",
  "employeeId" : 1,
  "id" : 6,
  "email" : "email"
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

