class_name DateData extends Resource

#@export var month :String = "none"
#@export var day :int = 0

static func day_num_to_date(day_num :int) -> Array:
	var date :int
	var month :String
	const month_dict = {
		"Jan": 31,
		"Feb": 59,
		"Mar": 90,
		"Apr": 120,
		"May": 151,
		"Jun": 181,
		"Jul": 212,
		"Aug": 243,
		"Sep": 273,
		"Oct": 304,
		"Nov": 334,
		"Dec": 365
	}
	if day_num <= month_dict["Jan"]:
		date = day_num
		month = "Jan"
	elif day_num <= month_dict["Feb"]:
		date = day_num - month_dict["Jan"]
		month = "Feb"
	elif day_num <= month_dict["Mar"]:
		date = day_num - month_dict["Feb"]
		month = "Mar"
	elif day_num <= month_dict["Apr"]:
		date = day_num - month_dict["Mar"]
		month = "Apr"
	elif day_num <= month_dict["May"]:
		date = day_num - month_dict["Apr"]
		month = "May"
	elif day_num <= month_dict["Jun"]:
		date = day_num - month_dict["May"]
		month = "Jun"
	elif day_num <= month_dict["Jul"]:
		date = day_num - month_dict["Jun"]
		month = "Jul"
	elif day_num <= month_dict["Aug"]:
		date = day_num - month_dict["Jul"]
		month = "Aug"
	elif day_num <= month_dict["Sep"]:
		date = day_num - month_dict["Aug"]
		month = "Sep"
	elif day_num <= month_dict["Oct"]:
		date = day_num - month_dict["Aug"]
		month = "Oct"
	elif day_num <= month_dict["Nov"]:
		date = day_num - month_dict["Oct"]
		month = "Nov"
	else:
		date = day_num - month_dict["Nov"]
		month = "Dec"
		
	var array :Array = [date,month]

	return array
