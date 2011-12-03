<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>TableSnapshots</title>
	<cfoutput>
		<link rel="stylesheet" href="css/snapshots.css">
		<link rel="stylesheet" href="css/menu_style.css" type="text/css" />
		<script type="text/javascript" src="javascript/jquery-1.4.2.min.js"></script>
	</cfoutput>
</head>

<body>

<div class="menu">
	<ul>
		<li><a href="index.cfm?event=home">Home</a></li>
		<li><a href="#">Snapshots</a>
			<ul>
				<li>
					<a href="index.cfm?event=generateSnapshots">Create</a>
				</li>
				<li>
					<a href="index.cfm?event=listSnapshots">List/Load</a>
				</li>
				<li>
					<a href="index.cfm?event=listSnapshotsToDelete">Delete</a>
				</li>
			</ul>
		</li>
		<li><a href="#">Backups</a>
			<ul>
				<li><a href="index.cfm?event=listBackups">List/Load</a></li>
				<li><a href="index.cfm?event=listBackupsToDelete">Delete</a></li>
			</ul>
		</li>
		<li><a href="index.cfm?event=reset">Reset</a></li>
		<li><a href="#">About</a>
			<ul>
				<li><a href="index.cfm?event=gettingStarted">Getting Started</a></li>
				<li><a href="index.cfm?event=technicalDetails">Technical Details</a></li>
				<li><a href="index.cfm?event=useCases">Use Cases</a></li>
				<li><a href="index.cfm?event=credits">Credits</a></li>
			</ul>
		</li>
	</ul>
</div>

<div id="content">
	
	
