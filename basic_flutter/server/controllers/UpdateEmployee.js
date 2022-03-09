'use strict';

var utils = require('../utils/writer.js');
var UpdateEmployee = require('../service/UpdateEmployeeService');

module.exports.employeemanagementV1EmployeeIdPUT = function employeemanagementV1EmployeeIdPUT (req, res, next, body, id) {
  UpdateEmployee.employeemanagementV1EmployeeIdPUT(body, id)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
