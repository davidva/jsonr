'use strict'

angular.module 'jsonrApp', []

angular.module('jsonrApp').controller 'JsonrCtrl', ($scope) ->
  $scope.title = 'Ola ke ase!'
  $scope.output = '{\n\t"ola": "ke ase"\n}'