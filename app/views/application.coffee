'use strict'

jsonrApp = angular.module 'jsonrApp', ['hljs']

jsonrApp.config (hljsServiceProvider) ->
  hljsServiceProvider.setOptions
    tabReplace: '  '

jsonrApp.controller 'JsonrCtrl', ($scope, $http) ->
  $scope.action = 'Format!'
  $scope.format = ->
    $scope.action = 'Processing...'
    $http.post('/format', $scope.source)
      .success (data) ->
        $scope.output = data
        $scope.action = 'Format!'
      .error (data, status) ->
        $scope.action = 'Format!'
