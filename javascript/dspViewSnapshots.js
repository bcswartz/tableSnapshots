$(function() {  
	
	var $dTable= $("#snapDataTable").dataTable( {
			"iDisplayLength": 5,
			"bStateSave": false,
			"sScrollX": "100%",
			"oLanguage": {
				"sSearch": "Search all columns:",
				"sLengthMenu": 'Show <select><option value="5">5</option><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option><option value="200">200</option><option value="-1">All</option></select> entries'
		}
	});		
	
	$("#colControlsLink").click(function(e) {
		var $tog= $(this);
		if($tog.hasClass("showControls")) {
			$tog.text("Hide column controls");
			$tog.removeClass("showControls");
			$tog.addClass("hideControls");
			$("#hiddenCols").removeClass("hideElement");
		} else {
			$tog.text("Display column controls");
			$tog.removeClass("hideControls");
			$tog.addClass("showControls");
			$("#hiddenCols").addClass("hideElement");
		}
		e.preventDefault();
	});
	
	$("#selAll").click(function(e) {
		e.preventDefault();
		$(":checkbox",$("#hiddenCols")).attr("checked",true);
	});
	
	$("#deselAll").click(function(e) {
		e.preventDefault();
		$(":checkbox",$("#hiddenCols")).attr("checked",false);
	});
	
	$("#updateCols").click(function(e) {
		$.blockUI({ message: '<h1>Updating table...</h1>' });
		$(":checkbox",$("#hiddenCols")).each(function() {
			var $box= $(this);
			var columnIndex= $box.val();
			if($box.attr("checked")) {
				$dTable.fnSetColumnVis(columnIndex,true,false);
			} else {
				$dTable.fnSetColumnVis(columnIndex,false,false);
			}
		});
		$dTable.fnAdjustColumnSizing();
		$.unblockUI();
		e.preventDefault();
	});

	
	$("thead input").click( function (e) { // i add this.
                stopTableSorting(e);
                this.focus();
            });
		
	$("thead input").keyup( function (e) {
		//Last parameter set false to make case-sensitive.
		$dTable.fnFilter(this.value,this.alt,false,true,true,false);
    });
	
	     
    $("thead input").focus( function () {
        if ( this.className == "search_init" )
        {
            this.className = "";
            this.value = "";
        }
    });
	     
    $("thead input").blur( function (i) {
        if ( this.value == "" )
        {
            this.className = "search_init";
            this.value = this.title;
        }
    });
	
		
});


function stopTableSorting(e) { 
    if (!e)
        var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation)
        e.stopPropagation();
};

