$(function() {  
	
	var $dTable= $("#snapDataTable").dataTable( {
			"iDisplayLength": 25,
			"bStateSave": false,
			"oLanguage": {
				"sSearch": "Search all columns:",
				"sLengthMenu": 'Show <select><option value="25">25</option><option value="50">50</option><option value="100">100</option><option value="200">200</option></select> entries'
		}
	});		
	
	$("a.hideLink").click(function(e) {
		e.preventDefault();
		var $link= $(this);
		var columnIndex= $link.attr("href");
		$("#hiddenCols").append('<a class="showLink" href="' + columnIndex + '">' + $link.attr("title") + '</a>');		
		$dTable.fnSetColumnVis(columnIndex,false);
	});

	$("a.showLink").live("click",function(e) {
		e.preventDefault();
		var $link= $(this);
		var columnIndex= $link.attr("href");
		$dTable.fnSetColumnVis(columnIndex,true);
		$dTable.fnAdjustColumnSizing();
		$link.remove();
	});	
	
	$("tfoot input").keyup( function () {
        /* Filter on the column (the index) of this element */
        $dTable.fnFilter( this.value, $("tfoot input").index(this) );
    });
	
	     
    $("tfoot input").focus( function () {
        if ( this.className == "search_init" )
        {
            this.className = "";
            this.value = "";
        }
    });
	     
    $("tfoot input").blur( function (i) {
        if ( this.value == "" )
        {
            this.className = "search_init";
            this.value = this.title;
        }
    });
	
});





/*
$(function() {
	$("a.hideLink").click(function(e) {
		e.preventDefault();
		var $link= $(this);
		var columnIndex= $link.attr("href");
		$("#hiddenCols").append('<a class="showLink" href="' + columnIndex + '">' + $link.attr("title") + '</a>');		
		$dTable.fnSetColumnVis(columnIndex,false);
		
	});
	
	$("a.showLink").live("click",function(e) {
		e.preventDefault();
		var $link= $(this);
		var columnIndex= $link.attr("href");
		$dTable.fnSetColumnVis(columnIndex,false);
		$link.remove();
		
	});	
});

*/
