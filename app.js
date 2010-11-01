$(function() {
  
  var Menu = function(element) {
    this.items = $(element).find("li");
    this.index = 0;
    this.size = this.items.length;
  }
  Menu.prototype = {
    'select': function() {
      var link = this.items.eq(this.index).find("a");
      selectStory.apply(link);
    },
    
    'previous': function() {
      this.highlight( (this.index == 0 ? this.size : this.index) - 1 );
    },
    
    'next': function() {
      this.highlight( (this.index == this.size - 1 ? -1 : this.index) + 1 );
    },
    
    'highlight': function(index) {
      this.items.eq(this.index).removeClass("highlight");
      this.items.eq(this.index = index).addClass("highlight");
    }
  }
  
  var Controller = function(menu) {
    this.menu = menu;
  }
  Controller.prototype = {
    'up': function() {
      this.menu.previous();
    },
    
    'down': function() {
      this.menu.next();
    },
    
    'select' : function() {
      this.menu.select();
    }
  }
  
  $.getJSON('/stories/top', function(stories) {
		buildUI();
		$.each(stories, addStory);
		window.controller = new Controller(new Menu(".menu"));
	});
	
	function buildUI() {
	  $('<ol class="menu"></ol><h1>&nbsp;</h1><p>&nbsp;</p>').appendTo("body");
	}
	
	function addStory() {
    $("<a />").appendTo($("<li />").appendTo(".menu"))
	  .attr('href', this.url)
	  .html(this.title)
  }
  
  function selectStory() {
    var storyLink = $(this);
    storyLink.addClass('selected');
    var url = storyLink.attr('href');
    $.getJSON(url, showStory);
    return false;
  }
  
  function showStory(story) {
		$("h1").html(story.title);
		$("p").html(story.body);
  }
	
});