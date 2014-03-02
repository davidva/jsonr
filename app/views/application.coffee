'use strict'

jsonrApp = angular.module 'jsonrApp', ['ngRoute', 'hljs', 'jsonrControllers']

jsonrApp.config (hljsServiceProvider) ->
  hljsServiceProvider.setOptions
    tabReplace: '  '

jsonrApp.config ['$routeProvider', ($routeProvider) ->
    $routeProvider.
      when('/', {
        templateUrl: '/format.html'
        controller: 'FormatCtrl'
      }).
      when('/compare_two', {
        templateUrl: '/compare_two.html'
        controller: 'CompareTwoCtrl'
      }).
      otherwise({
        redirectTo: '/'
      })
  ]

jsonrControllers = angular.module 'jsonrControllers', []

jsonrControllers.controller 'FormatCtrl', ($scope, $http) ->
  $scope.action = 'Format!'
  $scope.format = ->
    $scope.action = 'Processing...'
    $http.post('/format', $scope.source)
      .success (data) ->
        $scope.output = data
        $scope.action = 'Format!'
      .error (data, status) ->
        $scope.action = 'Format!'

jsonrControllers.controller 'CompareTwoCtrl', ($scope, $http) ->
  $scope.action = 'Compare!'
  $scope.compare = ->
    $scope.action = 'Processing...'
    $http.post('/compare_two', $scope.source)
      .success (data) ->
        $scope.output = data
        $scope.action = 'Compare!'
      .error (data, status) ->
        $scope.action = 'Compare!'
