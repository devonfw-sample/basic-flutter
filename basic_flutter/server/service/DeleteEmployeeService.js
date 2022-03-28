'use strict';


/**
 *
 * id Long 
 * no response value expected for this operation
 **/
exports.employeemanagementV1EmployeeIdDELETE = function(id) {
  return new Promise(function(resolve, reject) {
    for(var i = 0; i < data.length; i++){
      if(data[i] && data[i].id == id){
        data[i] = undefined;
      }
    }
    resolve();
  });
}

