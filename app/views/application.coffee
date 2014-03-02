'use strict'

jsonrApp = angular.module 'jsonrApp', ['ngRoute', 'hljs']

jsonrApp.config (hljsServiceProvider) ->
  hljsServiceProvider.setOptions
    tabReplace: '  '

jsonrApp.config ['$routeProvider', ($routeProvider) ->
    $routeProvider.
      when('/', {
        templateUrl: '/format.html'
        controller: 'JsonrCtrl'
      }).
      when('/compare_two', {
        templateUrl: '/compare_two.html'
        controller: 'JsonrCtrl'
      }).
      otherwise({
        redirectTo: '/'
      })
  ]

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
