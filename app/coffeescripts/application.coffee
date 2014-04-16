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
      when('/compare_list', {
        templateUrl: '/compare_list.html'
        controller: 'CompareListCtrl'
      }).
      otherwise({
        redirectTo: '/'
      })
  ]

jsonrControllers = angular.module 'jsonrControllers', ['jsonrServices']

jsonrControllers.controller 'FormatCtrl', ($scope, Server) ->
  $scope.action = 'Format!'
  $scope.path = '/format'
  $scope.format = ->
    Server.process $scope, $scope.source

jsonrControllers.controller 'CompareTwoCtrl', ($scope, Server) ->
  $scope.action = 'Compare!'
  $scope.path = '/compare_two'
  $scope.compare = ->
    Server.process $scope,
      source1: $scope.source1
      source2: $scope.source2

jsonrControllers.controller 'CompareListCtrl', ($scope, Server) ->
  $scope.action = 'Compare!'
  $scope.path = '/compare_list'
  $scope.compare = ->
    Server.process $scope, $scope.source

jsonrServices = angular.module 'jsonrServices', []

jsonrServices.factory 'Server', ['$http', ($http) ->
  {
    process: (scope, input) ->
      buttonLabel = scope.action
      scope.action = 'Processing...'
      $http.post(scope.path, input)
        .success (data) ->
          scope.output = data
          scope.action = buttonLabel
        .error (data, status) ->
          scope.action = buttonLabel
  }
]