var app = angular.module('wishlist');

app.factory('List', ['$resource', function($resource) {
  return $resource('/api/v1/lists/:id.json', { id: '@id' });
}]);
