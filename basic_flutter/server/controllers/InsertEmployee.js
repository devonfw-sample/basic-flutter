'use strict';

var utils = require('../utils/writer.js');
var InsertEmployee = require('../service/InsertEmployeeService');

module.exports.employeemanagementV1EmployeePOST = function employeemanagementV1EmployeePOST (req, res, next, body) {
  InsertEmployee.employeemanagementV1EmployeePOST(body)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
