'use strict';

var utils = require('../utils/writer.js');
var GetEmployee = require('../service/GetEmployeeService');

module.exports.employeemanagementV1EmployeeIdGET = function employeemanagementV1EmployeeIdGET (req, res, next, id) {
  GetEmployee.employeemanagementV1EmployeeIdGET(id)
    .then(function (response) {
      utils.writeJson(res, response);
      console.log('get request result printed');
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
