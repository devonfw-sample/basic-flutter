'use strict';

var utils = require('../utils/writer.js');
var DeleteEmployee = require('../service/DeleteEmployeeService');

module.exports.employeemanagementV1EmployeeIdDELETE = function employeemanagementV1EmployeeIdDELETE (req, res, next, id) {
  DeleteEmployee.employeemanagementV1EmployeeIdDELETE(id)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
