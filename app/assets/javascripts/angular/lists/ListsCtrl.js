var app = angular.module('wishlist');

app.controller('ListsCtrl', ['$scope', 'List', function($scope, List) {
  $scope.lists = List.query();

  $scope.message = "Angular Rocks!"
}]);
