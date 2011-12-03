$(function() {  
	
		var $dTable= $("table.dataTablesTable").dataTable( {
				"iDisplayLength": 25,
				"bStateSave": true,
				"oLanguage": {
				"sLengthMenu": 'Show <select><option value="25">25</option><option value="50">50</option><option value="100">100</option><option value="200">200</option></select> entries'
			}
		});
		
		$("#selectAll").click(function() {
			$(".load:checkbox").attr("checked",true);
			return false;
		});
		
		$("#deselectAll").click(function() {
			$(".load:checkbox").attr("checked",false);
			return false;
		});
		
});	

