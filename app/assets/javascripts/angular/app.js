// wishlist = angular.module('wishlist', [
//   'templates',
//   'ngRoute',
//   'ngResource',
//   'controllers'
// ])
//
// wishlist.config([ '$routeProvider',
//   ($routeProvider)->
//
//     $routeProvider
//       .when('/', {
//         templateUrl: "views/welcome/index.html"
//         controller: 'WelcomeController'
//       }).when('/about', {
//         templateUrl: "views/welcome/about.html"
//         controller: 'WelcomeController'
//       }).when('/contact', {
//         templateUrl: "views/welcome/contact.html"
//         controller: 'WelcomeController'
//       }).when('/lists', {
//         templateUrl: "views/lists/index.html"
//         controller: 'ListsController'
//       }).when('/lists/:listId/wishes/:wishId', {
//         templateUrl: "views/wishes/show.html"
//         controller: 'WishesController'
//       }).otherwise({
//         redirectTo: '/'
//       });
// ])
//
//
// controllers = angular.module('controllers',[])
//

var app = angular.module('wishlist', ['ngResource',]);
