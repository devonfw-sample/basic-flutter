'use strict';


/**
 *
 * body EmployeeInsertRequestDtoSchema  (optional)
 * returns EmployeeInsertResponseDtoSchema
 **/
exports.employeemanagementV1EmployeePOST = function(body) {
  return new Promise(function(resolve, reject) {
    if(body.id != null)
    {
    body.modificationCounter = body.modificationCounter | 0;
    data.push(body);
    resolve(body);
    }
    else{
    body.id = currentId++;
    body.modificationCounter = body.modificationCounter | 0;
    data.push(body);
    resolve(body);
    }  
  });
}

