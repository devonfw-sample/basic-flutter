'use strict';


/**
 *
 * body EmployeeListRequestDtoSchema 
 * returns EmployeeListResponseDtoSchema
 **/
exports.employeemanagementV1EmployeeSearchPOST = function(body) {
  return new Promise(function(resolve, reject) {
    data = data.filter(e => !!e);
    //TODO: implement filtering
      resolve({
        "content": data,
        "pageable": {},
        "totalElements": data.length
      });
  });
}

