// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap
//= require turbolinks
//= require_tree .


$(document).ready(function() {
    $('.jumbotron').ripples({ //波紋をつけたい要素の指定
          resolution: 1500, //波紋の広がりの速度（値が大きいほど遅くなる）
          dropRadius: 10, //波紋の大きさ（値が大きいほどでかくなる）
          perturbance: 0.01 //波紋による屈折量（値が大きいほどブレる）
      });
  });


  // Automatic drops
  setInterval(function() {
    var $el = $('.jumbotron');
    var x = Math.random() * $el.outerWidth();
    var y = Math.random() * $el.outerHeight();
    var dropRadius = 10;
    var strength = 0.04 + Math.random() * 0.04;

    $el.ripples('drop', x, y, dropRadius, strength);
}, 1000);