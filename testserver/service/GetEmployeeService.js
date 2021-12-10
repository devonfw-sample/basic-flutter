'use strict';

/**
 *
 * id Long 
 * returns EmployeeDetailResponseDtoSchema
 **/
exports.employeemanagementV1EmployeeIdGET = function(id) {
  return new Promise(function(resolve, reject) {
    var result = null;
    for(var i = 0; i < data.length; i++){
      if(data[i] && data[i].id == id){
        result = data[i];
        break;
      }
    }
    if (result) {
      resolve(result);
    } else {
      resolve();
    }
  });
}

