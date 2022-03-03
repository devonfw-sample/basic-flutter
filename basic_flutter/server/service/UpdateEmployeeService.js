'use strict';


/**
 *
 * body EmployeeInsertRequestDtoSchema  (optional)
 * id Long 
 * returns EmployeeDetailResponseDtoSchema
 **/
exports.employeemanagementV1EmployeeIdPUT = function(body,id) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = {
  "surname" : body.surname,
  "modificationCounter" : body.modificationCounter,
  "name" : body.name,
  "employeeId" : body.employeeId,
  "id" : body.id,
  "email" : body.email
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

