/**
 * Created by shamil on 9/4/16.
 */

//= require jquery
//= require bootstrap

jQuery(document).ready(function(){
  jQuery('.skillbar').each(function(){
    jQuery(this).find('.skillbar-bar').animate({
      width:jQuery(this).attr('data-percent')
    },3000);
  });
});