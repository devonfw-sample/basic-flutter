'use strict';

var utils = require('../utils/writer.js');
var SearchCriteria = require('../service/SearchCriteriaService');

module.exports.employeemanagementV1EmployeeSearchPOST = function employeemanagementV1EmployeeSearchPOST (req, res, next, body) {
  SearchCriteria.employeemanagementV1EmployeeSearchPOST(body)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
