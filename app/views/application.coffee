'use strict'

jsonrApp = angular.module 'jsonrApp', ['hljs']

jsonrApp.config (hljsServiceProvider) ->
  hljsServiceProvider.setOptions
    tabReplace: '  '

jsonrApp.controller 'JsonrCtrl', ($scope) ->
  $scope.title = 'Ola ke ase!'
  $scope.format = ->
    $scope.output = ['{','','\t"ola": "ke ase"','}']
