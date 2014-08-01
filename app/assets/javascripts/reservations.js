// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http:coffeescript.org/
$(document).ready(function(){
  $("#datepicker").datepicker({
      beforeShowDay: nonWorkingDates,
      // Change date format for MySQL date type to accept it
      dateFormat: "yy-mm-dd"
  });
});


function nonWorkingDates(date){
  var day = date.getDay(), Sunday = 0, Monday = 1, Tuesday = 2, Wednesday = 3, Thursday = 4, Friday = 5, Saturday = 6;
  var closedDates = [[7, 29, 2014], [8, 25, 2014]];
  var closedDays = [[Monday], [Thursday]];
  for (var i = 0; i < closedDays.length; i++) {
      if (day == closedDays[i][0]) {
          return [false];
      }

  }

  for (i = 0; i < closedDates.length; i++) {
      if (date.getMonth() == closedDates[i][0] - 1 &&
      date.getDate() == closedDates[i][1] &&
      date.getFullYear() == closedDates[i][2]) {
          return [false];
      }
  }

  return [true];
}
