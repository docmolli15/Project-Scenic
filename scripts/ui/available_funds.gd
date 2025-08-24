extends Label

func _ready():
	MessageBus.spent.connect(spend)
	MessageBus.acquired.connect(acquire)
	update_display()

func spend(amount: int) -> void:
	Global.funds -= amount
	update_display()

func acquire(amount: int) -> void:
	Global.funds += amount
	update_display()

func update_display():
	text = format_with_commas(int(String.num_int64(Global.funds)))

func format_with_commas(number: int) -> String:
	var num_str := str(number)
	var result := ""
	var count := 0

	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result

	return result
