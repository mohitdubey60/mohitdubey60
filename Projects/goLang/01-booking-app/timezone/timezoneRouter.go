package timezone

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"time"
)

// Timezone router
func timeZoneFor(zone string) string {
	loc, _ := time.LoadLocation(zone) //zone: "Asia/Shanghai"
	return fmt.Sprintf("%v", time.Now().In(loc))
}

func GetTimeZone(w http.ResponseWriter, r *http.Request) {
	zones := r.URL.Query().Get("tz") //"America/New_York,Asia/Kolkata" //vars["timeZone"]
	zoneWithTimeMap := make(map[string]string)
	allZones := strings.Split(zones, ",")

	for _, zone := range allZones {
		zoneWithTimeMap[zone] = timeZoneFor(zone)
	}

	jsonString, err := json.Marshal(zoneWithTimeMap)

	if err == nil {
		w.Header().Add("Content-Type", "application/json")
		fmt.Fprint(w, fmt.Sprintf(string(jsonString)))
	} else {
		fmt.Fprintf(w, err.Error())
	}
}
