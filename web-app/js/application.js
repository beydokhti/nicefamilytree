if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
		onCreate: function() {
			if($('spinner') && Ajax.activeRequestCount>0)
				Effect.Appear('spinner',{duration:0.5,queue:'end'});
		},
		onComplete: function() {
			if($('spinner') && Ajax.activeRequestCount==0)
				Effect.Fade('spinner',{duration:0.5,queue:'end'});
		}
	});
}


function checkType(type) {

	show('showStartDate', 'ANNOUNCEMENT'==type || 'CUSTOM_EVENT'==type);
	show('showEndDate', 'ANNOUNCEMENT'==type || 'CUSTOM_EVENT'==type);
	show('showPosition', 'ANNOUNCEMENT'==type || 'FAQ'==type);
}

function show(id, flag) {
	$(id).style.display = flag? "":"none";
}
