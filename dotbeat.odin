package main

import "core:fmt"
import "core:math"
import "core:time"

main :: proc() {
	seconds_per_hour: f64 : 60 * 60
	seconds_per_day: f64 : seconds_per_hour * 24
	beat_interval: f64 : seconds_per_day / 1_000

	now := time.now()
	now = time.time_add(now, time.Hour)
	// WAT time is UTC+01:00
	midnight, ok := time.components_to_time(
		time.year(now),
		time.month(now),
		time.day(now),
		0,
		0,
		0,
	)
	if !ok {
		fmt.println("Somehow, I cannot figure out midnight.")
		return
	}

	time_since_midnight := (time.diff(midnight, now)) / time.Second
	dotbeat := math.mod((f64(time_since_midnight) / 86.4), 1000)
	_, this_month, today := time.date(now)
	fmt.printf("\033[91md\033[0m%v.%v\n\033[91m@\033[0m%0.02f\n", today, this_month, dotbeat)
}
