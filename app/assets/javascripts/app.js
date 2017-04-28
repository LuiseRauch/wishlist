wishlist = angular.module('wishlist', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'ui.bootstrap',
])
wishlist.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/', {
        templateUrl: "views/welcome/index.html.erb"
        controller: 'WelcomeController'
      }).when('/about', {
        templateUrl: "views/welcome/about.html.erb"
        controller: 'WelcomeController'
      }).when('/contact', {
        templateUrl: "views/welcome/contact.html.erb"
        controller: 'WelcomeController'
      }).when('/lists', {
        templateUrl: "views/lists/index.html.erb"
        controller: 'ListsController'
      }).when('/lists/:listId/wishes/:wishId', {
        templateUrl: "views/wishes/show.html.erb"
        controller: 'WishesController'
      }).otherwise({
        redirectTo: '/'
      });
])

controllers = angular.module('controllers',[])
