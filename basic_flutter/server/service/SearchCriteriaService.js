'use strict';


/**
 *
 * body EmployeeListRequestDtoSchema 
 * returns EmployeeListResponseDtoSchema
 **/
exports.employeemanagementV1EmployeeSearchPOST = function(body) {
  return new Promise(function(resolve, reject) {
    data = data.filter(e => !!e);
    console.log("search function");
    console.log(data);
    console.log({
      "content": data,
      "pageable":[],
      "totalElements": data.length
    });
    resolve({
        "content": data,
        "pageable":[],
        "totalElements": data.length
      });
  });
}

